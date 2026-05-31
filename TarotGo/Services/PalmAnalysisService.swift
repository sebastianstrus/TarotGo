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

@MainActor
class PalmAnalysisService {
    static let shared = PalmAnalysisService()
    
    private init() {}
    
    // Analyze palm image and generate reading
    func analyzePalm(image originalImage: UIImage) async throws -> PalmReading {
        // Normalize the UIImage so its cgImage matches the displayed
        // orientation. Camera captures usually arrive with .right
        // orientation (sensor is landscape, display is portrait), which
        // means Vision and edge-detection would otherwise see a sideways
        // hand and produce noisier landmarks.
        let image = normalizeOrientation(of: originalImage)

        // Step 1: Detect hand landmarks
        let handLandmarks = try await detectHandLandmarks(in: image)

        // Step 2: Validate that the hand is open with extended fingers
        try validateOpenPalm(handLandmarks)

        // Step 3: Build the edge image + hand-local frame. Both lines and
        // mounts read from this shared pipeline so edge detection runs once.
        let palmPoints = try getPalmKeyPoints(from: handLandmarks)

        guard let cgImage = image.cgImage,
              let contourMaskImage = detectContoursMask(of: image),
              let contourCGImage = contourMaskImage.cgImage,
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
        let handShape = analyzeHandShape(using: handLandmarks)

        // Step 6: Analyze palm mounts deterministically from the edge image
        let mounts = analyzePalmMounts(edgePixels: edgePixels, handFrame: handFrame)

        // Debug dump — one block per scan, easy to paste as a new column in a tracking table.
        logDebugReading(lines: lineCharacteristics, handShape: handShape, mounts: mounts)

        // Step 7: Create palm reading
        return PalmReading(
            heartLine: lineCharacteristics.heartLine,
            headLine: lineCharacteristics.headLine,
            lifeLine: lineCharacteristics.lifeLine,
            fateLine: lineCharacteristics.fateLine,
            mounts: mounts,
            handShape: handShape
        )
    }

    // MARK: - Debug Logging

    private func logDebugReading(
        lines: (
            heartLine: PalmLineCharacteristics,
            headLine: PalmLineCharacteristics,
            lifeLine: PalmLineCharacteristics,
            fateLine: PalmLineCharacteristics?
        ),
        handShape: HandShapeAnalysis,
        mounts: [PalmMountCharacteristics]
    ) {
        let absent = "—"
        let fateLength = lines.fateLine?.length.rawValue ?? absent
        let fateDepth = lines.fateLine?.depth.rawValue ?? absent
        let fateContinuity = lines.fateLine?.continuity.rawValue ?? absent

        var rows: [(String, String)] = [
            ("Heart length",     lines.heartLine.length.rawValue),
            ("Heart depth",      lines.heartLine.depth.rawValue),
            ("Heart continuity", lines.heartLine.continuity.rawValue),
            ("Head length",      lines.headLine.length.rawValue),
            ("Head depth",       lines.headLine.depth.rawValue),
            ("Head continuity",  lines.headLine.continuity.rawValue),
            ("Life length",      lines.lifeLine.length.rawValue),
            ("Life depth",       lines.lifeLine.depth.rawValue),
            ("Life continuity",  lines.lifeLine.continuity.rawValue),
            ("Fate length",      fateLength),
            ("Fate depth",       fateDepth),
            ("Fate continuity",  fateContinuity),
            ("Hand shape",       handShape.shapeType.rawValue),
            ("Finger length",    handShape.fingerLength.rawValue),
            ("Palm ratio",       handShape.palmRatio.rawValue)
        ]
        for m in mounts {
            rows.append(("Mount \(m.mount.rawValue)", m.prominence.rawValue))
        }

        let labelWidth = rows.map { $0.0.count }.max() ?? 0
        var output = "\n========== Palm Reading ==========\n"
        for (label, value) in rows {
            let padding = String(repeating: " ", count: labelWidth - label.count)
            output += "\(label):\(padding)  \(value)\n"
        }
        output += "==================================\n"
        print(output)
    }
    
    // MARK: - Hand Detection
    
    private func detectHandLandmarks(in image: UIImage) async throws -> VNHumanHandPoseObservation {
        guard let cgImage = image.cgImage else {
            throw PalmAnalysisError.invalidImage
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNDetectHumanHandPoseRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let observations = request.results as? [VNHumanHandPoseObservation],
                      let firstHand = observations.first else {
                    continuation.resume(throwing: PalmAnalysisError.noHandDetected)
                    return
                }
                
                continuation.resume(returning: firstHand)
            }
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }

    // MARK: - Open Palm Validation

