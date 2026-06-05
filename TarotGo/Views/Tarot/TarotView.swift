//
//  TarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI
import Vortex

struct TarotView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var destination: TarotDestination?

    var body: some View {
        NavigationStack(path: $appViewModel.navigationPath) {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VortexView(.fog) {
                    RadialGradient(
                        colors: [.gray.opacity(1.0), .gray.opacity(0)],
                        center: .center,
                        startRadius: 0,
                        endRadius: 80
                    )
                    .frame(width: 180, height: 180)
                    .blur(radius: 8)
                    .tag("circle")
                }
                .ignoresSafeArea()
                .allowsHitTesting(false)

                VStack(spacing: 0) {
                    Spacer().frame(height: 10)

                    // Section title with gold styling
                    VStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

                        Text(L10n.tarotViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.tarotViewSubtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.bottom, 20)

                    Spacer(minLength: 0)

                    // Circular wheel menu
                    TarotWheelMenuView(
                        options: wheelOptions,
                        onSelect: handleSelection
                    )
                    .padding(.horizontal, 20)

                    Spacer(minLength: 0)

                    // Footer with golden accent
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)

                        Text(L10n.homeFooter)
                            .font(AppTheme.serifFont(size: 13, weight: .light))
                            .foregroundColor(AppTheme.textTertiary)

                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $destination) { dest in
                destinationView(for: dest)
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    destination = nil
                }
            }
            .onReceive(appViewModel.$shouldNavigateToDailyCard) { shouldNavigate in
                if shouldNavigate {
                    destination = .cardOfDay
                    // Reset the trigger
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appViewModel.shouldNavigateToDailyCard = false
                    }
                }
            }
        }
    }

    private var wheelOptions: [TarotWheelOption] {
        [
            TarotWheelOption(
                icon: "sparkles",
                title: L10n.homeNewReading,
                destination: .newReading
            ),
            TarotWheelOption(
                icon: "sun.max.fill",
                title: L10n.homeCardOfDay,
                destination: .cardOfDay
            ),
            TarotWheelOption(
                icon: "books.vertical.fill",
                title: L10n.homeCardDictionary,
                destination: .dictionary
            ),
            TarotWheelOption(
                icon: "book.fill",
                title: L10n.homeHistory,
                destination: .history
            ),
            TarotWheelOption(
                icon: "graduationcap.fill",
                title: L10n.homeLearnTarot,
                destination: .learn
            )
        ]
    }

    private func handleSelection(_ option: TarotWheelOption) {
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
        destination = option.destination
    }

    @ViewBuilder
    private func destinationView(for destination: TarotDestination) -> some View {
        switch destination {
        case .newReading:
            NewReadingView()
                .toolbar(.hidden, for: .tabBar)
        case .cardOfDay:
            CardOfTheDayView()
        case .dictionary:
            CardDictionaryView()
        case .history:
            HistoryView()
        case .learn:
            LearnTarotView()
        }
    }
}

// MARK: - Wheel Menu Model

enum TarotDestination: Hashable {
    case newReading
    case cardOfDay
    case dictionary
    case history
    case learn
}

struct TarotWheelOption: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let destination: TarotDestination
}

// MARK: - Wheel Menu View

struct TarotWheelMenuView: View {
    let options: [TarotWheelOption]
    let onSelect: (TarotWheelOption) -> Void

