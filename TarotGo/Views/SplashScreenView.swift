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
            // Animated gradient background
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.0, blue: 0.2),
                    Color(red: 0.05, green: 0.0, blue: 0.15),
                    Color.black
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Particles
            ParticleSystemView()
                .opacity(particlesOpacity)
            
            VStack(spacing: 30) {
                // Logo/Icon
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.purple.opacity(0.3),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .frame(width: 300, height: 300)
                        .blur(radius: 20)
                    
                    // Main icon
                    ZStack {
                        // Background circle
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.purple, Color.blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 140, height: 140)
                        
                        // Icon
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(rotation))
                    }
                    .shadow(color: Color.purple.opacity(0.5), radius: 20)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                
                // App name
                if showText {
                    VStack(spacing: 10) {
                        Text("TarotGo")
                            .font(.system(size: 48, weight: .thin, design: .serif))
                            .foregroundColor(.white)
                            .transition(.opacity.combined(with: .scale))
                        
                        Text("Your Journey Begins")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
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
                    Circle()
                        .fill(Color.white.opacity(particle.opacity))
                        .frame(width: particle.size, height: particle.size)
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
        particles = (0..<80).map { _ in
            Particle(
                position: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: 0...size.height)
                ),
                size: CGFloat.random(in: 1...4),
                opacity: Double.random(in: 0.1...0.5),
                blur: CGFloat.random(in: 0...2)
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
