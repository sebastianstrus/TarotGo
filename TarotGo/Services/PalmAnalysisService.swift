//
//  PalmAnalysisService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation
import Vision
import UIKit
import CoreImage
import MediaPipeTasksVision

// Single point in palm space — wraps MediaPipe's NormalizedLandmark in our
// own type so the rest of the service doesn't have to know about Vision or
// MediaPipe specifically. Coordinates are normalized [0, 1] with origin at
// TOP-LEFT (matching MediaPipe's convention and standard image pixel layout).
struct PalmLandmark {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
}

// Indexes into the MediaPipe HandLandmarker output (21 landmarks per hand).
// These match the standard MediaPipe hand landmark topology.
private enum HandLandmark: Int {
    case wrist = 0
    case thumbCMC = 1, thumbMP = 2, thumbIP = 3, thumbTip = 4
    case indexMCP = 5, indexPIP = 6, indexDIP = 7, indexTip = 8
    case middleMCP = 9, middlePIP = 10, middleDIP = 11, middleTip = 12
    case ringMCP = 13, ringPIP = 14, ringDIP = 15, ringTip = 16
    case littleMCP = 17, littlePIP = 18, littleDIP = 19, littleTip = 20
}

// Provenance tag for each row in the debug reading log. Distinguishes
// values that came from real signal vs. fallbacks that had to be
// substituted because there was nothing to measure.
private enum ReadingSource: String {
    case measured = "measured"       // meaningful signal detected in the ROI
    case noSignal = "no signal"      // ROI sampled successfully but edges were ~zero
    case defaulted = "default"       // sampling failed (off-image, guard failed)
    case absent = "absent"           // fate line: legitimate "no line found" result
}

// Not @MainActor on purpose: the analysis pipeline is heavy (MediaPipe +
// Vision + per-pixel sampling) and would otherwise freeze the UI when
// awaited from a @MainActor view model. Without the annotation the work
// runs on the global cooperative executor, off the main thread.
class PalmAnalysisService {
    static let shared = PalmAnalysisService()

    private init() {}

    // MediaPipe HandLandmarker, lazily created once. Loading the .task model
    // costs ~50-100 ms; re-using the same instance across scans amortizes
    // that cost.
    private lazy var handLandmarker: HandLandmarker? = {
        guard let modelPath = Bundle.main.path(forResource: "hand_landmarker", ofType: "task") else {
            print("[PalmAnalysis] hand_landmarker.task not found in bundle")
            return nil
        }
        let options = HandLandmarkerOptions()
        options.runningMode = .image
        options.numHands = 1
        options.minHandDetectionConfidence = 0.5
        options.minHandPresenceConfidence = 0.5
        options.minTrackingConfidence = 0.5
        options.baseOptions.modelAssetPath = modelPath
        // Run inference on the GPU. The hand landmarker is a small MobileNet-
        // style model whose GEMM ops map well to Metal; on-device runs are
        // typically 2-3× faster than the CPU default. MediaPipe falls back to
        // CPU automatically if Metal init fails, so this is a safe override.
        options.baseOptions.delegate = .GPU
        do {
            return try HandLandmarker(options: options)
        } catch {
            print("[PalmAnalysis] HandLandmarker init failed: \(error)")
            return nil
        }
    }()

    // Shared CIContext — first-time creation includes Metal pipeline
    // compilation that can stutter the UI. Re-using the same instance
    // across scans amortizes that cost.
    //
    // priorityRequestLow tells CoreImage to yield GPU access to other
    // Metal consumers (like SwiftUI's animation renderer) when there's
    // contention. Without this option Vision/CoreImage can starve the
    // overlay's animations mid-flight for a couple hundred milliseconds.
    private lazy var ciContext: CIContext = {
        let options: [CIContextOption: Any] = [
            .priorityRequestLow: true
        ]
        return CIContext(options: options)
    }()
    
