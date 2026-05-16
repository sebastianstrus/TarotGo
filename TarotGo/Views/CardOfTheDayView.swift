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
    @State private var isFinishing: Bool = false
    @State private var cardFrame: CGRect = .zero
    @State private var gestureCancelled: Bool = false
    @State private var showVibeCheck: Bool = false
    @State private var initialTouchLocation: CGPoint = .zero
    @State private var showBirthDateInput: Bool = false
    
    private let pressTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private let totalPressDuration: Double = 5.0
    
    // UserDefaults keys for persistence (include birth date hash for uniqueness)
    private var todayKey: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        
        // Include birth date hash to make key unique per user
        let birthDateHash = AstrologyService.shared.userBirthDate?.timeIntervalSince1970.hashValue ?? 0
        return "cardOfDay_\(components.year ?? 0)_\(components.month ?? 0)_\(components.day ?? 0)_\(birthDateHash)_revealed"
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 30) {
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
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity)
                        
                        if !isRevealed {
                            instructionView
                        }
                        
                        if !isRevealed {
                            progressIndicator
                                .padding(.bottom, -15)
                        }
                        
                        if let card = todayCard {
                            cardView(card: card)
                        }
                        
                        if showInterpretation, let card = todayCard {
                            interpretationSection(for: card)
                        }
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal)
                }
                .scrollDisabled(false)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showVibeCheck = true
                    }) {
                        Image(systemName: "globe.europe.africa.fill")
                            .foregroundStyle(AppTheme.goldGradient)
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showVibeCheck) {
                VibeCheckView()
            }
            .sheet(isPresented: $showBirthDateInput) {
                BirthDateInputView(isPresented: $showBirthDateInput) { date in
                    // Reload the card with the new personalized seed
                    loadTodayCard()
                }
            }
            .onAppear {
                // Check if birth date is needed and not set
                if !AstrologyService.shared.hasBirthDate {
                    showBirthDateInput = true
                }
                loadTodayCard()
                loadRevealedState()
                // Reset VortexSystem fire position to center
                let fireSystem = VortexSystem.fire
                fireSystem.position = [0.5, 0.5]
            }
            .onReceive(pressTimer) { _ in
                if isPressed && !isRevealed && !isFinishing {
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
        VStack(spacing: 10) {
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
            CardView()
                .frame(width: 220, height: 330)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .opacity(flipRotation < 90 ? 1 : 0)
                .rotation3DEffect(
                    .degrees(flipRotation),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
            
            // Card front (visible when flipped)
            CardView(card: card, showFront: true, isReversed: isReversed)
                .frame(width: 220, height: 330)
                .opacity(flipRotation >= 90 ? 1 : 0)
                .rotation3DEffect(
                    .degrees(flipRotation - 180),
                    axis: (x: 0, y: 1, z: 0),
                    perspective: 0.5
                )
        }
        .shadow(color: !isRevealed && isPressed ? AppTheme.gold.opacity(0.6) : .clear, radius: 20, x: 0, y: 0)
        .shadow(color: !isRevealed && isPressed ? AppTheme.gold.opacity(0.4) : .clear, radius: 40, x: 0, y: 0)
        .animation(.easeInOut(duration: 1.0), value: isPressed)
        .animation(.easeInOut(duration: 1.0), value: isRevealed)
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        cardFrame = geometry.frame(in: .global)
                    }
                    .onChange(of: geometry.frame(in: .global)) { oldValue, newValue in
                        cardFrame = newValue
                    }
            }
        )
        .onLongPressGesture(minimumDuration: 0.2, maximumDistance: 50) {
            // Long press confirmed - activate the press state
            guard !isRevealed && !isFinishing else { return }
            withAnimation(.spring(response: 0.3)) {
                isPressed = true
            }
        } onPressingChanged: { pressing in
            guard !isRevealed && !isFinishing else { return }
            
            if !pressing && isPressed {
                // Finger lifted before completion
                resetRitual()
            }
        }
        .simultaneousGesture(
            // Track finger movement to cancel if it moves off the card
            DragGesture(minimumDistance: 50, coordinateSpace: .global)
                .onChanged { value in
                    guard isPressed && !isRevealed && !isFinishing else { return }
                    
                    // Only track if already pressing - allows scroll otherwise
                    let touchPoint = value.location
                    if !cardFrame.contains(touchPoint) {
                        gestureCancelled = true
                        resetRitual()
                    }
                }
        )
    }
    
    private var progressIndicator: some View {
        RitualCandles(progress: pressProgress, duration: totalPressDuration)
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
                
                let keywords = isReversed ? card.localizedReversedKeywords : card.localizedKeywords
                FlowLayout(spacing: 8) {
                    ForEach(keywords, id: \.self) { keyword in
                        Text(keyword)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(AppTheme.darkNavy.opacity(0.5))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                                    )
                            )
                    }
                }
            }
            .padding(.bottom, 10)
            
            // Today's message - General
            InterpretationCard(
                title: L10n.cardOfDayTodaysMessage,
                icon: "sparkles",
                text: card.interpretation(for: .general, reversed: isReversed)
            )
            
            // Love interpretation
            InterpretationCard(
                title: L10n.categoryLove,
                icon: "heart.fill",
                text: card.interpretation(for: .love, reversed: isReversed)
            )
            
            // Career interpretation
            InterpretationCard(
                title: L10n.categoryCareer,
                icon: "briefcase.fill",
                text: card.interpretation(for: .career, reversed: isReversed)
            )
            
            // Finance interpretation
            InterpretationCard(
                title: L10n.categoryFinance,
                icon: "dollarsign.circle.fill",
                text: card.interpretation(for: .finance, reversed: isReversed)
            )
            
            // Health interpretation
            InterpretationCard(
                title: L10n.categoryHealth,
                icon: "cross.fill",
                text: card.interpretation(for: .health, reversed: isReversed)
            )
            
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
        // Use personalized seed based on user's birth date (if available)
        let currentDate = Date()
        let seed: UInt64
        
        if let birthDate = AstrologyService.shared.userBirthDate {
            // Use personalized seed combining date, zodiac sign, and life path number
            seed = AstrologyService.shared.personalizedSeed(for: currentDate, birthDate: birthDate)
        } else {
            // Fall back to date-only seed
            seed = AstrologyService.shared.defaultSeed(for: currentDate)
        }
        
        var generator = SeededRandomGenerator(seed: seed)
        let allCards = TarotDeck.allCards
        let randomIndex = Int(generator.next() % UInt64(allCards.count))
        todayCard = allCards[randomIndex]
        
        // 30% chance of being reversed
        isReversed = generator.next() % 100 < 30
    }
    
    private func loadRevealedState() {
        let wasRevealed = UserDefaults.standard.bool(forKey: todayKey)
        if wasRevealed {
            // Skip the ritual and show the card immediately
            isRevealed = true
            flipRotation = 180
            showInterpretation = true
            isFinishing = true
        }
    }
    
    private func saveRevealedState() {
        UserDefaults.standard.set(true, forKey: todayKey)
    }
    
    private func resetRitual() {
        withAnimation(.spring(response: 0.3)) {
            isPressed = false
            pressProgress = 0
        }
    }
    
    private func completePress() {
        isFinishing = true // Lock the UI immediately
        isPressed = false  // Stops the scaleEffect shrink
        
        HapticService.shared.impact(.heavy)
        
        // Save revealed state
        saveRevealedState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            SoundService.shared.play(.cardFlip, volume: 0.8)
            
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
    }
    
    private func reflectionPrompt(for card: TarotCard) -> String {
        // Simple reflection prompts based on card suits
        switch card.suit {
        case .majorArcana:
            return String(localized: "cardOfDay.reflection.majorArcana")
        case .cups:
            return String(localized: "cardOfDay.reflection.cups")
        case .pentacles:
            return String(localized: "cardOfDay.reflection.pentacles")
        case .swords:
            return String(localized: "cardOfDay.reflection.swords")
        case .wands:
            return String(localized: "cardOfDay.reflection.wands")
        }
    }
}

// MARK: - Ritual Candles (mystic ignition effect)
struct RitualCandles: View {
    var progress: CGFloat
    let duration: CGFloat
    
    private var normalized: CGFloat {
        min(max(progress / duration, 0), 1)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<5) { i in
                // Flame area with consistent frame
                ZStack {
                    if normalized >= CGFloat(i + 1) * 0.2 {
                        // Vortex flame effect
                        VortexView(.fire) {
                            Circle()
                                .fill(.white)
                                .blendMode(.plusLighter)
                                .blur(radius: 3)
                                .frame(width: 32)
                                .tag("circle")
                        }
                        .frame(width: 200, height: 350)
                        .scaleEffect(0.3)
                        .transition(.opacity.animation(.easeInOut(duration: 0.5)))
                    } else {
                        // Unlit state
                        Circle()
                            .fill(Color.orange.opacity(0.15))
                            .frame(width: 15, height: 15)
                            .blur(radius: 1.5)
                    }
                }
                .frame(width: 30, height: 60)
                .animation(.easeInOut(duration: 0.5), value: normalized >= CGFloat(i + 1) * 0.2)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CardOfTheDayView()
    }
}
