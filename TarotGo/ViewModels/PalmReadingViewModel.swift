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
        case reviewCapture
        case analyzing
        case results
    }

    // Initialize and start the reading flow
    func startReading() {
        currentPhase = .cameraCapture
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
    }

    // Camera delivered a photo. Park it on the review screen so the user
    // can decide whether to keep it or retake before we burn time on the
    // full analysis pipeline.
    func setCapturedImage(_ image: UIImage) {
        capturedImage = image
        currentPhase = .reviewCapture
        HapticService.shared.impact(.light)
        SoundService.shared.play(.click, volume: 0.4)
    }

    // User confirmed the captured photo — kick off the analysis.
    func confirmAnalysis() {
        guard let image = capturedImage else { return }
        // Switch to the analyzing phase synchronously so SwiftUI swaps to
        // PalmReadingOverlay on the same runloop tick as the button tap.
        currentPhase = .analyzing
        isAnalyzing = true
        // Haptic is instantaneous — keep it on the sync path for immediate
        // tactile feedback.
        HapticService.shared.impact(.medium)
        Task {
            // Sound playback can take 50-150ms to spin up its audio session.
            // Run it inside the Task so it doesn't block the runloop tick
            // that swaps the view to PalmReadingOverlay.
            SoundService.shared.play(.generate, volume: 0.5)
            await processPalmImage(image)
        }
    }

    // User wants a different shot — go back to live capture.
    func retakePhoto() {
        capturedImage = nil
        currentPhase = .cameraCapture
        HapticService.shared.impact(.light)
    }

    // Process captured palm image
    func processPalmImage(_ image: UIImage) async {
        capturedImage = image
        // Defensive: if called directly (not via confirmAnalysis) ensure the
        // overlay phase is set. The duplicate assignment is harmless.
        currentPhase = .analyzing
        isAnalyzing = true

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
