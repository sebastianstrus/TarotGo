//
//  TarotCard.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

enum TarotSuit: String, Codable {
    case majorArcana = "Major Arcana"
    case cups = "Cups"
    case pentacles = "Pentacles"
    case swords = "Swords"
    case wands = "Wands"
}

struct TarotCard: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let suit: TarotSuit
    let arcanaNumber: Int?
    let keywords: [String]
    let reversedKeywords: [String]
    
    var imageName: String {
        id
    }
    
    func interpretation(for category: IntentionCategory, reversed: Bool) -> String {
        let key = "\(id)_\(category.rawValue.lowercased())_\(reversed ? "reversed" : "upright")"
        return TarotInterpretations.interpretations[key] ?? "No interpretation available"
    }
    
    func alternativeInterpretation(for category: IntentionCategory, reversed: Bool, resonanceLevel: ResonanceLevel) -> String {
        let key = "\(id)_\(category.rawValue.lowercased())_\(reversed ? "reversed" : "upright")_\(resonanceLevel.rawValue)"
        return TarotInterpretations.alternativeInterpretations[key] ?? interpretation(for: category, reversed: reversed)
    }
}

enum ResonanceLevel: String, Codable {
    case resonates = "resonates"
    case unclear = "unclear"
    case notResonating = "not_resonating"
}

struct DrawnCard: Identifiable, Codable {
    let id: UUID
    let card: TarotCard
    let position: SpreadPosition
    let isReversed: Bool
    let category: IntentionCategory
    var resonanceLevel: ResonanceLevel?
    
    init(card: TarotCard, position: SpreadPosition, isReversed: Bool, category: IntentionCategory) {
        self.id = UUID()
        self.card = card
        self.position = position
        self.isReversed = isReversed
        self.category = category
        self.resonanceLevel = nil
    }
}
