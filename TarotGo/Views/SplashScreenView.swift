//
//  SplashScreenView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    @State private var rotation: Double = 0.0
    @State private var particlesOpacity: Double = 0.0
    @State private var showText: Bool = false
    
    let onComplete: () -> Void
    
    var body: some View {
        ZStack {
            // Elegant background matching app icon
            AppTheme.backgroundGradient
                .ignoresSafeArea()
            
            // Golden particles
            ParticleSystemView()
                .opacity(particlesOpacity)
            
            VStack(spacing: 30) {
                // App Icon
                ZStack {
                    // Outer golden glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    AppTheme.gold.opacity(0.4),
                                    AppTheme.darkGold.opacity(0.2),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 60,
                                endRadius: 180
                            )
                        )
                        .frame(width: 360, height: 360)
                        .blur(radius: 30)
                    
                    // Inner glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    AppTheme.lightGold.opacity(0.3),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 30,
                                endRadius: 100
                            )
                        )
                        .frame(width: 200, height: 200)
                        .blur(radius: 15)
                    
                    // App icon image
                    Image("tarotgo512")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 160, height: 160)
                        .cornerRadius(35)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(AppTheme.goldGradient, lineWidth: 3)
                        )
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 20, x: 0, y: 10)
                        .rotationEffect(.degrees(rotation))
                }
                .scaleEffect(scale)
                .opacity(opacity)
                
                // App name with gold styling
                if showText {
                    VStack(spacing: 12) {
                        Text("TarotGo")
                            .font(AppTheme.serifFont(size: 52, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            .transition(.opacity.combined(with: .scale))
                        
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundColor(AppTheme.gold)
                            
                            Text(L10n.splashJourneyBegins)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundColor(AppTheme.gold)
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
            }
        }
        .onAppear {
            startAnimation()
            SoundService.shared.play(.bellChime, volume: 0.5)
            HapticService.shared.customPattern(
                pattern: [.light, .medium, .heavy],
                interval: 0.2
            )
        }
    }
    
    private func startAnimation() {
        // Logo animation
        withAnimation(.spring(response: 1.2, dampingFraction: 0.6)) {
            scale = 1.0
            opacity = 1.0
        }
        
        withAnimation(.linear(duration: 2.0)) {
            rotation = 360
        }
        
        // Particles fade in
        withAnimation(.easeIn(duration: 1.0).delay(0.3)) {
            particlesOpacity = 1.0
        }
        
        // Text appearance
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeOut(duration: 0.6)) {
                showText = true
            }
        }
        
        // Complete splash screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            HapticService.shared.impact(.soft)
            onComplete()
        }
    }
}

struct ParticleSystemView: View {
    @State private var particles: [Particle] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    let isGold = particle.id.hashValue % 3 == 0
                    
                    ZStack {
                        if isGold {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            AppTheme.gold.opacity(0.4),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 0,
                                        endRadius: particle.size * 2
                                    )
                                )
                                .frame(width: particle.size * 3, height: particle.size * 3)
                        }
                        
                        Image(systemName: isGold ? "star.fill" : "circle.fill")
                            .font(.system(size: particle.size))
                            .foregroundColor(isGold ? AppTheme.gold : Color.white.opacity(particle.opacity))
                    }
                    .position(particle.position)
                    .blur(radius: particle.blur)
                }
            }
            .onAppear {
                generateParticles(in: geometry.size)
            }
        }
    }
    
    private func generateParticles(in size: CGSize) {
        particles = (0..<100).map { _ in
            Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: 0...size.height)
                ),
                size: CGFloat.random(in: 2...6),
                opacity: Double.random(in: 0.2...0.6),
                blur: CGFloat.random(in: 0...1)
            )
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    let position: CGPoint
    let size: CGFloat
    let opacity: Double
    let blur: CGFloat
}

#Preview {
    SplashScreenView {
        print("Splash completed")
    }
}
