//
//  TarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct TarotView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var subscriptionService: SubscriptionService
    @State private var destination: TarotDestination?
    @State private var showPaywall: Bool = false

    private static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

    var body: some View {
        NavigationStack(path: $appViewModel.navigationPath) {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 40)

                    VStack(spacing: 10) {

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

                    TarotWheelMenuView(
                        options: wheelOptions,
                        onSelect: handleSelection
                    )
                    .padding(.horizontal, Self.isIPad ? 30 : 10)

                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $destination) { dest in
                destinationView(for: dest)
            }
            .toolbarVisibility(.hidden, for: .tabBar)
            .onChange(of: destination) { _, newValue in
                withAnimation(.easeInOut(duration: 0.25)) {
                    let shouldHide = newValue == .newReading || newValue == .cardOfDay
                    appViewModel.tabBarVisibility = shouldHide ? .hidden : .visible
                }
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
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }

    private var wheelOptions: [TarotWheelOption] {
        let showPremium = !subscriptionService.isPremium
        return [
            TarotWheelOption(
                icon: "ic_new_tarot_reading",
                title: L10n.homeNewReading,
                destination: .newReading,
                isPremiumLocked: showPremium
            ),
            TarotWheelOption(
                icon: "ic_card_of_the_day",
                title: L10n.homeCardOfDay,
                destination: .cardOfDay
            ),
            TarotWheelOption(
                icon: "ic_learn_tarot",
                title: L10n.homeLearnTarot,
                destination: .learn
            ),
            TarotWheelOption(
                icon: "ic_saved_tarot_readings",
                title: L10n.homeHistory,
                destination: .history
            ),
            TarotWheelOption(
                icon: "ic_card_dictionary",
                title: L10n.homeCardDictionary,
                destination: .dictionary
            )
        ]
    }

    private func handleSelection(_ option: TarotWheelOption) {
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
        if option.destination == .newReading && !subscriptionService.isPremium {
            showPaywall = true
            return
        }
        destination = option.destination
    }

    @ViewBuilder
    private func destinationView(for destination: TarotDestination) -> some View {
        switch destination {
        case .newReading:
            NewReadingView()
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
    var isPremiumLocked: Bool = false
}

// MARK: - Wheel Menu View

struct TarotWheelMenuView: View {
    let options: [TarotWheelOption]
    let onSelect: (TarotWheelOption) -> Void

    @State private var pressedIndex: Int? = nil
    @State private var burstIndex: Int? = nil
    @State private var sunRotation: Double = 0
    @State private var ringPulse: CGFloat = 1.0

    private let segmentGapDegrees: Double = 5
    private let segmentCornerRadius: CGFloat = 16
    private static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: size / 2, y: size / 2)
            let outerRadius = size / 2 - 10
            let centerCircleRadius = size * 0.16
            let innerRadius = centerCircleRadius + size * 0.06 // gap between center and segments
            let labelRadius = (outerRadius + innerRadius) / 2
            let segmentAngle = 360.0 / Double(options.count)

            let iconSize: CGFloat = max(40, size * 0.10)
            let labelFontSize: CGFloat = max(11, size * 0.028)
            let labelStackSpacing: CGFloat = max(2, size * 0.006)
            let bottomLabelNudge: CGFloat = max(6, size * 0.016)

            ZStack {
                // Mystic outer ring (layered) with breathing pulse
                MysticOuterRing(size: size)
                    .scaleEffect(ringPulse)

                // Segments
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let rawStart = startAngleFor(index: index, segmentAngle: segmentAngle)
                    let startAngle = rawStart + segmentGapDegrees / 2
                    let endAngle = rawStart + segmentAngle - segmentGapDegrees / 2
                    let isPressed = pressedIndex == index
                    let isBurst = burstIndex == index
                    let highlight = isPressed || isBurst

                    let shape = RoundedWheelSegmentShape(
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(endAngle),
                        innerRadius: innerRadius,
                        outerRadius: outerRadius,
                        cornerRadius: segmentCornerRadius
                    )

                    Image("bg-button")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(shape)
                        .overlay(
                            shape
                                .fill(AppTheme.goldGradient)
                                .opacity(isBurst ? 0.45 : (isPressed ? 0.22 : 0))
                        )
                        .overlay(
                            shape
                                .stroke(
                                    highlight ? AppTheme.gold : AppTheme.gold.opacity(0.7),
                                    lineWidth: highlight ? 2 : 1
                                )
                        )
                        .scaleEffect(isBurst ? 1.07 : (isPressed ? 1.03 : 1.0))
                        .shadow(
                            color: highlight ? AppTheme.gold.opacity(0.8) : .clear,
                            radius: isBurst ? 18 : (isPressed ? 10 : 0)
                        )
                        .contentShape(shape)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    guard pressedIndex != index else { return }
                                    withAnimation(.easeOut(duration: 0.12)) {
                                        pressedIndex = index
                                    }
                                    HapticService.shared.impact(.soft)
                                }
                                .onEnded { value in
                                    let moved = hypot(value.translation.width, value.translation.height) > 10
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        pressedIndex = nil
                                    }
                                    if !moved {
                                        triggerBurstAndSelect(index: index, option: option)
                                    }
                                }
                        )
                }

                // Icons + labels (overlaid so taps still hit segments below).
                // Both the scale and radial position track the segment's scale so
                // the label drifts outward in lock-step with the expanding segment.
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let midDegrees = startAngleFor(index: index, segmentAngle: segmentAngle) + segmentAngle / 2
                    let midRadians = midDegrees * .pi / 180
                    let highlight = pressedIndex == index || burstIndex == index
                    let scale: CGFloat = burstIndex == index ? 1.07 : (pressedIndex == index ? 1.03 : 1.0)
                    let effectiveRadius = labelRadius * scale
                    let x = center.x + cos(midRadians) * effectiveRadius
                    // Nudge the bottom two segments (Learn Tarot, Reading History) upward
                    // so their two-line labels sit better within the segment.
                    let verticalNudge: CGFloat = (index == 2 || index == 3) ? -bottomLabelNudge : 0
                    let y = center.y + sin(midRadians) * effectiveRadius + verticalNudge

                    VStack(spacing: labelStackSpacing) {
                        if option.isPremiumLocked {
                            PremiumBadge(size: .small)
                                .scaleEffect(Self.isIPad ? 2.0 : 1.0)
                        }

                        Image(option.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize, height: iconSize)

                        Text(option.title)
                            .font(AppTheme.serifFont(size: labelFontSize, weight: .semibold))
                            .textCase(.uppercase)
                            .tracking(0.3)
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.6)
                            .fixedSize(horizontal: false, vertical: true)
                            .shadow(color: .black.opacity(0.6), radius: 3, x: 0, y: 1)
                    }
                    .frame(width: segmentLabelWidth(outerRadius: outerRadius, innerRadius: innerRadius))
                    .scaleEffect(scale)
                    .shadow(color: highlight ? AppTheme.gold.opacity(0.7) : .clear, radius: highlight ? 8 : 0)
                    .position(x: x, y: y)
                    .allowsHitTesting(false)
                }


                // Flashlight beam shining in the direction the sun's face is looking.
                // The beam tip sits at the wheel center and extends to the outer ring,
                // so its base corners land on the segment boundaries — making the beam
                // light up exactly one segment as the sun rotates.
                let segmentSweepDegrees = segmentAngle + segmentGapDegrees
                let beamHalfAngleRad = (segmentSweepDegrees / 2.0) * .pi / 180
                let beamLength = outerRadius + 20
                let beamBaseWidth = 2 * beamLength * CGFloat(tan(beamHalfAngleRad))
                let beamFrameSide = beamLength * 2.4 // accommodates rotation of the cone

                ZStack {
                    SunBeamShape(
                        tipWidth: 0,
                        baseWidth: beamBaseWidth,
                        length: beamLength
                    )
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: Color(red: 1.0, green: 0.92, blue: 0.55).opacity(0.55), location: 0.5),
                                .init(color: Color(red: 1.0, green: 0.82, blue: 0.40).opacity(0.25), location: 0.78),
                                .init(color: Color.clear, location: 0.92)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blur(radius: 16)

                    SunBeamShape(
                        tipWidth: 0,
                        baseWidth: beamBaseWidth * 0.55,
                        length: beamLength
                    )
                    .fill(
                        LinearGradient(
                            stops: [
                                .init(color: Color(red: 1.0, green: 0.97, blue: 0.78).opacity(0.85), location: 0.5),
                                .init(color: Color(red: 1.0, green: 0.88, blue: 0.50).opacity(0.30), location: 0.80),
                                .init(color: Color.clear, location: 0.92)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .blur(radius: 6)
                }
                .frame(width: beamFrameSide, height: beamFrameSide)
                .blendMode(.plusLighter)
                .rotationEffect(.degrees(sunRotation))
                .position(center)
                .allowsHitTesting(false)

                Image("sun512")
                    .resizable()
                    .scaledToFit()
                    .frame(width: centerCircleRadius * 2.6, height: centerCircleRadius * 2.6)
                    .rotationEffect(.degrees(sunRotation))
                    .position(center)
                    .allowsHitTesting(false)
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onAppear {
                startAmbientAnimations()
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }

    /// Plays a burst highlight on the tapped segment, then forwards the selection.
    private func triggerBurstAndSelect(index: Int, option: TarotWheelOption) {
        withAnimation(.spring(response: 0.28, dampingFraction: 0.5)) {
            burstIndex = index
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) {
            withAnimation(.easeOut(duration: 0.2)) {
                burstIndex = nil
            }
            onSelect(option)
        }
    }

    /// Starts the continuous ambient animations (sun spin, ring breathing).
    private func startAmbientAnimations() {
        withAnimation(.linear(duration: 90).repeatForever(autoreverses: false)) {
            sunRotation = 360
        }
        withAnimation(.easeInOut(duration: 2.6).repeatForever(autoreverses: true)) {
            ringPulse = 1.018
        }
    }

    /// Returns the start angle (in degrees) for the segment at `index`.
    /// Orients the wheel so the first segment is centered at the top.
    private func startAngleFor(index: Int, segmentAngle: Double) -> Double {
        -90.0 - segmentAngle / 2 + Double(index) * segmentAngle
    }

    private func segmentLabelWidth(outerRadius: CGFloat, innerRadius: CGFloat) -> CGFloat {
        // Roughly the chord width at the label radius
        max(60, (outerRadius - innerRadius) * 0.80)
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
            Circle()
                .stroke(AppTheme.gold.opacity(0.35), lineWidth: 8)
                .frame(width: size + 4, height: size + 4)
                .blur(radius: 6)

            Circle()
                .stroke(AppTheme.goldGradient, lineWidth: 1.5)
                .frame(width: size, height: size)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 6)

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

/// A cone-shaped flashlight beam whose tip sits at the center of the rect
/// and whose base extends straight down. Rotating the containing view
/// pivots the beam around its tip.
struct SunBeamShape: Shape {
    let tipWidth: CGFloat
    let baseWidth: CGFloat
    let length: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cx = rect.midX
        let cy = rect.midY
        path.move(to: CGPoint(x: cx - tipWidth / 2, y: cy))
        path.addLine(to: CGPoint(x: cx + tipWidth / 2, y: cy))
        path.addLine(to: CGPoint(x: cx + baseWidth / 2, y: cy + length))
        path.addLine(to: CGPoint(x: cx - baseWidth / 2, y: cy + length))
        path.closeSubpath()
        return path
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

#Preview {
    TarotView()
        .environmentObject(AppViewModel())
}
