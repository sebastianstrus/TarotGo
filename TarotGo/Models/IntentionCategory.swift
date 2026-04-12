//
//  IntentionCategory.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

enum IntentionCategory: String, CaseIterable, Codable {
    case love = "Love"
    case career = "Career"
    case finance = "Finance"
    case health = "Health"
    case general = "General"
    
    var description: String {
        switch self {
        case .love:
            return "Matters of the heart, relationships, and connections"
        case .career:
            return "Work, professional growth, and career paths"
        case .finance:
            return "Money, abundance, and material security"
        case .health:
            return "Physical, mental, and spiritual wellbeing"
        case .general:
            return "General guidance and life direction"
        }
    }
    
    var defaultSpreadType: SpreadType {
        switch self {
        case .love:
            return .loveTriangle
        case .career:
            return .careerPath
        case .finance:
            return .threeCard
        case .health:
            return .threeCard
        case .general:
            return .celticCross
        }
    }
}