    private let segmentGapDegrees: Double = 5
    private let segmentCornerRadius: CGFloat = 16

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: size / 2, y: size / 2)
            let outerRadius = size / 2 - 10
            let centerCircleRadius = size * 0.16
            let innerRadius = centerCircleRadius + size * 0.06 // gap between center and segments
            let labelRadius = (outerRadius + innerRadius) / 2
            let segmentAngle = 360.0 / Double(options.count)

            ZStack {
                // Mystic outer ring (layered)
                MysticOuterRing(size: size)

                // Segments
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let rawStart = startAngleFor(index: index, segmentAngle: segmentAngle)
                    let startAngle = rawStart + segmentGapDegrees / 2
                    let endAngle = rawStart + segmentAngle - segmentGapDegrees / 2

                    RoundedWheelSegmentShape(
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(endAngle),
                        innerRadius: innerRadius,
                        outerRadius: outerRadius,
                        cornerRadius: segmentCornerRadius
                    )
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.midNavy.opacity(0.85),
                                AppTheme.deepNavy.opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedWheelSegmentShape(
                            startAngle: .degrees(startAngle),
                            endAngle: .degrees(endAngle),
                            innerRadius: innerRadius,
                            outerRadius: outerRadius,
                            cornerRadius: segmentCornerRadius
                        )
                        .stroke(AppTheme.gold.opacity(0.7), lineWidth: 1)
                    )
                    .contentShape(
                        RoundedWheelSegmentShape(
                            startAngle: .degrees(startAngle),
                            endAngle: .degrees(endAngle),
                            innerRadius: innerRadius,
                            outerRadius: outerRadius,
                            cornerRadius: segmentCornerRadius
                        )
                    )
                    .onTapGesture {
                        onSelect(option)
                    }
                }

                // Icons + labels (overlaid so taps still hit segments below)
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let midDegrees = startAngleFor(index: index, segmentAngle: segmentAngle) + segmentAngle / 2
                    let midRadians = midDegrees * .pi / 180
                    let x = center.x + cos(midRadians) * labelRadius
                    let y = center.y + sin(midRadians) * labelRadius

                    VStack(spacing: 6) {
                        Image(systemName: option.icon)
                            .font(.system(size: 22, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text(option.title)
                            .font(AppTheme.serifFont(size: 12, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(width: segmentLabelWidth(outerRadius: outerRadius, innerRadius: innerRadius))
                    .position(x: x, y: y)
                    .allowsHitTesting(false)
                }

                // Decorative dots between segments, sitting just inside each segment's inner edge
                ForEach(0..<options.count, id: \.self) { index in
                    let degrees = startAngleFor(index: index, segmentAngle: segmentAngle)
                    let radians = degrees * .pi / 180
                    let dotRadius = (innerRadius + centerCircleRadius) / 2
                    let x = center.x + cos(radians) * dotRadius
                    let y = center.y + sin(radians) * dotRadius

                    Circle()
                        .fill(AppTheme.gold)
                        .frame(width: 5, height: 5)
                        .shadow(color: AppTheme.gold.opacity(0.8), radius: 3)
                        .position(x: x, y: y)
                        .allowsHitTesting(false)
                }

                // Center circle
                ZStack {
                    Circle()
                        .fill(AppTheme.deepNavy)
                        .frame(width: centerCircleRadius * 2, height: centerCircleRadius * 2)

                    Circle()
                        .stroke(AppTheme.goldGradient, lineWidth: 2)
                        .frame(width: centerCircleRadius * 2, height: centerCircleRadius * 2)

                    Image(systemName: "sun.max.fill")
                        .font(.system(size: centerCircleRadius * 1.1))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.6), radius: 6)
                }
                .position(center)
                .allowsHitTesting(false)
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    /// Returns the start angle (in degrees) for the segment at `index`.
    /// Orients the wheel so the first segment is centered at the top.
    private func startAngleFor(index: Int, segmentAngle: Double) -> Double {
        -90.0 - segmentAngle / 2 + Double(index) * segmentAngle
    }

    private func segmentLabelWidth(outerRadius: CGFloat, innerRadius: CGFloat) -> CGFloat {
        // Roughly the chord width at the label radius
        max(60, (outerRadius - innerRadius) * 0.95)
    }
}

// MARK: - Segment Shape

// MARK: - Mystic Outer Ring

/// A decorative multi-layer ring used as the wheel's backdrop.
///
/// Composition (outside → inside):
///  1. Soft golden outer glow.
///  2. Thin outer gold stroke.
///  3. Dark purple band, filled and with a faint inner gold rim.
///  4. A "starfield" of tiny twinkling dots scattered around the ring.
///  5. Four diamond-shaped ornaments at the cardinal points.
///  6. A second, thicker gold stroke marking the inner edge of the band.
struct MysticOuterRing: View {
    let size: CGFloat

    /// Width of the decorative band (between the two gold strokes).
    private var bandWidth: CGFloat { size * 0.045 }

    private var outerStrokeRadius: CGFloat { size / 2 }
    private var innerStrokeRadius: CGFloat { outerStrokeRadius - bandWidth }
    private var starRadius: CGFloat { outerStrokeRadius - bandWidth / 2 }

    var body: some View {
        ZStack {
            // 1. Soft outer glow
            Circle()
                .stroke(AppTheme.gold.opacity(0.35), lineWidth: 8)
                .frame(width: size + 4, height: size + 4)
                .blur(radius: 6)

            // 3. Purple band fill
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            AppTheme.deepPurple.opacity(0.55),
                            AppTheme.midNavy.opacity(0.5),
                            AppTheme.deepPurple.opacity(0.55)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)

            // Interior fill (covers band where the wheel sits)
            Circle()
                .fill(AppTheme.deepPurple.opacity(0.35))
                .frame(width: size - bandWidth * 2, height: size - bandWidth * 2)

            // 2. Outer gold stroke
            Circle()
                .stroke(AppTheme.goldGradient, lineWidth: 1.5)
                .frame(width: size, height: size)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 6)

            // 6. Inner gold stroke
            Circle()
                .stroke(AppTheme.goldGradient, lineWidth: 1.5)
                .frame(width: size - bandWidth * 2, height: size - bandWidth * 2)

            // Faint hairline in the middle of the band
            Circle()
                .stroke(AppTheme.gold.opacity(0.25), lineWidth: 0.5)
                .frame(width: size - bandWidth, height: size - bandWidth)

            // 4. Starfield around the band
            ForEach(0..<24, id: \.self) { index in
                let angle = Double(index) * (360.0 / 24.0)
                let radians = angle * .pi / 180
                let x = size / 2 + cos(radians) * starRadius
                let y = size / 2 + sin(radians) * starRadius
                let isLarge = index % 3 == 0

                Image(systemName: isLarge ? "sparkle" : "star.fill")
                    .font(.system(size: isLarge ? 7 : 3))
                    .foregroundStyle(AppTheme.goldGradient)
                    .opacity(isLarge ? 0.95 : 0.65)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 2)
                    .position(x: x, y: y)
            }

            // 5. Diamond ornaments at cardinal points
            ForEach(0..<4, id: \.self) { index in
                let angle = Double(index) * 90.0 - 90.0
                let radians = angle * .pi / 180
                let x = size / 2 + cos(radians) * starRadius
                let y = size / 2 + sin(radians) * starRadius

                Image(systemName: "diamond.fill")
                    .font(.system(size: 9))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.8), radius: 3)
                    .position(x: x, y: y)
            }
        }
        .frame(width: size, height: size)
        .allowsHitTesting(false)
    }
}

