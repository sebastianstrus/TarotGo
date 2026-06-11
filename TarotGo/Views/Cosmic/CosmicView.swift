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
                    // Header
                    VStack(spacing: 10) {
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

                        Text(L10n.cosmicViewTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .regular))
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
                    .padding(.top, 10)
                    .padding(.bottom, 8)

                    // Orbital menu
                    CosmicOrbitMenu()

                    // Footer
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)

                        Text(L10n.cosmicViewFooter)
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

                node(
                    icon: "sparkle.magnifyingglass",
                    title: L10n.horoscopeTitle,
                    destination: AnyView(HoroscopeView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.18,
                    relY: -0.25,
                    labelOffset: CGSize(width: 0, height: -50)
                )

                node(
                    icon: "moon.circle.fill",
                    title: L10n.lunarCalendarTitle,
                    destination: AnyView(LunarCalendarView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: 0.26,
                    relY: -0.30,
                    labelOffset: CGSize(width: 0, height: -50)
                )

                node(
                    icon: "number.circle.fill",
                    title: L10n.numerologyTitle,
                    destination: AnyView(NumerologyView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.35,
                    relY: 0.21,
                    labelOffset: CGSize(width: 0, height: 50),
                )

                node(
                    icon: "heart.circle.fill",
                    title: L10n.compatibilityTitle,
                    destination: AnyView(CompatibilityView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: -0.02,
                    relY: 0.28,
                    labelOffset: CGSize(width: 0, height: 50)
                )

                node(
                    icon: "circle.grid.cross.fill",
                    title: L10n.cosmogramTitle,
                    destination: AnyView(CosmogramView()),
                    center: center,
                    bgWidth: bgWidth,
                    bgHeight: bgHeight,
                    relX: 0.32,
                    relY: 0.12,
                    labelOffset: CGSize(width: 0, height: 50)
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
        labelOffset: CGSize,
        labelAlignment: TextAlignment = .center
    ) -> some View {
        let x = center.x + bgWidth * relX
        let y = center.y + bgHeight * relY

        NavigationLink {
            destination
        } label: {
            CosmicOrbitNode(
                icon: icon,
                title: title,
                labelOffset: labelOffset,
                labelAlignment: labelAlignment
            )
        }
        .buttonStyle(CosmicNodeButtonStyle())
        .simultaneousGesture(TapGesture().onEnded {
            HapticService.shared.impact(.light)
            SoundService.shared.play(.whoosh, volume: 0.4)
        })
        .position(x: x, y: y)
    }
}

// MARK: - Orbit Node

private struct CosmicOrbitNode: View {
    let icon: String
    let title: String
    let labelOffset: CGSize
    let labelAlignment: TextAlignment

    private let buttonSize: CGFloat = 90

    var body: some View {
        ZStack {
            // The clickable round button
            ZStack {
                Image("bg-ring")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: buttonSize, height: buttonSize)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 10)

                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            // Label
            VStack(alignment: horizontalAlignment, spacing: 2) {
                Text(title)
                    .font(AppTheme.serifFont(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
            }
            .multilineTextAlignment(labelAlignment)
            .fixedSize(horizontal: true, vertical: false)
            .shadow(color: .black.opacity(0.6), radius: 4)
            .offset(labelOffset)
        }
    }

    private var horizontalAlignment: HorizontalAlignment {
        switch labelAlignment {
        case .leading: return .leading
        case .trailing: return .trailing
        case .center: return .center
        }
    }
}

private struct CosmicNodeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
    }
}

#Preview {
    CosmicView()
        .environmentObject(AppViewModel())
}
