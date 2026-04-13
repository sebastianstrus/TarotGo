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
}