    // Verifies that the detected hand is open with extended fingers and that
    // the key landmarks are confident enough to support a meaningful reading.
    // A closed fist still registers as a "hand" in Vision, so this guard
    // prevents the rest of the pipeline from running on bent/curled fingers.
    private func validateOpenPalm(_ observation: VNHumanHandPoseObservation) throws {
        // Vision recognizes joints with confidence in [0, 1]. Anything below
        // this is too unreliable to base a reading on.
        let minimumConfidence: Float = 0.3
        // Ratio of straight-line MCP→TIP distance to the sum of the three
        // finger segments. 1.0 means a perfectly straight finger; a fist
        // collapses to ~0.4. 0.80 is a comfortable threshold that still
        // accepts a naturally relaxed open hand.
        let straightnessThreshold: CGFloat = 0.80

        let fingers: [(mcp: VNHumanHandPoseObservation.JointName,
                       pip: VNHumanHandPoseObservation.JointName,
                       dip: VNHumanHandPoseObservation.JointName,
                       tip: VNHumanHandPoseObservation.JointName)] = [
            (.indexMCP, .indexPIP, .indexDIP, .indexTip),
            (.middleMCP, .middlePIP, .middleDIP, .middleTip),
            (.ringMCP, .ringPIP, .ringDIP, .ringTip),
            (.littleMCP, .littlePIP, .littleDIP, .littleTip)
        ]

        // Confidence gate first: if any required joint is missing or weak,
        // bail out before we trust the geometry.
        let requiredJoints: [VNHumanHandPoseObservation.JointName] = [
            .wrist,
            .indexMCP, .indexTip,
            .middleMCP, .middleTip,
            .ringMCP, .ringTip,
            .littleMCP, .littleTip
        ]
        for joint in requiredJoints {
            guard let point = try? observation.recognizedPoint(joint),
                  point.confidence >= minimumConfidence else {
                throw PalmAnalysisError.lowConfidence
            }
        }

        // Straightness check per finger.
        for finger in fingers {
            guard let mcp = try? observation.recognizedPoint(finger.mcp),
                  let pip = try? observation.recognizedPoint(finger.pip),
                  let dip = try? observation.recognizedPoint(finger.dip),
                  let tip = try? observation.recognizedPoint(finger.tip) else {
                throw PalmAnalysisError.lowConfidence
            }

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

    // MARK: - Palm Region Extraction
    
    private func extractPalmRegion(from image: UIImage, using landmarks: VNHumanHandPoseObservation) -> UIImage {
        guard let cgImage = image.cgImage else { return image }
        
        // Get key points to define palm boundary
        guard let wrist = try? landmarks.recognizedPoint(.wrist),
              let thumbCMC = try? landmarks.recognizedPoint(.thumbCMC),
              let indexMCP = try? landmarks.recognizedPoint(.indexMCP),
              let middleMCP = try? landmarks.recognizedPoint(.middleMCP),
              let ringMCP = try? landmarks.recognizedPoint(.ringMCP),
              let littleMCP = try? landmarks.recognizedPoint(.littleMCP),
              let indexTip = try? landmarks.recognizedPoint(.indexTip),
              let littleTip = try? landmarks.recognizedPoint(.littleTip) else {
            return image
        }
        
        // Vision framework uses normalized coordinates (0-1), origin at bottom-left
        // We need to convert to image coordinates
        let imageHeight = CGFloat(cgImage.height)
        let imageWidth = CGFloat(cgImage.width)
        
        // Convert normalized points to image coordinates
        func toImageCoords(_ point: VNRecognizedPoint) -> CGPoint {
            return CGPoint(
                x: point.location.x * imageWidth,
                y: (1.0 - point.location.y) * imageHeight // Flip Y axis
            )
        }
        
        let wristPoint = toImageCoords(wrist)
        let thumbPoint = toImageCoords(thumbCMC)
        let indexBasePoint = toImageCoords(indexMCP)
        let middleBasePoint = toImageCoords(middleMCP)
        let ringBasePoint = toImageCoords(ringMCP)
        let littleBasePoint = toImageCoords(littleMCP)
        let indexTipPoint = toImageCoords(indexTip)
        let littleTipPoint = toImageCoords(littleTip)
        
        // Calculate bounding box with some padding
        let points = [wristPoint, thumbPoint, indexBasePoint, middleBasePoint, 
                     ringBasePoint, littleBasePoint, indexTipPoint, littleTipPoint]
        
        let minX = points.map { $0.x }.min() ?? 0
        let maxX = points.map { $0.x }.max() ?? imageWidth
        let minY = points.map { $0.y }.min() ?? 0
        let maxY = points.map { $0.y }.max() ?? imageHeight
        
        // Add padding (10% on each side)
        let paddingX = (maxX - minX) * 0.1
        let paddingY = (maxY - minY) * 0.1
        
        let cropRect = CGRect(
            x: max(0, minX - paddingX),
            y: max(0, minY - paddingY),
            width: min(imageWidth - minX + paddingX, maxX - minX + 2 * paddingX),
            height: min(imageHeight - minY + paddingY, maxY - minY + 2 * paddingY)
        )
        
        // Crop the image
        guard let croppedCGImage = cgImage.cropping(to: cropRect) else {
            return image
        }
        
        return UIImage(cgImage: croppedCGImage, scale: image.scale, orientation: image.imageOrientation)
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
        fateLine: PalmLineCharacteristics?
    ) {
        // ROIs in hand-local coordinates. (a, b) where:
        //   a ∈ [-0.5, 0.5] runs along palmRight (across the palm)
        //   b ∈ [0, 1] runs along palmUp (wrist → MCPs)
        // Tightened ranges to stay well inside the palm interior so the
        // samples don't pick up palm-background or finger-crease edges.
        let heartRect = HandLocalRect(aRange: -0.32 ... 0.32, bRange: 0.72 ... 0.86)
        let headRect  = HandLocalRect(aRange: -0.32 ... 0.32, bRange: 0.48 ... 0.62)
        let lifeRect  = HandLocalRect(aRange: -0.42 ... -0.22, bRange: 0.30 ... 0.85)
        let fateRect  = HandLocalRect(aRange: -0.10 ... 0.10, bRange: 0.28 ... 0.78)

        let heartLine = analyzeLine(edgePixels, handFrame: handFrame, rect: heartRect, line: .heart, axis: .horizontal)
        let headLine  = analyzeLine(edgePixels, handFrame: handFrame, rect: headRect,  line: .head,  axis: .horizontal)
        let lifeLine  = analyzeLine(edgePixels, handFrame: handFrame, rect: lifeRect,  line: .life,  axis: .vertical)
        let fateLine  = analyzeFateLine(edgePixels, handFrame: handFrame, rect: fateRect)

        return (heartLine, headLine, lifeLine, fateLine)
    }

    // Converts a Vision normalized point (origin bottom-left) into top-left
    // pixel coordinates of the given image.
    private func toImagePoint(_ point: VNRecognizedPoint, imageSize: CGSize) -> CGPoint {
        return CGPoint(
            x: point.location.x * imageSize.width,
            y: (1.0 - point.location.y) * imageSize.height
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
    
    private func getPalmKeyPoints(from observation: VNHumanHandPoseObservation) throws -> PalmKeyPoints {
        // Extract key points from hand landmarks
        let wrist = try observation.recognizedPoint(.wrist)
        let thumbCMC = try observation.recognizedPoint(.thumbCMC)
        let indexMCP = try observation.recognizedPoint(.indexMCP)
        let middleMCP = try observation.recognizedPoint(.middleMCP)
        let ringMCP = try observation.recognizedPoint(.ringMCP)
        let littleMCP = try observation.recognizedPoint(.littleMCP)
        
        return PalmKeyPoints(
            wrist: wrist,
            thumbBase: thumbCMC,
            indexBase: indexMCP,
            middleBase: middleMCP,
            ringBase: ringMCP,
            littleBase: littleMCP
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

    // Detects palm-line contours via Apple's Vision framework and rasterizes
    // them into a binary mask. Replaces the older CIEdges-based gradient
    // detector. Advantages: Vision's contour detector is purpose-built for
    // line-like structures, handles low contrast better, and gives us vector
    // paths (so we could later filter by length, curvature, etc.).
    private func detectContoursMask(of image: UIImage) -> UIImage? {
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

        let context = CIContext()
        guard let normalizedCG = context.createCGImage(exposureNormalized, from: exposureNormalized.extent) else {
            return nil
        }

        let request = VNDetectContoursRequest()
        // contrastAdjustment widens the luminance distribution before contour
        // tracing — palm creases are subtle, so we push this above default.
        request.contrastAdjustment = 2.0
        // Palm creases are darker than surrounding skin.
        request.detectsDarkOnLight = true
        // Higher dimension catches finer creases. 1024 is a good balance of
        // detail and speed; 0 would use the full image at the cost of latency.
        request.maximumImageDimension = 1024

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

        return rasterizeContours(observation, size: CGSize(width: cgImage.width, height: cgImage.height))
    }

    // Draws the detected contours into a black-and-white mask the same size
    // as the input image. Top-level contour paths already include their
    // children combined with the even-odd winding rule, so iterating
    // topLevelContours and using .eoFillStroke renders the entire hierarchy.
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

        // White fill + stroke for contour interiors and outlines.
        context.setFillColor(CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1))
        context.setStrokeColor(CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1))
        context.setLineWidth(2.0)
        context.setLineCap(.round)
        context.setLineJoin(.round)

        // Vision returns paths in normalized [0,1] coordinates with origin
        // at bottom-left. CGContext's default coordinate system is also
        // bottom-left, so a plain scale by image size lands the contours
        // at the right pixel positions — the resulting CGImage reads back
        // with the standard top-left orientation our sampler expects.
        var transform = CGAffineTransform(scaleX: size.width, y: size.height)

        for contour in observation.topLevelContours {
            let normalizedPath = contour.normalizedPath
            if let scaledPath = normalizedPath.copy(using: &transform) {
                context.addPath(scaledPath)
                context.drawPath(using: .eoFillStroke)
            }
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
        let context = CIContext()
        context.render(
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
    ) -> PalmLineCharacteristics {
        guard let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: axis) else {
            return PalmLineCharacteristics(line: line, length: .medium, depth: .moderate, continuity: .continuous)
        }

        // Combined length score: combining edgeRatio and coverage damps the
        // noise of either signal alone — they are correlated but noisy in
        // different ways, so the sum is more stable across captures of the
        // same palm than either individually.
        let lengthScore = metrics.edgeRatio * 8 + metrics.coverage * 0.3

        let length: PalmLineCharacteristics.LineLength
        if lengthScore >= 0.70 {
            length = .long
        } else if lengthScore >= 0.40 {
            length = .medium
        } else {
            length = .short
        }

        // Adaptive thresholding compresses post-edge intensities into a
        // narrower band (~0.02-0.10 for typical palms). Bucket boundaries
        // are placed in the gaps between observed line clusters so faint
        // lines (life ≈ 0.027) split from moderate lines (heart/head/fate
        // ≈ 0.05-0.07) without flipping at boundaries.
        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.085 {
            depth = .deep
        } else if metrics.avgIntensity >= 0.038 {
            depth = .moderate
        } else {
            depth = .faint
        }

        // Continuity from edgeRatio alone: density of edge samples reflects
        // how unbroken the line signal is across its ROI.
        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.edgeRatio >= 0.05 {
            continuity = .continuous
        } else if metrics.edgeRatio >= 0.020 {
            continuity = .chained
        } else {
            continuity = .broken
        }

        print(String(format: "[PalmAnalysis] %@: edges=%.3f intensity=%.3f coverage=%.3f score=%.3f → %@/%@/%@",
                     line.rawValue, metrics.edgeRatio, metrics.avgIntensity, metrics.coverage, lengthScore,
                     length.rawValue, depth.rawValue, continuity.rawValue))

        return PalmLineCharacteristics(line: line, length: length, depth: depth, continuity: continuity)
    }

    // Fate line is often absent in real palms; only declare it present when
    // the ROI shows a clear vertical signal above the noise floor.
    private func analyzeFateLine(_ edgePixels: EdgePixels, handFrame: HandFrame, rect: HandLocalRect) -> PalmLineCharacteristics? {
        guard let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: .vertical) else {
            return nil
        }

        let lengthScore = metrics.edgeRatio * 8 + metrics.coverage * 0.3

        print(String(format: "[PalmAnalysis] fate:  edges=%.3f intensity=%.3f coverage=%.3f score=%.3f",
                     metrics.edgeRatio, metrics.avgIntensity, metrics.coverage, lengthScore))

        // Presence gate: require both a minimum edge density and coverage.
        let minimumEdgeRatio: Float = 0.020
        let minimumCoverage: Float = 0.35
        guard metrics.edgeRatio >= minimumEdgeRatio, metrics.coverage >= minimumCoverage else {
            return nil
        }

        let length: PalmLineCharacteristics.LineLength
        if lengthScore >= 0.70 { length = .long }
        else if lengthScore >= 0.40 { length = .medium }
        else { length = .short }

        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.085 { depth = .deep }
        else if metrics.avgIntensity >= 0.038 { depth = .moderate }
        else { depth = .faint }

        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.edgeRatio >= 0.05 { continuity = .continuous }
        else if metrics.edgeRatio >= 0.020 { continuity = .chained }
        else { continuity = .broken }

        return PalmLineCharacteristics(line: .fate, length: length, depth: depth, continuity: continuity)
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

        // Adaptive threshold: edge pixels must be substantially above the
        // ROI's mean brightness. Floor of 18 prevents false edges in
        // completely flat ROIs (where mean * factor would be near zero).
        let edgeThreshold = max(UInt32(18), UInt32(meanBrightness * 2.6))

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

    private func calculateDistance(from point1: VNRecognizedPoint, to point2: VNRecognizedPoint) -> CGFloat {
        let dx = point1.location.x - point2.location.x
        let dy = point1.location.y - point2.location.y
        return sqrt(dx * dx + dy * dy)
    }
    
    // MARK: - Hand Shape Analysis
    
    private func analyzeHandShape(using landmarks: VNHumanHandPoseObservation) -> HandShapeAnalysis {
        guard let palmPoints = try? getPalmKeyPoints(from: landmarks),
              let middleTip = try? landmarks.recognizedPoint(.middleTip) else {
            // Return default if analysis fails
            return HandShapeAnalysis(
                shapeType: .earth,
                fingerLength: .average,
                palmRatio: .square
            )
        }
        
        // Calculate palm dimensions
        let palmWidth = calculateDistance(from: palmPoints.indexBase, to: palmPoints.littleBase)
        let palmHeight = calculateDistance(from: palmPoints.wrist, to: palmPoints.middleBase)
        
        // Calculate finger length (using middle finger as reference)
        let fingerLength = calculateDistance(from: palmPoints.middleBase, to: middleTip)
        
        // Determine palm ratio. Threshold raised to 1.25 because Vision's
        // normalized landmark coordinates squash the y axis on portrait
        // photos, so the ratio sits near 1.1-1.2 for most square-ish palms
        // and would otherwise flip square↔rectangular between captures.
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
        
        return HandShapeAnalysis(
            shapeType: shapeType,
            fingerLength: fingerLengthCategory,
            palmRatio: palmRatio
        )
    }
    
    // MARK: - Mount Analysis

    // Each mount is a region of the palm. Prominent mounts physically bulge
    // - we cannot measure that in 2D, so we use edge density in the mount's
    // ROI as a proxy: prominent mounts have more skin folding, creases,
    // and texture relative to flat (smooth) regions.
    private func analyzePalmMounts(edgePixels: EdgePixels, handFrame: HandFrame) -> [PalmMountCharacteristics] {
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

        var results: [PalmMountCharacteristics] = []
        for (mount, rect) in mountROIs {
            let metrics = sampleLineMetrics(edgePixels, handFrame: handFrame, rect: rect, axis: .horizontal)
            let prominence = mountProminence(from: metrics)
            if let m = metrics {
                print(String(format: "[PalmAnalysis] mount %@: edges=%.3f intensity=%.3f → %@",
                             mount.rawValue, m.edgeRatio, m.avgIntensity, prominence.rawValue))
            } else {
                print("[PalmAnalysis] mount \(mount.rawValue): off-image → \(prominence.rawValue)")
            }
            results.append(PalmMountCharacteristics(mount: mount, prominence: prominence))
        }
        return results
    }

    private func mountProminence(from metrics: LineMetrics?) -> PalmMountCharacteristics.MountProminence {
        // Off-image or undersampled ROIs default to .normal rather than .flat
        // so a clipped landmark doesn't read as a missing mount.
        guard let metrics = metrics else { return .normal }

        // Same metric scale as the line analyzer (adaptive thresholding
        // already normalizes for lighting). Bands picked so that smooth
        // regions land in .flat, typical palm skin in .normal, and
        // well-developed mounts with visible creases in .prominent.
        if metrics.edgeRatio >= 0.065 {
            return .prominent
        } else if metrics.edgeRatio >= 0.028 {
            return .normal
        } else {
            return .flat
        }
    }
}

// MARK: - Supporting Types

struct PalmKeyPoints {
    let wrist: VNRecognizedPoint
    let thumbBase: VNRecognizedPoint
    let indexBase: VNRecognizedPoint
    let middleBase: VNRecognizedPoint
    let ringBase: VNRecognizedPoint
    let littleBase: VNRecognizedPoint
}

enum PalmAnalysisError: LocalizedError {
    case invalidImage
    case noHandDetected
    case fingersNotExtended
    case lowConfidence
    case processingFailed

    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "The image could not be processed. Please try taking another photo."
        case .noHandDetected:
            return "No hand detected in the image. Please ensure your palm is clearly visible and well-lit."
        case .fingersNotExtended:
            return "Please open your hand and extend all your fingers. A closed fist or curled fingers cannot be read."
        case .lowConfidence:
            return "Your palm couldn't be clearly identified. Show the inside of your hand to the camera with good lighting and try again."
        case .processingFailed:
            return "Failed to analyze the palm lines. Please try again with better lighting."
        }
    }
}
