//
//  ReadingViewModel.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class ReadingViewModel: ObservableObject {
    @Published var availableCards: [TarotCard] = []
    @Published var drawnCards: [DrawnCard] = []
    @Published var isShuffling: Bool = false
    @Published var selectedCardIds: Set<String> = []
    
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType
    
    init(category: IntentionCategory, customQuestion: String?, spreadType: SpreadType) {
        self.category = category
        self.customQuestion = customQuestion
        self.spreadType = spreadType
        self.availableCards = TarotDeck.allCards.shuffled()
    }
    
    func shuffleDeck(completion: @escaping () -> Void) {
        isShuffling = true
        
        // Animate shuffle over 3 seconds with multiple shuffles
        var shuffleCount = 0
        let totalShuffles = 6
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.availableCards.shuffle()
            HapticService.shared.impact(.light)
            
            shuffleCount += 1
            
            if shuffleCount >= totalShuffles {
                timer.invalidate()
                self.isShuffling = false
                HapticService.shared.impact(.success)
                SoundService.shared.play(.success, volume: 0.5)
                completion()
            } else {
                SoundService.shared.play(.cardShuffle, volume: 0.4)
            }
        }
    }
    
    func drawCard(at position: SpreadPosition, selectedCard: TarotCard) -> DrawnCard? {
        guard !selectedCardIds.contains(selectedCard.id) else { return nil }
        
        selectedCardIds.insert(selectedCard.id)
        let isReversed = Double.random(in: 0...1) < 0.3
        
        let drawnCard = DrawnCard(
            card: selectedCard,
            position: position,
            isReversed: isReversed,
            category: category
        )
        
        drawnCards.append(drawnCard)
        
        SoundService.shared.play(.cardDraw, volume: 0.6)
        HapticService.shared.impact(.medium)
        
        return drawnCard
    }
    
    func resetReading() {
        availableCards = TarotDeck.allCards.shuffled()
        drawnCards = []
        selectedCardIds = []
        isShuffling = false
    }
}
