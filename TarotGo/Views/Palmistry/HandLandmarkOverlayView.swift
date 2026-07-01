//
//  HandLandmarkOverlayView.swift
//  TarotGo
//
//  Draws MediaPipe hand landmarks on top of the palm-capture camera preview
//  with a mystical gold-arcane aesthetic: multi-layer glowing lines, radiant
//  landmark orbs, and starburst sparkles at each fingertip. A slow pulse
//  animates the outermost glow so the skeleton feels alive.
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

    // Rendering configuration — tuned for a mystic/arcane look.
    var lineWidth: CGFloat = 2.4
    var pointRadius: CGFloat = 4.5
    // Deep amber → arcane gold palette.
    var lineColor: UIColor = UIColor(red: 255/255, green: 224/255, blue: 128/255, alpha: 1)      // luminous inner core
    var midGlowColor: UIColor = UIColor(red: 255/255, green: 190/255, blue: 70/255, alpha: 1)   // AppTheme.gold-adjacent
    var outerGlowColor: UIColor = UIColor(red: 255/255, green: 150/255, blue: 40/255, alpha: 1) // warm amber halo
    var pointCoreColor: UIColor = UIColor.white
    var pointFillColor: UIColor = UIColor(red: 255/255, green: 235/255, blue: 170/255, alpha: 1)
    var pointHaloColor: UIColor = UIColor(red: 255/255, green: 200/255, blue: 80/255, alpha: 1)

    // MediaPipe fingertip indices — thumb, index, middle, ring, pinky.
    private let fingertipIndices: Set<Int> = [4, 8, 12, 16, 20]

    private var overlays: [HandOverlayData] = []
    private var displayLink: CADisplayLink?
    private var pulsePhase: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    deinit {
        displayLink?.invalidate()
    }

    private func commonInit() {
        backgroundColor = .clear
        isOpaque = false
        isUserInteractionEnabled = false
        startPulseAnimation()
    }

    // MARK: - Public API

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

    // MARK: - Pulse animation

    private func startPulseAnimation() {
        let link = CADisplayLink(target: self, selector: #selector(tickPulse))
        link.preferredFrameRateRange = CAFrameRateRange(minimum: 30, maximum: 60, preferred: 60)
        link.add(to: .main, forMode: .common)
        displayLink = link
    }

    @objc private func tickPulse(link: CADisplayLink) {
        // ~2.4s per full pulse cycle for a slow, breath-like shimmer.
        pulsePhase += CGFloat(link.duration) * (2 * .pi / 2.4)
        if pulsePhase > 2 * .pi { pulsePhase -= 2 * .pi }
        if !overlays.isEmpty {
            setNeedsDisplay()
        }
    }

    // MARK: - Rendering

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // Additive blend makes overlapping glow strokes reinforce each
        // other into brighter joins — the same trick the classic Vitruvian/
        // arcane diagram renderers use for their "energy line" feel.
        context.setBlendMode(.plusLighter)

        // Slow shimmer that pulses the outer halo strength.
        let pulse = 0.5 + 0.5 * sin(pulsePhase)   // 0…1
        let outerAlpha: CGFloat = 0.35 + 0.25 * pulse
        let midAlpha: CGFloat = 0.55 + 0.20 * pulse
        let sparkleAlpha: CGFloat = 0.55 + 0.35 * pulse

        for overlay in overlays {
            // ── Layer 1: wide amber halo (very soft, sits behind everything)
            context.saveGState()
            context.setShadow(offset: .zero, blur: 22, color: outerGlowColor.cgColor)
            strokePath(from: overlay.lines,
                       in: context,
                       width: lineWidth * 3.2,
                       color: outerGlowColor.withAlphaComponent(outerAlpha))
            context.restoreGState()

            // ── Layer 2: mid gold glow
            context.saveGState()
            context.setShadow(offset: .zero, blur: 10, color: midGlowColor.cgColor)
            strokePath(from: overlay.lines,
                       in: context,
                       width: lineWidth * 1.8,
                       color: midGlowColor.withAlphaComponent(midAlpha))
            context.restoreGState()

            // ── Layer 3: crisp luminous core
            context.saveGState()
            context.setShadow(offset: .zero, blur: 3, color: lineColor.cgColor)
            strokePath(from: overlay.lines,
                       in: context,
                       width: lineWidth,
                       color: lineColor)
            context.restoreGState()

            // ── Landmark orbs — radial gradient halo + bright core.
            for (index, dot) in overlay.dots.enumerated() {
                let isFingertip = fingertipIndices.contains(index)
                drawOrb(at: dot,
                        in: context,
                        emphasized: isFingertip,
                        pulse: pulse)
                if isFingertip {
                    drawSparkle(at: dot,
                                in: context,
                                alpha: sparkleAlpha,
                                phase: pulsePhase)
                }
            }
        }
    }

    private func strokePath(from lines: [HandOverlayLine],
                            in context: CGContext,
                            width: CGFloat,
                            color: UIColor) {
        let path = UIBezierPath()
        for line in lines {
            path.move(to: line.from)
            path.addLine(to: line.to)
        }
        path.lineWidth = width
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        color.setStroke()
        path.stroke()
    }

    private func drawOrb(at point: CGPoint,
                         in context: CGContext,
                         emphasized: Bool,
                         pulse: CGFloat) {
        let baseRadius = emphasized ? pointRadius * 1.4 : pointRadius
        let haloRadius = baseRadius * (emphasized ? 4.0 : 2.8) * (0.9 + 0.15 * pulse)

        // Radial halo — draw with a CoreGraphics gradient for a soft falloff.
        context.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let haloColors = [
            pointHaloColor.withAlphaComponent(0.9).cgColor,
            pointHaloColor.withAlphaComponent(0.0).cgColor
        ] as CFArray
        if let gradient = CGGradient(colorsSpace: colorSpace,
                                     colors: haloColors,
                                     locations: [0, 1]) {
            context.drawRadialGradient(
                gradient,
                startCenter: point, startRadius: 0,
                endCenter: point, endRadius: haloRadius,
                options: []
            )
        }
        context.restoreGState()

        // Bright core with a hot white centre — reads as a tiny star.
        context.saveGState()
        context.setShadow(offset: .zero, blur: 6, color: pointHaloColor.cgColor)
        let coreRect = CGRect(x: point.x - baseRadius,
                              y: point.y - baseRadius,
                              width: baseRadius * 2,
                              height: baseRadius * 2)
        let corePath = UIBezierPath(ovalIn: coreRect)
        pointFillColor.setFill()
        corePath.fill()

        let innerRadius = baseRadius * 0.45
        let innerRect = CGRect(x: point.x - innerRadius,
                               y: point.y - innerRadius,
                               width: innerRadius * 2,
                               height: innerRadius * 2)
        pointCoreColor.setFill()
        UIBezierPath(ovalIn: innerRect).fill()
        context.restoreGState()
    }

    // Four-pointed sparkle drawn as two crossed rays. Rotates slowly with
    // the pulse phase to feel like light glinting off a jewel.
    private func drawSparkle(at point: CGPoint,
                             in context: CGContext,
                             alpha: CGFloat,
                             phase: CGFloat) {
        let rayLength = pointRadius * 4.2
        let angle = phase * 0.35 // slow rotation

        context.saveGState()
        context.translateBy(x: point.x, y: point.y)
        context.rotate(by: angle)
        context.setShadow(offset: .zero, blur: 8, color: pointHaloColor.cgColor)

        let ray = UIBezierPath()
        ray.move(to: CGPoint(x: -rayLength, y: 0))
        ray.addLine(to: CGPoint(x: rayLength, y: 0))
        ray.move(to: CGPoint(x: 0, y: -rayLength))
        ray.addLine(to: CGPoint(x: 0, y: rayLength))
        ray.lineWidth = 1.1
        ray.lineCapStyle = .round
        pointFillColor.withAlphaComponent(alpha).setStroke()
        ray.stroke()

        // Shorter diagonal rays for a six-way glimmer.
        let diag = rayLength * 0.55
        let cross = UIBezierPath()
        cross.move(to: CGPoint(x: -diag, y: -diag))
        cross.addLine(to: CGPoint(x: diag, y: diag))
        cross.move(to: CGPoint(x: -diag, y: diag))
        cross.addLine(to: CGPoint(x: diag, y: -diag))
        cross.lineWidth = 0.7
        cross.lineCapStyle = .round
        pointHaloColor.withAlphaComponent(alpha * 0.75).setStroke()
        cross.stroke()

        context.restoreGState()
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
