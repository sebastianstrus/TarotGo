//
//  CardOfTheDayView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import Combine
import Vortex

struct CardOfTheDayView: View {
    @State private var todayCard: TarotCard?
    @State private var isReversed: Bool = false
    @State private var isRevealed: Bool = false
    @State private var showInterpretation: Bool = false
    @State private var pressProgress: Double = 0.0
    @State private var isPressed: Bool = false
    @State private var flipRotation: Double = 0
    @State private var emitterPosition: SIMD2<Double> = [0.5, 0.5]
    @State private var showFire: Bool = false
    @State private var screenSize: CGSize = .zero
    
    private let pressTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private let totalPressDuration: Double = 5.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 10) {
                        Image(systemName: "sun.max.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.cardOfDayTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: true, vertical: true)
                            .multilineTextAlignment(.center)
                            .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                        
                        Text(Date().formatted(date: .long, time: .omitted))
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                    }
                    .padding(.top, 30)
                    .frame(maxWidth: .infinity)
                    
                    if !isRevealed {
                        instructionView
                    }
                    
                    // Card
                    if let card = todayCard {
                        VStack(spacing: 20) {
                            cardView(card: card)
                            
                            // Progress indicator below card
                            progressIndicator
                                .opacity(isPressed && !isRevealed ? 1 : 0)
                        }
                        .padding(.vertical, 30)
                    }
                    
                    // Interpretation
                    if showInterpretation, let card = todayCard {
                        interpretationSection(for: card)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
            
            // Fire effect on top
            mysticalFireEffect
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                loadTodayCard()
                screenSize = geometry.size
            }
            .onReceive(pressTimer) { _ in
                if isPressed && !isRevealed {
                    pressProgress += 0.05
                    
                    if Int(pressProgress * 10) % 10 == 0 {
                        HapticService.shared.impact(.light)
                    }
                    
                    if pressProgress >= totalPressDuration {
                        completePress()
                    }
                }
            }
        }
    }
    
    private var instructionView: some View {
        VStack(spacing: 15) {
            Text(L10n.cardOfDayCenterYourself)
                .font(AppTheme.serifFont(size: 20, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
                .multilineTextAlignment(.center)
            
            Text(L10n.cardOfDayInstruction)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private func cardView(card: TarotCard) -> some View {
        ZStack {
            // Card back (visible when not flipped)
            CardBackView(isSelected: false)
                .frame(width: 220, height: 330)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .opacity(flipRotation < 90 ? 1 : 0)
                .rotation3DEffect(
                    .degrees(flipRotation),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
            
            // Card front (visible when flipped)
            TarotCardFrontView(card: card, isReversed: isReversed)
                .frame(width: 220, height: 330)
                .opacity(flipRotation >= 90 ? 1 : 0)
                .rotation3DEffect(
                    .degrees(flipRotation - 180),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
        }
        .onLongPressGesture(minimumDuration: totalPressDuration, maximumDistance: 50) {
            // This is called when the long press completes
            // The actual completion is handled in the timer
        } onPressingChanged: { pressing in
            if !isRevealed {
                if pressing {
                    withAnimation(.spring(response: 0.3)) {
                        isPressed = true
                    }
                    // Fade in fire effect
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showFire = true
                    }
                } else if pressProgress < totalPressDuration {
                    withAnimation(.spring(response: 0.3)) {
                        isPressed = false
                        pressProgress = 0
                    }
                    // Fade out fire effect
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showFire = false
                    }
                }
            }
        }
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
    
    private func interpretationSection(for card: TarotCard) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            // Card name and keywords
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(card.localizedName)
                        .font(AppTheme.serifFont(size: 26, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    if isReversed {
                        Text(L10n.interpretationReversed)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                    }
                }
                
                let keywords = isReversed ? card.reversedKeywords : card.keywords
                Text(keywords.joined(separator: " • "))
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.gold.opacity(0.9))
            }
            .padding(.bottom, 10)
            
            // Today's message
            VStack(alignment: .leading, spacing: 10) {
                Text(L10n.cardOfDayTodaysMessage)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(card.interpretation(for: .general, reversed: isReversed))
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineSpacing(8)
            }
            
            // Daily reflection prompt
            VStack(alignment: .leading, spacing: 10) {
                Text(L10n.cardOfDayReflect)
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(reflectionPrompt(for: card))
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(6)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
    
    private func loadTodayCard() {
        // Use current date as seed for reproducible random card each day
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let seed = (components.year ?? 0) * 10000 + (components.month ?? 0) * 100 + (components.day ?? 0)
        
        var generator = SeededRandomGenerator(seed: UInt64(seed))
        let allCards = TarotDeck.allCards
        let randomIndex = Int(generator.next() % UInt64(allCards.count))
        todayCard = allCards[randomIndex]
        
        // 30% chance of being reversed
        isReversed = generator.next() % 100 < 30
    }
    
    private func completePress() {
        isPressed = false
        
        // Fade out fire effect
        withAnimation(.easeInOut(duration: 0.5)) {
            showFire = false
        }
        
        HapticService.shared.impact(.heavy)
        SoundService.shared.play(.cardFlip, volume: 0.8)
        
        // Animate the flip
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
            flipRotation = 180
            isRevealed = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                showInterpretation = true
            }
            HapticService.shared.impact(.soft)
            SoundService.shared.play(.bellChime, volume: 0.5)
        }
    }
    
    private func reflectionPrompt(for card: TarotCard) -> String {
        // Simple reflection prompts based on card suits
        switch card.suit {
        case .majorArcana:
            return "What major theme or lesson is presenting itself in your life today? How can you honor this energy?"
        case .cups:
            return "What emotions are you experiencing today? How can you honor your feelings while staying balanced?"
        case .pentacles:
            return "What practical steps can you take today to manifest your goals? Where should you focus your energy?"
        case .swords:
            return "What truth needs to be acknowledged today? How can you communicate clearly and compassionately?"
        case .wands:
            return "What passion or creative project is calling to you? How can you channel your enthusiasm productively?"
        }
    }
}

// Seeded random number generator for reproducible daily cards
struct SeededRandomGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        state = seed
    }
    
    mutating func next() -> UInt64 {
        // Linear congruential generator
        state = (state &* 6364136223846793005) &+ 1442695040888963407
        return state
    }
}

#Preview {
    NavigationStack {
        CardOfTheDayView()
    }
}
