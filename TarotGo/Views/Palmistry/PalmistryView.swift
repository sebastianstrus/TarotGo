//
//  PalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct PalmistryView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateToPalmReading: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 40)
                    
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
                                navigateToPalmReading = true
                            } label: {
                                PalmButton(
                                    icon: "hand.raised.fill",
                                    title: L10n.palmReadingTitle
                                )
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
            .toolbar(appViewModel.tabBarVisibility, for: .tabBar)
            .onChange(of: navigateToPalmReading) { _, isActive in
                withAnimation(.easeInOut(duration: 0.25)) {
                    appViewModel.tabBarVisibility = isActive ? .hidden : .visible
                }
            }
        }
    }
}

private struct PalmCardButton: View {
    let imageName: String
    let title: String
    var phase: Double = 0

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
                            .font(AppTheme.serifFont(size: 8, weight: .semibold))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .minimumScaleFactor(0.7)
                            .shadow(color: .black.opacity(0.6), radius: 2)
                            .padding(.horizontal, 8)
                            .frame(width: geo.size.width,
                                   height: geo.size.height * 0.32,
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
    var scale: CGFloat = 1.2
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
            
            Image("palm-spark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: circleSize * 0.5, height: circleSize * 0.5)
                .scaleEffect(sparkAnimating ? 0.6 : 1)
                //.opacity(sparkAnimating ? 0.7 : 1)
                .animation(
                    .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                    value: sparkAnimating
                )
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