    // Analyze palm image and generate reading
    func analyzePalm(image originalImage: UIImage) async throws -> PalmReading {
        // Normalize the UIImage so its cgImage matches the displayed
        // orientation. Camera captures usually arrive with .right
        // orientation (sensor is landscape, display is portrait), which
        // means Vision and edge-detection would otherwise see a sideways
        // hand and produce noisier landmarks.
        let oriented = normalizeOrientation(of: originalImage)

        // Downscale to a max dimension of 1536. The full 3024×4032 capture
        // takes ~48 MB just for the RGBA pixel buffer in decodeRGBA — that
        // allocation + the corresponding CGContext.draw is the dominant
        // source of mid-animation UI stutter. At 1536-wide max the buffer
        // drops to ~7 MB and palm creases are still well-resolved (~3 px
        // wide instead of ~6 px).
        let image = downscale(oriented, maxDimension: 1536)

        // Step 1: Detect hand landmarks (and MediaPipe's handedness label)
        let detection = try await detectHandLandmarks(in: image)
        let handLandmarks = detection.landmarks

        // Step 2: Validate that the hand is open with extended fingers
        try validateOpenPalm(handLandmarks)

        // Step 2b: Reject the back of the hand. Without this gate the contour
        // detector happily traces knuckle wrinkles and reports the same
        // "lines" as if it had seen a real palm.
        try validatePalmSide(handLandmarks, mediaPipeHandedness: detection.handedness)

        // Resolve which hand it actually is. Back camera input is not mirrored,
        // so MediaPipe's label (which assumes a selfie-style mirror) is swapped.
        let handedness = realHandedness(fromMediaPipeLabel: detection.handedness)

        // Step 3: Build the edge image + hand-local frame. Both lines and
        // mounts read from this shared pipeline so edge detection runs once.
        let palmPoints = try getPalmKeyPoints(from: handLandmarks)

        guard let cgImage = image.cgImage,
              let contourResult = detectContoursMask(of: image),
              let contourCGImage = contourResult.mask.cgImage,
              let edgePixels = decodeRGBA(from: contourCGImage) else {
            throw PalmAnalysisError.processingFailed
        }

        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        let wrist = toImagePoint(palmPoints.wrist, imageSize: imageSize)
        let indexBase = toImagePoint(palmPoints.indexBase, imageSize: imageSize)
        let middleBase = toImagePoint(palmPoints.middleBase, imageSize: imageSize)
        let littleBase = toImagePoint(palmPoints.littleBase, imageSize: imageSize)

        let handFrame = HandFrame(
            wrist: wrist,
            palmRight: CGPoint(x: littleBase.x - indexBase.x, y: littleBase.y - indexBase.y),
            palmUp: CGPoint(x: middleBase.x - wrist.x, y: middleBase.y - wrist.y)
        )

        print(String(format: "[PalmAnalysis] handFrame wrist=(%.0f, %.0f) palmRight=(%.0f, %.0f) palmUp=(%.0f, %.0f) imageSize=%dx%d",
                     wrist.x, wrist.y, handFrame.palmRight.x, handFrame.palmRight.y,
                     handFrame.palmUp.x, handFrame.palmUp.y, cgImage.width, cgImage.height))

        // Step 4: Analyze palm lines deterministically from the edge image
        let lineCharacteristics = analyzePalmLines(edgePixels: edgePixels, handFrame: handFrame)

        // Step 5: Analyze hand shape (uses landmark geometry only)
        let (handShape, handShapeSource) = analyzeHandShape(using: handLandmarks)

        // Step 6: Analyze palm mounts deterministically from the edge image
        let mountResults = analyzePalmMounts(edgePixels: edgePixels, handFrame: handFrame)

        // Debug dump — one block per scan, easy to paste as a new column in a tracking table.
        logDebugReading(
            handedness: handedness,
            contourCount: contourResult.contourCount,
            topLevelContourCount: contourResult.topLevelCount,
            lines: lineCharacteristics,
            handShape: handShape,
            handShapeSource: handShapeSource,
            mounts: mountResults
        )

        // Quality gate — reject captures that clearly didn't produce enough
        // crease detail to analyze. Two independent signals, either one
        // triggers the poor-lighting error:
        //
        //  1. Contour count under 300. Empirically, good captures produce
        //     500-3000+ contours; anything under 300 has been dim/backlit
        //     input where Vision couldn't trace enough boundaries.
        //  2. All three primary lines (heart/head/life) fail to signal.
        //     Heart in particular is the most reliable palm crease — if
        //     even it comes back empty, the mask is genuinely blank
        //     rather than the user having an unusual palm.
        //
        // Mount `.noSignal` counts are not used here: real palms often
        // have several genuinely smooth mounts (venus/moon/marsUpper),
        // so a raw "many no-signals" heuristic false-positives on hands
        // that would otherwise read fine.
        let primaryLinesEmpty = lineCharacteristics.heartSource == .noSignal
            && lineCharacteristics.headSource == .noSignal
            && lineCharacteristics.lifeSource == .noSignal
        if contourResult.contourCount < 300 || primaryLinesEmpty {
            print("[PalmAnalysis] rejecting reading — contours=\(contourResult.contourCount), primaryLinesEmpty=\(primaryLinesEmpty)")
            throw PalmAnalysisError.poorLighting
        }

        // Step 7: Create palm reading
        return PalmReading(
            heartLine: lineCharacteristics.heartLine,
            headLine: lineCharacteristics.headLine,
            lifeLine: lineCharacteristics.lifeLine,
            fateLine: lineCharacteristics.fateLine,
            mounts: mountResults.map { $0.mount },
            handShape: handShape,
            handedness: handedness
        )
    }

    // MARK: - Debug Logging

    private func logDebugReading(
        handedness: Handedness?,
        contourCount: Int,
        topLevelContourCount: Int,
        lines: (
            heartLine: PalmLineCharacteristics,
            headLine: PalmLineCharacteristics,
            lifeLine: PalmLineCharacteristics,
            fateLine: PalmLineCharacteristics?,
            heartSource: ReadingSource,
            headSource: ReadingSource,
            lifeSource: ReadingSource,
            fateSource: ReadingSource
        ),
        handShape: HandShapeAnalysis,
        handShapeSource: ReadingSource,
        mounts: [(mount: PalmMountCharacteristics, source: ReadingSource)]
    ) {
        let absent = "—"
        let fateLength = lines.fateLine?.length.rawValue ?? absent
        let fateDepth = lines.fateLine?.depth.rawValue ?? absent
        let fateContinuity = lines.fateLine?.continuity.rawValue ?? absent

        let handednessValue = handedness?.rawValue ?? "unknown"
        let handednessSource: ReadingSource = handedness == nil ? .defaulted : .measured
        let contourValue = "\(contourCount) (top: \(topLevelContourCount))"

        var rows: [(label: String, value: String, source: ReadingSource)] = [
            ("Handedness",       handednessValue,                     handednessSource),
            ("Contours",         contourValue,                        .measured),
            ("Heart length",     lines.heartLine.length.rawValue,     lines.heartSource),
            ("Heart depth",      lines.heartLine.depth.rawValue,      lines.heartSource),
            ("Heart continuity", lines.heartLine.continuity.rawValue, lines.heartSource),
            ("Head length",      lines.headLine.length.rawValue,      lines.headSource),
            ("Head depth",       lines.headLine.depth.rawValue,       lines.headSource),
            ("Head continuity",  lines.headLine.continuity.rawValue,  lines.headSource),
            ("Life length",      lines.lifeLine.length.rawValue,      lines.lifeSource),
            ("Life depth",       lines.lifeLine.depth.rawValue,       lines.lifeSource),
            ("Life continuity",  lines.lifeLine.continuity.rawValue,  lines.lifeSource),
            ("Fate length",      fateLength,                          lines.fateSource),
            ("Fate depth",       fateDepth,                           lines.fateSource),
            ("Fate continuity",  fateContinuity,                      lines.fateSource),
            ("Hand shape",       handShape.shapeType.rawValue,        handShapeSource),
            ("Finger length",    handShape.fingerLength.rawValue,     handShapeSource),
            ("Palm ratio",       handShape.palmRatio.rawValue,        handShapeSource)
        ]
        for (m, source) in mounts {
            rows.append(("Mount \(m.mount.rawValue)", m.prominence.rawValue, source))
        }

        let labelWidth = rows.map { $0.label.count }.max() ?? 0
        let valueWidth = rows.map { $0.value.count }.max() ?? 0
        var output = "\n========== Palm Reading ==========\n"
        for row in rows {
            let labelPadding = String(repeating: " ", count: labelWidth - row.label.count)
            let valuePadding = String(repeating: " ", count: valueWidth - row.value.count)
            output += "\(row.label):\(labelPadding)  \(row.value)\(valuePadding)  [\(row.source.rawValue)]\n"
        }
        output += "==================================\n"
        print(output)
    }
    
