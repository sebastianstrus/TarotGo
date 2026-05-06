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
    @State private var fireOpacity: Double = 0.0
    @State private var deckFrame: CGRect = .zero
    @State private var fireSoundTask: DispatchWorkItem?
    @State private var gestureCancelled: Bool = false
    
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
                    .frame(width: 200, height: 300)
                
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
            .onDisappear {
                // Reset fire position to center for next time
                emitterPosition = [0.5, 0.5]
                showFire = false
                fireOpacity = 0.0
            }
        }
    }
    
    private var instructionText: some View {
        ZStack {
            // Instruction phase
            if phase == .instruction {
                VStack(spacing: 15) {
                    Text(L10n.shuffleTakeBreath)
                        .font(AppTheme.serifFont(size: 28, weight: .light))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                    Text(L10n.shuffleInstruction)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .transition(.opacity)
            }
            
            // Pressing phase
            if phase == .pressing {
                Text(L10n.shuffleFocusing)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                    .transition(.opacity)
            }
            
            // Shuffling phase
            if phase == .shuffling {
                Text(L10n.shuffleShuffling)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                    .transition(.opacity)
            }
            
            // Complete phase
            if phase == .complete {
                Text(L10n.shuffleReady)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                    .transition(.opacity)
            }
        }
        .frame(minHeight: 100)
        .animation(.easeInOut(duration: 0.2), value: phase)
    }
    
    private var deckView: some View {
        ZStack {
            // Stack of cards to show depth
            ForEach(0..<5, id: \.self) { index in
                CardView()
                    .frame(width: 200, height: 300)
                    .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation + Double(index * 10) : 0))
                    .offset(x: CGFloat(index) * 3 + (phase == .shuffling ? shuffleOffset * CGFloat(index) : 0), y: CGFloat(index) * -3)
            }
            
            // Top card
            CardView()
                .frame(width: 200, height: 300)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation : 0))
        }
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        deckFrame = geometry.frame(in: .global)
                    }
                    .onChange(of: geometry.frame(in: .global)) { oldValue, newValue in
                        deckFrame = newValue
                    }
            }
        )
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { value in
                    // 1. Always update position immediately
                    let newPos: SIMD2<Double> = [
                        Double(value.location.x / screenSize.width),
                        Double(value.location.y / screenSize.height)
                    ]
                    emitterPosition = newPos

                    // 2. If this is the start of a touch (instruction phase) and gesture hasn't been cancelled
                    if phase == .instruction && !gestureCancelled {
                        isPressed = true
                        phase = .pressing
                        
                        // Cancel any existing fire sound task
                        fireSoundTask?.cancel()
                        
                        // Create new fire sound task
                        let task = DispatchWorkItem {
                            SoundService.shared.play(.fire, volume: 0.6)
                        }
                        fireSoundTask = task
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6, execute: task)
                        
                        showFire = true
                        fireOpacity = 0.0
                        
                        withAnimation(.easeInOut(duration: 0.4).delay(0.6)) {
                            fireOpacity = 1.0
                        }
                    }
                    
                    // 3. Check if finger has moved off the card
                    if phase == .pressing && !gestureCancelled {
                        let touchPoint = value.location
                        if !deckFrame.contains(touchPoint) {
                            // Finger moved off the card, cancel the ritual
                            gestureCancelled = true
                            resetRitual()
                        }
                    }
                }
                .onEnded { _ in
                    // 4. Handle release logic
                    if phase == .pressing && pressProgress < totalPressDuration {
                        // Released before 5 seconds
                        resetRitual()
                    }
                    // Reset gesture cancelled flag for next gesture
                    gestureCancelled = false
                }
        )
    }
    
    private func resetRitual() {
        // Cancel the delayed fire sound task if it hasn't executed yet
        fireSoundTask?.cancel()
        fireSoundTask = nil
        
        // Stop the fire sound if it's playing
        SoundService.shared.stop(.fire)
        
        // Immediate reset without animation to prevent label overlap
        isPressed = false
        phase = .instruction
        pressProgress = 0
        showFire = false
        fireOpacity = 0.0
        emitterPosition = [0.5, 0.5] // Reset to center for next time
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
        .opacity(showFire ? fireOpacity : 0.0)
    }
    
    // Returns the built-in fire preset with our emitter position injected
    private func fireSystem() -> VortexSystem {
        let fire = VortexSystem.fire
        fire.position = emitterPosition
        return fire
    }
    

    private func completePress() {
        isPressed = false
        phase = .shuffling
        
        emitterPosition = [0.5, 0.5]
        
        withAnimation(.easeInOut(duration: 0.5)) {
            showFire = false
        }
        SoundService.shared.stop(.fire)
        
        // Initial heavy hit
        HapticService.shared.impact(.heavy)
        SoundService.shared.play(.cardShuffle, volume: 0.7)
        
        // 1. Trigger the intensive "riffle" feel
        triggerIntensiveShuffleHaptics(duration: 2.5)
        
        // Shuffle animation
        withAnimation(.easeInOut(duration: 2.5).repeatCount(3, autoreverses: true)) {
            shuffleRotation = 360
            shuffleOffset = 30
        }
        
        // 2. Final completion haptics
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                phase = .complete
            }
            SoundService.shared.play(.bellChime, volume: 0.6)
            
            // Use your existing .success case which triggers UINotificationFeedbackGenerator
            HapticService.shared.impact(.success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                navigateToReading = true
            }
        }
    }

    private func triggerIntensiveShuffleHaptics(duration: Double) {
        let hapticCount = 20
        let interval = duration / Double(hapticCount)
        
        for i in 0..<hapticCount {
            let delay = Double(i) * interval
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // Alternating between selection (light click) and light impact
                // creates a mechanical "card sliding" texture
                if i % 2 == 0 {
                    HapticService.shared.impact(.selection)
                } else {
                    HapticService.shared.impact(.light)
                }
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
