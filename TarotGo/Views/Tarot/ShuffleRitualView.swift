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
    @State private var auraIntensity: Double = 0.0
    @State private var auraScale: CGFloat = 0.8
    @State private var deckRotation: Double = 0
    @State private var deckFlip: Double = 0
    @Environment(\.dismiss) private var dismiss
    
    private let cardCount: Int = 24
    
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
                    cardStates = (0..<cardCount).map { i in
                        var s = ShuffleCardState()
                        s.offsetX = CGFloat(i) * 1.2
                        s.offsetY = -CGFloat(i) * 1.2
                        s.zIndex = Double(i)
                        return s
                    }
                }
            }
            .onDisappear {
                // Reset fire position to center for next time
                emitterPosition = [0.5, 0.5]
                showFire = false
                fireOpacity = 0.0
                auraIntensity = 0.0
                auraScale = 0.8
                deckRotation = 0
                deckFlip = 0
                cardStates = (0..<cardCount).map { i in
                    var s = ShuffleCardState()
                    s.offsetX = CGFloat(i) * 1.2
                    s.offsetY = -CGFloat(i) * 1.2
                    s.zIndex = Double(i)
                    return s
                }
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
            // Mystical aura behind the deck — intensifies during shuffle and final pulse
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppTheme.gold.opacity(0.55),
                            AppTheme.gold.opacity(0.18),
                            .clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )
                .frame(width: 380, height: 380)
                .blur(radius: 28)
                .blendMode(.plusLighter)
                .opacity(auraIntensity)
                .scaleEffect(auraScale)
                .allowsHitTesting(false)
            
            // Choreographed deck of cards — wrapped in a group so the whole deck
            // can rotate and flip in 3D while individual cards animate independently.
            ZStack {
                ForEach(0..<cardCount, id: \.self) { index in
                    let state = cardStateAt(index)
                    let isTopCard = index == cardCount - 1
                    CardView()
                        .frame(width: 200, height: 300)
                        .shadow(color: .black.opacity(0.35), radius: 8, x: 2, y: 6)
                        .shadow(color: AppTheme.gold.opacity(phase == .shuffling ? 0.3 : 0.0), radius: 14)
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
            .rotation3DEffect(
                .degrees(deckFlip),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .rotationEffect(.degrees(deckRotation))
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
    
    // Computed home position for a card in the fanned arc layout.
    private func fanPosition(for index: Int) -> (x: CGFloat, y: CGFloat, rotation: Double, tilt: Double) {
        let t = Double(index) / Double(max(cardCount - 1, 1))
        let centered = (t - 0.5) * 2.0
        return (
            x: CGFloat(centered) * 130,
            y: -CGFloat(abs(centered)) * 34 - 18,
            rotation: centered * 26,
            tilt: centered * 18
        )
    }
    
    private func runShuffleSequence() {
        // Safety: make sure cardStates is initialized
        if cardStates.count < cardCount {
            cardStates = (0..<cardCount).map { _ in ShuffleCardState() }
        }
        
        let count = cardCount
        let half = count / 2
        
        // ───────────────────────────────────────────────
        // PHASE 1 — Lift entrance (0.00 – 0.45s)
        // ───────────────────────────────────────────────
        withAnimation(.easeOut(duration: 0.45)) {
            auraIntensity = 0.55
            auraScale = 1.0
            for i in 0..<count {
                cardStates[i].offsetY = -12
                cardStates[i].tilt3DX = -10
                cardStates[i].scale = 0.97
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 2 — Fan out into a wide arc (0.45 – 1.40s)
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
            for i in 0..<count {
                let pos = fanPosition(for: i)
                withAnimation(.spring(response: 0.6, dampingFraction: 0.78).delay(Double(i) * 0.022)) {
                    cardStates[i].offsetX = pos.x
                    cardStates[i].offsetY = pos.y
                    cardStates[i].rotation = pos.rotation
                    cardStates[i].tilt3DX = -10
                    cardStates[i].tilt3DY = pos.tilt
                    cardStates[i].scale = 0.94
                    cardStates[i].zIndex = Double(i)
                }
            }
            HapticService.shared.impact(.soft)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 3 — Shimmer cascade (1.40 – 2.20s)
        // Each card briefly rises + scales as a wave ripples through the fan.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            for i in 0..<count {
                let delay = Double(i) * 0.025
                let pos = fanPosition(for: i)
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    withAnimation(.easeOut(duration: 0.22)) {
                        cardStates[i].offsetY = pos.y - 36
                        cardStates[i].scale = 1.08
                        cardStates[i].zIndex = Double(300 + i)
                    }
                    if i % 3 == 0 {
                        HapticService.shared.impact(.selection)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                        withAnimation(.easeIn(duration: 0.28)) {
                            cardStates[i].offsetY = pos.y
                            cardStates[i].scale = 0.94
                            cardStates[i].zIndex = Double(i)
                        }
                    }
                }
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 4 — Split into two halves with strong 3D tilt (2.20 – 2.70s)
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            for i in 0..<count {
                let isLeft = i < half
                let side: CGFloat = isLeft ? -1 : 1
                let positionInHalf = isLeft ? i : (i - half)
                let depthT = Double(positionInHalf) / Double(max(half - 1, 1))
                withAnimation(.easeInOut(duration: 0.45).delay(Double(positionInHalf) * 0.012)) {
                    cardStates[i].offsetX = side * 130
                    cardStates[i].offsetY = CGFloat(depthT) * 6 - 26
                    cardStates[i].rotation = Double(side) * 12
                    cardStates[i].tilt3DX = -14
                    cardStates[i].tilt3DY = Double(side) * 38
                    cardStates[i].scale = 0.96
                }
            }
            HapticService.shared.impact(.medium)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 5 — First riffle interleave (2.70 – 3.90s)
        // Cards drop into the center one by one, alternating L/R halves.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            for n in 0..<count {
                let isLeft = n % 2 == 0
                let positionInHalf = n / 2
                let cardIndex = isLeft ? positionInHalf : (half + positionInHalf)
                let stagger = Double(n) * 0.045
                DispatchQueue.main.asyncAfter(deadline: .now() + stagger) {
                    let jitterX = CGFloat.random(in: -6...6)
                    let jitterY = CGFloat.random(in: -5...5)
                    let jitterRot = Double.random(in: -3.5...3.5)
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        cardStates[cardIndex].offsetX = jitterX
                        cardStates[cardIndex].offsetY = jitterY
                        cardStates[cardIndex].rotation = jitterRot
                        cardStates[cardIndex].tilt3DX = 0
                        cardStates[cardIndex].tilt3DY = 0
                        cardStates[cardIndex].scale = 0.99
                        cardStates[cardIndex].zIndex = Double(500 + n)
                    }
                    HapticService.shared.impact(n % 2 == 0 ? .selection : .light)
                }
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 6 — Deck cut (3.90 – 4.50s)
        // Top half lifts to the right, bottom half stays — then they re-merge with swapped order.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.9) {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.75)) {
                for i in 0..<count {
                    let isTopHalf = i >= half
                    if isTopHalf {
                        cardStates[i].offsetX = 90
                        cardStates[i].offsetY = -40
                        cardStates[i].rotation = 6
                        cardStates[i].tilt3DY = 18
                    } else {
                        cardStates[i].offsetX = -25
                        cardStates[i].offsetY = 0
                        cardStates[i].rotation = -3
                        cardStates[i].tilt3DY = -10
                    }
                }
            }
            HapticService.shared.impact(.rigid)
        }
        // Re-merge with swapped order (top half re-stacks under the bottom)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.25) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.78)) {
                for i in 0..<count {
                    let isTopHalf = i >= half
                    cardStates[i].offsetX = 0
                    cardStates[i].offsetY = 0
                    cardStates[i].rotation = 0
                    cardStates[i].tilt3DY = 0
                    // Swap stacking order: previous top half goes under
                    cardStates[i].zIndex = isTopHalf ? Double(i - half) : Double(half + i)
                }
            }
            HapticService.shared.impact(.medium)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 7 — Orbital constellation (4.60 – 5.70s)
        // Cards fly out into a circular formation, then the whole deck rotates as one.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.6) {
            for i in 0..<count {
                let angle = (Double(i) / Double(count)) * 2.0 * .pi - .pi / 2
                let radius: CGFloat = 135
                withAnimation(.spring(response: 0.55, dampingFraction: 0.78).delay(Double(i) * 0.012)) {
                    cardStates[i].offsetX = CGFloat(cos(angle)) * radius
                    cardStates[i].offsetY = CGFloat(sin(angle)) * radius
                    cardStates[i].rotation = (angle * 180 / .pi) + 90
                    cardStates[i].tilt3DX = 0
                    cardStates[i].tilt3DY = 0
                    cardStates[i].scale = 0.78
                    cardStates[i].zIndex = Double(i)
                }
            }
            HapticService.shared.impact(.heavy)
            // Spin the whole constellation
            withAnimation(.easeInOut(duration: 1.0).delay(0.15)) {
                deckRotation = 270
            }
        }
        
        // ───────────────────────────────────────────────
        // PHASE 8 — Spin + 3D flip collapse (5.70 – 6.40s)
        // Cards converge to center while the entire deck flips 360° on Y-axis.
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.7) {
            withAnimation(.easeIn(duration: 0.55)) {
                for i in 0..<count {
                    cardStates[i].offsetX = CGFloat.random(in: -10...10)
                    cardStates[i].offsetY = CGFloat.random(in: -8...8)
                    cardStates[i].rotation = Double.random(in: -8...8)
                    cardStates[i].scale = 1.0
                }
                deckRotation = 360
            }
            withAnimation(.easeInOut(duration: 0.7)) {
                deckFlip = 360
            }
            HapticService.shared.impact(.heavy)
            SoundService.shared.play(.cardShuffle, volume: 0.45)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 9 — Settle into a clean stack (6.40 – 7.00s)
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.4) {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.82)) {
                deckRotation = 0
                deckFlip = 0
            }
            for i in 0..<count {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.85).delay(Double(i) * 0.008)) {
                    cardStates[i].offsetX = CGFloat(i) * 0.8
                    cardStates[i].offsetY = -CGFloat(i) * 0.8
                    cardStates[i].rotation = 0
                    cardStates[i].tilt3DX = 0
                    cardStates[i].tilt3DY = 0
                    cardStates[i].scale = 1.0
                    cardStates[i].zIndex = Double(i)
                }
            }
            HapticService.shared.impact(.medium)
        }
        
        // ───────────────────────────────────────────────
        // PHASE 10 — Final golden pulse signalling readiness (7.00 – 7.50s)
        // ───────────────────────────────────────────────
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            withAnimation(.easeInOut(duration: 0.35)) {
                for i in 0..<count {
                    cardStates[i].scale = 1.05
                }
                auraIntensity = 1.0
                auraScale = 1.25
            }
        }
        
        // Resolve to complete + bell chime
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.45) {
            withAnimation(.easeOut(duration: 0.5)) {
                for i in 0..<count {
                    cardStates[i].scale = 1.0
                }
                auraIntensity = 0.35
                auraScale = 1.0
            }
            withAnimation {
                phase = .complete
            }
            SoundService.shared.play(.bellChime, volume: 0.6)
            HapticService.shared.impact(.success)
        }
        
        // Navigate to next view
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.4) {
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
