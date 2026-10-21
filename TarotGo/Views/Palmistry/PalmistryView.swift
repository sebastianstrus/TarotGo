//
//  PalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct PalmistryView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var subscriptionService: SubscriptionService
    @State private var navigateToPalmReading: Bool = false
    @State private var showPaywall: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 6)
                    
                    VStack(spacing: 8) {
                        Text(L10n.palmistryViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.palmistryViewSubtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    
                    Spacer(minLength: 0)

                    GeometryReader { geo in
                        ZStack {
                            Image("gold_palm")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(alignment: .bottom) {
                                    HStack(alignment: .bottom, spacing: 4) {
                                        NavigationLink(destination: PalmReadingHistoryView()) {
                                            PalmCardButton(
                                                imageName: "palm_btn1",
                                                title: L10n.palmHistoryButtonTitle,
                                                phase: 0.0
                                            )
                                        }
                                        .buttonStyle(NavigationButtonStyle())
                                        .offset(y: -50)

                                        Spacer(minLength: 4)

                                        NavigationLink(destination: PalmistryAndMindView()) {
                                            PalmCardButton(
                                                imageName: "palm_btn2",
                                                title: L10n.learnPalmistryMindTitle,
                                                phase: 1.1
                                            )
                                        }
                                        .buttonStyle(NavigationButtonStyle())
                                        .offset(y: -10)

                                        Spacer(minLength: 4)

                                        NavigationLink(destination: PalmistryFAQView()) {
                                            PalmCardButton(
                                                imageName: "palm_btn3",
                                                title: L10n.learnPalmistryFaqTitle,
                                                phase: 2.3
                                            )
                                        }
                                        .buttonStyle(NavigationButtonStyle())

                                        Spacer(minLength: 4)

                                        NavigationLink(destination: HowToReadPalmView()) {
                                            PalmCardButton(
                                                imageName: "palm_btn4",
                                                title: L10n.learnPalmistryHowToReadTitle,
                                                phase: 3.6
                                            )
                                        }
                                        .buttonStyle(NavigationButtonStyle())
                                        .offset(y: -10)

                                        Spacer(minLength: 4)

                                        NavigationLink(destination: HistoryOfPalmistryView()) {
                                            PalmCardButton(
                                                imageName: "palm_btn5",
                                                title: L10n.learnPalmistryHistoryTitle,
                                                phase: 4.8
                                            )
                                        }
                                        .buttonStyle(NavigationButtonStyle())
                                        .offset(y: -50)
                                    }
                                    .padding(.horizontal, 12)
                                }
                                .shadow(color: AppTheme.gold.opacity(0.35), radius: 30)
                                .padding(.horizontal, 8)
                                .frame(width: geo.size.width, height: geo.size.height)

                            Button {
                                if subscriptionService.isPremium {
                                    navigateToPalmReading = true
                                } else {
                                    showPaywall = true
                                }
                            } label: {
                                PalmButton(
                                    icon: "hand.raised.fill",
                                    title: L10n.palmReadingTitle
                                )
                                .overlay(alignment: .top) {
                                    if !subscriptionService.isPremium {
                                        PremiumBadge()
                                            .offset(y: -6)
                                    }
                                }
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.58)
                        }
                    }

                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToPalmReading) {
                PalmReadingView()
            }
            .toolbarVisibility(.hidden, for: .tabBar)
            .onChange(of: navigateToPalmReading) { _, isActive in
                withAnimation(.easeInOut(duration: 0.25)) {
                    appViewModel.tabBarVisibility = isActive ? .hidden : .visible
                }
            }
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }
}

private struct PalmCardButton: View {
    let imageName: String
    let title: String
    var phase: Double = 0

    private static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    private var titleFontSize: CGFloat { Self.isIPad ? 16 : 8 }

    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let bob = sin(t * 1.1 + phase) * 3.5
            let sway = sin(t * 0.7 + phase * 1.3) * 1.5
            let tilt = sin(t * 0.9 + phase * 0.8) * 1.6

            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 6)
                .overlay {
                    GeometryReader { geo in
                        Text(title)
                            .font(AppTheme.serifFont(size: titleFontSize, weight: .semibold))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .minimumScaleFactor(0.7)
                            .shadow(color: .black.opacity(0.6), radius: 2)
                            .padding(.horizontal, 8)
                            .frame(width: max(0, geo.size.width - (Self.isIPad ? 6 : 0)),
                                   height: max(0, geo.size.height * 0.32),
                                   alignment: .center)
                            .position(x: geo.size.width * 0.5,
                                      y: geo.size.height * 0.68)
                    }
                }
                .rotationEffect(.degrees(tilt))
                .offset(x: sway, y: bob)
        }
    }
}

