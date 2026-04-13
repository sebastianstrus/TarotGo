//
//  IntentionCategory.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

enum IntentionCategory: String, CaseIterable, Codable {
    case love
    case career
    case finance
    case health
    case general
    
    var displayName: String {
        switch self {
        case .love:
            return L10n.categoryLove
        case .career:
            return L10n.categoryCareer
        case .finance:
            return L10n.categoryFinance
        case .health:
            return L10n.categoryHealth
        case .general:
            return L10n.categoryGeneral
        }
    }
    
    var description: String {
        switch self {
        case .love:
            return L10n.categoryLoveDesc
        case .career:
            return L10n.categoryCareerDesc
        case .finance:
            return L10n.categoryFinanceDesc
        case .health:
            return L10n.categoryHealthDesc
        case .general:
            return L10n.categoryGeneralDesc
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
