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
        
        // Try to get specific interpretation
        if let specific = TarotInterpretations.interpretations[key] {
            return specific
        }
        
        // Fall back to general interpretation
        let generalKey = "\(id)_general_\(reversed ? "reversed" : "upright")"
        if let general = TarotInterpretations.interpretations[generalKey] {
            return general
        }
        
        // Generate a meaningful interpretation based on keywords and card attributes
        return generateGenericInterpretation(for: category, reversed: reversed)
    }
    
    private func generateGenericInterpretation(for category: IntentionCategory, reversed: Bool) -> String {
        let relevantKeywords = reversed ? reversedKeywords : keywords
        let keywordString = relevantKeywords.prefix(3).joined(separator: ", ")
        
        let orientation = reversed ? "reversed" : "upright"
        let cardType = suit == .majorArcana ? "major card" : "\(suit.rawValue) card"
        
        var interpretation = "The \(name) appears \(orientation) in your reading. "
        interpretation += "This \(cardType) brings the energies of \(keywordString). "
        
        switch category {
        case .love:
            if reversed {
                interpretation += "In matters of love, this suggests a need to address \(relevantKeywords.first ?? "challenges"). "
                interpretation += "Reflect on how these themes are showing up in your relationships and what might need attention or healing."
            } else {
                interpretation += "In your love life, embrace the qualities of \(relevantKeywords.first ?? "this energy"). "
                interpretation += "This card encourages you to embody these attributes as you navigate your romantic path."
            }
        case .career:
            if reversed {
                interpretation += "Regarding your career, consider where \(relevantKeywords.first ?? "obstacles") might be blocking your progress. "
                interpretation += "This is a call to reassess your approach and address any imbalances."
            } else {
                interpretation += "In your professional life, channel the energy of \(relevantKeywords.first ?? "success"). "
                interpretation += "This card suggests that these qualities will serve you well in your current endeavors."
            }
        case .finance:
            if reversed {
                interpretation += "Financially, be mindful of \(relevantKeywords.first ?? "challenges"). "
                interpretation += "This card advises caution and careful consideration of your resources and decisions."
            } else {
                interpretation += "In financial matters, align with the energy of \(relevantKeywords.first ?? "abundance"). "
                interpretation += "This card indicates favorable conditions when you apply these principles wisely."
            }
        case .health:
            if reversed {
                interpretation += "For your wellbeing, pay attention to signs related to \(relevantKeywords.first ?? "imbalance"). "
                interpretation += "Your body or mind may be asking for attention in these areas."
            } else {
                interpretation += "Regarding your health, embrace \(relevantKeywords.first ?? "vitality"). "
                interpretation += "This card encourages you to nurture yourself through these positive energies."
            }
        case .general:
            if reversed {
                interpretation += "This card invites you to examine where \(relevantKeywords.first ?? "blockages") might be present. "
                interpretation += "Reflection and honest self-assessment will help you move forward."
            } else {
                interpretation += "This card brings the gift of \(relevantKeywords.first ?? "wisdom"). "
                interpretation += "Trust in these energies as they guide you on your current path."
            }
        }
        
        return interpretation
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