private struct PalmButton: View {
    let icon: String
    let title: String
    var scale: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 2.4 : 1.2
    @State private var sparkAnimating: Bool = false

    private var circleSize: CGFloat { 90 * scale }
    private var capsuleThickness: CGFloat { 16 * scale }
    private var fontSize: CGFloat { 9 * scale }
    private var iconSize: CGFloat { 22 * scale }
    // Midline of the capsule sits exactly on the ring's border
    private var arcRadius: CGFloat { circleSize / 2 }
    // Square frame large enough to hold the full capsule centered on the ring center
    private var capsuleFrameSize: CGFloat { circleSize + capsuleThickness + 2 * scale }

    private var angleSpan: Double {
        let attrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        ]
        let textWidth = (title as NSString).size(withAttributes: attrs).width
        let textAngle = Double(textWidth / arcRadius)
        return textAngle + 0.28
    }

    var body: some View {
        ZStack {

            Image("bg-palmring")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: circleSize, height: circleSize)
                .shadow(color: AppTheme.gold.opacity(sparkAnimating ? 0.5 : 0.95), radius: sparkAnimating ? 8 : 24)
                .shadow(color: AppTheme.gold.opacity(sparkAnimating ? 0.3 : 0.7), radius: sparkAnimating ? 14 : 40)
                .animation(
                    .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                    value: sparkAnimating
                )
            
            PalmSpark()
                .frame(width: circleSize * 0.85, height: circleSize * 0.85)
                .onAppear { sparkAnimating = true }


            // Curved capsule label centered on ring center
            ZStack {
                let canvasCenter = capsuleFrameSize / 2
                ForEach([
                    Double.pi / 2 - angleSpan / 2,
                    Double.pi / 2 + angleSpan / 2
                ], id: \.self) { angle in
                    Circle()
                        .fill(AppTheme.darkPlum)
                        .overlay(
                            Circle()
                                .strokeBorder(AppTheme.gold, lineWidth: 1)
                        )
                        .frame(width: capsuleThickness + 1, height: capsuleThickness + 1)
                        .position(
                            x: canvasCenter + arcRadius * CGFloat(cos(angle)),
                            y: canvasCenter + arcRadius * CGFloat(sin(angle))
                        )
                }

                ArcSegment(radius: arcRadius,
                           thickness: capsuleThickness,
                           angleSpan: angleSpan)
                    .fill(AppTheme.darkPlum)

                ArcOuterLine(radius: arcRadius,
                             thickness: capsuleThickness,
                             angleSpan: angleSpan)
                    .stroke(AppTheme.gold, lineWidth: 1)

                ArcInnerLine(radius: arcRadius,
                             thickness: capsuleThickness,
                             angleSpan: angleSpan)
                    .stroke(AppTheme.gold, lineWidth: 1)

                ArcText(text: title,
                        radius: arcRadius,
                        fontSize: fontSize,
                        radialOffset: -scale)
            }
            .frame(width: capsuleFrameSize, height: capsuleFrameSize)
        }
        .frame(width: circleSize, height: capsuleFrameSize)
    }
}

// MARK: - Programmatic sparkle

private struct PalmSpark: View {
    private let particleCount: Int = 20
    private let microStarSeeds: [Double] = [
        0.04, 0.11, 0.18, 0.25, 0.33, 0.40,
        0.47, 0.54, 0.61, 0.68, 0.75, 0.82,
        0.89, 0.96, 0.08, 0.29, 0.57, 0.73,
        0.02, 0.07, 0.14, 0.21, 0.28, 0.35,
        0.43, 0.50, 0.58, 0.65, 0.71, 0.78,
        0.85, 0.92, 0.99, 0.16, 0.44, 0.66
    ]

    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let pulse = sin(t * 2.2) * 0.5 + 0.5
            let slowPulse = sin(t * 1.3 + 0.7) * 0.5 + 0.5
            let twinkle = sin(t * 3.4 + 1.2) * 0.5 + 0.5
            let breath = sin(t * 0.9) * 0.5 + 0.5
            let rotation = t.truncatingRemainder(dividingBy: 360) * 6
            let hueShift = sin(t * 0.6) * 0.05

