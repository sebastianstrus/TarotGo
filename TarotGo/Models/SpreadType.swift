//
//  SpreadType.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

enum SpreadType: String, Codable {
    case threeCard
    case celticCross
    case loveTriangle
    case careerPath

    var displayName: String {
        switch self {
        case .threeCard:
            return L10n.spreadThreeCard
        case .celticCross:
            return L10n.spreadCelticCross
        case .loveTriangle:
            return L10n.spreadLoveTriangle
        case .careerPath:
            return L10n.spreadCareerPath
        }
    }
    
    // Custom decoding to handle old data with display names
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        // Try direct match first
        if let value = SpreadType(rawValue: rawValue) {
            self = value
            return
        }
        
        // Handle old display names
        switch rawValue {
        case "Three Card Spread", "Trois Cartes":
            self = .threeCard
        case "Celtic Cross", "Croix Celtique":
            self = .celticCross
        case "Love Triangle", "Triangle Amoureux", "Trójkąt Miłosny":
            self = .loveTriangle
        case "Career Path", "Chemin de Carrière", "Ścieżka Kariery":
            self = .careerPath
        default:
            // If we can't decode, default to threeCard
            self = .threeCard
        }
    }

    var positions: [SpreadPosition] {
        switch self {
        case .threeCard:
            return [
                SpreadPosition(id: "past", nameKey: "past_short", descriptionKey: "past_short_desc"),
                SpreadPosition(id: "present", nameKey: "present_short", descriptionKey: "present_short_desc"),
                SpreadPosition(id: "future", nameKey: "future_short", descriptionKey: "future_short_desc")
            ]
        case .celticCross:
            return [
                SpreadPosition(id: "present", nameKey: "present_short", descriptionKey: "present_short_desc"),
                SpreadPosition(id: "challenge", nameKey: "challenge", descriptionKey: "challenge_desc"),
                SpreadPosition(id: "past", nameKey: "foundation", descriptionKey: "foundation_desc"),
                SpreadPosition(id: "future", nameKey: "approaching", descriptionKey: "approaching_desc"),
                SpreadPosition(id: "above", nameKey: "above", descriptionKey: "above_desc"),
                SpreadPosition(id: "below", nameKey: "below", descriptionKey: "below_desc"),
                SpreadPosition(id: "advice", nameKey: "advice", descriptionKey: "advice_desc"),
                SpreadPosition(id: "external", nameKey: "external", descriptionKey: "external_desc"),
                SpreadPosition(id: "hopes", nameKey: "hopes", descriptionKey: "hopes_desc"),
                SpreadPosition(id: "outcome", nameKey: "outcome", descriptionKey: "outcome_desc")
            ]
        case .loveTriangle:
            return [
                SpreadPosition(id: "you", nameKey: "you", descriptionKey: "you_desc"),
                SpreadPosition(id: "them", nameKey: "them", descriptionKey: "them_desc"),
                SpreadPosition(id: "connection", nameKey: "connection", descriptionKey: "connection_desc")
            ]
        case .careerPath:
            return [
                SpreadPosition(id: "current", nameKey: "current", descriptionKey: "current_desc"),
                SpreadPosition(id: "obstacles", nameKey: "obstacles", descriptionKey: "obstacles_desc"),
                SpreadPosition(id: "strengths", nameKey: "strengths", descriptionKey: "strengths_desc"),
                SpreadPosition(id: "action", nameKey: "action", descriptionKey: "action_desc"),
                SpreadPosition(id: "outcome", nameKey: "careerOutcome", descriptionKey: "careerOutcome_desc")
            ]
        }
    }
}

struct SpreadPosition: Identifiable, Codable {
    let id: String
    private let nameKey: String
    private let descriptionKey: String

    var name: String {
        // Return localized string based on nameKey
        switch nameKey {
        case "past_short": return L10n.positionPastShort
        case "present_short": return L10n.positionPresentShort
        case "future_short": return L10n.positionFutureShort
        case "challenge": return L10n.positionChallenge
        case "foundation": return L10n.positionFoundation
        case "approaching": return L10n.positionApproaching
        case "above": return L10n.positionAbove
        case "below": return L10n.positionBelow
        case "advice": return L10n.positionAdvice
        case "external": return L10n.positionExternal
        case "hopes": return L10n.positionHopes
        case "outcome": return L10n.positionOutcome
        case "you": return L10n.positionYou
        case "them": return L10n.positionThem
        case "connection": return L10n.positionConnection
        case "current": return L10n.positionCurrent
        case "obstacles": return L10n.positionObstacles
        case "strengths": return L10n.positionStrengths
        case "action": return L10n.positionAction
        case "careerOutcome": return L10n.positionCareerOutcome
        default: return nameKey
        }
    }

