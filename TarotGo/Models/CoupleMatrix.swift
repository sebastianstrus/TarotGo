//
//  CoupleMatrix.swift
//  TarotGo
//
//  Couple Matrix model for two-birth-date relationship energy mapping
//

import Foundation

/// A yearly energy of the couple
struct CoupleYearlyEnergy: Identifiable {
    let id = UUID()
    let yearsTogetherIndex: Int // 0 = current year, 1 = next year, etc. (used for label "Year N")
    let year: Int
    let primaryEnergy: Int // 1-22
    let isCurrentYear: Bool

    var primaryCard: TarotCard? {
        let cards = TarotDeck.majorArcana
        guard primaryEnergy >= 1 && primaryEnergy <= 22 else { return nil }
        return cards[primaryEnergy - 1]
    }
}

/// A single position in a Couple Matrix reading
struct CoupleMatrixPosition: Identifiable {
    let id = UUID()
    let number: Int // 1-22 (Major Arcana)
    let position: CouplePositionType
    let x: Double // 0-1 normalized position in the diagram
    let y: Double // 0-1 normalized position in the diagram

    enum CouplePositionType: String, CaseIterable {
        case partnerA
        case partnerB
        case union
        case love
        case karma
        case money
        case sexuality
        case children
        case purpose
        case health

        var displayName: String {
            switch self {
            case .partnerA: return L10n.coupleMatrixPartnerA
            case .partnerB: return L10n.coupleMatrixPartnerB
            case .union: return L10n.coupleMatrixUnion
            case .love: return L10n.coupleMatrixLove
            case .karma: return L10n.coupleMatrixKarma
            case .money: return L10n.coupleMatrixMoney
            case .sexuality: return L10n.coupleMatrixSexuality
            case .children: return L10n.coupleMatrixChildren
            case .purpose: return L10n.coupleMatrixPurpose
            case .health: return L10n.coupleMatrixHealth
            }
        }

        var description: String {
            switch self {
            case .partnerA: return L10n.coupleMatrixPartnerADesc
            case .partnerB: return L10n.coupleMatrixPartnerBDesc
            case .union: return L10n.coupleMatrixUnionDesc
            case .love: return L10n.coupleMatrixLoveDesc
            case .karma: return L10n.coupleMatrixKarmaDesc
            case .money: return L10n.coupleMatrixMoneyDesc
            case .sexuality: return L10n.coupleMatrixSexualityDesc
            case .children: return L10n.coupleMatrixChildrenDesc
            case .purpose: return L10n.coupleMatrixPurposeDesc
            case .health: return L10n.coupleMatrixHealthDesc
            }
        }
    }

    /// Get the corresponding Major Arcana tarot card for this position
    var tarotCard: TarotCard? {
        let cards = TarotDeck.majorArcana
        guard number >= 1 && number <= 22 else { return nil }
        return cards[number - 1]
    }
}

/// Complete Couple Matrix calculation result
struct CoupleMatrix: Identifiable {
    let id = UUID()
    let birthDateA: Date
    let birthDateB: Date
    let positions: [CoupleMatrixPosition]
    let yearlyEnergies: [CoupleYearlyEnergy]
    let calculatedAt: Date

    init(
        birthDateA: Date,
        birthDateB: Date,
        positions: [CoupleMatrixPosition],
        yearlyEnergies: [CoupleYearlyEnergy] = []
    ) {
        self.birthDateA = birthDateA
        self.birthDateB = birthDateB
        self.positions = positions
        self.yearlyEnergies = yearlyEnergies
        self.calculatedAt = Date()
    }

    /// Get a position by type
    func position(for type: CoupleMatrixPosition.CouplePositionType) -> CoupleMatrixPosition? {
        positions.first { $0.position == type }
    }

    /// Combined energy at the heart of the union
    var unionPosition: CoupleMatrixPosition? {
        position(for: .union)
    }

    /// Get the current year's couple energy
    var currentYearEnergy: CoupleYearlyEnergy? {
        yearlyEnergies.first { $0.isCurrentYear }
    }

    var formattedBirthDateA: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDateA)
    }

    var formattedBirthDateB: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDateB)
    }
}