            GeometryReader { geo in
                let size = min(geo.size.width, geo.size.height)

                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    AppTheme.lightGold.opacity(0.55 * (0.6 + pulse * 0.4)),
                                    AppTheme.gold.opacity(0.30 * pulse),
                                    .clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: size * 0.55
                            )
                        )
                        .scaleEffect(0.75 + pulse * 0.45)
                        .blur(radius: size * 0.06)
                        .hueRotation(.degrees(hueShift * 25))

                    Circle()
                        .stroke(
                            AngularGradient(
                                colors: [
                                    AppTheme.gold.opacity(0.0),
                                    AppTheme.lightGold.opacity(0.55),
                                    .white.opacity(0.7),
                                    AppTheme.lightGold.opacity(0.55),
                                    AppTheme.gold.opacity(0.0)
                                ],
                                center: .center
                            ),
                            lineWidth: 0.8
                        )
                        .frame(width: size * 0.78, height: size * 0.78)
                        .blur(radius: 0.6)
                        .rotationEffect(.degrees(rotation * 0.5))
                        .opacity(0.5 + breath * 0.4)

                    ForEach(0..<particleCount, id: \.self) { i in
                        let baseAngle = (Double(i) / Double(particleCount)) * 360.0
                        let orbitRadius = size * (0.40 + sin(t * 0.8 + Double(i)) * 0.03)
                        let angle = baseAngle + rotation * 0.6
                        let dotPulse = sin(t * 2.6 + Double(i) * 0.7) * 0.5 + 0.5
                        let dotSize = size * (0.012 + dotPulse * 0.018)

                        Circle()
                            .fill(AppTheme.lightGold)
                            .frame(width: dotSize, height: dotSize)
                            .shadow(color: AppTheme.lightGold, radius: 2)
                            .offset(
                                x: orbitRadius * CGFloat(cos(angle * .pi / 180)),
                                y: orbitRadius * CGFloat(sin(angle * .pi / 180))
                            )
                            .opacity(0.55 + dotPulse * 0.4)
                    }

                    ForEach(0..<8, id: \.self) { i in
                        SparkRay()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        AppTheme.lightGold.opacity(0.95),
                                        .white,
                                        AppTheme.lightGold.opacity(0.95),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(
                                width: size * 0.055,
                                height: size * (0.62 + pulse * 0.14)
                            )
                            .blur(radius: 0.3)
                            .shadow(color: AppTheme.lightGold.opacity(0.6), radius: 4)
                            .rotationEffect(.degrees(Double(i) * 45 + rotation * 0.15))
                    }

                    ForEach(0..<8, id: \.self) { i in
                        SparkRay()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        AppTheme.gold.opacity(0.85 * slowPulse),
                                        AppTheme.lightGold.opacity(0.95 * slowPulse),
                                        AppTheme.gold.opacity(0.85 * slowPulse),
                                        .clear
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(
                                width: size * 0.05,
                                height: size * (0.55 + slowPulse * 0.20)
                            )
                            .rotationEffect(.degrees(22.5 + Double(i) * 45 - rotation * 0.2))
                    }

                    ForEach(0..<16, id: \.self) { i in
                        SparkRay()
                            .fill(AppTheme.lightGold.opacity(0.55 * twinkle))
                            .frame(
                                width: size * 0.025,
                                height: size * (0.28 + twinkle * 0.10)
                            )
                            .rotationEffect(.degrees(11.25 + Double(i) * 22.5 + rotation * 0.35))
                    }

                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    .white,
                                    AppTheme.lightGold,
                                    AppTheme.gold.opacity(0.65),
                                    .clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: size * 0.20
                            )
                        )
                        .frame(width: size * 0.40, height: size * 0.40)
                        .scaleEffect(0.85 + twinkle * 0.25)
                        .blur(radius: 0.6)

                    Circle()
                        .fill(.white)
                        .frame(width: size * 0.11, height: size * 0.11)
                        .opacity(0.75 + twinkle * 0.25)
                        .blur(radius: 0.9)
                        .shadow(color: .white.opacity(0.9), radius: 4)

                    ForEach(Array(microStarSeeds.enumerated()), id: \.offset) { idx, seed in
                        let angle = seed * .pi * 2 + t * 0.25
                        let radius = size * (0.30 + sin(t * 0.7 + seed * 5) * 0.10)
                        let starPulse = sin(t * 2.8 + seed * 6.3) * 0.5 + 0.5
                        let opacity = max(0, starPulse * starPulse) // squared for sharper twinkle

                        MicroStar()
                            .fill(.white)
                            .frame(
                                width: size * (0.04 + starPulse * 0.02),
                                height: size * (0.04 + starPulse * 0.02)
                            )
                            .offset(
                                x: radius * CGFloat(cos(angle + Double(idx))),
                                y: radius * CGFloat(sin(angle + Double(idx)))
                            )
                            .opacity(opacity * 0.9)
                            .blur(radius: 0.3)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .compositingGroup()
            .drawingGroup()
        }
    }
}

