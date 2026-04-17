//
//  ShuffleRitualView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import Combine
import Vortex

enum ShufflePhase {
    case instruction
    case pressing
    case shuffling
    case complete
}

struct MysticWave: View {
    var progress: CGFloat
    let duration: CGFloat = 5.0
    
    private var normalized: CGFloat {
        min(max(progress / duration, 0), 1)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            // Background track
            Capsule()
                .fill(AppTheme.gold.opacity(0.15))
                .frame(width: 180, height: 10)
            
            // Energy flow
            Capsule()
                .fill(AppTheme.goldGradient)
                .frame(width: 180 * normalized, height: 10)
                .shadow(color: AppTheme.gold.opacity(0.6), radius: 10)
            
            // Optional: subtle shimmer overlay (more "mystic" feel)
            Capsule()
                .fill(
                    LinearGradient(
                        colors: [
                            .clear,
                            AppTheme.gold.opacity(0.6),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 60, height: 10)
                .offset(x: 180 * normalized - 60)
                .opacity(normalized > 0.05 ? 1 : 0)
                .blur(radius: 4)
                .animation(.linear(duration: 0.2), value: progress)
        }
        .animation(.linear(duration: 0.02), value: progress)
    }
}

struct ShuffleRitualView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let category: IntentionCategory
    let customQuestion: String?
    
    @State private var phase: ShufflePhase = .instruction
    @State private var pressProgress: Double = 0.0
    @State private var isPressed: Bool = false
    @State private var navigateToReading: Bool = false
    @State private var shuffleRotation: Double = 0
    @State private var shuffleOffset: CGFloat = 0
    @State private var emitterPosition: SIMD2<Double> = [0.5, 0.5]
    @State private var showFire: Bool = false
    @State private var screenSize: CGSize = .zero
    
    private let pressTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private let totalPressDuration: Double = 5.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 40) {
                Spacer()
                
                // Instruction text
                instructionText
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Deck of cards with long press
                deckView
                
                Spacer()
                
                // Progress indicator
                progressIndicator
                    .opacity(phase == .pressing ? 1 : 0)
                
                Spacer()
            }
            
            // Fire effect on top
            mysticalFireEffect
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $navigateToReading) {
                CardSelectionView(
                    category: category,
                    customQuestion: customQuestion,
                    spreadType: category.defaultSpreadType
                )
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    navigateToReading = false
                }
            }
            .onReceive(pressTimer) { _ in
                if isPressed && phase == .pressing {
                    pressProgress += 0.05
                    
                    // Haptic feedback every second
                    if Int(pressProgress * 10) % 10 == 0 {
                        lightHaptic()
                    }
                    
                    if pressProgress >= totalPressDuration {
                        completePress()
                    }
                }
            }
            .onAppear {
                screenSize = geometry.size
            }
        }
    }
    
    private var instructionText: some View {
        VStack(spacing: 15) {
            switch phase {
            case .instruction:
                Text(L10n.shuffleTakeBreath)
                    .font(AppTheme.serifFont(size: 28, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                Text(L10n.shuffleInstruction)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            case .pressing:
                Text(L10n.shuffleFocusing)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            case .shuffling:
                Text(L10n.shuffleShuffling)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            case .complete:
                Text(L10n.shuffleReady)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            }
        }
        .frame(minHeight: 100)
    }
    
    private var deckView: some View {
        ZStack {
            // Stack of cards to show depth
            ForEach(0..<5, id: \.self) { index in
                cardBackView(offset: CGFloat(index) * 3, yOffset: CGFloat(index) * -3)
                    .frame(width: 200, height: 300)
                    .shadow(color: AppTheme.gold.opacity(0.2), radius: 5)
                    .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation + Double(index * 10) : 0))
                    .offset(x: phase == .shuffling ? shuffleOffset * CGFloat(index) : 0)
            }
            
            // Top card
            cardBackView(offset: 0, yOffset: 0)
                .frame(width: 200, height: 300)
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 15)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation : 0))
        }
        .gesture(
            LongPressGesture(minimumDuration: totalPressDuration)
                .onChanged { _ in
                    if phase == .instruction {
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = true
                            phase = .pressing
                        }
                    }
                }
                .onEnded { _ in
                    // Handled in timer
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { value in
                    // Convert global screen coords to Vortex normalised [0…1] space
                    withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.7)) {
                        emitterPosition = [
                            Double(value.location.x / screenSize.width),
                            Double(value.location.y / screenSize.height)
                        ]
                    }
                    
                    if phase == .instruction {
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = true
                            phase = .pressing
                        }
                        // Fade in fire effect
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showFire = true
                        }
                    }
                }
                .onEnded { _ in
                    if phase == .pressing && pressProgress < totalPressDuration {
                        // Released too early
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = false
                            phase = .instruction
                            pressProgress = 0
                        }
                        // Fade out fire effect
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showFire = false
                        }
                    }
                }
        )
    }
    
    private var progressIndicator: some View {
        MysticWave(progress: pressProgress)
    }
    
    private var mysticalFireEffect: some View {
        VortexView(fireSystem()) {
            Circle()
                .fill(.white)
                .blendMode(.plusLighter)
                .blur(radius: 3)
                .frame(width: 32)
                .tag("circle")
        }
        .opacity(showFire ? 1.0 : 0.0)
    }
    
    // Returns the built-in fire preset with our emitter position injected
    private func fireSystem() -> VortexSystem {
        let fire = VortexSystem.fire
        fire.position = emitterPosition
        return fire
    }
    
    private func cardBackView(offset: CGFloat, yOffset: CGFloat) -> some View {
        ZStack {
            // White background to ensure no transparency
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            // Real card back image
            if let uiImage = UIImage(named: "ReversCard") {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(12)
            } else {
                // Fallback
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.cardGradient)
                
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(AppTheme.goldGradient.opacity(0.3))
            }
            
            // Gold border
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
        }
        .offset(x: offset, y: yOffset)
    }
    
    private func completePress() {
        isPressed = false
        phase = .shuffling
        
        // Fade out fire effect
        withAnimation(.easeInOut(duration: 0.5)) {
            showFire = false
        }
        
        HapticService.shared.impact(.heavy)
        SoundService.shared.play(.cardShuffle, volume: 0.7)
        
        // Shuffle animation with sound
        withAnimation(.easeInOut(duration: 2.5).repeatCount(3, autoreverses: true)) {
            shuffleRotation = 360
            shuffleOffset = 30
        }
        
        // Additional shuffle sounds during animation
        for i in 1...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.8) {
                SoundService.shared.play(.cardShuffle, volume: 0.5)
                HapticService.shared.impact(.medium)
            }
        }
        
        // Navigate after shuffle
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                phase = .complete
            }
            SoundService.shared.play(.bellChime, volume: 0.6)
            HapticService.shared.impact(.success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                navigateToReading = true
            }
        }
    }
    
    private func lightHaptic() {
        HapticService.shared.impact(.light)
    }
    
    private func strongHaptic() {
        HapticService.shared.impact(.heavy)
    }
}

#Preview {
    NavigationStack {
        ShuffleRitualView(category: .love, customQuestion: "Will I find love?")
    }
    .environmentObject(AppViewModel())
}
