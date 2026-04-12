//
//  InterpretationView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct InterpretationView: View {
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
            AnimatedBackgroundView()
            
            ScrollView {
                VStack(spacing: 30) {
                    if let card = currentCard {
                        // Progress
                        progressIndicator
                        
                        // Position name
                        VStack(spacing: 10) {
                            Text(card.position.name)
                                .font(.system(size: 28, weight: .light, design: .serif))
                                .foregroundColor(.white)
                            
                            if !isCardRevealed {
                                Text("Tap to reveal when you're ready")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.white.opacity(0.7))
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
                    .fill(index <= currentCardIndex ? Color.white : Color.white.opacity(0.3))
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
                        Text(card.card.name)
                            .font(.system(size: 24, weight: .medium, design: .serif))
                            .foregroundColor(.white)
                        
                        if card.isReversed {
                            Text("(Reversed)")
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                    
                    // Keywords
                    let keywords = card.isReversed ? card.card.reversedKeywords : card.card.keywords
                    Text(keywords.joined(separator: " • "))
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.bottom, 10)
            }
            
            // Interpretation text
            Text(interpretationText)
                .font(.system(size: 18, weight: .light))
                .foregroundColor(.white)
                .lineSpacing(8)
                .multilineTextAlignment(.leading)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
    
    private var resonanceSection: some View {
        VStack(spacing: 20) {
            Text("Does this resonate with you?")
                .font(.system(size: 20, weight: .light, design: .serif))
                .foregroundColor(.white)
            
            VStack(spacing: 12) {
                ResonanceButton(
                    text: "Yes, this speaks to me",
                    icon: "checkmark.circle.fill",
                    isSelected: selectedResonance == .resonates
                ) {
                    selectResonance(.resonates)
                }
                
                ResonanceButton(
                    text: "I'm not sure",
                    icon: "questionmark.circle.fill",
                    isSelected: selectedResonance == .unclear
                ) {
                    selectResonance(.unclear)
                }
                
                ResonanceButton(
                    text: "This doesn't fit",
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
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
    
    private var continueButton: some View {
        Button {
            proceedToNextCard()
        } label: {
            Text(currentCardIndex < drawnCards.count - 1 ? "Continue" : "See Full Reading")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
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
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            VStack(spacing: 15) {
                // Card name
                Text(card.name)
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 10)
                
                // Card image placeholder (you'll add real images later)
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [Color.purple.opacity(0.2), Color.blue.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Image(systemName: cardIcon)
                        .font(.system(size: 50))
                        .foregroundColor(.purple)
                }
                .frame(height: 180)
                .cornerRadius(8)
                .padding(.horizontal, 15)
                
                // Suit
                Text(card.suit.rawValue)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 15)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
        }
        .rotationEffect(.degrees(isReversed ? 180 : 0))
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
                
                Text(text)
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(isSelected ? Color.white.opacity(0.6) : Color.white.opacity(0.2), lineWidth: isSelected ? 2 : 1)
                    )
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
                    position: SpreadPosition(id: "past", name: "Past", description: "What brought you here"),
                    isReversed: false,
                    category: .love
                )
            ],
            category: .love,
            customQuestion: "Will I find love?",
            spreadType: .threeCard
        )
    }
}