private struct SparkRay: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.midX
        let top = CGPoint(x: midX, y: rect.minY)
        let bottom = CGPoint(x: midX, y: rect.maxY)
        let leftControl = CGPoint(x: rect.minX, y: rect.midY)
        let rightControl = CGPoint(x: rect.maxX, y: rect.midY)

        path.move(to: top)
        path.addQuadCurve(to: bottom, control: rightControl)
        path.addQuadCurve(to: top, control: leftControl)
        path.closeSubpath()
        return path
    }
}

private struct MicroStar: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cx = rect.midX
        let cy = rect.midY
        let r = min(rect.width, rect.height) / 2
        let inner = r * 0.22

        // 4-point star: tips at N/E/S/W, concave inner corners on diagonals
        let tips: [CGPoint] = [
            CGPoint(x: cx, y: cy - r),
            CGPoint(x: cx + r, y: cy),
            CGPoint(x: cx, y: cy + r),
            CGPoint(x: cx - r, y: cy)
        ]
        let inners: [CGPoint] = [
            CGPoint(x: cx + inner, y: cy - inner),
            CGPoint(x: cx + inner, y: cy + inner),
            CGPoint(x: cx - inner, y: cy + inner),
            CGPoint(x: cx - inner, y: cy - inner)
        ]

        path.move(to: tips[0])
        for i in 0..<4 {
            path.addLine(to: inners[i])
            path.addLine(to: tips[(i + 1) % 4])
        }
        path.closeSubpath()
        return path
    }
}

// MARK: - Arc shapes & text

private struct ArcSegment: Shape {
    let radius: CGFloat
    let thickness: CGFloat
    let angleSpan: Double

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let innerRadius = radius - thickness / 2
        let outerRadius = radius + thickness / 2
        let startAngle = Double.pi / 2 - angleSpan / 2
        let endAngle   = Double.pi / 2 + angleSpan / 2

        var path = Path()
        path.addArc(center: center, radius: outerRadius,
                    startAngle: .radians(startAngle),
                    endAngle: .radians(endAngle),
                    clockwise: false)
        path.addArc(center: center, radius: innerRadius,
                    startAngle: .radians(endAngle),
                    endAngle: .radians(startAngle),
                    clockwise: true)
        path.closeSubpath()
        return path
    }
}

private struct ArcOuterLine: Shape {
    let radius: CGFloat
    let thickness: CGFloat
    let angleSpan: Double

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = radius + thickness / 2
        let startAngle = Double.pi / 2 - angleSpan / 2
        let endAngle   = Double.pi / 2 + angleSpan / 2

        var path = Path()
        path.addArc(center: center, radius: outerRadius,
                    startAngle: .radians(startAngle),
                    endAngle: .radians(endAngle),
                    clockwise: false)
        return path
    }
}

private struct ArcInnerLine: Shape {
    let radius: CGFloat
    let thickness: CGFloat
    let angleSpan: Double

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let innerRadius = radius - thickness / 2
        let startAngle = Double.pi / 2 - angleSpan / 2
        let endAngle   = Double.pi / 2 + angleSpan / 2

        var path = Path()
        path.addArc(center: center, radius: innerRadius,
                    startAngle: .radians(startAngle),
                    endAngle: .radians(endAngle),
                    clockwise: false)
        return path
    }
}

private struct ArcText: View {
    let text: String
    let radius: CGFloat
    let fontSize: CGFloat
    var radialOffset: CGFloat = 0

    var body: some View {
        Canvas { context, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let characters = Array(text)

            let charWidths: [CGFloat] = characters.map { char in
                context.resolve(
                    Text(String(char))
                        .font(.system(size: fontSize, weight: .semibold, design: .serif))
                ).measure(in: size).width
            }

            let totalWidth = charWidths.reduce(0, +)
            let totalAngle = totalWidth / radius
            var currentAngle = (.pi / 2) + (totalAngle / 2)

            for (i, char) in characters.enumerated() {
                let charAngle = charWidths[i] / radius
                currentAngle -= charAngle / 2

                let x = center.x + radius * cos(currentAngle)
                let y = center.y + radius * sin(currentAngle)

                let resolved = context.resolve(
                    Text(String(char))
                        .font(.system(size: fontSize, weight: .semibold, design: .serif))
                        .foregroundColor(AppTheme.lightGold)
                )
                let charSize = resolved.measure(in: size)

                context.drawLayer { ctx in
                    ctx.translateBy(x: x, y: y)
                    ctx.rotate(by: Angle(radians: currentAngle - .pi / 2))
                    ctx.draw(resolved,
                             at: CGPoint(x: -charSize.width / 2,
                                         y: -charSize.height / 2 + radialOffset),
                             anchor: .topLeading)
                }

                currentAngle -= charAngle / 2
            }
        }
    }
}

#Preview {
    PalmistryView()
        .environmentObject(AppViewModel())
}