    // MARK: - Hand Detection

    // Runs MediaPipe's HandLandmarker on the image and returns 21 palm
    // landmarks plus the raw handedness label ("Left" / "Right") emitted by
    // MediaPipe's classifier. MediaPipe's hand model is more geometrically
    // stable than Apple Vision's hand pose request — landmarks barely drift
    // between captures of the same palm in similar conditions.
    private func detectHandLandmarks(in image: UIImage) async throws -> (landmarks: [PalmLandmark], handedness: String?) {
        guard let landmarker = handLandmarker else {
            throw PalmAnalysisError.processingFailed
        }
        guard let mpImage = try? MPImage(uiImage: image) else {
            throw PalmAnalysisError.invalidImage
        }

        let result: HandLandmarkerResult
        do {
            result = try landmarker.detect(image: mpImage)
        } catch {
            print("[PalmAnalysis] HandLandmarker.detect failed: \(error)")
            throw PalmAnalysisError.noHandDetected
        }

        guard let firstHand = result.landmarks.first, firstHand.count == 21 else {
            throw PalmAnalysisError.noHandDetected
        }

        let landmarks = firstHand.map { PalmLandmark(x: CGFloat($0.x), y: CGFloat($0.y), z: CGFloat($0.z)) }
        let handednessLabel = result.handedness.first?.first?.categoryName
        if let label = handednessLabel, let score = result.handedness.first?.first?.score {
            print(String(format: "[PalmAnalysis] MediaPipe handedness: %@ (score=%.2f)", label, score))
        }
        return (landmarks, handednessLabel)
    }

    // MARK: - Palm Side Validation

    // Rejects images where the user is showing the back of their hand instead
    // of the palm. Without this check the contour detector traces knuckle
    // wrinkles and finger-joint creases, producing the same "lines" output as
    // if it had seen a real palm — the user gets a confidently wrong reading.
    //
    // Algorithm: in image-space, compute the 2D cross product of the wrist→
    // indexMCP and wrist→littleMCP vectors. Its sign encodes the winding
    // direction of the index→little sweep. For each MediaPipe handedness
    // label, the winding sign that corresponds to a palm-facing hand is
    // fixed; the opposite sign means the back is shown.
    //
    // MediaPipe assumes the input is mirrored (selfie convention). Our camera
    // pipeline uses the back camera (non-mirrored), so MediaPipe's label is
    // the opposite of the real hand — but that doesn't matter for this check,
    // because the relationship "label X + winding Y ⇔ palm side" is internally
    // consistent within MediaPipe's own coordinate convention.
    private func validatePalmSide(_ landmarks: [PalmLandmark], mediaPipeHandedness: String?) throws {
        let wrist = landmarks[HandLandmark.wrist.rawValue]
        let indexMCP = landmarks[HandLandmark.indexMCP.rawValue]
        let littleMCP = landmarks[HandLandmark.littleMCP.rawValue]

        let v1x = indexMCP.x - wrist.x
        let v1y = indexMCP.y - wrist.y
        let v2x = littleMCP.x - wrist.x
        let v2y = littleMCP.y - wrist.y

        // 2D cross product z-component (image coords use top-left origin
        // with y-down, so signs are inverted relative to standard math
        // convention — that's already baked into the expected-sign table
        // below).
        let cross = v1x * v2y - v1y * v2x

        let isPalmFacing: Bool
        switch mediaPipeHandedness {
        case "Left":
            // Empirical rule verified against on-device captures: a real
            // left palm shown to the back camera produces MediaPipe label
            // "Left" together with a positive 2D cross-product of the
            // wrist→index, wrist→little vectors. Inverting the sign
            // therefore reliably signals the back of the hand.
            isPalmFacing = cross > 0
        case "Right":
            isPalmFacing = cross < 0
        default:
            // No handedness label — fall through without false-rejecting.
            print("[PalmAnalysis] palm-side check: no handedness label, skipping")
            return
        }

        print(String(format: "[PalmAnalysis] palm-side check: handedness=%@ cross=%.4f → %@",
                     mediaPipeHandedness ?? "?", cross, isPalmFacing ? "palm" : "back"))

        if !isPalmFacing {
            throw PalmAnalysisError.wrongHandSide
        }
    }

    // Converts MediaPipe's classifier label to the real-world hand the user
    // photographed. Verified against device behavior: the capture pipeline
    // (camera preview + saved JPEG) already presents the image in the
    // orientation MediaPipe expects, so the label is taken as-is rather
    // than swapped.
    private func realHandedness(fromMediaPipeLabel label: String?) -> Handedness? {
        switch label {
        case "Left": return .left
        case "Right": return .right
        default: return nil
        }
    }

    // MARK: - Open Palm Validation

