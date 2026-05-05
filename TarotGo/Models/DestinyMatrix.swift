//
//  DestinyMatrix.swift
//  TarotGo
//
//  Destiny Matrix model for birth date-based tarot calculations
//

import Foundation

/// Represents a yearly energy in the Destiny Matrix
struct YearlyEnergy: Identifiable {
    let id = UUID()
    let age: Int
    let year: Int
    let primaryEnergy: Int // Main energy for this year (1-22)
    let secondaryEnergy: Int // Personal year energy (1-22)
    let isCurrentYear: Bool
    
    /// Get the corresponding tarot card for primary energy
    var primaryCard: TarotCard? {
        let cards = TarotDeck.majorArcana
        guard primaryEnergy >= 1 && primaryEnergy <= 22 else { return nil }
        return cards[primaryEnergy - 1]
    }
    
    /// Get the corresponding tarot card for secondary energy
    var secondaryCard: TarotCard? {
        let cards = TarotDeck.majorArcana
        guard secondaryEnergy >= 1 && secondaryEnergy <= 22 else { return nil }
        return cards[secondaryEnergy - 1]
    }
}

/// Represents a position in the Destiny Matrix
struct MatrixPosition: Identifiable {
    let id = UUID()
    let number: Int // 1-22 (Major Arcana)
    let position: PositionType
    let x: Double // Position in diagram (0-1 normalized)
    let y: Double // Position in diagram (0-1 normalized)
    
    enum PositionType: String, CaseIterable {
        case center = "center"
        case personalPower = "personalPower"
        case socialRealization = "socialRealization"
        case spiritualDevelopment = "spiritualDevelopment"
        case planetaryInfluence = "planetaryInfluence"
        case money = "money"
        case relationships = "relationships"
        case talents = "talents"
        case purpose = "purpose"
        case health = "health"
        case karma = "karma"
        case male = "male" // Father line
        case female = "female" // Mother line
        case sky = "sky" // Heaven
        case earth = "earth" // Earth
        case comfort = "comfort"
        case past = "past"
        case present = "present"
        case future = "future"
        
        var displayName: String {
            switch self {
            case .center: return L10n.matrixCenter
            case .personalPower: return L10n.matrixPersonalPower
            case .socialRealization: return L10n.matrixSocialRealization
            case .spiritualDevelopment: return L10n.matrixSpiritualDevelopment
            case .planetaryInfluence: return L10n.matrixPlanetaryInfluence
            case .money: return L10n.matrixMoney
            case .relationships: return L10n.matrixRelationships
            case .talents: return L10n.matrixTalents
            case .purpose: return L10n.matrixPurpose
            case .health: return L10n.matrixHealth
            case .karma: return L10n.matrixKarma
            case .male: return L10n.matrixMale
            case .female: return L10n.matrixFemale
            case .sky: return L10n.matrixSky
            case .earth: return L10n.matrixEarth
            case .comfort: return L10n.matrixComfort
            case .past: return L10n.matrixPast
            case .present: return L10n.matrixPresent
            case .future: return L10n.matrixFuture
            }
        }
        
        var description: String {
            switch self {
            case .center: return L10n.matrixCenterDesc
            case .personalPower: return L10n.matrixPersonalPowerDesc
            case .socialRealization: return L10n.matrixSocialRealizationDesc
            case .spiritualDevelopment: return L10n.matrixSpiritualDevelopmentDesc
            case .planetaryInfluence: return L10n.matrixPlanetaryInfluenceDesc
            case .money: return L10n.matrixMoneyDesc
            case .relationships: return L10n.matrixRelationshipsDesc
            case .talents: return L10n.matrixTalentsDesc
            case .purpose: return L10n.matrixPurposeDesc
            case .health: return L10n.matrixHealthDesc
            case .karma: return L10n.matrixKarmaDesc
            case .male: return L10n.matrixMaleDesc
            case .female: return L10n.matrixFemaleDesc
            case .sky: return L10n.matrixSkyDesc
            case .earth: return L10n.matrixEarthDesc
            case .comfort: return L10n.matrixComfortDesc
            case .past: return L10n.matrixPastDesc
            case .present: return L10n.matrixPresentDesc
            case .future: return L10n.matrixFutureDesc
            }
        }
    }
    
    /// Get the corresponding tarot card for this position
    var tarotCard: TarotCard? {
        // Major Arcana cards are indexed 0-21, but Destiny Matrix uses 1-22
        let cards = TarotDeck.majorArcana
        guard number >= 1 && number <= 22 else { return nil }
        return cards[number - 1]
    }
}

/// Complete Destiny Matrix calculation result
struct DestinyMatrix: Identifiable {
    let id = UUID()
    let birthDate: Date
    let positions: [MatrixPosition]
    let yearlyEnergies: [YearlyEnergy]
    let calculatedAt: Date
    
    init(birthDate: Date, positions: [MatrixPosition], yearlyEnergies: [YearlyEnergy] = []) {
        self.birthDate = birthDate
        self.positions = positions
        self.yearlyEnergies = yearlyEnergies
        self.calculatedAt = Date()
    }
    
    /// Get position by type
    func position(for type: MatrixPosition.PositionType) -> MatrixPosition? {
        positions.first { $0.position == type }
    }
    
    /// Get the center (main energy) position
    var centerPosition: MatrixPosition? {
        position(for: .center)
    }
    
    /// Get formatted birth date
    var formattedBirthDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDate)
    }
    
    /// Get current year's energy
    var currentYearEnergy: YearlyEnergy? {
        yearlyEnergies.first { $0.isCurrentYear }
    }
    
    /// Get energy for a specific age
    func yearlyEnergy(forAge age: Int) -> YearlyEnergy? {
        yearlyEnergies.first { $0.age == age }
    }
}
