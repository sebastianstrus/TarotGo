//
//  PalmReadingViewModel.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

@MainActor
class PalmReadingViewModel: ObservableObject {
    @Published var currentPhase: ReadingPhase = .introduction
    @Published var capturedImage: UIImage?
    @Published var palmReading: PalmReading?
    @Published var isAnalyzing: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    enum ReadingPhase {
        case introduction
        case cameraCapture
        case analyzing
        case results
    }
    
    // Initialize and start the reading flow
    func startReading() {
        currentPhase = .cameraCapture
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
    }
    
    // Process captured palm image
    func processPalmImage(_ image: UIImage) async {
        capturedImage = image
        currentPhase = .analyzing
        isAnalyzing = true

        HapticService.shared.impact(.medium)
        SoundService.shared.play(.magic, volume: 0.5)

        // Mid-ritual heartbeat haptics to match the mystical overlay pacing.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard self?.currentPhase == .analyzing else { return }
            HapticService.shared.impact(.light)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [weak self] in
            guard self?.currentPhase == .analyzing else { return }
            HapticService.shared.impact(.light)
        }

        let overlayStart = Date()
        let minimumOverlayDuration: TimeInterval = 4.4

        do {
            // Analyze the palm
            let reading = try await PalmAnalysisService.shared.analyzePalm(image: image)

            // Ensure the mystical overlay stays visible for the full ritual duration.
            let elapsed = Date().timeIntervalSince(overlayStart)
            if elapsed < minimumOverlayDuration {
                let remaining = minimumOverlayDuration - elapsed
                try await Task.sleep(nanoseconds: UInt64(remaining * 1_000_000_000))
            }

            palmReading = reading
            currentPhase = .results

            HapticService.shared.impact(.success)
            SoundService.shared.play(.success, volume: 0.6)

        } catch {
            errorMessage = error.localizedDescription
            showError = true
            currentPhase = .cameraCapture
            HapticService.shared.impact(.error)
        }

        isAnalyzing = false
    }
    
    // Retry analysis with same image
    func retryAnalysis() {
        guard let image = capturedImage else { return }
        Task {
            await processPalmImage(image)
        }
    }
    
    // Take new photo
    func takeNewPhoto() {
        capturedImage = nil
        palmReading = nil
        errorMessage = nil
        currentPhase = .cameraCapture
        HapticService.shared.impact(.light)
    }
    
    // Reset to start
    func reset() {
        capturedImage = nil
        palmReading = nil
        errorMessage = nil
        currentPhase = .introduction
        HapticService.shared.impact(.light)
    }
    
    // Check camera permission
    func checkCameraPermission() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default:
            return false
        }
    }
}
