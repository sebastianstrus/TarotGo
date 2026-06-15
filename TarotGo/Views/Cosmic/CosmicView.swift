//
//  CosmicView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct CosmicView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(spacing: 10) {

                        Text(L10n.cosmicViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.cosmicViewSubtitle)
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.bottom, 8)

                    Spacer(minLength: 0)

                    CosmicOrbitMenu()
                    
                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Orbit Menu

private struct CosmicOrbitMenu: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            // Anchor everything to the cosmos background image rect
            let bgWidth = min(w, h * 1.05)
            let bgHeight = bgWidth * 0.78
            let center = CGPoint(x: w / 2, y: h / 2)

            ZStack {
                Image("bg-cosmos")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: bgWidth)
                    .position(center)
                
                PulsingCosmicSun(size: bgWidth * 0.13)
                    .position(x: w * 0.49, y: h * 0.45)

                node(
                    icon: "ic_cosmic_horoscope",
                    title: L10n.horoscopeTitle,
                    destination: AnyView(HoroscopeView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.18,
                    relY: -0.25,
                    animationDelay: 0.0
                )

                node(
                    icon: "ic_cosmic_lunar_calendar",
                    title: L10n.lunarCalendarTitle,
                    destination: AnyView(LunarCalendarView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: 0.26,
                    relY: -0.30,
                    animationDelay: 0.35
                )

                node(
                    icon: "ic_cosmic_numerology",
                    title: L10n.numerologyTitle,
                    destination: AnyView(NumerologyView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.35,
                    relY: 0.21,
                    animationDelay: 0.7
                )

                node(
                    icon: "ic_cosmic_compatibility",
                    title: L10n.compatibilityTitle,
                    destination: AnyView(CompatibilityView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.02,
                    relY: 0.28,
                    animationDelay: 1.05
                )

                node(
                    icon: "ic_cosmic_cosmogram",
                    title: L10n.cosmogramTitle,
                    destination: AnyView(CosmogramView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: 0.32,
                    relY: 0.12,
                    animationDelay: 1.4
                )
            }
            .frame(width: w, height: h)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .padding(.horizontal, 8)
    }

    @ViewBuilder
    private func node(
        icon: String,
        title: String,
        destination: AnyView,
        center: CGPoint,
        bgWidth: CGFloat,
        bgHeight: CGFloat,
        relX: CGFloat,
        relY: CGFloat,
        animationDelay: Double
    ) -> some View {
        let x = center.x + bgWidth * relX
        let y = center.y + bgHeight * relY

        NavigationLink {
            destination
        } label: {
            CosmicOrbitNode(icon: icon, title: title, animationDelay: animationDelay)
        }
        .buttonStyle(CosmicNodeButtonStyle())
        .simultaneousGesture(TapGesture().onEnded {
            HapticService.shared.impact(.light)
            SoundService.shared.play(.whoosh, volume: 0.4)
        })
        .position(x: x, y: y)
    }
}

// MARK: - Pulsing Sun

private struct PulsingCosmicSun: View {
    let size: CGFloat
    @State private var pulse = false

    var body: some View {
        Image("cosmic-sun")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .shadow(color: AppTheme.gold.opacity(pulse ? 0.9 : 0.3),
                    radius: pulse ? 4 : 2)
            .shadow(color: AppTheme.gold.opacity(pulse ? 0.7 : 0.2),
                    radius: pulse ? 6 : 3)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
    }
}

// MARK: - Orbit Node

private struct CosmicOrbitNode: View {
    let icon: String
    let title: String
    let animationDelay: Double

    @State private var float: Bool = false
    @State private var glow: Bool = false
    @State private var iconSpin: Bool = false

    private let circleSize: CGFloat = 90
    private let capsuleThickness: CGFloat = 16
    private let fontSize: CGFloat = 9
    // Midline of the capsule sits exactly on the ring's border
    private var arcRadius: CGFloat { circleSize / 2 }
    // Square frame large enough to hold the full capsule centered on the ring center
    private var capsuleFrameSize: CGFloat { circleSize + capsuleThickness + 2 }

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
            // Pulsing outer aura
            Circle()
                .fill(AppTheme.gold.opacity(glow ? 0.28 : 0.08))
                .frame(width: circleSize * 1.25, height: circleSize * 1.25)
                .blur(radius: 14)
                .scaleEffect(glow ? 1.08 : 0.92)

            Image("bg-ring")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: circleSize, height: circleSize)
                .shadow(color: AppTheme.gold.opacity(glow ? 0.95 : 0.5),
                        radius: glow ? 14 : 8)

            Image("bg-button")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: circleSize * 0.5, height: circleSize * 0.5)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(AppTheme.lightGold.opacity(glow ? 0.5 : 0.15), lineWidth: 0.6)
                )


            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .rotation3DEffect(
                    .degrees(iconSpin ? 6 : -6),
                    axis: (x: 1, y: 0.3, z: 0)
                )


            // Curved capsule label centered on ring center
            ZStack {
                let canvasCenter = capsuleFrameSize / 2
                ForEach([
                    Double.pi / 2 - angleSpan / 2,
                    Double.pi / 2 + angleSpan / 2
                ], id: \.self) { angle in
                    Circle()
                        .fill(AppTheme.deepNavy)
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
                    .fill(AppTheme.deepNavy)

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
                        radialOffset: -1)
            }
            .frame(width: capsuleFrameSize, height: capsuleFrameSize)
            .shadow(color: .black.opacity(0.6), radius: 3)
        }
        .frame(width: circleSize, height: capsuleFrameSize)
        .offset(y: float ? -4 : 4)
        .onAppear { startAnimations() }
    }

    private func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDelay) {
            withAnimation(.easeInOut(duration: 2.6).repeatForever(autoreverses: true)) {
                float = true
            }
            withAnimation(.easeInOut(duration: 1.9).repeatForever(autoreverses: true)) {
                glow = true
            }
            withAnimation(.easeInOut(duration: 3.4).repeatForever(autoreverses: true)) {
                iconSpin = true
            }
        }
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

private struct CosmicNodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.86 : 1.0)
            .rotationEffect(.degrees(configuration.isPressed ? -3 : 0))
            .brightness(configuration.isPressed ? 0.18 : 0)
            .shadow(color: AppTheme.lightGold.opacity(configuration.isPressed ? 0.7 : 0.0),
                    radius: configuration.isPressed ? 14 : 0)
            .animation(.spring(response: 0.35, dampingFraction: 0.55),
                       value: configuration.isPressed)
    }
}

#Preview {
    CosmicView()
        .environmentObject(AppViewModel())
}
