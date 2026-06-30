//
//  DestinyMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct DestinyMatrixView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var subscriptionService: SubscriptionService
    @State private var navigateToDestinyMatrix: Bool = false
    @State private var navigateToCoupleDestiny: Bool = false
    @State private var navigateToHistory: Bool = false
    @State private var navigateToLearn: Bool = false
    @State private var showPaywall: Bool = false
    @State private var galaxyRotationBack: Double = 0
    @State private var galaxyRotationMiddle: Double = 0
    @State private var galaxyRotationFront: Double = 0
    
    private static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

    private var isAnyDestinationActive: Bool {
        navigateToDestinyMatrix || navigateToCoupleDestiny || navigateToHistory || navigateToLearn
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: 40)

                    VStack(spacing: 10) {
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

                    ringSection

                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToDestinyMatrix) {
                DestinyMatrixInputView()
            }
            .navigationDestination(isPresented: $navigateToCoupleDestiny) {
                CoupleDestinyView()
            }
            .navigationDestination(isPresented: $navigateToHistory) {
                DestinyMatrixHistoryView()
            }
            .navigationDestination(isPresented: $navigateToLearn) {
                LearnDestinyMatrixView()
            }
            .toolbar(appViewModel.tabBarVisibility, for: .tabBar)
            .onChange(of: isAnyDestinationActive) { _, isActive in
                withAnimation(.easeInOut(duration: 0.25)) {
                    appViewModel.tabBarVisibility = isActive ? .hidden : .visible
                }
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    navigateToDestinyMatrix = false
                    navigateToCoupleDestiny = false
                    navigateToHistory = false
                    navigateToLearn = false
                }
            }
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }

    private var ringSection: some View {
        GeometryReader { geometry in
            let side = max(0, min(geometry.size.width - 20, geometry.size.height))
            let ringSize = side
            let buttonRadius = ringSize * 0.39

            ZStack {
                Image("outer-ring")
                    .resizable()
                    .scaledToFit()
                    .frame(width: ringSize, height: ringSize)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 20)

                Image("spiral-galaxy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: ringSize * 0.44, height: ringSize * 0.44)
                    .opacity(1)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(galaxyRotationBack))
                    .onAppear {
                        withAnimation(.linear(duration: 5.3).repeatForever(autoreverses: false)) {
                            galaxyRotationBack = 360
                        }
                    }
                
                Image("spiral-galaxy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: ringSize * 0.44, height: ringSize * 0.44)
                    .opacity(0.7)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(galaxyRotationMiddle))
                    .onAppear {
                        withAnimation(.linear(duration: 4.1).repeatForever(autoreverses: false)) {
                            galaxyRotationMiddle = 360
                        }
                    }
                
                Image("spiral-galaxy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: ringSize * 0.44, height: ringSize * 0.44)
                    .opacity(0.5)
                    .clipShape(Circle())
                    .rotationEffect(.degrees(galaxyRotationFront))
                    .onAppear {
                        withAnimation(.linear(duration: 2.3).repeatForever(autoreverses: false)) {
                            galaxyRotationFront = 360
                        }
                    }
                
                Image("matrix-ring")
                    .resizable()
                    .scaledToFit()
                    .frame(width: ringSize * 0.5, height: ringSize * 0.5)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 12)

                // Top button - Destiny Matrix
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    if subscriptionService.isPremium {
                        navigateToDestinyMatrix = true
                    } else {
                        showPaywall = true
                    }
                } label: {
                    CircularRingButton(
                        icon: "ic_destiny_matrix",
                        title: L10n.homeDestinyMatrix,
                        animationDelay: 0.0,
                        isPremiumLocked: !subscriptionService.isPremium
                    )
                }
                .buttonStyle(RingButtonPressStyle())
                .offset(y: -buttonRadius)

                // Right button - Couple Destiny
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    if subscriptionService.isPremium {
                        navigateToCoupleDestiny = true
                    } else {
                        showPaywall = true
                    }
                } label: {
                    CircularRingButton(
                        icon: "ic_couple_destiny",
                        title: L10n.homeCoupleDestiny,
                        animationDelay: 0.3,
                        isPremiumLocked: !subscriptionService.isPremium
                    )
                }
                .buttonStyle(RingButtonPressStyle())
                .offset(x: buttonRadius)

                // Bottom button - Learn Matrix
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToLearn = true
                } label: {
                    CircularRingButton(
                        icon: "ic_learn_destiny_matrix",
                        title: L10n.homeLearnDestinyMatrix,
                        animationDelay: 0.6
                    )
                }
                .buttonStyle(RingButtonPressStyle())
                .offset(y: buttonRadius)

                // Left button - Saved Matrices
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToHistory = true
                } label: {
                    CircularRingButton(
                        icon: "ic_saved_matrices",
                        title: L10n.homeMatrixHistory,
                        animationDelay: 0.9
                    )
                }
                .buttonStyle(RingButtonPressStyle())
                .offset(x: -buttonRadius)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding(.horizontal, Self.isIPad ? 20 : 10)
        .onAppear {
            SoundService.shared.playAmbient(.galaxy, volume: 0.6, loop: true)
        }
        .onDisappear {
            SoundService.shared.stopAmbient(fadeOut: true)
        }
    }
}

// MARK: - Circular Ring Button

private struct CircularRingButton: View {
    let icon: String
    let title: String
    let animationDelay: Double
    var isPremiumLocked: Bool = false

    @State private var float: Bool = false
    @State private var glow: Bool = false
    @State private var iconWobble: Bool = false

    private static let isIPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    private let buttonSize: CGFloat = isIPad ? 220 : 110
    private let iconSize: CGFloat = isIPad ? 64 : 32
    private let titleFontSize: CGFloat = isIPad ? 24 : 12

    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.gold.opacity(glow ? 0.30 : 0.08))
                .frame(width: buttonSize * 1.15, height: buttonSize * 1.15)
                .blur(radius: 14)
                .scaleEffect(glow ? 1.08 : 0.92)

            Image("bg-button")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: buttonSize * 0.82, height: buttonSize * 0.82)
                .overlay(
                    Circle()
                        .stroke(AppTheme.lightGold.opacity(glow ? 0.5 : 0.15), lineWidth: 0.6)
                        .frame(width: buttonSize * 0.82, height: buttonSize * 0.82)
                )

            Image("button-ring")
                .resizable()
                .scaledToFit()
                .frame(width: buttonSize, height: buttonSize)
                .shadow(color: AppTheme.gold.opacity(glow ? 0.95 : 0.5),
                        radius: glow ? 14 : 8)

            VStack(spacing: 0) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .rotation3DEffect(
                        .degrees(iconWobble ? 6 : -6),
                        axis: (x: 1, y: 0.3, z: 0)
                    )

                Text(title)
                    .font(AppTheme.serifFont(size: titleFontSize, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .frame(width: buttonSize * 0.65)
                    .padding(.bottom, 4)
            }
        }
        .frame(width: buttonSize, height: buttonSize)
        .overlay(alignment: .top) {
            if isPremiumLocked {
                PremiumBadge(size: .small)
                    .scaleEffect(Self.isIPad ? 2.0 : 1.0)
                    .offset(y: Self.isIPad ? -12 : -6)
            }
        }
        .contentShape(Circle())
        .offset(y: float ? -3 : 3)
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
                iconWobble = true
            }
        }
    }
}

private struct RingButtonPressStyle: ButtonStyle {
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
    DestinyMatrixView()
        .environmentObject(AppViewModel())
}