    // Verifies that the detected hand is open with extended fingers.
    // MediaPipe always returns 21 landmarks when detection succeeds, so we
    // skip per-landmark confidence checks (already enforced by the
    // detector's minHandDetectionConfidence threshold) and just gate on
    // finger straightness — which catches fists and curled fingers.
    private func validateOpenPalm(_ landmarks: [PalmLandmark]) throws {
        // Ratio of straight-line MCP→TIP distance to the sum of the three
        // finger segments. 1.0 = perfectly straight; a fist collapses to
        // ~0.4. 0.80 accepts a naturally relaxed open hand.
        let straightnessThreshold: CGFloat = 0.80

        let fingers: [(mcp: HandLandmark, pip: HandLandmark, dip: HandLandmark, tip: HandLandmark)] = [
            (.indexMCP, .indexPIP, .indexDIP, .indexTip),
            (.middleMCP, .middlePIP, .middleDIP, .middleTip),
            (.ringMCP, .ringPIP, .ringDIP, .ringTip),
            (.littleMCP, .littlePIP, .littleDIP, .littleTip)
        ]

        for finger in fingers {
            let mcp = landmarks[finger.mcp.rawValue]
            let pip = landmarks[finger.pip.rawValue]
            let dip = landmarks[finger.dip.rawValue]
            let tip = landmarks[finger.tip.rawValue]

            let directDistance = calculateDistance(from: mcp, to: tip)
            let segmentedDistance = calculateDistance(from: mcp, to: pip)
                + calculateDistance(from: pip, to: dip)
                + calculateDistance(from: dip, to: tip)

            guard segmentedDistance > 0 else {
                throw PalmAnalysisError.fingersNotExtended
            }

            let straightness = directDistance / segmentedDistance
            if straightness < straightnessThreshold {
                throw PalmAnalysisError.fingersNotExtended
            }
        }
    }

    // MARK: - Line Analysis

    private enum LineAxis {
        case horizontal // line runs across the palm — coverage measured in vertical strips
        case vertical   // line runs along the palm — coverage measured in horizontal strips
    }

    private struct LineMetrics {
        let edgeRatio: Float    // proportion of ROI pixels above the edge brightness threshold
        let avgIntensity: Float // average pixel brightness in the ROI, normalized to 0...1
        let coverage: Float     // fraction of strips along the line's axis that contain at least one edge pixel
    }

    private func analyzePalmLines(edgePixels: EdgePixels, handFrame: HandFrame) -> (
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?,
        heartSource: ReadingSource,
        headSource: ReadingSource,
        lifeSource: ReadingSource,
        fateSource: ReadingSource
    ) {
        // ROIs in hand-local coordinates. (a, b) where:
        //   a ∈ [-0.5, 0.5] runs along palmRight (across the palm)
        //   b ∈ [0, 1] runs along palmUp (wrist → MCPs)
        // Tightened ranges to stay well inside the palm interior so the
        // samples don't pick up palm-background or finger-crease edges.
        let heartRect = HandLocalRect(aRange: -0.32 ... 0.32, bRange: 0.72 ... 0.86)
        let headRect  = HandLocalRect(aRange: -0.32 ... 0.32, bRange: 0.45 ... 0.66)
        // Life line curves diagonally along the thumb ball — a rectangular
        // ROI can only approximate it. Widened a-range (was -0.42...-0.22)
        // catches both the near-index top (a≈-0.28) and the near-wrist
        // bottom (a≈-0.18) of the curve. bRange extended down to 0.20 to
        // reach where the line meets the wrist crease.
        let lifeRect  = HandLocalRect(aRange: -0.44 ... -0.15, bRange: 0.20 ... 0.85)
        let fateRect  = HandLocalRect(aRange: -0.12 ... 0.12, bRange: 0.25 ... 0.82)

        let (heartLine, heartSource) = analyzeLine(edgePixels, handFrame: handFrame, rect: heartRect, line: .heart, axis: .horizontal)
        let (headLine, headSource)   = analyzeLine(edgePixels, handFrame: handFrame, rect: headRect,  line: .head,  axis: .horizontal)
        let (lifeLine, lifeSource)   = analyzeLine(edgePixels, handFrame: handFrame, rect: lifeRect,  line: .life,  axis: .vertical)
        let (fateLine, fateSource)   = analyzeFateLine(edgePixels, handFrame: handFrame, rect: fateRect)

        return (heartLine, headLine, lifeLine, fateLine, heartSource, headSource, lifeSource, fateSource)
    }

    // Converts a MediaPipe-style PalmLandmark (normalized [0,1], top-left
    // origin) into top-left image pixel coordinates. No Y-flip needed —
    // MediaPipe's convention already matches the image pixel layout.
    private func toImagePoint(_ landmark: PalmLandmark, imageSize: CGSize) -> CGPoint {
        return CGPoint(
            x: landmark.x * imageSize.width,
            y: landmark.y * imageSize.height
        )
    }

    // Hand-local 2D frame. (a, b) coordinates live in palm space and are
    // mapped to image pixels via toImage so that ROIs stay on the palm
    // regardless of how the hand is rotated in the photograph.
    private struct HandFrame {
        let wrist: CGPoint
        let palmRight: CGPoint
        let palmUp: CGPoint

        func toImage(a: CGFloat, b: CGFloat) -> CGPoint {
            return CGPoint(
                x: wrist.x + a * palmRight.x + b * palmUp.x,
                y: wrist.y + a * palmRight.y + b * palmUp.y
            )
        }
    }

    private struct HandLocalRect {
        let aRange: ClosedRange<CGFloat>
        let bRange: ClosedRange<CGFloat>
    }

    // Pre-decoded RGBA representation of the edge image, used for
    // pixel-precise brightness lookups during hand-local ROI sampling.
    private struct EdgePixels {
        let buffer: [UInt8]
        let width: Int
        let height: Int
        let bytesPerRow: Int

        func brightness(atPixel x: Int, _ y: Int) -> UInt32? {
            guard x >= 0, x < width, y >= 0, y < height else { return nil }
            let offset = y * bytesPerRow + x * 4
            let r = UInt32(buffer[offset])
            let g = UInt32(buffer[offset + 1])
            let b = UInt32(buffer[offset + 2])
            return (r + g + b) / 3
        }
    }

