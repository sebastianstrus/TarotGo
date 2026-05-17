//
//  LunarService.swift
//  TarotGo
//
//  Service for calculating moon phases
//

import Foundation

enum MoonPhase: CaseIterable {
    case newMoon
    case waxingCrescent
    case firstQuarter
    case waxingGibbous
    case fullMoon
    case waningGibbous
    case lastQuarter
    case waningCrescent
    
    var rawValue: String {
        switch self {
        case .newMoon: return L10n.moonPhaseNewMoon
        case .waxingCrescent: return L10n.moonPhaseWaxingCrescent
        case .firstQuarter: return L10n.moonPhaseFirstQuarter
        case .waxingGibbous: return L10n.moonPhaseWaxingGibbous
        case .fullMoon: return L10n.moonPhaseFullMoon
        case .waningGibbous: return L10n.moonPhaseWaningGibbous
        case .lastQuarter: return L10n.moonPhaseLastQuarter
        case .waningCrescent: return L10n.moonPhaseWaningCrescent
        }
    }
    
    var symbol: String {
        switch self {
        case .newMoon: return "🌑"
        case .waxingCrescent: return "🌒"
        case .firstQuarter: return "🌓"
        case .waxingGibbous: return "🌔"
        case .fullMoon: return "🌕"
        case .waningGibbous: return "🌖"
        case .lastQuarter: return "🌗"
        case .waningCrescent: return "🌘"
        }
    }
    
    var description: String {
        switch self {
        case .newMoon:
            return L10n.moonPhaseNewMoonDesc
        case .waxingCrescent:
            return L10n.moonPhaseWaxingCrescentDesc
        case .firstQuarter:
            return L10n.moonPhaseFirstQuarterDesc
        case .waxingGibbous:
            return L10n.moonPhaseWaxingGibbousDesc
        case .fullMoon:
            return L10n.moonPhaseFullMoonDesc
        case .waningGibbous:
            return L10n.moonPhaseWaningGibbousDesc
        case .lastQuarter:
            return L10n.moonPhaseLastQuarterDesc
        case .waningCrescent:
            return L10n.moonPhaseWaningCrescentDesc
        }
    }
    
    var energy: String {
        switch self {
        case .newMoon: return L10n.moonPhaseNewMoonEnergy
        case .waxingCrescent: return L10n.moonPhaseWaxingCrescentEnergy
        case .firstQuarter: return L10n.moonPhaseFirstQuarterEnergy
        case .waxingGibbous: return L10n.moonPhaseWaxingGibbousEnergy
        case .fullMoon: return L10n.moonPhaseFullMoonEnergy
        case .waningGibbous: return L10n.moonPhaseWaningGibbousEnergy
        case .lastQuarter: return L10n.moonPhaseLastQuarterEnergy
        case .waningCrescent: return L10n.moonPhaseWaningCrescentEnergy
        }
    }
}

class LunarService {
    static let shared = LunarService()
    
    private init() {}
    
    /// Calculate moon phase for a given date
    /// Uses simplified lunar phase calculation based on synodic month (29.53 days)
    func moonPhase(for date: Date) -> MoonPhase {
        // Reference new moon: January 6, 2000, 18:14 UTC
        let referenceDate = Date(timeIntervalSince1970: 947182440)
        let synodicMonth = 29.53058867 * 24 * 60 * 60 // in seconds
        
        let timeDifference = date.timeIntervalSince(referenceDate)
        let phaseNumber = timeDifference.truncatingRemainder(dividingBy: synodicMonth)
        let phasePercentage = phaseNumber / synodicMonth
        
        // Divide into 8 phases
        switch phasePercentage {
        case 0..<0.0625:
            return .newMoon
        case 0.0625..<0.1875:
            return .waxingCrescent
        case 0.1875..<0.3125:
            return .firstQuarter
        case 0.3125..<0.4375:
            return .waxingGibbous
        case 0.4375..<0.5625:
            return .fullMoon
        case 0.5625..<0.6875:
            return .waningGibbous
        case 0.6875..<0.8125:
            return .lastQuarter
        case 0.8125..<1.0:
            return .waningCrescent
        default:
            return .newMoon
        }
    }
    
    /// Calculate illumination percentage
    func illuminationPercentage(for date: Date) -> Double {
        let referenceDate = Date(timeIntervalSince1970: 947182440)
        let synodicMonth = 29.53058867 * 24 * 60 * 60
        
        let timeDifference = date.timeIntervalSince(referenceDate)
        let phaseNumber = timeDifference.truncatingRemainder(dividingBy: synodicMonth)
        let phasePercentage = phaseNumber / synodicMonth
        
        // Calculate illumination (0% at new moon, 100% at full moon)
        if phasePercentage < 0.5 {
            return phasePercentage * 200
        } else {
            return (1 - phasePercentage) * 200
        }
    }
    
    /// Get dates for upcoming moon phases
    func upcomingPhases(from date: Date, count: Int) -> [(date: Date, phase: MoonPhase)] {
        var phases: [(Date, MoonPhase)] = []
        var currentDate = date
        
        for _ in 0..<count {
            let phase = moonPhase(for: currentDate)
            phases.append((currentDate, phase))
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return phases
    }
    
    /// Get zodiac sign the moon is in (simplified)
    func moonZodiacSign(for date: Date) -> ZodiacSign {
        // Moon moves through zodiac approximately every 2.5 days
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 1
        let signIndex = (dayOfYear / 3) % 12
        return ZodiacSign.allCases[signIndex]
    }
}
