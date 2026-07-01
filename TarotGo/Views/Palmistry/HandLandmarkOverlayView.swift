//
//  HandLandmarkOverlayView.swift
//  TarotGo
//
//  Draws MediaPipe hand landmarks on top of the palm-capture camera preview:
//  small dots for each of the 21 landmarks joined by gold connecting lines
//  that follow the MediaPipe hand skeleton topology.
//

import AVFoundation
import MediaPipeTasksVision
import UIKit

struct HandOverlayLine {
    let from: CGPoint
    let to: CGPoint
}

struct HandOverlayData {
    let dots: [CGPoint]
    let lines: [HandOverlayLine]
}

final class HandLandmarkOverlayView: UIView {

    // Rendering configuration.
    var lineWidth: CGFloat = 3
    var pointRadius: CGFloat = 5
    var lineColor: UIColor = UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1) // AppTheme.gold
    var glowColor: UIColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 0.9) // AppTheme.lightGold
    var pointFillColor: UIColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1)
    var pointStrokeColor: UIColor = UIColor.white

    private var overlays: [HandOverlayData] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear
        isOpaque = false
        isUserInteractionEnabled = false
    }

    func update(landmarks: [[NormalizedLandmark]],
                imageSize: CGSize,
                previewGravity: AVLayerVideoGravity = .resizeAspectFill) {
        overlays = Self.buildOverlays(
            landmarks: landmarks,
            imageSize: imageSize,
            viewSize: bounds.size,
            previewGravity: previewGravity
        )
        setNeedsDisplay()
    }

    func clear() {
        overlays = []
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for overlay in overlays {
            // Soft glow underlay so lines pop off the camera background.
            context.saveGState()
            context.setShadow(offset: .zero, blur: 8, color: glowColor.cgColor)
            drawLines(overlay.lines, in: context)
            context.restoreGState()

            // Crisp gold pass on top of the glow.
            drawLines(overlay.lines, in: context)
            drawDots(overlay.dots, in: context)
        }
    }

    private func drawLines(_ lines: [HandOverlayLine], in context: CGContext) {
        let path = UIBezierPath()
        for line in lines {
            path.move(to: line.from)
            path.addLine(to: line.to)
        }
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        lineColor.setStroke()
        path.stroke()
    }

    private func drawDots(_ dots: [CGPoint], in context: CGContext) {
        for dot in dots {
            let rect = CGRect(
                x: dot.x - pointRadius,
                y: dot.y - pointRadius,
                width: pointRadius * 2,
                height: pointRadius * 2
            )
            let path = UIBezierPath(ovalIn: rect)
            pointFillColor.setFill()
            pointStrokeColor.setStroke()
            path.fill()
            path.lineWidth = 1
            path.stroke()
        }
    }

    // MARK: - Coordinate mapping

    private static func buildOverlays(
        landmarks: [[NormalizedLandmark]],
        imageSize: CGSize,
        viewSize: CGSize,
        previewGravity: AVLayerVideoGravity
    ) -> [HandOverlayData] {
        guard imageSize.width > 0, imageSize.height > 0,
              viewSize.width > 0, viewSize.height > 0,
              !landmarks.isEmpty else {
            return []
        }

        let widthScale = viewSize.width / imageSize.width
        let heightScale = viewSize.height / imageSize.height
        let scale: CGFloat
        switch previewGravity {
        case .resizeAspectFill:
            scale = max(widthScale, heightScale)
        case .resizeAspect:
            scale = min(widthScale, heightScale)
        default:
            scale = 1
        }
        let scaledWidth = imageSize.width * scale
        let scaledHeight = imageSize.height * scale
        let xOffset = (viewSize.width - scaledWidth) / 2
        let yOffset = (viewSize.height - scaledHeight) / 2

        return landmarks.map { hand in
            let dots: [CGPoint] = hand.map { landmark in
                CGPoint(
                    x: CGFloat(landmark.x) * imageSize.width * scale + xOffset,
                    y: CGFloat(landmark.y) * imageSize.height * scale + yOffset
                )
            }
            let lines: [HandOverlayLine] = HandLandmarker.handConnections.compactMap { connection in
                let startIndex = Int(connection.start)
                let endIndex = Int(connection.end)
                guard startIndex < dots.count, endIndex < dots.count else { return nil }
                return HandOverlayLine(from: dots[startIndex], to: dots[endIndex])
            }
            return HandOverlayData(dots: dots, lines: lines)
        }
    }
}

