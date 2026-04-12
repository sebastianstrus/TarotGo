//
//  OnboardingFlowView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct OnboardingFlowView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var currentPage: Int = 0
    @State private var showGetStarted: Bool = false
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "moon.stars.fill",
            title: "Welcome to TarotGo",
            description: "Your personal guide to the ancient wisdom of tarot cards. Discover insights and guidance whenever you need it.",
            accentColor: AppTheme.gold
        ),
        OnboardingPage(
            icon: "hand.point.up.fill",
            title: "Physical Connection",
            description: "Experience the ritual through touch. Long press gestures create a deeper, more meaningful connection with your reading.",
            accentColor: AppTheme.lightGold
        ),
        OnboardingPage(
            icon: "sparkles",
            title: "Personalized Readings",
            description: "Choose from different spreads and categories. Each reading is tailored to your specific question and intention.",
            accentColor: AppTheme.mysticalPurple
        ),
        OnboardingPage(
            icon: "book.fill",
            title: "Track Your Journey",
            description: "Save your readings and reflections. Watch patterns emerge and deepen your understanding over time.",
            accentColor: AppTheme.darkGold
        )
    ]
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            
            VStack(spacing: 0) {
                // Page indicator
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Capsule()
                            .fill(currentPage == index ? Color.white : Color.white.opacity(0.3))
                            .frame(width: currentPage == index ? 30 : 8, height: 8)
                            .animation(.spring(response: 0.3), value: currentPage)
                    }
                }
                .padding(.top, 50)
                
                // Pages
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, page in
                        OnboardingPageView(page: page)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentPage) { oldValue, newValue in
                    HapticService.shared.impact(.selection)
                    
                    if newValue == pages.count - 1 {
                        withAnimation(.easeIn(duration: 0.5).delay(0.3)) {
                            showGetStarted = true
                        }
                    } else {
                        showGetStarted = false
                    }
                }
                
                // Get Started button
                VStack(spacing: 20) {
                    if showGetStarted {
                        Button {
                            completeOnboarding()
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 16))
                                
                                Text("Get Started")
                                    .font(AppTheme.serifFont(size: 18, weight: .semibold))
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 16))
                            }
                            .foregroundColor(AppTheme.deepNavy)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(AppTheme.goldGradient)
                            .cornerRadius(15)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 15, x: 0, y: 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(AppTheme.lightGold, lineWidth: 1)
                            )
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        .padding(.horizontal, 30)
                    } else {
                        Button {
                            if currentPage < pages.count - 1 {
                                withAnimation {
                                    currentPage += 1
                                }
                            }
                        } label: {
                            HStack {
                                Text("Next")
                                Image(systemName: "arrow.right")
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.bottom, 20)
                    }
                    
                    // Skip button
                    if !showGetStarted {
                        Button {
                            completeOnboarding()
                        } label: {
                            Text("Skip")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                }
                .frame(height: 100)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            SoundService.shared.playAmbient(.ambientMystic, volume: 0.2)
        }
        .onDisappear {
            SoundService.shared.stopAmbient()
        }
    }
    
    private func completeOnboarding() {
        SoundService.shared.play(.success, volume: 0.6)
        HapticService.shared.impact(.success)
        appViewModel.completeOnboarding()
    }
}

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
    let accentColor: Color
}

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    @State private var iconScale: CGFloat = 0.5
    @State private var iconRotation: Double = 0
    @State private var textOpacity: Double = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icon with elegant gold styling
            ZStack {
                // Outer golden glow
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                page.accentColor.opacity(0.4),
                                page.accentColor.opacity(0.2),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 50,
                            endRadius: 150
                        )
                    )
                    .frame(width: 300, height: 300)
                    .blur(radius: 25)
                
                // Gold ring
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
                    .frame(width: 130, height: 130)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                
                // Background circle
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: 120, height: 120)
                
                // Icon
                Image(systemName: page.icon)
                    .font(.system(size: 60))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [page.accentColor, page.accentColor.opacity(0.8)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rotationEffect(.degrees(iconRotation))
                    .shadow(color: page.accentColor.opacity(0.5), radius: 5)
            }
            .scaleEffect(iconScale)
            .shadow(color: AppTheme.gold.opacity(0.3), radius: 20, x: 0, y: 10)
            
            // Text with gold accents
            VStack(spacing: 20) {
                Text(page.title)
                    .font(AppTheme.serifFont(size: 32, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .multilineTextAlignment(.center)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 5)
                
                Text(page.description)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .padding(.horizontal, 40)
            }
            .opacity(textOpacity)
            
            Spacer()
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                iconScale = 1.0
            }
            
            withAnimation(.linear(duration: 1.5)) {
                iconRotation = 360
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
                textOpacity = 1.0
            }
        }
    }
}

#Preview {
    OnboardingFlowView()
        .environmentObject(AppViewModel())
}
