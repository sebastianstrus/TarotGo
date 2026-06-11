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
                        title: L10n.homeDestinyMatrix
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
                        title: L10n.homeCoupleDestiny
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
                        title: L10n.homeLearnDestinyMatrix
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
                        title: L10n.homeMatrixHistory
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

private struct CircularRingButton: View {
    let icon: String
    let title: String

    private let buttonSize: CGFloat = 110

    var body: some View {
        ZStack {
            Image("button-ring")
                .resizable()
                .scaledToFit()
                .frame(width: buttonSize, height: buttonSize)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8)

            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(AppTheme.goldGradient)

                Text(title)
                    .font(AppTheme.serifFont(size: 12, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .frame(width: buttonSize * 0.65)
            }
        }
        .frame(width: buttonSize, height: buttonSize)
        .contentShape(Circle())
    }
}

#Preview {
    DestinyMatrixView()
        .environmentObject(AppViewModel())
}
