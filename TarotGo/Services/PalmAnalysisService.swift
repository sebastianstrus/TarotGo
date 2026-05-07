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
        
        // Step 2: Isolate palm region
        let palmRegion = extractPalmRegion(from: image, using: handLandmarks)
        
        // Step 3: Analyze palm lines using edge detection
        let lineCharacteristics = try await analyzePalmLines(in: palmRegion, landmarks: handLandmarks)
        
        // Step 4: Create palm reading
        return PalmReading(
            heartLine: lineCharacteristics.heartLine,
            headLine: lineCharacteristics.headLine,
            lifeLine: lineCharacteristics.lifeLine,
            fateLine: lineCharacteristics.fateLine
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
    
    // MARK: - Palm Region Extraction
    
    private func extractPalmRegion(from image: UIImage, using landmarks: VNHumanHandPoseObservation) -> UIImage {
        // For now, return the original image
        // In a production app, you would crop to the palm region based on landmarks
        return image
    }
    
    // MARK: - Line Analysis
    
    private func analyzePalmLines(in image: UIImage, landmarks: VNHumanHandPoseObservation) async throws -> (
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?
    ) {
        // Get palm landmarks for analysis
        let palmPoints = try getPalmKeyPoints(from: landmarks)
        
        // Apply edge detection to find lines
        guard let processedImage = applyEdgeDetection(to: image) else {
            throw PalmAnalysisError.processingFailed
        }
        
        // Analyze each major line
        let heartLine = analyzeHeartLine(in: processedImage, palmPoints: palmPoints)
        let headLine = analyzeHeadLine(in: processedImage, palmPoints: palmPoints)
        let lifeLine = analyzeLifeLine(in: processedImage, palmPoints: palmPoints)
        let fateLine = analyzeFateLine(in: processedImage, palmPoints: palmPoints)
        
        return (heartLine, headLine, lifeLine, fateLine)
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
    
    // MARK: - Individual Line Analysis
    
    private func analyzeHeartLine(in image: UIImage, palmPoints: PalmKeyPoints) -> PalmLineCharacteristics {
        // Analyze heart line characteristics based on image analysis and palm geometry
        // In production, this would use ML or advanced image analysis
        // For now, we'll generate realistic readings based on heuristics
        
        let characteristics = generateCharacteristics(for: .heart, using: palmPoints)
        return characteristics
    }
    
    private func analyzeHeadLine(in image: UIImage, palmPoints: PalmKeyPoints) -> PalmLineCharacteristics {
        let characteristics = generateCharacteristics(for: .head, using: palmPoints)
        return characteristics
    }
    
    private func analyzeLifeLine(in image: UIImage, palmPoints: PalmKeyPoints) -> PalmLineCharacteristics {
        let characteristics = generateCharacteristics(for: .life, using: palmPoints)
        return characteristics
    }
    
    private func analyzeFateLine(in image: UIImage, palmPoints: PalmKeyPoints) -> PalmLineCharacteristics? {
        // Fate line is not always present
        // Generate with 70% probability
        guard Int.random(in: 0...9) < 7 else { return nil }
        
        let characteristics = generateCharacteristics(for: .fate, using: palmPoints)
        return characteristics
    }
    
    // MARK: - Characteristics Generation
    
    private func generateCharacteristics(for line: PalmLine, using palmPoints: PalmKeyPoints) -> PalmLineCharacteristics {
        // Generate realistic characteristics based on palm geometry
        // This uses the hand landmarks to make informed analysis
        
        // Calculate palm size as a basis for analysis
        let palmWidth = calculateDistance(from: palmPoints.indexBase, to: palmPoints.littleBase)
        let palmHeight = calculateDistance(from: palmPoints.wrist, to: palmPoints.middleBase)
        
        // Use palm proportions to determine line characteristics
        let lengthRatio = palmHeight / palmWidth
        let length: PalmLineCharacteristics.LineLength
        
        if lengthRatio > 1.2 {
            length = .long
        } else if lengthRatio > 0.9 {
            length = .medium
        } else {
            length = .short
        }
        
        // Generate depth based on line type and variation
        let depth: PalmLineCharacteristics.LineDepth
        switch line {
        case .heart, .life:
            // These lines are typically more prominent
            depth = [.moderate, .deep, .deep].randomElement() ?? .moderate
        case .head:
            depth = [.faint, .moderate, .moderate, .deep].randomElement() ?? .moderate
        case .fate:
            // Fate line is more variable
            depth = [.faint, .faint, .moderate, .deep].randomElement() ?? .moderate
        }
        
        // Generate continuity
        let continuity: PalmLineCharacteristics.LineContinuity
        if line == .life {
            continuity = [.continuous, .continuous, .continuous, .broken].randomElement() ?? .continuous
        } else {
            continuity = [.continuous, .continuous, .chained, .broken].randomElement() ?? .continuous
        }
        
        return PalmLineCharacteristics(
            line: line,
            length: length,
            depth: depth,
            continuity: continuity
        )
    }
    
    private func calculateDistance(from point1: VNRecognizedPoint, to point2: VNRecognizedPoint) -> CGFloat {
        let dx = point1.location.x - point2.location.x
        let dy = point1.location.y - point2.location.y
        return sqrt(dx * dx + dy * dy)
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
    case processingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "The image could not be processed. Please try taking another photo."
        case .noHandDetected:
            return "No hand detected in the image. Please ensure your palm is clearly visible and well-lit."
        case .processingFailed:
            return "Failed to analyze the palm lines. Please try again with better lighting."
        }
    }
}
