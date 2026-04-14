//
//  InterpretationView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct InterpretationView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let drawnCards: [DrawnCard]
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType
    
    @State private var currentCardIndex: Int = 0
    @State private var isCardRevealed: Bool = false
    @State private var showInterpretation: Bool = false
    @State private var showResonanceQuestion: Bool = false
    @State private var selectedResonance: ResonanceLevel?
    @State private var interpretationText: String = ""
    @State private var navigateToSummary: Bool = false
    @State private var updatedDrawnCards: [DrawnCard] = []
    
    private var currentCard: DrawnCard? {
        guard currentCardIndex < drawnCards.count else { return nil }
        return drawnCards[currentCardIndex]
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    if let card = currentCard {
                        // Progress
                        progressIndicator
                        
                        // Position name
                        VStack(spacing: 10) {
                            Text(card.position.name)
                                .font(AppTheme.serifFont(size: 28, weight: .light))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                            
                            if !isCardRevealed {
                                Text(L10n.interpretationTapReveal)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary.opacity(0.8))
                            }
                        }
                        .padding(.top, 20)
                        
                        // Card with flip animation
                        cardView(for: card)
                            .padding(.vertical, 30)
                        
                        // Interpretation text
                        if showInterpretation {
                            interpretationSection
                        }
                        
                        // Resonance question
                        if showResonanceQuestion {
                            resonanceSection
                        }
                        
                        // Continue button
                        if selectedResonance != nil {
                            continueButton
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToSummary) {
            SummaryView(
                drawnCards: updatedDrawnCards,
                category: category,
                customQuestion: customQuestion,
                spreadType: spreadType
            )
        }
        .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
            if shouldDismiss {
                navigateToSummary = false
            }
        }
        .onAppear {
            updatedDrawnCards = drawnCards
            SoundService.shared.playAmbient(.ambientMystic, volume: 0.15)
        }
        .onDisappear {
            SoundService.shared.stopAmbient()
        }
    }
    
    private var progressIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<drawnCards.count, id: \.self) { index in
                Capsule()
                    .fill(index <= currentCardIndex ? AppTheme.goldGradient : LinearGradient(colors: [AppTheme.gold.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 40)
    }
    
    private func cardView(for drawnCard: DrawnCard) -> some View {
        FlipCardView(
            isFlipped: $isCardRevealed,
            card: drawnCard.card,
            isReversed: drawnCard.isReversed
        ) {
            revealCard(drawnCard)
        }
    }
    
    private var interpretationSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Card name and keywords
            if let card = currentCard {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(card.card.localizedName)
                            .font(AppTheme.serifFont(size: 24, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        if card.isReversed {
                            Text(L10n.interpretationReversed)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(AppTheme.gold.opacity(0.8))
                        }
                    }
                    
                    // Keywords
                    let keywords = card.isReversed ? card.card.reversedKeywords : card.card.keywords
                    Text(keywords.joined(separator: " • "))
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.9))
                }
                .padding(.bottom, 10)
            }
            
            // Interpretation text
            Text(interpretationText)
                .font(.system(size: 18, weight: .light))
                .foregroundColor(AppTheme.textPrimary)
                .lineSpacing(8)
                .multilineTextAlignment(.leading)
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
    
    private var resonanceSection: some View {
        VStack(spacing: 20) {
            Text(L10n.interpretationResonateQuestion)
                .font(AppTheme.serifFont(size: 20, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
            
            VStack(spacing: 12) {
                ResonanceButton(
                    text: L10n.interpretationResonateYes,
                    icon: "checkmark.circle.fill",
                    isSelected: selectedResonance == .resonates
                ) {
                    selectResonance(.resonates)
                }
                
                ResonanceButton(
                    text: L10n.interpretationResonateUnsure,
                    icon: "questionmark.circle.fill",
                    isSelected: selectedResonance == .unclear
                ) {
                    selectResonance(.unclear)
                }
                
                ResonanceButton(
                    text: L10n.interpretationResonateNo,
                    icon: "xmark.circle.fill",
                    isSelected: selectedResonance == .notResonating
                ) {
                    selectResonance(.notResonating)
                }
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
    
    private var continueButton: some View {
        Button {
            proceedToNextCard()
        } label: {
            HStack(spacing: 8) {
                Text(currentCardIndex < drawnCards.count - 1 ? L10n.interpretationContinue : L10n.interpretationSeeFullReading)
                    .font(AppTheme.serifFont(size: 18, weight: .semibold))
                
                Image(systemName: "arrow.right")
                    .font(.system(size: 14))
            }
            .foregroundColor(AppTheme.deepNavy)
            .frame(maxWidth: .infinity)
            .padding()
            .background(AppTheme.goldGradient)
            .cornerRadius(15)
            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
        }
        .padding(.top, 10)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
    
    private func revealCard(_ drawnCard: DrawnCard) {
        withAnimation(.spring(response: 0.5)) {
            isCardRevealed = true
        }
        
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.cardFlip, volume: 0.7)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation {
                interpretationText = drawnCard.card.interpretation(
                    for: category,
                    reversed: drawnCard.isReversed
                )
                showInterpretation = true
            }
            HapticService.shared.impact(.soft)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    showResonanceQuestion = true
                }
            }
        }
    }
    
    private func selectResonance(_ level: ResonanceLevel) {
        withAnimation {
            selectedResonance = level
        }
        
        HapticService.shared.impact(.selection)
        SoundService.shared.play(.whoosh, volume: 0.3)
        
        // Update interpretation if not resonating
        if level != .resonates, let card = currentCard {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    interpretationText = card.card.alternativeInterpretation(
                        for: category,
                        reversed: card.isReversed,
                        resonanceLevel: level
                    )
                }
                HapticService.shared.impact(.soft)
            }
        }
        
        // Update the drawn card with resonance level
        if currentCardIndex < updatedDrawnCards.count {
            updatedDrawnCards[currentCardIndex].resonanceLevel = level
        }
    }
    
    private func proceedToNextCard() {
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.whoosh, volume: 0.5)
        
        if currentCardIndex < drawnCards.count - 1 {
            withAnimation {
                currentCardIndex += 1
                isCardRevealed = false
                showInterpretation = false
                showResonanceQuestion = false
                selectedResonance = nil
                interpretationText = ""
            }
        } else {
            HapticService.shared.impact(.success)
            navigateToSummary = true
        }
    }
}

