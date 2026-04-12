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
            accentColor: .purple
        ),
        OnboardingPage(
            icon: "hand.point.up.fill",
            title: "Physical Connection",
            description: "Experience the ritual through touch. Long press gestures create a deeper, more meaningful connection with your reading.",
            accentColor: .blue
        ),
        OnboardingPage(
            icon: "sparkles",
            title: "Personalized Readings",
            description: "Choose from different spreads and categories. Each reading is tailored to your specific question and intention.",
            accentColor: .indigo
        ),
        OnboardingPage(
            icon: "book.fill",
            title: "Track Your Journey",
            description: "Save your readings and reflections. Watch patterns emerge and deepen your understanding over time.",
            accentColor: .cyan
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
                            Text("Get Started")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.purple, Color.blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                                .shadow(color: Color.purple.opacity(0.5), radius: 10)
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
            
            // Icon
            ZStack {
                // Glow effect
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                page.accentColor.opacity(0.3),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 40,
                            endRadius: 120
                        )
                    )
                    .frame(width: 240, height: 240)
                    .blur(radius: 20)
                
                // Background circle
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [page.accentColor, page.accentColor.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                // Icon
                Image(systemName: page.icon)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(iconRotation))
            }
            .scaleEffect(iconScale)
            .shadow(color: page.accentColor.opacity(0.5), radius: 20)
            
            // Text
            VStack(spacing: 20) {
                Text(page.title)
                    .font(.system(size: 32, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(page.description)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
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