    var description: String {
        // Return localized description based on descriptionKey
        switch descriptionKey {
        case "past_short_desc": return L10n.positionPastShortDesc
        case "present_short_desc": return L10n.positionPresentShortDesc
        case "future_short_desc": return L10n.positionFutureShortDesc
        case "challenge_desc": return L10n.positionChallengeDesc
        case "foundation_desc": return L10n.positionFoundationDesc
        case "approaching_desc": return L10n.positionApproachingDesc
        case "above_desc": return L10n.positionAboveDesc
        case "below_desc": return L10n.positionBelowDesc
        case "advice_desc": return L10n.positionAdviceDesc
        case "external_desc": return L10n.positionExternalDesc
        case "hopes_desc": return L10n.positionHopesDesc
        case "outcome_desc": return L10n.positionOutcomeDesc
        case "you_desc": return L10n.positionYouDesc
        case "them_desc": return L10n.positionThemDesc
        case "connection_desc": return L10n.positionConnectionDesc
        case "current_desc": return L10n.positionCurrentDesc
        case "obstacles_desc": return L10n.positionObstaclesDesc
        case "strengths_desc": return L10n.positionStrengthsDesc
        case "action_desc": return L10n.positionActionDesc
        case "careerOutcome_desc": return L10n.positionCareerOutcomeDesc
        default: return descriptionKey
        }
    }

    init(id: String, nameKey: String, descriptionKey: String) {
        self.id = id
        self.nameKey = nameKey
        self.descriptionKey = descriptionKey
    }
    
    // Custom Codable implementation for backward compatibility
    enum CodingKeys: String, CodingKey {
        case id
        case nameKey
        case descriptionKey
        case name  // Old format
        case description  // Old format
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        
        // Try new format first, fall back to old format
        if let nKey = try? container.decode(String.self, forKey: .nameKey) {
            nameKey = nKey
        } else if let oldName = try? container.decode(String.self, forKey: .name) {
            // Convert old name to nameKey
            nameKey = Self.convertOldNameToKey(oldName)
        } else {
            nameKey = "unknown"
        }
        
        if let dKey = try? container.decode(String.self, forKey: .descriptionKey) {
            descriptionKey = dKey
        } else if let oldDesc = try? container.decode(String.self, forKey: .description) {
            // Convert old description to descriptionKey
            descriptionKey = Self.convertOldDescriptionToKey(oldDesc)
        } else {
            descriptionKey = "unknown"
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nameKey, forKey: .nameKey)
        try container.encode(descriptionKey, forKey: .descriptionKey)
    }
    
    private static func convertOldNameToKey(_ oldName: String) -> String {
        // Map old static names to new keys
        switch oldName {
        case "Past": return "past_short"
        case "Present": return "present_short"
        case "Future": return "future_short"
        case "Challenge": return "challenge"
        case "Foundation": return "foundation"
        case "Approaching": return "approaching"
        case "Above": return "above"
        case "Below": return "below"
        case "Advice": return "advice"
        case "External": return "external"
        case "Hopes & Fears": return "hopes"
        case "Outcome": return "outcome"
        case "You": return "you"
        case "Them": return "them"
        case "Connection": return "connection"
        case "Current Situation": return "current"
        case "Obstacles": return "obstacles"
        case "Strengths": return "strengths"
        case "Action": return "action"
        default: return "unknown"
        }
    }
    
    private static func convertOldDescriptionToKey(_ oldDesc: String) -> String {
        // Map old static descriptions to new keys
        switch oldDesc {
        case "What brought you here": return "past_short_desc"
        case "Your current situation": return "present_short_desc"
        case "What's coming": return "future_short_desc"
        case "What crosses you": return "challenge_desc"
        case "Foundation of the situation": return "foundation_desc"
        case "What's approaching": return "approaching_desc"
        case "Your goal or aspiration": return "above_desc"
        case "Unconscious influences": return "below_desc"
        case "Your best approach": return "advice_desc"
        case "Outside influences": return "external_desc"
        case "Your inner emotions": return "hopes_desc"
        case "Final result": return "outcome_desc"
        case "Your emotional state": return "you_desc"
        case "Their emotional state": return "them_desc"
        case "The relationship dynamic": return "connection_desc"
        case "Where you are now": return "current_desc"
        case "What's blocking you": return "obstacles_desc"
        case "Your assets": return "strengths_desc"
        case "What to do next": return "action_desc"
        case "Potential result": return "careerOutcome_desc"
        default: return "unknown"
        }
    }
}
