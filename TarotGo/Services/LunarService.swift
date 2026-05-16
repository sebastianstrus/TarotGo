//
//  LunarService.swift
//  TarotGo
//
//  Service for calculating moon phases
//

import Foundation

enum MoonPhase: String, CaseIterable {
    case newMoon = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case fullMoon = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"
    
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
            return "A time for new beginnings, setting intentions, and planting seeds for the future."
        case .waxingCrescent:
            return "Energy is building. Take initial action on your goals and remain flexible."
        case .firstQuarter:
            return "Time for decision and commitment. Push through obstacles with determination."
        case .waxingGibbous:
            return "Refine your plans and adjust your approach. Success is within reach."
        case .fullMoon:
            return "Peak energy for manifestation, celebration, and emotional release. Harvest what you've sown."
        case .waningGibbous:
            return "Share your wisdom and gratitude. Reflect on lessons learned."
        case .lastQuarter:
            return "Release what no longer serves you. Let go and create space for renewal."
        case .waningCrescent:
            return "Rest, restore, and prepare for the next cycle. Surrender and trust."
        }
    }
    
    var energy: String {
        switch self {
        case .newMoon: return "Intention & New Beginnings"
        case .waxingCrescent: return "Growth & Expansion"
        case .firstQuarter: return "Action & Determination"
        case .waxingGibbous: return "Refinement & Adjustment"
        case .fullMoon: return "Manifestation & Release"
        case .waningGibbous: return "Gratitude & Sharing"
        case .lastQuarter: return "Letting Go & Forgiveness"
        case .waningCrescent: return "Rest & Surrender"
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