struct WheelSegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        path.closeSubpath()
        return path
    }
}

/// A donut-sector with rounded corners at each of its four vertices.
///
/// Corners are softened by insetting along both adjacent edges by `cornerRadius`,
/// then bridging the gap with a quadratic curve whose control point is the
/// original sharp corner.
struct RoundedWheelSegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat
    let cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let a1 = CGFloat(startAngle.radians)
        let a2 = CGFloat(endAngle.radians)

        // Cap the corner radius so insets never collide.
        let halfSpan = (a2 - a1) / 2
        let maxRadial = (outerRadius - innerRadius) * 0.45
        let maxOuterArc = halfSpan * outerRadius * 0.9
        let maxInnerArc = halfSpan * innerRadius * 0.9
        let cr = max(0, min(cornerRadius, min(maxRadial, min(maxOuterArc, maxInnerArc))))

        // Angular insets so the rounded corners sit cleanly on each arc.
        let outerAngularInset = cr / outerRadius
        let innerAngularInset = cr / innerRadius

        let outerStartA = a1 + outerAngularInset
        let outerEndA = a2 - outerAngularInset
        let innerStartA = a1 + innerAngularInset
        let innerEndA = a2 - innerAngularInset

        let outerInsetR = outerRadius - cr
        let innerInsetR = innerRadius + cr

        // Corner anchor points (original sharp corners — used as quad-curve controls).
        let cornerOuterStart = point(center: center, angle: a1, radius: outerRadius)
        let cornerOuterEnd = point(center: center, angle: a2, radius: outerRadius)
        let cornerInnerEnd = point(center: center, angle: a2, radius: innerRadius)
        let cornerInnerStart = point(center: center, angle: a1, radius: innerRadius)

        // Inset points on each edge, near each corner.
        let outerArcStart = point(center: center, angle: outerStartA, radius: outerRadius)
        let outerArcEnd = point(center: center, angle: outerEndA, radius: outerRadius)
        let innerArcStart = point(center: center, angle: innerStartA, radius: innerRadius)
        let innerArcEnd = point(center: center, angle: innerEndA, radius: innerRadius)

        let radialOuterStart = point(center: center, angle: a1, radius: outerInsetR)
        let radialOuterEnd = point(center: center, angle: a2, radius: outerInsetR)
        let radialInnerStart = point(center: center, angle: a1, radius: innerInsetR)
        let radialInnerEnd = point(center: center, angle: a2, radius: innerInsetR)

        var path = Path()
        path.move(to: radialOuterStart)
        path.addQuadCurve(to: outerArcStart, control: cornerOuterStart)
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: .radians(Double(outerStartA)),
            endAngle: .radians(Double(outerEndA)),
            clockwise: false
        )
        path.addQuadCurve(to: radialOuterEnd, control: cornerOuterEnd)
        path.addLine(to: radialInnerEnd)
        path.addQuadCurve(to: innerArcEnd, control: cornerInnerEnd)
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: .radians(Double(innerEndA)),
            endAngle: .radians(Double(innerStartA)),
            clockwise: true
        )
        path.addQuadCurve(to: radialInnerStart, control: cornerInnerStart)
        path.closeSubpath()
        return path
    }

    private func point(center: CGPoint, angle: CGFloat, radius: CGFloat) -> CGPoint {
        CGPoint(
            x: center.x + cos(angle) * radius,
            y: center.y + sin(angle) * radius
        )
    }
}

// MARK: - Fog Vortex System

extension VortexSystem {
    /// A dense, slow-drifting fog that covers the full screen.
    /// Distinct, swirling gray smoke plumes that rise and drift.
    static var fog: VortexSystem {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 1.15],
            shape: .box(width: 1.2, height: 0.1),
            birthRate: 18,
            lifespan: 105,
            lifespanVariation: 30,
            speed: 0.02,
            speedVariation: 0.01,
            angle: .degrees(0),
            angleRange: .degrees(40),
            acceleration: [0, -0.01],
            angularSpeed: [0, 0, 0.16],
            angularSpeedVariation: [0, 0, 0.2],
            colors: .ramp(
                .gray.opacity(0.7),
                .gray.opacity(1.0),
                .gray.opacity(0.9),
                .gray.opacity(0)
            ),
            size: 1.0,
            sizeVariation: 0.6,
            sizeMultiplierAtDeath: 2.6,
            stretchFactor: 1.6
        )
    }
}

#Preview {
    TarotView()
        .environmentObject(AppViewModel())
}
