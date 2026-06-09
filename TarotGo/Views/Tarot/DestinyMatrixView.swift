//
//  DestinyMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct DestinyMatrixView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateToDestinyMatrix: Bool = false
    @State private var navigateToCoupleDestiny: Bool = false
    @State private var navigateToHistory: Bool = false
    @State private var navigateToLearn: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    // Top spacing
                    Spacer()
                        .frame(height: 10)

                    // Section title with gold styling
                    VStack(spacing: 10) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

                        Text(L10n.destinyMatrixViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.destinyMatrixViewSubtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.bottom, 10)

                    Spacer(minLength: 0)

                    // Ring with 4 circular buttons
                    ringSection

                    Spacer(minLength: 0)

                    // Footer with golden accent
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)

                        Text(L10n.destinyMatrixViewFooter)
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
            .navigationDestination(isPresented: $navigateToDestinyMatrix) {
                DestinyMatrixInputView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(isPresented: $navigateToCoupleDestiny) {
                CoupleDestinyView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(isPresented: $navigateToHistory) {
                DestinyMatrixHistoryView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(isPresented: $navigateToLearn) {
                LearnDestinyMatrixView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    navigateToDestinyMatrix = false
                    navigateToCoupleDestiny = false
                    navigateToHistory = false
                    navigateToLearn = false
                }
            }
        }
    }

    private var ringSection: some View {
        GeometryReader { geometry in
            let side = min(geometry.size.width - 20, geometry.size.height)
            let ringSize = side
            let buttonRadius = ringSize * 0.39

            ZStack {
                // Outer ring decoration
                Image("outer-ring")
                    .resizable()
                    .scaledToFit()
                    .frame(width: ringSize, height: ringSize)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 20)

                // Inner ring with galaxy
                Image("inner-ring")
                    .resizable()
                    .scaledToFit()
                    .frame(width: ringSize * 0.36, height: ringSize * 0.36)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 12)

                // Top button - Destiny Matrix
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToDestinyMatrix = true
                } label: {
                    CircularRingButton(
                        icon: "star.circle.fill",
                        title: L10n.homeDestinyMatrix,
                        subtitle: L10n.homeDestinyMatrixSubtitle,
                        labelPosition: .above
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .offset(y: -buttonRadius)

                // Right button - Couple Destiny
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToCoupleDestiny = true
                } label: {
                    CircularRingButton(
                        icon: "heart.circle.fill",
                        title: L10n.homeCoupleDestiny,
                        subtitle: L10n.homeCoupleDestinySubtitle,
                        labelPosition: .below
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x: buttonRadius)

                // Bottom button - Learn Matrix
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToLearn = true
                } label: {
                    CircularRingButton(
                        icon: "graduationcap.fill",
                        title: L10n.homeLearnDestinyMatrix,
                        subtitle: L10n.homeLearnDestinyMatrixSubtitle,
                        labelPosition: .below
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .offset(y: buttonRadius)

                // Left button - Saved Matrices
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToHistory = true
                } label: {
                    CircularRingButton(
                        icon: "star.square.on.square.fill",
                        title: L10n.homeMatrixHistory,
                        subtitle: L10n.homeMatrixHistorySubtitle,
                        labelPosition: .below
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x: -buttonRadius)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, 10)
    }
}

// MARK: - Circular Ring Button

private enum RingButtonLabelPosition {
    case above, below, left, right
}

private struct CircularRingButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let labelPosition: RingButtonLabelPosition

    private let iconSize: CGFloat = 58
    private let labelGap: CGFloat = 10
    private let labelWidth: CGFloat = 110

    var body: some View {
        ZStack {
            // Icon stays centered at (0, 0) in the local coordinate system
            ZStack {
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: iconSize, height: iconSize)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.goldGradient, lineWidth: 1.5)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 8)

                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            // Label positioned via offset so it doesn't change the button's hit area
            labelView
                .offset(labelOffset)
        }
        .frame(width: iconSize, height: iconSize)
        .contentShape(Rectangle())
    }

    private var labelView: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(AppTheme.serifFont(size: 14, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(subtitle)
                .font(.system(size: 10, weight: .light))
                .foregroundColor(AppTheme.textTertiary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: labelWidth)
    }

    private var labelOffset: CGSize {
        let verticalGap = iconSize / 2 + labelGap + 18
        let horizontalGap = iconSize / 2 + labelGap + labelWidth / 2
        switch labelPosition {
        case .above:
            return CGSize(width: 0, height: -verticalGap)
        case .below:
            return CGSize(width: 0, height: verticalGap)
        case .left:
            return CGSize(width: -horizontalGap, height: 0)
        case .right:
            return CGSize(width: horizontalGap, height: 0)
        }
    }
}

#Preview {
    DestinyMatrixView()
        .environmentObject(AppViewModel())
}