    private func decodeRGBA(from cgImage: CGImage) -> EdgePixels? {
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        var buffer = [UInt8](repeating: 0, count: width * height * bytesPerPixel)

        guard let context = CGContext(
            data: &buffer,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return EdgePixels(buffer: buffer, width: width, height: height, bytesPerRow: bytesPerRow)
    }

    private func lerp(_ range: ClosedRange<CGFloat>, t: CGFloat) -> CGFloat {
        return range.lowerBound + (range.upperBound - range.lowerBound) * t
    }
    
    // Pull the palm-anatomical landmarks we care about out of MediaPipe's
    // 21-landmark output. Throws if the array isn't fully populated.
    private func getPalmKeyPoints(from landmarks: [PalmLandmark]) throws -> PalmKeyPoints {
        guard landmarks.count >= 21 else {
            throw PalmAnalysisError.noHandDetected
        }
        return PalmKeyPoints(
            wrist:      landmarks[HandLandmark.wrist.rawValue],
            thumbBase:  landmarks[HandLandmark.thumbCMC.rawValue],
            indexBase:  landmarks[HandLandmark.indexMCP.rawValue],
            middleBase: landmarks[HandLandmark.middleMCP.rawValue],
            ringBase:   landmarks[HandLandmark.ringMCP.rawValue],
            littleBase: landmarks[HandLandmark.littleMCP.rawValue]
        )
    }
    
    // MARK: - Image Processing

    // Re-renders a UIImage so its underlying cgImage matches the displayed
    // orientation (imageOrientation becomes .up). Required because Vision
    // and Core Image read raw cgImage pixels — without this, a portrait
    // photo from the camera (orientation .right) would be processed sideways.
    private func normalizeOrientation(of image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = image.scale
        let renderer = UIGraphicsImageRenderer(size: image.size, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: image.size))
        }
    }

    // Downsamples a UIImage so its longer edge is at most maxDimension
    // (points). Drops scale to 1.0 to avoid Retina-doubling the pixel count.
    // Returns the input untouched if it's already small enough.
    private func downscale(_ image: UIImage, maxDimension: CGFloat) -> UIImage {
        let longest = max(image.size.width, image.size.height)
        guard longest > maxDimension else { return image }
        let scale = maxDimension / longest
        let targetSize = CGSize(width: image.size.width * scale,
                                height: image.size.height * scale)
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = 1.0
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }

    // Detects palm-line contours via Apple's Vision framework and rasterizes
    // them into a binary mask. Replaces the older CIEdges-based gradient
    // detector. Advantages: Vision's contour detector is purpose-built for
    // line-like structures, handles low contrast better, and gives us vector
    // paths (so we could later filter by length, curvature, etc.).
    private func detectContoursMask(of image: UIImage) -> (mask: UIImage, contourCount: Int, topLevelCount: Int)? {
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)

        // Auto-exposure normalize so Vision sees consistent brightness
        // regardless of ambient light.
        let exposureNormalized: CIImage
        if let sceneMean = computeMeanLuminance(of: ciImage), sceneMean > 0.01 {
            let targetLuminance: Float = 0.55
            let evAdjustment = log2(targetLuminance / sceneMean)
            let clampedEV = max(-1.5, min(2.5, evAdjustment))
            print(String(format: "[PalmAnalysis] scene mean=%.3f EV adjust=%.2f", sceneMean, clampedEV))
            if let expFilter = CIFilter(name: "CIExposureAdjust") {
                expFilter.setValue(ciImage, forKey: kCIInputImageKey)
                expFilter.setValue(clampedEV, forKey: kCIInputEVKey)
                exposureNormalized = expFilter.outputImage ?? ciImage
            } else {
                exposureNormalized = ciImage
            }
        } else {
            exposureNormalized = ciImage
        }

        // Grayscale + contrast + sharpen. Palm creases are only ~10-20
        // luminance units darker than surrounding skin, which is right at
        // Vision's contour-detection noise floor — without this pre-pass,
        // the same hand can produce 5× more or fewer contours depending on
        // subtle lighting shifts. Desaturating removes skin-tone color
        // variance; the contrast bump widens the crease-vs-skin gap; the
        // unsharp mask emphasizes the thin dark lines specifically.
        //
        // Shadow-lifting was tried and dropped: pushing shadow midtones
        // up amplified noise enough that Vision fragmented crease lines
        // into hundreds of tiny disconnected contours (topLevel count
        // went from ~130 to ~700 while ROI signal collapsed to zero).
        var preprocessed = exposureNormalized
        if let colorFilter = CIFilter(name: "CIColorControls") {
            colorFilter.setValue(preprocessed, forKey: kCIInputImageKey)
            colorFilter.setValue(0.0, forKey: kCIInputSaturationKey)
            colorFilter.setValue(1.35, forKey: kCIInputContrastKey)
            colorFilter.setValue(0.0, forKey: kCIInputBrightnessKey)
            if let out = colorFilter.outputImage {
                preprocessed = out
            }
        }
        if let sharpen = CIFilter(name: "CIUnsharpMask") {
            sharpen.setValue(preprocessed, forKey: kCIInputImageKey)
            sharpen.setValue(1.5, forKey: kCIInputRadiusKey)
            sharpen.setValue(0.8, forKey: kCIInputIntensityKey)
            if let out = sharpen.outputImage {
                preprocessed = out
            }
        }

        guard let normalizedCG = ciContext.createCGImage(preprocessed, from: preprocessed.extent) else {
            return nil
        }

        let request = VNDetectContoursRequest()
        // contrastAdjustment widens the luminance distribution before contour
        // tracing — palm creases are subtle, so we push this above default.
        request.contrastAdjustment = 2.0
        // Palm creases are darker than surrounding skin.
        request.detectsDarkOnLight = true
        // Lower internal processing dimension speeds up Vision considerably.
        // 768 still catches major palm creases at 12MP input but cuts work
        // by ~30% vs 1024.
        request.maximumImageDimension = 768

        let handler = VNImageRequestHandler(cgImage: normalizedCG, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("[PalmAnalysis] contour detection failed: \(error)")
            return nil
        }

        guard let observation = request.results?.first as? VNContoursObservation else {
            return nil
        }

        print("[PalmAnalysis] contours total=\(observation.contourCount) topLevel=\(observation.topLevelContourCount)")

        guard let mask = rasterizeContours(observation, size: CGSize(width: cgImage.width, height: cgImage.height)) else {
            return nil
        }
        return (mask, observation.contourCount, observation.topLevelContourCount)
    }

    // Draws the detected contours into a black-and-white mask the same size
    // as the input image. Uses observation.normalizedPath (all contours in a
    // single path) rather than iterating topLevelContours — VNContour's own
    // normalizedPath only covers that one contour's outline, so palm creases
    // (which are children of the palm silhouette) would be skipped entirely.
    private func rasterizeContours(_ observation: VNContoursObservation, size: CGSize) -> UIImage? {
        let width = Int(size.width)
        let height = Int(size.height)
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        // Black background.
        context.setFillColor(CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1))
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        // White stroke on black — palm creases appear as bright stripes the
        // ROI sampler can hit. 4 px roughly matches real crease width at
        // 1536-max downscale; wider strokes (10 px prior) over-saturated
        // small mount ROIs so every mount classified as "prominent."
        // Sampling grid is ~2-5 px between samples, so 4 px + round caps
        // still gets reliably hit even with slight registration offsets.
        context.setStrokeColor(CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1))
        context.setLineWidth(4.0)
        context.setLineCap(.round)
        context.setLineJoin(.round)

        // Vision returns paths in normalized [0,1] coordinates with origin
        // at bottom-left. CGContext's default coordinate system is also
        // bottom-left, so a plain scale by image size lands the contours
        // at the right pixel positions — the resulting CGImage reads back
        // with the standard top-left orientation our sampler expects.
        var transform = CGAffineTransform(scaleX: size.width, y: size.height)
        let combinedPath = observation.normalizedPath
        if let scaledPath = combinedPath.copy(using: &transform) {
            context.addPath(scaledPath)
            context.strokePath()
        }

        guard let outputImage = context.makeImage() else { return nil }
        return UIImage(cgImage: outputImage)
    }

    // Returns the average luminance (0...1) of the entire image.
    private func computeMeanLuminance(of ciImage: CIImage) -> Float? {
        guard let avgFilter = CIFilter(name: "CIAreaAverage") else { return nil }
        avgFilter.setValue(ciImage, forKey: kCIInputImageKey)
        avgFilter.setValue(CIVector(cgRect: ciImage.extent), forKey: kCIInputExtentKey)
        guard let outImage = avgFilter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        ciContext.render(
            outImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )
        return (Float(bitmap[0]) + Float(bitmap[1]) + Float(bitmap[2])) / (3.0 * 255.0)
    }
    
    // MARK: - Per-Line Metric Mapping

    private func analyzeLine(
        _ edgePixels: EdgePixels,
        handFrame: HandFrame,
        rect: HandLocalRect,
        line: PalmLine,
        axis: LineAxis
    ) -> (PalmLineCharacteristics, source: ReadingSource) {
        guard let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: axis) else {
            return (PalmLineCharacteristics(line: line, length: .medium, depth: .moderate, continuity: .continuous), .defaulted)
        }

        // Combined length score: combining edgeRatio and coverage damps the
        // noise of either signal alone — they are correlated but noisy in
        // different ways, so the sum is more stable across captures of the
        // same palm than either individually.
        let lengthScore = metrics.edgeRatio * 8 + metrics.coverage * 0.3

        // Thresholds recalibrated after palm-region exposure metering
        // started delivering full-strength captures (contour counts
        // 500-3000+ vs. earlier 180-1000). At the old bar every well-lit
        // palm read long/deep/continuous across all four lines — the top
        // bucket got saturated and stopped differentiating hands. Bar
        // raised to 1.5 so "long" now means the line clearly dominates
        // the ROI (not just any line with coverage=1.0), and "medium"
        // requires meaningful presence.
        let length: PalmLineCharacteristics.LineLength
        if lengthScore >= 1.5 {
            length = .long
        } else if lengthScore >= 0.40 {
            length = .medium
        } else {
            length = .short
        }

        // Depth bar raised from 0.14 → 0.20 for the same reason: with
        // the stronger mask, moderate palm lines were reading as deep.
        // "Moderate" threshold nudged from 0.05 → 0.08 to keep the
        // three-band spread even.
        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.20 {
            depth = .deep
        } else if metrics.avgIntensity >= 0.08 {
            depth = .moderate
        } else {
            depth = .faint
        }

        // Continuity tuned to 0.035: head/fate edges in 0.04-0.08 range
        // reliably stabilize at "continuous" instead of flipping to
        // "chained" at the previous 0.05 boundary.
        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.edgeRatio >= 0.035 {
            continuity = .continuous
        } else if metrics.edgeRatio >= 0.015 {
            continuity = .chained
        } else {
            continuity = .broken
        }

        print(String(format: "[PalmAnalysis] %@: edges=%.3f intensity=%.3f coverage=%.3f score=%.3f → %@/%@/%@",
                     line.rawValue, metrics.edgeRatio, metrics.avgIntensity, metrics.coverage, lengthScore,
                     length.rawValue, depth.rawValue, continuity.rawValue))

        // Below this edge ratio the ROI has essentially no bright pixels, so
        // length/depth/continuity all collapse to their low-end enum values —
        // effectively the same as a fallback rather than a real measurement.
        let source: ReadingSource = metrics.edgeRatio < 0.005 ? .noSignal : .measured
        return (PalmLineCharacteristics(line: line, length: length, depth: depth, continuity: continuity), source)
    }

    // Fate line is often absent in real palms; only declare it present when
    // the ROI shows a clear vertical signal above the noise floor.
    private func analyzeFateLine(_ edgePixels: EdgePixels, handFrame: HandFrame, rect: HandLocalRect) -> (PalmLineCharacteristics?, source: ReadingSource) {
        guard let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: .vertical) else {
            return (nil, .defaulted)
        }

        let lengthScore = metrics.edgeRatio * 8 + metrics.coverage * 0.3

        print(String(format: "[PalmAnalysis] fate:  edges=%.3f intensity=%.3f coverage=%.3f score=%.3f",
                     metrics.edgeRatio, metrics.avgIntensity, metrics.coverage, lengthScore))

        // Presence gate: require both a minimum edge density and coverage.
        // Lowered from 0.020/0.35 — real fate lines at edge≈0.017 with
        // solid coverage were being rejected; the new floor still filters
        // out captures showing effectively no vertical signal.
        let minimumEdgeRatio: Float = 0.015
        let minimumCoverage: Float = 0.30
        guard metrics.edgeRatio >= minimumEdgeRatio, metrics.coverage >= minimumCoverage else {
            // Distinguish "sampled but nothing there" from "presence gate failed
            // with some signal": both leave fateLine=nil, but the log source
            // differs so we can tell which happened.
            return (nil, metrics.edgeRatio < 0.005 ? .noSignal : .absent)
        }

        // Fate line uses the same length/depth thresholds as the other
        // lines so classifications are comparable across the reading.
        let length: PalmLineCharacteristics.LineLength
        if lengthScore >= 1.5 { length = .long }
        else if lengthScore >= 0.40 { length = .medium }
        else { length = .short }

        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.20 { depth = .deep }
        else if metrics.avgIntensity >= 0.08 { depth = .moderate }
        else { depth = .faint }

        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.edgeRatio >= 0.035 { continuity = .continuous }
        else if metrics.edgeRatio >= 0.015 { continuity = .chained }
        else { continuity = .broken }

        return (PalmLineCharacteristics(line: .fate, length: length, depth: depth, continuity: continuity), .measured)
    }

    // Samples the edge image on a regular grid laid out in hand-local
    // coordinates. Two-pass: first pass collects sample brightnesses to
    // compute an ROI-adaptive threshold (mean * factor), second pass
    // counts edges and strip coverage. Adaptive threshold means a dim
    // capture's faint edges still register relative to the local noise
    // floor instead of being clipped by a fixed 80/255 cutoff.
    private func sampleLineMetrics(
        _ edgePixels: EdgePixels,
        handFrame: HandFrame,
        rect: HandLocalRect,
        axis: LineAxis
    ) -> LineMetrics? {
        let alongSamples = 64
        let acrossSamples = 12
        let aSamples: Int
        let bSamples: Int
        switch axis {
        case .horizontal:
            aSamples = alongSamples
            bSamples = acrossSamples
        case .vertical:
            aSamples = acrossSamples
            bSamples = alongSamples
        }

        struct Sample { let brightness: UInt32; let ai: Int; let bi: Int }
        var samples: [Sample] = []
        samples.reserveCapacity(aSamples * bSamples)
        var intensitySum: UInt64 = 0

        for ai in 0..<aSamples {
            for bi in 0..<bSamples {
                let a = lerp(rect.aRange, t: CGFloat(ai) / CGFloat(max(1, aSamples - 1)))
                let b = lerp(rect.bRange, t: CGFloat(bi) / CGFloat(max(1, bSamples - 1)))
                let point = handFrame.toImage(a: a, b: b)
                let x = Int(point.x.rounded())
                let y = Int(point.y.rounded())

                guard let brightness = edgePixels.brightness(atPixel: x, y) else { continue }
                samples.append(Sample(brightness: brightness, ai: ai, bi: bi))
                intensitySum += UInt64(brightness)
            }
        }

        guard samples.count > 16 else { return nil }

        let totalSamples = samples.count
        let meanBrightness = Float(intensitySum) / Float(totalSamples)

        // Fixed mid-point threshold. The contour mask is essentially binary
        // (white strokes on black), so a pixel is either inside a stroke
        // (≈255) or in background (0), with anti-aliased ramp in between.
        // 128 cleanly separates the two. Earlier adaptive formula
        // (mean * 2.6) saturated above 255 when ROI was densely stroked,
        // producing the misleading "edges=0 intensity=0.4" combination.
        let edgeThreshold: UInt32 = 128

        let stripCount = 8
        var stripHasEdge = [Bool](repeating: false, count: stripCount)
        var edgeCount = 0

        for sample in samples {
            if sample.brightness >= edgeThreshold {
                edgeCount += 1
                let stripIndex: Int
                switch axis {
                case .horizontal: stripIndex = min(stripCount - 1, sample.ai * stripCount / aSamples)
                case .vertical:   stripIndex = min(stripCount - 1, sample.bi * stripCount / bSamples)
                }
                stripHasEdge[stripIndex] = true
            }
        }

        let stripsWithEdge = stripHasEdge.filter { $0 }.count
        return LineMetrics(
            edgeRatio: Float(edgeCount) / Float(totalSamples),
            avgIntensity: meanBrightness / 255.0,
            coverage: Float(stripsWithEdge) / Float(stripCount)
        )
    }

    private func calculateDistance(from a: PalmLandmark, to b: PalmLandmark) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx * dx + dy * dy)
    }
    
    // MARK: - Hand Shape Analysis
    
    private func analyzeHandShape(using landmarks: [PalmLandmark]) -> (HandShapeAnalysis, source: ReadingSource) {
        guard let palmPoints = try? getPalmKeyPoints(from: landmarks),
              landmarks.count > HandLandmark.middleTip.rawValue else {
            return (HandShapeAnalysis(
                shapeType: .earth,
                fingerLength: .average,
                palmRatio: .square
            ), .defaulted)
        }
        let middleTip = landmarks[HandLandmark.middleTip.rawValue]

        // Calculate palm dimensions in normalized coords.
        let palmWidth = calculateDistance(from: palmPoints.indexBase, to: palmPoints.littleBase)
        let palmHeight = calculateDistance(from: palmPoints.wrist, to: palmPoints.middleBase)

        // Calculate finger length (using middle finger as reference)
        let fingerLength = calculateDistance(from: palmPoints.middleBase, to: middleTip)

        // Determine palm ratio. Threshold raised to 1.25 because normalized
        // landmark coords squash the y axis on portrait photos, so the
        // ratio sits near 1.1-1.2 for most square-ish palms and would
        // otherwise flip square↔rectangular between captures.
        let heightToWidthRatio = palmHeight / palmWidth
        let palmRatio: HandShapeAnalysis.PalmRatio = heightToWidthRatio > 1.25 ? .rectangular : .square
        
        // Determine finger length relative to palm
        let fingerToPalmRatio = fingerLength / palmHeight
        let fingerLengthCategory: HandShapeAnalysis.FingerLength
        if fingerToPalmRatio > 0.95 {
            fingerLengthCategory = .long
        } else if fingerToPalmRatio > 0.75 {
            fingerLengthCategory = .average
        } else {
            fingerLengthCategory = .short
        }
        
        // Determine hand shape type based on palm ratio and finger length
        let shapeType: HandShapeAnalysis.HandShapeType
        switch (palmRatio, fingerLengthCategory) {
        case (.square, .short), (.square, .average):
            shapeType = .earth
        case (.square, .long):
            shapeType = .air
        case (.rectangular, .long):
            shapeType = .water
        case (.rectangular, .short), (.rectangular, .average):
            shapeType = .fire
        }
        
        return (HandShapeAnalysis(
            shapeType: shapeType,
            fingerLength: fingerLengthCategory,
            palmRatio: palmRatio
        ), .measured)
    }
    
    // MARK: - Mount Analysis

    // Each mount is a region of the palm. Prominent mounts physically bulge
    // - we cannot measure that in 2D, so we use edge density in the mount's
    // ROI as a proxy: prominent mounts have more skin folding, creases,
    // and texture relative to flat (smooth) regions.
    private func analyzePalmMounts(edgePixels: EdgePixels, handFrame: HandFrame) -> [(mount: PalmMountCharacteristics, source: ReadingSource)] {
        // ROIs in hand-local coordinates. Thumb side sits at a < 0 (because
        // palmRight is defined as index → little, away from the thumb).
        let mountROIs: [(mount: PalmMount, rect: HandLocalRect)] = [
            // Finger-base mounts: bands just below each MCP.
            (.jupiter,   HandLocalRect(aRange: -0.50 ... -0.28, bRange: 0.76 ... 0.92)),
            (.saturn,    HandLocalRect(aRange: -0.12 ...  0.12, bRange: 0.76 ... 0.92)),
            (.apollo,    HandLocalRect(aRange:  0.15 ...  0.32, bRange: 0.76 ... 0.92)),
            (.mercury,   HandLocalRect(aRange:  0.34 ...  0.50, bRange: 0.76 ... 0.92)),
            // Side mounts: Venus is the thumb ball, Moon (Luna) is on the
            // percussion side opposite the thumb, near the wrist.
            (.venus,     HandLocalRect(aRange: -0.55 ... -0.32, bRange: 0.15 ... 0.50)),
            (.moon,      HandLocalRect(aRange:  0.32 ...  0.50, bRange: 0.12 ... 0.42)),
            // Mars Upper (active): thumb side mid-palm.
            // Mars Lower (passive): percussion side mid-palm.
            (.marsUpper, HandLocalRect(aRange: -0.42 ... -0.25, bRange: 0.55 ... 0.72)),
            (.marsLower, HandLocalRect(aRange:  0.28 ...  0.48, bRange: 0.48 ... 0.65)),
            // Neptune sits at the bottom-center of the palm between Venus
            // and Moon, right above the wrist.
            (.neptune,   HandLocalRect(aRange: -0.18 ...  0.18, bRange: 0.05 ... 0.22))
        ]

        var results: [(mount: PalmMountCharacteristics, source: ReadingSource)] = []
        for (mount, rect) in mountROIs {
            let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: .horizontal)
            let prominence = mountProminence(from: metrics)
            let source: ReadingSource
            if let m = metrics {
                print(String(format: "[PalmAnalysis] mount %@: edges=%.3f intensity=%.3f → %@",
                             mount.rawValue, m.edgeRatio, m.avgIntensity, prominence.rawValue))
                source = m.edgeRatio < 0.005 ? .noSignal : .measured
            } else {
                print("[PalmAnalysis] mount \(mount.rawValue): off-image → \(prominence.rawValue)")
                source = .defaulted
            }
            results.append((PalmMountCharacteristics(mount: mount, prominence: prominence), source))
        }
        return results
    }

    private func mountProminence(from metrics: LineMetrics?) -> PalmMountCharacteristics.MountProminence {
        // Off-image or undersampled ROIs default to .normal rather than .flat
        // so a clipped landmark doesn't read as a missing mount.
        guard let metrics = metrics else { return .normal }

        // Thresholds bumped after camera-region metering produced stronger
        // masks (0.065/0.028 previously left 6-7 of 9 mounts reading
        // "prominent" on well-lit palms). New bar reserves .prominent for
        // mounts with clearly denser crease texture than surrounding skin.
        if metrics.edgeRatio >= 0.15 {
            return .prominent
        } else if metrics.edgeRatio >= 0.05 {
            return .normal
        } else {
            return .flat
        }
    }
}

// MARK: - Supporting Types

struct PalmKeyPoints {
    let wrist: PalmLandmark
    let thumbBase: PalmLandmark
    let indexBase: PalmLandmark
    let middleBase: PalmLandmark
    let ringBase: PalmLandmark
    let littleBase: PalmLandmark
}

enum PalmAnalysisError: LocalizedError {
    case invalidImage
    case noHandDetected
    case fingersNotExtended
    case lowConfidence
    case processingFailed
    case wrongHandSide
    case poorLighting

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return L10n.palmAnalysisErrorInvalidImage
        case .noHandDetected:
            return L10n.palmAnalysisErrorNoHandDetected
        case .fingersNotExtended:
            return L10n.palmAnalysisErrorFingersNotExtended
        case .lowConfidence:
            return L10n.palmAnalysisErrorLowConfidence
        case .processingFailed:
            return L10n.palmAnalysisErrorProcessingFailed
        case .wrongHandSide:
            return L10n.palmAnalysisErrorWrongHandSide
        case .poorLighting:
            return L10n.palmAnalysisErrorPoorLighting
        }
    }
}
