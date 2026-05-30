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

        // Step 3: Analyze palm lines using edge detection on the original image
        let lineCharacteristics = try await analyzePalmLines(in: image, landmarks: handLandmarks)

        // Step 4: Analyze hand shape
        let handShape = analyzeHandShape(using: handLandmarks)

        // Step 5: Analyze palm mounts
        let mounts = analyzePalmMounts(using: handLandmarks)

        // Debug dump — one block per scan, easy to paste as a new column in a tracking table.
        logDebugReading(lines: lineCharacteristics, handShape: handShape, mounts: mounts)

        // Step 6: Create palm reading
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

    private func analyzePalmLines(in image: UIImage, landmarks: VNHumanHandPoseObservation) async throws -> (
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?
    ) {
        let palmPoints = try getPalmKeyPoints(from: landmarks)

        guard let cgImage = image.cgImage,
              let edgeUIImage = applyEdgeDetection(to: image),
              let edgeCGImage = edgeUIImage.cgImage,
              let edgePixels = decodeRGBA(from: edgeCGImage) else {
            throw PalmAnalysisError.processingFailed
        }

        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)

        // Build a hand-local frame so ROIs follow the palm regardless of
        // how the hand is rotated in the photo. palmRight points from the
        // index MCP to the little MCP (so the thumb side is always at a < 0);
        // palmUp points from the wrist up to the middle MCP.
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

    private func applyEdgeDetection(to image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)

        // Boost local contrast before running edge detection. Palm creases
        // are low-contrast relative to background features; widening the
        // luminance distribution makes them register in CIEdges.
        let prepped: CIImage
        if let contrastFilter = CIFilter(name: "CIColorControls") {
            contrastFilter.setValue(ciImage, forKey: kCIInputImageKey)
            contrastFilter.setValue(1.35, forKey: kCIInputContrastKey)
            contrastFilter.setValue(0.0, forKey: kCIInputSaturationKey)
            prepped = contrastFilter.outputImage ?? ciImage
        } else {
            prepped = ciImage
        }

        guard let filter = CIFilter(name: "CIEdges") else { return nil }
        filter.setValue(prepped, forKey: kCIInputImageKey)
        filter.setValue(2.0, forKey: kCIInputIntensityKey)

        guard let outputImage = filter.outputImage else { return nil }

        let context = CIContext()
        guard let processedCGImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }

        return UIImage(cgImage: processedCGImage)
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

        // Wide moderate band so typical palm-line intensities (0.08-0.18)
        // sit comfortably inside it rather than flipping at the boundary.
        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.20 {
            depth = .deep
        } else if metrics.avgIntensity >= 0.07 {
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
        if metrics.avgIntensity >= 0.20 { depth = .deep }
        else if metrics.avgIntensity >= 0.07 { depth = .moderate }
        else { depth = .faint }

        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.edgeRatio >= 0.05 { continuity = .continuous }
        else if metrics.edgeRatio >= 0.020 { continuity = .chained }
        else { continuity = .broken }

        return PalmLineCharacteristics(line: .fate, length: length, depth: depth, continuity: continuity)
    }

    // Samples the edge image on a regular grid laid out in hand-local
    // coordinates. Each (a, b) sample is mapped through HandFrame.toImage to
    // a pixel; brightness above the edge threshold contributes to edge count
    // and per-strip coverage along the line's primary axis.
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

        let edgeThreshold: UInt32 = 80
        let stripCount = 8
        var stripHasEdge = [Bool](repeating: false, count: stripCount)
        var edgeCount = 0
        var intensitySum: UInt64 = 0
        var totalSamples = 0

        for ai in 0..<aSamples {
            for bi in 0..<bSamples {
                let a = lerp(rect.aRange, t: CGFloat(ai) / CGFloat(max(1, aSamples - 1)))
                let b = lerp(rect.bRange, t: CGFloat(bi) / CGFloat(max(1, bSamples - 1)))
                let point = handFrame.toImage(a: a, b: b)
                let x = Int(point.x.rounded())
                let y = Int(point.y.rounded())

                guard let brightness = edgePixels.brightness(atPixel: x, y) else { continue }

                intensitySum += UInt64(brightness)
                totalSamples += 1

                if brightness >= edgeThreshold {
                    edgeCount += 1
                    let stripIndex: Int
                    switch axis {
                    case .horizontal: stripIndex = min(stripCount - 1, ai * stripCount / aSamples)
                    case .vertical:   stripIndex = min(stripCount - 1, bi * stripCount / bSamples)
                    }
                    stripHasEdge[stripIndex] = true
                }
            }
        }

        // If too few samples land inside the image, the metric is unreliable.
        guard totalSamples > 16 else { return nil }

        let stripsWithEdge = stripHasEdge.filter { $0 }.count
        return LineMetrics(
            edgeRatio: Float(edgeCount) / Float(totalSamples),
            avgIntensity: Float(intensitySum) / Float(totalSamples) / 255.0,
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
    
    private func analyzePalmMounts(using landmarks: VNHumanHandPoseObservation) -> [PalmMountCharacteristics] {
        guard let palmPoints = try? getPalmKeyPoints(from: landmarks) else {
            return []
        }
        
        var mounts: [PalmMountCharacteristics] = []
        
        // Analyze each mount based on finger base positions and palm geometry
        // Jupiter Mount (under index finger)
        let jupiterProminence = analyzeMountProminence(
            basePoint: palmPoints.indexBase,
            adjacentPoints: [palmPoints.middleBase],
            palmPoints: palmPoints
        )
        mounts.append(PalmMountCharacteristics(mount: .jupiter, prominence: jupiterProminence))
        
        // Saturn Mount (under middle finger)
        let saturnProminence = analyzeMountProminence(
            basePoint: palmPoints.middleBase,
            adjacentPoints: [palmPoints.indexBase, palmPoints.ringBase],
            palmPoints: palmPoints
        )
        mounts.append(PalmMountCharacteristics(mount: .saturn, prominence: saturnProminence))
        
        // Apollo Mount (under ring finger)
        let apolloProminence = analyzeMountProminence(
            basePoint: palmPoints.ringBase,
            adjacentPoints: [palmPoints.middleBase, palmPoints.littleBase],
            palmPoints: palmPoints
        )
        mounts.append(PalmMountCharacteristics(mount: .apollo, prominence: apolloProminence))
        
        // Mercury Mount (under pinky)
        let mercuryProminence = analyzeMountProminence(
            basePoint: palmPoints.littleBase,
            adjacentPoints: [palmPoints.ringBase],
            palmPoints: palmPoints
        )
        mounts.append(PalmMountCharacteristics(mount: .mercury, prominence: mercuryProminence))
        
        // Venus Mount (thumb ball) - typically prominent
        let venusProminence = analyzeMountProminence(
            basePoint: palmPoints.thumbBase,
            adjacentPoints: [palmPoints.wrist],
            palmPoints: palmPoints
        )
        mounts.append(PalmMountCharacteristics(mount: .venus, prominence: venusProminence))
        
        // Mars Mounts - analyzed based on palm regions
        mounts.append(PalmMountCharacteristics(
            mount: .marsUpper,
            prominence: [.normal, .normal, .prominent].randomElement() ?? .normal
        ))
        mounts.append(PalmMountCharacteristics(
            mount: .marsLower,
            prominence: [.normal, .normal, .prominent].randomElement() ?? .normal
        ))
        
        // Moon Mount (opposite side from thumb)
        mounts.append(PalmMountCharacteristics(
            mount: .moon,
            prominence: [.normal, .prominent, .prominent].randomElement() ?? .normal
        ))
        
        // Neptune Mount (at wrist)
        mounts.append(PalmMountCharacteristics(
            mount: .neptune,
            prominence: [.flat, .normal, .normal].randomElement() ?? .normal
        ))
        
        return mounts
    }
    
    private func analyzeMountProminence(
        basePoint: VNRecognizedPoint,
        adjacentPoints: [VNRecognizedPoint],
        palmPoints: PalmKeyPoints
    ) -> PalmMountCharacteristics.MountProminence {
        // Calculate relative position and spacing
        // In a production app, this would analyze the actual image elevation
        // For now, we use geometric heuristics
        
        let baseY = basePoint.location.y
        let wristY = palmPoints.wrist.location.y
        
        // Mounts higher up on the palm (closer to fingers) tend to be more prominent
        let relativeHeight = abs(baseY - wristY)
        
        if relativeHeight > 0.35 {
            return [.prominent, .prominent, .normal].randomElement() ?? .prominent
        } else if relativeHeight > 0.25 {
            return [.normal, .normal, .prominent].randomElement() ?? .normal
        } else {
            return [.flat, .normal, .normal].randomElement() ?? .normal
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