struct FlipCardView: View {
    @Binding var isFlipped: Bool
    let card: TarotCard
    let isReversed: Bool
    let onTap: () -> Void
    
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            if rotation < 90 {
                // Card back
                CardBackView(isSelected: false)
                    .frame(width: 200, height: 300)
            } else {
                // Card front
                TarotCardFrontView(card: card, isReversed: isReversed)
                    .frame(width: 200, height: 300)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
        .onTapGesture {
            if !isFlipped {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    rotation = 180
                }
                onTap()
            }
        }
    }
}

struct TarotCardFrontView: View {
    let card: TarotCard
    let isReversed: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width
            let cardHeight = geometry.size.height
            let scaleFactor = min(cardWidth / 200, cardHeight / 300) // Base size 200x300
            
            ZStack {
                RoundedRectangle(cornerRadius: 12 * scaleFactor)
                    .fill(
                        LinearGradient(
                            colors: [Color.white, Color(white: 0.95)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                VStack(spacing: 8 * scaleFactor) {
                    // Card name with reversed indicator
                    HStack(spacing: 3 * scaleFactor) {
                        if isReversed {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 10 * scaleFactor))
                                .foregroundColor(AppTheme.gold)
                        }
                        
                        Text(card.localizedName)
                            .font(AppTheme.serifFont(size: 14 * scaleFactor, weight: .semibold))
                            .foregroundColor(AppTheme.deepNavy)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                        
                        if isReversed {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 10 * scaleFactor))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.horizontal, 8 * scaleFactor)
                    
                    // Card image placeholder with gold accents
                    ZStack {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [AppTheme.darkNavy.opacity(0.9), AppTheme.deepNavy],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Image(systemName: cardIcon)
                            .font(.system(size: 40 * scaleFactor))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        // Reversed indicator overlay
                        if isReversed {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Image(systemName: "arrow.turn.up.forward.iphone.fill")
                                        .font(.system(size: 16 * scaleFactor))
                                        .foregroundColor(AppTheme.gold.opacity(0.7))
                                        .rotationEffect(.degrees(180))
                                        .padding(8 * scaleFactor)
                                }
                            }
                        }
                    }
                    .cornerRadius(8 * scaleFactor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8 * scaleFactor)
                            .stroke(isReversed ? AppTheme.gold : AppTheme.gold.opacity(0.5), lineWidth: max(1, 2 * scaleFactor))
                    )
                    .padding(.horizontal, 10 * scaleFactor)
                    
                    // Suit
                    Text(card.suit.localizedName)
                        .font(.system(size: 10 * scaleFactor, weight: .light))
                        .foregroundColor(AppTheme.gold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .padding(.vertical, 10 * scaleFactor)
                
                RoundedRectangle(cornerRadius: 12 * scaleFactor)
                    .stroke(
                        LinearGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: max(1, 3 * scaleFactor)
                    )
            }
            .shadow(color: AppTheme.gold.opacity(0.3), radius: 10 * scaleFactor)
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    private var cardIcon: String {
        switch card.suit {
        case .majorArcana:
            return "sparkles"
        case .cups:
            return "heart.fill"
        case .pentacles:
            return "circle.hexagongrid.fill"
        case .swords:
            return "flame.fill"
        case .wands:
            return "wand.and.stars"
        }
    }
}

struct ResonanceButton: View {
    let text: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(isSelected ? AppTheme.goldGradient : LinearGradient(colors: [AppTheme.textPrimary], startPoint: .leading, endPoint: .trailing))
                
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? AppTheme.textPrimary : AppTheme.textSecondary)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? AppTheme.cardGradient : LinearGradient(colors: [Color.white.opacity(0.05)], startPoint: .top, endPoint: .bottom))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.3), lineWidth: isSelected ? 2 : 1)
                    )
                    .shadow(color: isSelected ? AppTheme.gold.opacity(0.3) : .clear, radius: 8)
            )
        }
    }
}

#Preview {
    NavigationStack {
        InterpretationView(
            drawnCards: [
                DrawnCard(
                    card: TarotDeck.majorArcana[0],
                    position: SpreadPosition(id: "past", nameKey: "past_short", descriptionKey: "past_short_desc"),
                    isReversed: false,
                    category: .love
                )
            ],
            category: .love,
            customQuestion: "Will I find love?",
            spreadType: .threeCard
        )
    }
    .environmentObject(AppViewModel())
}
