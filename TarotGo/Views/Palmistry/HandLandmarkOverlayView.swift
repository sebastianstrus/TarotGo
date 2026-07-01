//
//  HandLandmarkOverlayView.swift
//  TarotGo
//
//  Draws MediaPipe hand landmarks on top of the palm-capture camera preview
//  with a mystical gold-arcane aesthetic. Renders three tiers of content:
//
//    1. The 21-landmark skeleton (multi-layer glowing gold lines + orbs).
//    2. The four palmistry lines (heart / head / life / fate) painted as
//       smoothed dashed arcs in their own coloured glow — geometry mirrors
//       PalmAnalysisService's line ROIs.
//    3. The nine planetary mounts (Jupiter, Saturn, Apollo, Mercury, Venus,
//       Moon, Mars upper, Mars lower, Neptune) marked with astrological
//       glyph rings sitting on the palm surface.
//
//  A slow display-link driven pulse breathes the outer halos so the whole
//  overlay feels alive.
//

import AVFoundation
import MediaPipeTasksVision
import UIKit

// MARK: - Overlay data structures

struct HandOverlayLine {
    let from: CGPoint
    let to: CGPoint
}

enum PalmLineKind {
    case heart, head, life, fate

    // Curve control samples in hand-local (a, b) coordinates, matching
    // PalmAnalysisService.HandFrame — a runs across the palm (index→little,
    // negative = thumb side), b runs wrist→middle-MCP.
    var samples: [(a: CGFloat, b: CGFloat)] {
        switch self {
        case .heart:
            return [(0.35, 0.75), (0.20, 0.80), (0.00, 0.83), (-0.18, 0.82), (-0.32, 0.77)]
        case .head:
            return [(0.32, 0.60), (0.15, 0.58), (-0.05, 0.55), (-0.22, 0.53), (-0.34, 0.50)]
        case .life:
            return [(-0.28, 0.82), (-0.36, 0.68), (-0.42, 0.52), (-0.42, 0.38), (-0.36, 0.24)]
        case .fate:
            return [(0.00, 0.22), (0.02, 0.40), (0.03, 0.58), (0.02, 0.72), (0.00, 0.82)]
        }
    }

    var tint: UIColor {
        switch self {
        case .heart: return UIColor(red: 255/255, green: 130/255, blue: 145/255, alpha: 1) // rose gold
        case .head:  return UIColor(red: 190/255, green: 220/255, blue: 255/255, alpha: 1) // moonlight silver
        case .life:  return UIColor(red: 160/255, green: 235/255, blue: 175/255, alpha: 1) // verdant emerald
        case .fate:  return UIColor(red: 215/255, green: 175/255, blue: 255/255, alpha: 1) // arcane violet
        }
    }
}

struct PalmLineOverlay {
    let kind: PalmLineKind
    let points: [CGPoint]
}

struct PalmMountOverlay {
    let mount: PalmMount
    let center: CGPoint
    let radius: CGFloat
    let symbol: String
}

struct HandOverlayData {
    let dots: [CGPoint]
    let lines: [HandOverlayLine]
    let palmLines: [PalmLineOverlay]
    let palmMounts: [PalmMountOverlay]
}

// MARK: - Overlay view

final class HandLandmarkOverlayView: UIView {

