//
//  HandLandmarkerLiveService.swift
//  TarotGo
//
//  Live-stream hand landmark detection used by the palm capture screen to
//  overlay landmark dots and gold connecting lines on top of the camera
//  preview while the user is framing their hand.
//

import AVFoundation
import MediaPipeTasksVision
import UIKit

protocol HandLandmarkerLiveServiceDelegate: AnyObject {
    func handLandmarkerLiveService(
        _ service: HandLandmarkerLiveService,
        didDetect landmarks: [[NormalizedLandmark]],
        imageSize: CGSize,
        orientation: UIImage.Orientation
    )
}

final class HandLandmarkerLiveService: NSObject {

    weak var delegate: HandLandmarkerLiveServiceDelegate?

    private var handLandmarker: HandLandmarker?
    private var lastImageSize: CGSize = .zero
    private var lastOrientation: UIImage.Orientation = .up

    init?(numHands: Int = 1,
          minHandDetectionConfidence: Float = 0.5,
          minHandPresenceConfidence: Float = 0.5,
          minTrackingConfidence: Float = 0.5) {
        super.init()
        guard let modelPath = Bundle.main.path(forResource: "hand_landmarker", ofType: "task") else {
            print("[HandLandmarkerLive] hand_landmarker.task not found in bundle")
            return nil
        }
        let options = HandLandmarkerOptions()
        options.runningMode = .liveStream
        options.numHands = numHands
        options.minHandDetectionConfidence = minHandDetectionConfidence
        options.minHandPresenceConfidence = minHandPresenceConfidence
        options.minTrackingConfidence = minTrackingConfidence
        options.baseOptions.modelAssetPath = modelPath
        options.baseOptions.delegate = .GPU
        options.handLandmarkerLiveStreamDelegate = self
        do {
            handLandmarker = try HandLandmarker(options: options)
        } catch {
            print("[HandLandmarkerLive] init failed: \(error)")
            return nil
        }
    }

    func detectAsync(sampleBuffer: CMSampleBuffer,
                     orientation: UIImage.Orientation,
                     timestampMs: Int) {
        guard let landmarker = handLandmarker,
              let mpImage = try? MPImage(sampleBuffer: sampleBuffer, orientation: orientation) else {
            return
        }
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            // MediaPipe reports landmarks in the coordinate system of the
            // MPImage it received, which follows the sample buffer's raw
            // pixel dimensions rotated to match the given orientation.
            let bufferWidth = CGFloat(CVPixelBufferGetWidth(pixelBuffer))
            let bufferHeight = CGFloat(CVPixelBufferGetHeight(pixelBuffer))
            switch orientation {
            case .left, .right, .leftMirrored, .rightMirrored:
                lastImageSize = CGSize(width: bufferHeight, height: bufferWidth)
            default:
                lastImageSize = CGSize(width: bufferWidth, height: bufferHeight)
            }
            lastOrientation = orientation
        }
        do {
            try landmarker.detectAsync(image: mpImage, timestampInMilliseconds: timestampMs)
        } catch {
            // Timestamps must monotonically increase; live-stream will
            // reject out-of-order frames. Nothing actionable here beyond
            // dropping the frame.
        }
    }
}

extension HandLandmarkerLiveService: HandLandmarkerLiveStreamDelegate {
    func handLandmarker(
        _ handLandmarker: HandLandmarker,
        didFinishDetection result: HandLandmarkerResult?,
        timestampInMilliseconds: Int,
        error: Error?
    ) {
        let landmarks = result?.landmarks ?? []
        let size = lastImageSize
        let orientation = lastOrientation
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.delegate?.handLandmarkerLiveService(
                self,
                didDetect: landmarks,
                imageSize: size,
                orientation: orientation
            )
        }
    }
}
