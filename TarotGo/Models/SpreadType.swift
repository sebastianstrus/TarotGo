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
                SpreadPosition(id: "past", name: L10n.positionPastShort, description: L10n.positionPastShortDesc),
                SpreadPosition(id: "present", name: L10n.positionPresentShort, description: L10n.positionPresentShortDesc),
                SpreadPosition(id: "future", name: L10n.positionFutureShort, description: L10n.positionFutureShortDesc)
            ]
        case .celticCross:
            return [
                SpreadPosition(id: "present", name: L10n.positionPresentShort, description: L10n.positionPresentShortDesc),
                SpreadPosition(id: "challenge", name: L10n.positionChallenge, description: L10n.positionChallengeDesc),
                SpreadPosition(id: "past", name: L10n.positionFoundation, description: L10n.positionFoundationDesc),
                SpreadPosition(id: "future", name: L10n.positionApproaching, description: L10n.positionApproachingDesc),
                SpreadPosition(id: "above", name: L10n.positionAbove, description: L10n.positionAboveDesc),
                SpreadPosition(id: "below", name: L10n.positionBelow, description: L10n.positionBelowDesc),
                SpreadPosition(id: "advice", name: L10n.positionAdvice, description: L10n.positionAdviceDesc),
                SpreadPosition(id: "external", name: L10n.positionExternal, description: L10n.positionExternalDesc),
                SpreadPosition(id: "hopes", name: L10n.positionHopes, description: L10n.positionHopesDesc),
                SpreadPosition(id: "outcome", name: L10n.positionOutcome, description: L10n.positionOutcomeDesc)
            ]
        case .loveTriangle:
            return [
                SpreadPosition(id: "you", name: L10n.positionYou, description: L10n.positionYouDesc),
                SpreadPosition(id: "them", name: L10n.positionThem, description: L10n.positionThemDesc),
                SpreadPosition(id: "connection", name: L10n.positionConnection, description: L10n.positionConnectionDesc)
            ]
        case .careerPath:
            return [
                SpreadPosition(id: "current", name: L10n.positionCurrent, description: L10n.positionCurrentDesc),
                SpreadPosition(id: "obstacles", name: L10n.positionObstacles, description: L10n.positionObstaclesDesc),
                SpreadPosition(id: "strengths", name: L10n.positionStrengths, description: L10n.positionStrengthsDesc),
                SpreadPosition(id: "action", name: L10n.positionAction, description: L10n.positionActionDesc),
                SpreadPosition(id: "outcome", name: L10n.positionCareerOutcome, description: L10n.positionCareerOutcomeDesc)
            ]
        }
    }
}

struct SpreadPosition: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
}
