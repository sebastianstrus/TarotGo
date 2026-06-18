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

fileprivate struct ShuffleCardState {
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var rotation: Double = 0
    var tilt3DX: Double = 0
    var tilt3DY: Double = 0
    var scale: CGFloat = 1.0
    var opacity: Double = 1.0
    var zIndex: Double = 0
}

struct ShuffleRitualView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let category: IntentionCategory
    let customQuestion: String?
    
    @State private var phase: ShufflePhase = .instruction
    @State private var pressProgress: Double = 0.0
    @State private var isPressed: Bool = false
    @State private var navigateToReading: Bool = false
    @State private var emitterPosition: SIMD2<Double> = [0.5, 0.5]
    @State private var showFire: Bool = false
    @State private var screenSize: CGSize = .zero
    @State private var fireOpacity: Double = 0.0
    @State private var deckFrame: CGRect = .zero
    @State private var fireSoundTask: DispatchWorkItem?
    @State private var gestureCancelled: Bool = false
    @State private var showExitConfirmation: Bool = false
    @State private var cardStates: [ShuffleCardState] = []
    @Environment(\.dismiss) private var dismiss
    
    private let cardCount: Int = 78
    
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showExitConfirmation = true
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(AppTheme.goldGradient)
                    }
                }
            }
            .confirmationDialog(
                L10n.exitReadingTitle,
                isPresented: $showExitConfirmation,
                titleVisibility: .visible
            ) {
                Button(L10n.exitReadingConfirm, role: .destructive) {
                    appViewModel.returnToHome()
                    dismiss()
                }
                Button(L10n.exitReadingCancel, role: .cancel) {}
            } message: {
                Text(L10n.exitReadingMessage)
            }
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
                if cardStates.isEmpty {
                    cardStates = (0..<cardCount).map { i in initialStackedState(for: i) }
                }
            }
            .onDisappear {
                // Reset fire position to center for next time
                emitterPosition = [0.5, 0.5]
                showFire = false
                fireOpacity = 0.0
                cardStates = (0..<cardCount).map { i in initialStackedState(for: i) }
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
            // Cards — each animates independently for a natural riffle feel.
            ForEach(0..<cardCount, id: \.self) { index in
                let state = cardStateAt(index)
                let isTopCard = index == cardCount - 1
                CardView()
                    .frame(width: 200, height: 300)
                    .rotation3DEffect(
                        .degrees(state.tilt3DX),
                        axis: (x: 1, y: 0, z: 0),
                        perspective: 0.6
                    )
                    .rotation3DEffect(
                        .degrees(state.tilt3DY),
                        axis: (x: 0, y: 1, z: 0),
                        perspective: 0.6
                    )
                    .rotationEffect(.degrees(state.rotation))
                    .scaleEffect(state.scale * (isTopCard && isPressed ? 0.95 : 1.0))
                    .offset(x: state.offsetX, y: state.offsetY)
                    .opacity(state.opacity)
                    .zIndex(state.zIndex)
            }
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
    

    private func cardStateAt(_ index: Int) -> ShuffleCardState {
        guard index < cardStates.count else { return ShuffleCardState() }
        return cardStates[index]
    }
    
    // The resting stack — tiny offset per card so the deck reads as more than one card without looking bulky.
    private func initialStackedState(for index: Int) -> ShuffleCardState {
        var s = ShuffleCardState()
        s.offsetX = CGFloat(index) * 0.15
        s.offsetY = -CGFloat(index) * 0.15
        s.zIndex = Double(index)
        return s
    }

    private func completePress() {
        isPressed = false
        phase = .shuffling
        
        emitterPosition = [0.5, 0.5]
        
        withAnimation(.easeInOut(duration: 0.5)) {
            showFire = false
        }
        SoundService.shared.stop(.fire)
        
        // Initial heavy hit + shuffle sound
        HapticService.shared.impact(.heavy)
        SoundService.shared.play(.cardShuffle, volume: 0.7)
        
        runShuffleSequence()
    }
    
    private func runShuffleSequence() {
        // Safety: make sure cardStates is initialized
        if cardStates.count < cardCount {
            cardStates = (0..<cardCount).map { i in initialStackedState(for: i) }
        }
        
        let count = cardCount
        let half = count / 2
        
        // ───────────────────────────────────────────────
        // PHASE 1 — Lift (0.00 – 0.55s)
        // The deck rises with a small tilt.
        // ───────────────────────────────────────────────
        withAnimation(.easeOut(duration: 0.55)) {
            for i in 0..<count {
                cardStates[i].offsetY = -CGFloat(i) * 0.15 - 12
                cardStates[i].tilt3DX = -8
                cardStates[i].scale = 0.98
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 2 — Cut (0.60 – 1.45s)
        // The deck cleanly splits into two thick halves.
        // Each half keeps its internal stack offset so it still reads as a stack of 39 cards.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.82)) {
                for i in 0..<count {
                    let isLeft = i < half
                    let side: CGFloat = isLeft ? -1 : 1
                    let positionInHalf = isLeft ? i : (i - half)
                    // Small internal stack offset per half — visible as a stack, but not bulky
                    let stackX = CGFloat(positionInHalf) * 0.12
                    let stackY = -CGFloat(positionInHalf) * 0.15
                    cardStates[i].offsetX = side * 130 + side * stackX
                    cardStates[i].offsetY = -20 + stackY
                    cardStates[i].rotation = Double(side) * 5
                    cardStates[i].tilt3DX = -8
                    cardStates[i].tilt3DY = Double(side) * 16
                    cardStates[i].scale = 0.97
                    cardStates[i].zIndex = Double(positionInHalf) + (isLeft ? 0 : Double(half))
                }
            }
            HapticService.shared.impact(.soft)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 3 — Bridge (1.50 – 2.20s)
        // Each half bows inward — the classic riffle-shuffle pre-bend.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.55)) {
                for i in 0..<count {
                    let isLeft = i < half
                    let side: CGFloat = isLeft ? -1 : 1
                    let positionInHalf = isLeft ? i : (i - half)
                    let depthT = Double(positionInHalf) / Double(max(half - 1, 1))
                    let stackX = CGFloat(positionInHalf) * 0.12
                    let stackY = -CGFloat(positionInHalf) * 0.15
                    // Inward bow: cards bend toward the centerline but never cross it
                    cardStates[i].offsetX = side * 115 + side * stackX - CGFloat(side) * CGFloat(depthT) * 8
                    cardStates[i].offsetY = -28 + stackY - CGFloat(depthT) * 3
                    cardStates[i].rotation = Double(side) * 2.5
                    cardStates[i].tilt3DY = Double(side) * 26
                }
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 4 — Riffle (2.25 – 5.40s)
        // 78 cards alternately zip into the center one at a time.
        // ~40ms between drops → ~3.1s of staccato riffle.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
            for n in 0..<count {
                let isLeft = n % 2 == 0
                let positionInHalf = n / 2
                let cardIndex = isLeft ? positionInHalf : (half + positionInHalf)
                let stagger = Double(n) * 0.04
                DispatchQueue.main.asyncAfter(deadline: .now() + stagger) {
                    let jitterX = CGFloat.random(in: -3...3)
                    let jitterY = CGFloat.random(in: -2...2)
                    let jitterRot = Double.random(in: -1.8...1.8)
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.74)) {
                        cardStates[cardIndex].offsetX = jitterX
                        cardStates[cardIndex].offsetY = jitterY
                        cardStates[cardIndex].rotation = jitterRot
                        cardStates[cardIndex].tilt3DX = 0
                        cardStates[cardIndex].tilt3DY = 0
                        cardStates[cardIndex].scale = 1.0
                        cardStates[cardIndex].zIndex = Double(1000 + n)
                    }
                    // Light haptic every 4th card — ~8 Hz for a pleasant riffle texture, not a buzz
                    if n % 4 == 0 {
                        HapticService.shared.impact(.light)
                    }
                }
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 5 — Square-up (5.45 – 6.15s)
        // The deck settles into its resting form with a soft tap.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.45) {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.86)) {
                for i in 0..<count {
                    cardStates[i].offsetX = CGFloat(i) * 0.15
                    cardStates[i].offsetY = -CGFloat(i) * 0.15
                    cardStates[i].rotation = 0
                    cardStates[i].tilt3DX = 0
                    cardStates[i].tilt3DY = 0
                    cardStates[i].scale = 1.0
                    cardStates[i].zIndex = Double(i)
                }
            }
            HapticService.shared.impact(.soft)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 6 — Ready (6.30s)
        // Bell chime + success haptic signal the deck is shuffled.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.3) {
            withAnimation {
                phase = .complete
            }
            SoundService.shared.play(.bellChime, volume: 0.6)
            HapticService.shared.impact(.success)
        }
        
        // Navigate to next view
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.6) {
            navigateToReading = true
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