    // Rendering configuration — tuned for a mystic/arcane look.
    var lineWidth: CGFloat = 2.4
    var pointRadius: CGFloat = 4.5
    // Deep amber → arcane gold palette.
    var lineColor: UIColor = UIColor(red: 255/255, green: 224/255, blue: 128/255, alpha: 1)
    var midGlowColor: UIColor = UIColor(red: 255/255, green: 190/255, blue: 70/255, alpha: 1)
    var outerGlowColor: UIColor = UIColor(red: 255/255, green: 150/255, blue: 40/255, alpha: 1)
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
        pulsePhase += CGFloat(link.duration) * (2 * .pi / 2.4)
        if pulsePhase > 2 * .pi { pulsePhase -= 2 * .pi }
        if !overlays.isEmpty {
            setNeedsDisplay()
        }
    }

    // MARK: - Rendering

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        // Additive blend so overlapping glow strokes reinforce each
        // other into brighter joins.
        context.setBlendMode(.plusLighter)

        let pulse = 0.5 + 0.5 * sin(pulsePhase)   // 0…1
        let outerAlpha: CGFloat = 0.35 + 0.25 * pulse
        let midAlpha: CGFloat = 0.55 + 0.20 * pulse
        let sparkleAlpha: CGFloat = 0.55 + 0.35 * pulse
        let palmLineAlpha: CGFloat = 0.65 + 0.25 * pulse

        for overlay in overlays {
            drawPalmLines(overlay.palmLines,
                          in: context,
                          alpha: palmLineAlpha,
                          phase: pulsePhase)

            drawSkeleton(overlay.lines,
                         in: context,
                         outerAlpha: outerAlpha,
                         midAlpha: midAlpha)

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

            drawMounts(overlay.palmMounts,
                       in: context,
                       pulse: pulse)
        }
    }

    // MARK: - Skeleton pass

    private func drawSkeleton(_ lines: [HandOverlayLine],
                              in context: CGContext,
                              outerAlpha: CGFloat,
                              midAlpha: CGFloat) {
        // Layer 1: wide amber halo.
        context.saveGState()
        context.setShadow(offset: .zero, blur: 22, color: outerGlowColor.cgColor)
        strokePath(from: lines,
                   in: context,
                   width: lineWidth * 3.2,
                   color: outerGlowColor.withAlphaComponent(outerAlpha))
        context.restoreGState()

        // Layer 2: mid gold glow.
        context.saveGState()
        context.setShadow(offset: .zero, blur: 10, color: midGlowColor.cgColor)
        strokePath(from: lines,
                   in: context,
                   width: lineWidth * 1.8,
                   color: midGlowColor.withAlphaComponent(midAlpha))
        context.restoreGState()

        // Layer 3: crisp luminous core.
        context.saveGState()
        context.setShadow(offset: .zero, blur: 3, color: lineColor.cgColor)
        strokePath(from: lines,
                   in: context,
                   width: lineWidth,
                   color: lineColor)
        context.restoreGState()
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

    // MARK: - Palm lines (heart / head / life / fate)

    private func drawPalmLines(_ palmLines: [PalmLineOverlay],
                               in context: CGContext,
                               alpha: CGFloat,
                               phase: CGFloat) {
        for palmLine in palmLines {
            let path = smoothPath(from: palmLine.points)
            let tint = palmLine.kind.tint

            // Outer coloured aura.
            context.saveGState()
            context.setShadow(offset: .zero, blur: 18, color: tint.cgColor)
            path.lineWidth = lineWidth * 2.4
            path.lineCapStyle = .round
            path.lineJoinStyle = .round
            tint.withAlphaComponent(alpha * 0.55).setStroke()
            path.stroke()
            context.restoreGState()

            // Bright dashed inner stroke — dashes slowly drift with the
            // pulse phase to feel like flowing energy along the line.
            context.saveGState()
            context.setShadow(offset: .zero, blur: 4, color: tint.cgColor)
            let dashPattern: [CGFloat] = [10, 6]
            let dashPhase = -phase * 8 // scroll dashes along the curve
            let dashedPath = path.copy() as! UIBezierPath
            dashedPath.setLineDash(dashPattern, count: dashPattern.count, phase: dashPhase)
            dashedPath.lineWidth = lineWidth * 1.4
            dashedPath.lineCapStyle = .round
            tint.withAlphaComponent(min(1, alpha + 0.15)).setStroke()
            dashedPath.stroke()
            context.restoreGState()

            // Tiny bright endpoint jewels so the curve reads as anchored.
            if let first = palmLine.points.first,
               let last = palmLine.points.last {
                drawEndpointJewel(at: first, tint: tint, in: context)
                drawEndpointJewel(at: last, tint: tint, in: context)
            }
        }
    }

    private func drawEndpointJewel(at point: CGPoint,
                                   tint: UIColor,
                                   in context: CGContext) {
        context.saveGState()
        context.setShadow(offset: .zero, blur: 8, color: tint.cgColor)
        let r: CGFloat = 3
        let rect = CGRect(x: point.x - r, y: point.y - r, width: r * 2, height: r * 2)
        UIColor.white.setFill()
        UIBezierPath(ovalIn: rect).fill()
        context.restoreGState()
    }

    // Catmull-Rom-ish smoothing: draw quadratic curves through the midpoints
    // of consecutive samples, using the samples themselves as control points.
    private func smoothPath(from points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        guard let first = points.first else { return path }
        path.move(to: first)
        if points.count < 3 {
            for p in points.dropFirst() { path.addLine(to: p) }
            return path
        }
        for i in 1..<(points.count - 1) {
            let mid = CGPoint(
                x: (points[i].x + points[i + 1].x) / 2,
                y: (points[i].y + points[i + 1].y) / 2
            )
            path.addQuadCurve(to: mid, controlPoint: points[i])
        }
        path.addLine(to: points[points.count - 1])
        return path
    }

    // MARK: - Landmark orbs

    private func drawOrb(at point: CGPoint,
                         in context: CGContext,
                         emphasized: Bool,
                         pulse: CGFloat) {
        let baseRadius = emphasized ? pointRadius * 1.4 : pointRadius
        let haloRadius = baseRadius * (emphasized ? 4.0 : 2.8) * (0.9 + 0.15 * pulse)

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

        context.saveGState()
        context.setShadow(offset: .zero, blur: 6, color: pointHaloColor.cgColor)
        let coreRect = CGRect(x: point.x - baseRadius,
                              y: point.y - baseRadius,
                              width: baseRadius * 2,
                              height: baseRadius * 2)
        pointFillColor.setFill()
        UIBezierPath(ovalIn: coreRect).fill()

        let innerRadius = baseRadius * 0.45
        let innerRect = CGRect(x: point.x - innerRadius,
                               y: point.y - innerRadius,
                               width: innerRadius * 2,
                               height: innerRadius * 2)
        pointCoreColor.setFill()
        UIBezierPath(ovalIn: innerRect).fill()
        context.restoreGState()
    }

    private func drawSparkle(at point: CGPoint,
                             in context: CGContext,
                             alpha: CGFloat,
                             phase: CGFloat) {
        let rayLength = pointRadius * 4.2
        let angle = phase * 0.35

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

    // MARK: - Mount rings

    private func drawMounts(_ mounts: [PalmMountOverlay],
                            in context: CGContext,
                            pulse: CGFloat) {
        for mount in mounts {
            let ringRadius = mount.radius * (0.95 + 0.08 * pulse)

            // Outer aura.
            context.saveGState()
            context.setShadow(offset: .zero, blur: 14, color: pointHaloColor.cgColor)
            let rect = CGRect(x: mount.center.x - ringRadius,
                              y: mount.center.y - ringRadius,
                              width: ringRadius * 2,
                              height: ringRadius * 2)
            let ring = UIBezierPath(ovalIn: rect)
            ring.lineWidth = 1.4
            pointHaloColor.withAlphaComponent(0.85).setStroke()
            ring.stroke()
            context.restoreGState()

            // Faint fill so the ring reads against the camera background.
            context.saveGState()
            pointHaloColor.withAlphaComponent(0.10 + 0.08 * pulse).setFill()
            UIBezierPath(ovalIn: rect).fill()
            context.restoreGState()

            // Planetary glyph centred inside the ring.
            let glyphSize = max(ringRadius * 1.1, 9)
            drawGlyph(mount.symbol,
                      at: mount.center,
                      size: glyphSize,
                      in: context)
        }
    }

    private func drawGlyph(_ symbol: String,
                           at center: CGPoint,
                           size: CGFloat,
                           in context: CGContext) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: size, weight: .medium),
            .foregroundColor: pointFillColor,
        ]
        let text = NSAttributedString(string: symbol, attributes: attributes)
        let textSize = text.size()
        let origin = CGPoint(x: center.x - textSize.width / 2,
                             y: center.y - textSize.height / 2)

        context.saveGState()
        context.setShadow(offset: .zero, blur: 6, color: pointHaloColor.cgColor)
        text.draw(at: origin)
        context.restoreGState()
    }

    // MARK: - Coordinate mapping + palm frame derivation

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

        return landmarks.compactMap { hand -> HandOverlayData? in
            guard hand.count >= 21 else { return nil }
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

            // Build the same hand-local frame PalmAnalysisService uses:
            //   wrist = landmark 0
            //   palmRight = littleBase(17) - indexBase(5)
            //   palmUp    = middleBase(9)  - wrist
            let wrist = dots[0]
            let indexBase = dots[5]
            let middleBase = dots[9]
            let littleBase = dots[17]
            let palmRight = CGPoint(x: littleBase.x - indexBase.x,
                                    y: littleBase.y - indexBase.y)
            let palmUp = CGPoint(x: middleBase.x - wrist.x,
                                 y: middleBase.y - wrist.y)

            let toView: (CGFloat, CGFloat) -> CGPoint = { a, b in
                CGPoint(
                    x: wrist.x + a * palmRight.x + b * palmUp.x,
                    y: wrist.y + a * palmRight.y + b * palmUp.y
                )
            }

            let palmLines: [PalmLineOverlay] = [.heart, .head, .life, .fate].map { kind in
                PalmLineOverlay(
                    kind: kind,
                    points: kind.samples.map { toView($0.a, $0.b) }
                )
            }

            let palmHeight = hypot(palmUp.x, palmUp.y)
            let mountRadius = max(palmHeight * 0.06, 10)
            let mountROIs: [(mount: PalmMount, a: CGFloat, b: CGFloat, symbol: String)] = [
                (.jupiter,   -0.39, 0.84, "♃"),
                (.saturn,     0.00, 0.84, "♄"),
                (.apollo,     0.23, 0.84, "☉"),
                (.mercury,    0.42, 0.84, "☿"),
                (.venus,     -0.43, 0.32, "♀"),
                (.moon,       0.41, 0.27, "☾"),
                (.marsUpper, -0.33, 0.63, "♂"),
                (.marsLower,  0.38, 0.56, "♂"),
                (.neptune,    0.00, 0.13, "♆"),
            ]
            let palmMounts: [PalmMountOverlay] = mountROIs.map { roi in
                PalmMountOverlay(
                    mount: roi.mount,
                    center: toView(roi.a, roi.b),
                    radius: mountRadius,
                    symbol: roi.symbol
                )
            }

            return HandOverlayData(
                dots: dots,
                lines: lines,
                palmLines: palmLines,
                palmMounts: palmMounts
            )
        }
    }
}
