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
    func analyzePalm(image: UIImage) async throws -> PalmReading {
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
              let edgeCGImage = edgeUIImage.cgImage else {
            throw PalmAnalysisError.processingFailed
        }

        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)

        let heartROI = roiForHeartLine(palmPoints: palmPoints, imageSize: imageSize)
        let headROI = roiForHeadLine(palmPoints: palmPoints, imageSize: imageSize)
        let lifeROI = roiForLifeLine(palmPoints: palmPoints, imageSize: imageSize)
        let fateROI = roiForFateLine(palmPoints: palmPoints, imageSize: imageSize)

        let heartLine = analyzeLineCharacteristics(in: edgeCGImage, roi: heartROI, line: .heart, axis: .horizontal)
        let headLine = analyzeLineCharacteristics(in: edgeCGImage, roi: headROI, line: .head, axis: .horizontal)
        let lifeLine = analyzeLineCharacteristics(in: edgeCGImage, roi: lifeROI, line: .life, axis: .vertical)
        let fateLine = analyzeFateLineCharacteristics(in: edgeCGImage, roi: fateROI)

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

    // Heart line: a thin horizontal band immediately below the MCP row.
    private func roiForHeartLine(palmPoints: PalmKeyPoints, imageSize: CGSize) -> CGRect {
        let wrist = toImagePoint(palmPoints.wrist, imageSize: imageSize)
        let mcps = [palmPoints.indexBase, palmPoints.middleBase, palmPoints.ringBase, palmPoints.littleBase]
            .map { toImagePoint($0, imageSize: imageSize) }
        let mcpMinX = mcps.map(\.x).min() ?? 0
        let mcpMaxX = mcps.map(\.x).max() ?? imageSize.width
        let mcpY = mcps.map(\.y).reduce(0, +) / CGFloat(mcps.count)
        let palmHeight = max(1, wrist.y - mcpY)

        return CGRect(
            x: mcpMinX,
            y: mcpY + palmHeight * 0.05,
            width: max(1, mcpMaxX - mcpMinX),
            height: palmHeight * 0.18
        )
    }

    // Head line: horizontal band roughly one-third down the palm.
    private func roiForHeadLine(palmPoints: PalmKeyPoints, imageSize: CGSize) -> CGRect {
        let wrist = toImagePoint(palmPoints.wrist, imageSize: imageSize)
        let mcps = [palmPoints.indexBase, palmPoints.middleBase, palmPoints.ringBase, palmPoints.littleBase]
            .map { toImagePoint($0, imageSize: imageSize) }
        let mcpMinX = mcps.map(\.x).min() ?? 0
        let mcpMaxX = mcps.map(\.x).max() ?? imageSize.width
        let mcpY = mcps.map(\.y).reduce(0, +) / CGFloat(mcps.count)
        let palmHeight = max(1, wrist.y - mcpY)

        return CGRect(
            x: mcpMinX,
            y: mcpY + palmHeight * 0.28,
            width: max(1, mcpMaxX - mcpMinX),
            height: palmHeight * 0.20
        )
    }

    // Life line: curves from index MCP around the thumb base to the wrist.
    // Approximated as the bounding box of those three landmarks.
    private func roiForLifeLine(palmPoints: PalmKeyPoints, imageSize: CGSize) -> CGRect {
        let wrist = toImagePoint(palmPoints.wrist, imageSize: imageSize)
        let thumb = toImagePoint(palmPoints.thumbBase, imageSize: imageSize)
        let index = toImagePoint(palmPoints.indexBase, imageSize: imageSize)

        let xs = [wrist.x, thumb.x, index.x]
        let ys = [wrist.y, thumb.y, index.y]
        let minX = xs.min() ?? 0
        let maxX = xs.max() ?? imageSize.width
        let minY = ys.min() ?? 0
        let maxY = ys.max() ?? imageSize.height

        return CGRect(
            x: minX,
            y: minY,
            width: max(1, maxX - minX),
            height: max(1, maxY - minY)
        )
    }

    // Fate line: vertical band running from below the middle finger toward the wrist.
    private func roiForFateLine(palmPoints: PalmKeyPoints, imageSize: CGSize) -> CGRect {
        let wrist = toImagePoint(palmPoints.wrist, imageSize: imageSize)
        let middle = toImagePoint(palmPoints.middleBase, imageSize: imageSize)
        let index = toImagePoint(palmPoints.indexBase, imageSize: imageSize)
        let ring = toImagePoint(palmPoints.ringBase, imageSize: imageSize)

        let palmWidth = max(1, abs(ring.x - index.x))
        let palmHeight = max(1, wrist.y - middle.y)

        return CGRect(
            x: middle.x - palmWidth * 0.25,
            y: middle.y + palmHeight * 0.20,
            width: palmWidth * 0.50,
            height: palmHeight * 0.65
        )
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
    
    private func applyEdgeDetection(to image: UIImage) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let ciImage = CIImage(cgImage: cgImage)
        
        // Apply edge detection filter
        guard let filter = CIFilter(name: "CIEdges") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(2.0, forKey: kCIInputIntensityKey)
        
        guard let outputImage = filter.outputImage else { return nil }
        
        let context = CIContext()
        guard let processedCGImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        
        return UIImage(cgImage: processedCGImage)
    }
    
    // MARK: - Per-Line Metric Mapping

    // Reads edge metrics from the line's ROI and maps them deterministically
    // to length / depth / continuity. No randomness — same image yields the
    // same reading.
    private func analyzeLineCharacteristics(
        in edgeImage: CGImage,
        roi: CGRect,
        line: PalmLine,
        axis: LineAxis
    ) -> PalmLineCharacteristics {
        guard let metrics = computeLineMetrics(in: edgeImage, roi: roi, axis: axis) else {
            // ROI unusable (off-image or too small) — return a neutral default.
            return PalmLineCharacteristics(line: line, length: .medium, depth: .moderate, continuity: .continuous)
        }

        let length: PalmLineCharacteristics.LineLength
        if metrics.coverage >= 0.62 {
            length = .long
        } else if metrics.coverage >= 0.30 {
            length = .medium
        } else {
            length = .short
        }

        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.15 {
            depth = .deep
        } else if metrics.avgIntensity >= 0.06 {
            depth = .moderate
        } else {
            depth = .faint
        }

        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.coverage >= 0.78 && metrics.edgeRatio >= 0.035 {
            continuity = .continuous
        } else if metrics.coverage >= 0.45 {
            continuity = .chained
        } else {
            continuity = .broken
        }

        return PalmLineCharacteristics(line: line, length: length, depth: depth, continuity: continuity)
    }

    // Fate line is often absent in real palms; only declare it present when
    // the ROI shows a clear vertical signal above the noise floor.
    private func analyzeFateLineCharacteristics(in edgeImage: CGImage, roi: CGRect) -> PalmLineCharacteristics? {
        guard let metrics = computeLineMetrics(in: edgeImage, roi: roi, axis: .vertical) else {
            return nil
        }

        let minimumEdgeRatio: Float = 0.020
        let minimumCoverage: Float = 0.35
        guard metrics.edgeRatio >= minimumEdgeRatio, metrics.coverage >= minimumCoverage else {
            return nil
        }

        let length: PalmLineCharacteristics.LineLength
        if metrics.coverage >= 0.65 { length = .long }
        else if metrics.coverage >= 0.40 { length = .medium }
        else { length = .short }

        let depth: PalmLineCharacteristics.LineDepth
        if metrics.avgIntensity >= 0.12 { depth = .deep }
        else if metrics.avgIntensity >= 0.05 { depth = .moderate }
        else { depth = .faint }

        let continuity: PalmLineCharacteristics.LineContinuity
        if metrics.coverage >= 0.75 && metrics.edgeRatio >= 0.035 { continuity = .continuous }
        else if metrics.coverage >= 0.50 { continuity = .chained }
        else { continuity = .broken }

        return PalmLineCharacteristics(line: .fate, length: length, depth: depth, continuity: continuity)
    }

    // Pixel-level scan of the edge image within the given ROI. Single pass
    // over RGBA buffer collects edge count, intensity sum, and per-strip edge
    // counts so we don't need to walk the buffer three times.
    private func computeLineMetrics(in edgeImage: CGImage, roi: CGRect, axis: LineAxis) -> LineMetrics? {
        let imageBounds = CGRect(x: 0, y: 0, width: edgeImage.width, height: edgeImage.height)
        let clamped = roi.integral.intersection(imageBounds)
        guard clamped.width >= 4, clamped.height >= 4,
              let cropped = edgeImage.cropping(to: clamped) else {
            return nil
        }

        let width = cropped.width
        let height = cropped.height
        let bytesPerPixel = 4
        let bytesPerRow = width * bytesPerPixel
        var pixels = [UInt8](repeating: 0, count: width * height * bytesPerPixel)

        guard let context = CGContext(
            data: &pixels,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: bytesPerRow,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        ) else {
            return nil
        }

        context.draw(cropped, in: CGRect(x: 0, y: 0, width: width, height: height))

        // Edge brightness threshold (0-255). CIEdges output has mostly dark
        // pixels with bright streaks where edges live; ~80 catches most palm
        // creases without picking up noise.
        let edgeThreshold: UInt32 = 80
        let stripCount = 8
        var stripHasEdge = [Bool](repeating: false, count: stripCount)
        var edgeCount = 0
        var intensitySum: UInt64 = 0
        let totalPixels = width * height

        let stripDivisor: Int
        switch axis {
        case .horizontal: stripDivisor = max(1, width / stripCount)
        case .vertical:   stripDivisor = max(1, height / stripCount)
        }

        for y in 0..<height {
            for x in 0..<width {
                let i = (y * width + x) * bytesPerPixel
                let r = UInt32(pixels[i])
                let g = UInt32(pixels[i + 1])
                let b = UInt32(pixels[i + 2])
                let brightness = (r + g + b) / 3
                intensitySum += UInt64(brightness)
                if brightness >= edgeThreshold {
                    edgeCount += 1
                    let stripIndex: Int
                    switch axis {
                    case .horizontal: stripIndex = min(stripCount - 1, x / stripDivisor)
                    case .vertical:   stripIndex = min(stripCount - 1, y / stripDivisor)
                    }
                    stripHasEdge[stripIndex] = true
                }
            }
        }

        let stripsWithEdge = stripHasEdge.filter { $0 }.count
        let edgeRatio = Float(edgeCount) / Float(totalPixels)
        let avgIntensity = Float(intensitySum) / Float(totalPixels) / 255.0
        let coverage = Float(stripsWithEdge) / Float(stripCount)

        return LineMetrics(edgeRatio: edgeRatio, avgIntensity: avgIntensity, coverage: coverage)
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
        
        // Determine palm ratio
        let heightToWidthRatio = palmHeight / palmWidth
        let palmRatio: HandShapeAnalysis.PalmRatio = heightToWidthRatio > 1.15 ? .rectangular : .square
        
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
