//
//  ReadingSession.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation
import SwiftData

@Model
final class ReadingSession {
    var id: UUID
    var date: Date
    var category: IntentionCategory
    var customQuestion: String?
    var spreadType: SpreadType
    @Relationship(deleteRule: .cascade) var drawnCards: [DrawnCard]
    var notes: String?
    
    init(category: IntentionCategory, customQuestion: String? = nil, spreadType: SpreadType, drawnCards: [DrawnCard] = []) {
        self.id = UUID()
        self.date = Date()
        self.category = category
        self.customQuestion = customQuestion
        self.spreadType = spreadType
        self.drawnCards = drawnCards
        self.notes = nil
    }
    
    var summary: String {
        let suitCounts = drawnCards.reduce(into: [TarotSuit: Int]()) { counts, drawnCard in
            counts[drawnCard.card.suit, default: 0] += 1
        }
        
        var summaryText = ""
        
        if let dominantSuit = suitCounts.max(by: { $0.value < $1.value })?.key {
            switch dominantSuit {
            case .cups:
                summaryText += "This reading shows a strong emotional theme. "
            case .swords:
                summaryText += "This reading carries mental and intellectual energy. "
            case .wands:
                summaryText += "This reading pulses with creative and passionate energy. "
            case .pentacles:
                summaryText += "This reading grounds itself in material and practical matters. "
            case .majorArcana:
                summaryText += "This reading reveals significant life themes and major transitions. "
            }
        }
        
        return summaryText
    }
}
