//
//  TarotInterpretations.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

struct TarotInterpretations {
    
    /// Key-based lookup into the String Catalog. Resolved on every access (not cached
    /// in a `static let`) so the text always matches the currently selected language.
    struct Lookup {
        private static let missing = "\u{0}missing\u{0}"

        subscript(key: String) -> String? {
            let value = NSLocalizedString("interpretation.\(key)", value: Self.missing, comment: "Tarot interpretation")
            return value == Self.missing ? nil : value
        }
    }

    // Main interpretations for each card, category, and orientation
    static var interpretations: Lookup { Lookup() }

    // Alternative interpretations based on resonance level
    static var alternativeInterpretations: Lookup { Lookup() }

    
    // Spread summaries - contextual interpretations that tie multiple cards together
    static func spreadSummary(for cards: [DrawnCard], category: IntentionCategory, spreadType: SpreadType) -> String {
        let majorArcanaCount = cards.filter { $0.card.suit == .majorArcana }.count
        let reversedCount = cards.filter { $0.isReversed }.count
        let suitCounts = cards.reduce(into: [TarotSuit: Int]()) { counts, drawnCard in
            counts[drawnCard.card.suit, default: 0] += 1
        }
        
        var summaryParts: [String] = []
        
        // ALWAYS provide Major Arcana insight
        if majorArcanaCount >= cards.count / 2 {
            summaryParts.append(L10n.summaryMajorArcanaHigh(majorArcanaCount))
        } else {
            summaryParts.append(L10n.summaryMajorArcanaLow)
        }
        
        // ALWAYS provide reversed cards insight
        if reversedCount > cards.count / 2 {
            summaryParts.append(L10n.summaryReversedMany)
        } else if reversedCount > 0 {
            summaryParts.append(L10n.summaryReversedSome)
        } else {
            summaryParts.append(L10n.summaryReversedNone)
        }
        
        // ALWAYS provide suit insight - either dominant suit or balanced
        if let dominantSuit = suitCounts.max(by: { $0.value < $1.value })?.key,
           let count = suitCounts[dominantSuit] {
            // For 3-card spreads, 2 cards of same suit is significant
            // For larger spreads, need more cards to be dominant
            let threshold = cards.count <= 3 ? 2 : (cards.count / 2)
            
            if count >= threshold {
                switch dominantSuit {
                case .cups:
                    summaryParts.append(L10n.summarySuitCupsDominant)
                case .swords:
                    summaryParts.append(L10n.summarySuitSwordsDominant)
                case .wands:
                    summaryParts.append(L10n.summarySuitWandsDominant)
                case .pentacles:
                    summaryParts.append(L10n.summarySuitPentaclesDominant)
                case .majorArcana:
                    summaryParts.append(L10n.summarySuitMajorArcanaDominant)
                }
            } else {
                summaryParts.append(L10n.summarySuitBalanced)
            }
        } else {
            summaryParts.append(L10n.summarySuitBalanced)
        }
        
        // Category-specific insight
        let categoryInsight: String
        switch category {
        case .love:
            categoryInsight = L10n.summaryInsightLove
        case .career:
            categoryInsight = L10n.summaryInsightCareer
        case .finance:
            categoryInsight = L10n.summaryInsightFinance
        case .health:
            categoryInsight = L10n.summaryInsightHealth
        case .general:
            categoryInsight = L10n.summaryInsightGeneral
        }
        summaryParts.append(categoryInsight)
        
        // Deterministic closing based on category and last card orientation
        let lastCardReversed = cards.last?.isReversed ?? false
        summaryParts.append(L10n.closingForReading(category: category, lastCardReversed: lastCardReversed))
        
        // Join all parts with a space
        return summaryParts.joined(separator: " ")
    }
}
