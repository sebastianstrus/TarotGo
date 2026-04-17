//
//  SplashScreenView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var riftOpen: Bool = false
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
                // Mystical Rift Reveal
                ZStack {
                    // Rift shape - mystical portal
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [
                                    AppTheme.deepNavy,
                                    AppTheme.gold.opacity(0.3),
                                    AppTheme.lightGold.opacity(0.4),
                                    AppTheme.gold.opacity(0.3),
                                    AppTheme.deepNavy
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: riftOpen ? 220 : 10, height: 280)
                        .blur(radius: 12)
                        .animation(.easeInOut(duration: 1.2), value: riftOpen)
                    
                    // Outer glow around rift
                    Capsule()
                        .stroke(AppTheme.gold.opacity(0.8), lineWidth: 3)
                        .frame(width: riftOpen ? 220 : 10, height: 280)
                        .blur(radius: 8)
                        .animation(.easeInOut(duration: 1.2), value: riftOpen)
                    
                    // Inner magical glow
                    Capsule()
                        .stroke(AppTheme.lightGold.opacity(0.6), lineWidth: 2)
                        .frame(width: riftOpen ? 220 : 10, height: 280)
                        .blur(radius: 4)
                        .animation(.easeInOut(duration: 1.2), value: riftOpen)
                    
                    // App icon emerging from the rift
                    Image("tarotgo512")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(AppTheme.goldGradient, lineWidth: 3)
                        )
                        .shadow(color: AppTheme.gold.opacity(0.6), radius: 20, x: 0, y: 10)
                        .opacity(riftOpen ? 1 : 0)
                        .scaleEffect(riftOpen ? 1 : 0.7)
                        .animation(.easeOut(duration: 0.8).delay(0.5), value: riftOpen)
                }
                
                // App name with gold styling
                VStack(spacing: 12) {
                    Text("TarotGo")
                        .font(AppTheme.serifFont(size: 52, weight: .regular))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                        .opacity(showText ? 1 : 0)
                        .scaleEffect(showText ? 1 : 0.8)
                    
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
                    .opacity(showText ? 1 : 0)
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
        // Open the mystical rift
        riftOpen = true
        
        // Particles fade in
        withAnimation(.easeIn(duration: 1.0).delay(0.3)) {
            particlesOpacity = 1.0
        }
        
        // Text appearance
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
