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
    // full analysis pipeline. Stays in the .cameraCapture phase while
    // PalmCaptureView plays its shrink animation; PalmCaptureView calls
    // completeCaptureAnimation() at the end of that spring to flip the
    // phase to .reviewCapture.
    func setCapturedImage(_ image: UIImage) {
        capturedImage = image
        HapticService.shared.impact(.light)
        SoundService.shared.play(.click, volume: 0.4)
    }

    // Called by PalmCaptureView once its capture-shrink animation lands
    // at the review thumbnail's position. Switches the phase so
    // PalmReviewView takes over rendering at the same spot.
    func completeCaptureAnimation() {
        guard currentPhase == .cameraCapture, capturedImage != nil else { return }
        currentPhase = .reviewCapture
    }

    // User confirmed the captured photo — kick off the analysis.
    func confirmAnalysis() {
        guard let image = capturedImage else { return }
        currentPhase = .analyzing
        isAnalyzing = true
        HapticService.shared.impact(.medium)

        // Defer sound to background — its audio session activation can
        // spike main thread on first play.
        Task.detached(priority: .utility) {
            await SoundService.shared.play(.generate, volume: 0.5)
        }

        // Run the actual analysis as a fully detached task at background
        // priority. Background QoS pushes the work toward the efficiency
        // cores which don't share L2 cache with the performance core
        // running SwiftUI's animation render — eliminates the cache
        // pressure that causes the mid-animation stutter.
        Task.detached(priority: .background) { [weak self] in
            guard let self else { return }
            do {
                let reading = try await PalmAnalysisService.shared.analyzePalm(image: image)
                await self.handleAnalysisResult(.success(reading))
            } catch {
                await self.handleAnalysisResult(.failure(error))
            }
        }

        // Schedule the heartbeat haptics on main while the overlay plays.
        scheduleHeartbeatHaptics()
    }

    private func scheduleHeartbeatHaptics() {
        let overlayStart = Date()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard self?.currentPhase == .analyzing else { return }
            HapticService.shared.impact(.light)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { [weak self] in
            guard self?.currentPhase == .analyzing else { return }
            HapticService.shared.impact(.light)
        }
        analysisStartDate = overlayStart
    }

    private var analysisStartDate: Date = Date()

    private func handleAnalysisResult(_ result: Result<PalmReading, Error>) async {
        // Hold the mystical overlay for at least 4.4s so it doesn't blink
        // through on fast captures.
        let minimum: TimeInterval = 4.4
        let elapsed = Date().timeIntervalSince(analysisStartDate)
        if elapsed < minimum {
            try? await Task.sleep(nanoseconds: UInt64((minimum - elapsed) * 1_000_000_000))
        }
        switch result {
        case .success(let reading):
            palmReading = reading
            currentPhase = .results
            HapticService.shared.impact(.success)
        case .failure(let error):
            errorMessage = error.localizedDescription
            showError = true
            currentPhase = .cameraCapture
            HapticService.shared.impact(.error)
        }
        isAnalyzing = false
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

        // Give SwiftUI ~6 frames at 60fps to render PalmReadingOverlay and
        // fire its onAppear animations before the heavy MediaPipe + Vision
        // pipeline starts contending for CPU and GPU. Without this nudge,
        // the analysis kicks off in the same runloop tick as the phase
        // change and the entrance animations don't have time to start
        // visibly playing.
        try? await Task.sleep(nanoseconds: 100_000_000)

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
