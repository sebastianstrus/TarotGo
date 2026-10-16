// Copy of TarotGo/Services/AstrologyService.swift for the watch target (kept in sync manually).
//
//  AstrologyService.swift
//  TarotGo
//
//  Service for astrological calculations and personalization
//

import Foundation

enum ZodiacSign: Int, CaseIterable {
    case aries = 1
    case taurus = 2
    case gemini = 3
    case cancer = 4
    case leo = 5
    case virgo = 6
    case libra = 7
    case scorpio = 8
    case sagittarius = 9
    case capricorn = 10
    case aquarius = 11
    case pisces = 12
    
    var name: String {
        switch self {
        case .aries: return String(localized: String.LocalizationValue("astrology.sign.aries"), bundle: SelectedLanguage.bundle)
        case .taurus: return String(localized: String.LocalizationValue("astrology.sign.taurus"), bundle: SelectedLanguage.bundle)
        case .gemini: return String(localized: String.LocalizationValue("astrology.sign.gemini"), bundle: SelectedLanguage.bundle)
        case .cancer: return String(localized: String.LocalizationValue("astrology.sign.cancer"), bundle: SelectedLanguage.bundle)
        case .leo: return String(localized: String.LocalizationValue("astrology.sign.leo"), bundle: SelectedLanguage.bundle)
        case .virgo: return String(localized: String.LocalizationValue("astrology.sign.virgo"), bundle: SelectedLanguage.bundle)
        case .libra: return String(localized: String.LocalizationValue("astrology.sign.libra"), bundle: SelectedLanguage.bundle)
        case .scorpio: return String(localized: String.LocalizationValue("astrology.sign.scorpio"), bundle: SelectedLanguage.bundle)
        case .sagittarius: return String(localized: String.LocalizationValue("astrology.sign.sagittarius"), bundle: SelectedLanguage.bundle)
        case .capricorn: return String(localized: String.LocalizationValue("astrology.sign.capricorn"), bundle: SelectedLanguage.bundle)
        case .aquarius: return String(localized: String.LocalizationValue("astrology.sign.aquarius"), bundle: SelectedLanguage.bundle)
        case .pisces: return String(localized: String.LocalizationValue("astrology.sign.pisces"), bundle: SelectedLanguage.bundle)
        }
    }
    
    var symbol: String {
        switch self {
        case .aries: return "♈"
        case .taurus: return "♉"
        case .gemini: return "♊"
        case .cancer: return "♋"
        case .leo: return "♌"
        case .virgo: return "♍"
        case .libra: return "♎"
        case .scorpio: return "♏"
        case .sagittarius: return "♐"
        case .capricorn: return "♑"
        case .aquarius: return "♒"
        case .pisces: return "♓"
        }
    }

    /// Stable lowercase identifier used in localization keys.
    var key: String {
        switch self {
        case .aries: return "aries"
        case .taurus: return "taurus"
        case .gemini: return "gemini"
        case .cancer: return "cancer"
        case .leo: return "leo"
        case .virgo: return "virgo"
        case .libra: return "libra"
        case .scorpio: return "scorpio"
        case .sagittarius: return "sagittarius"
        case .capricorn: return "capricorn"
        case .aquarius: return "aquarius"
        case .pisces: return "pisces"
        }
    }
}

class AstrologyService {
    static let shared = AstrologyService()
    
    private init() {}
    
    // MARK: - Birth Date Storage
    
    private let birthDateKey = "userBirthDate"
    
    var userBirthDate: Date? {
        get {
            UserDefaults.standard.object(forKey: birthDateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: birthDateKey)
        }
    }
    
    var hasBirthDate: Bool {
        userBirthDate != nil
    }
    
    // MARK: - Zodiac Sign Calculation
    
    /// Calculate zodiac sign from birth date
    func zodiacSign(from date: Date) -> ZodiacSign {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day], from: date)
        
        guard let month = components.month, let day = components.day else {
            return .aries
        }
        
        // Zodiac sign date ranges
        switch (month, day) {
        case (3, 21...31), (4, 1...19):
            return .aries
        case (4, 20...30), (5, 1...20):
            return .taurus
        case (5, 21...31), (6, 1...20):
            return .gemini
        case (6, 21...30), (7, 1...22):
            return .cancer
        case (7, 23...31), (8, 1...22):
            return .leo
        case (8, 23...31), (9, 1...22):
            return .virgo
        case (9, 23...30), (10, 1...22):
            return .libra
        case (10, 23...31), (11, 1...21):
            return .scorpio
        case (11, 22...30), (12, 1...21):
            return .sagittarius
        case (12, 22...31), (1, 1...19):
            return .capricorn
        case (1, 20...31), (2, 1...18):
            return .aquarius
        case (2, 19...29), (3, 1...20):
            return .pisces
        default:
            return .aries
        }
    }
    
    // MARK: - Life Path Number Calculation
    
    /// Calculate life path number (1-9 or master numbers 11, 22)
    func lifePathNumber(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        
        guard let day = components.day,
              let month = components.month,
              let year = components.year else {
            return 1
        }
        
        // Sum all digits from birth date
        let daySum = reduceToSingleDigit(day, keepMasterNumbers: false)
        let monthSum = reduceToSingleDigit(month, keepMasterNumbers: false)
        let yearSum = reduceToSingleDigit(year, keepMasterNumbers: false)
        
        let total = daySum + monthSum + yearSum
        return reduceToSingleDigit(total, keepMasterNumbers: true)
    }
    
    /// Reduce a number to a single digit (with option to keep master numbers 11, 22)
    private func reduceToSingleDigit(_ number: Int, keepMasterNumbers: Bool) -> Int {
        var result = number
        
        while result > 9 {
            // Keep master numbers 11 and 22
            if keepMasterNumbers && (result == 11 || result == 22) {
                return result
            }
            
            result = sumDigits(result)
        }
        
        return result
    }
    
    /// Sum all digits in a number
    private func sumDigits(_ number: Int) -> Int {
        var num = abs(number)
        var sum = 0
        
        while num > 0 {
            sum += num % 10
            num /= 10
        }
        
        return sum
    }
    
    // MARK: - Personalized Seed Generation
    
    /// Generate a personalized seed for card of the day
    /// Combines: current date + zodiac sign + life path number
    func personalizedSeed(for date: Date, birthDate: Date) -> UInt64 {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        // Base seed from current date
        let dateSeed = (components.year ?? 0) * 10000 + (components.month ?? 0) * 100 + (components.day ?? 0)
        
        // Zodiac sign (1-12)
        let sign = zodiacSign(from: birthDate)
        let signValue = sign.rawValue
        
        // Life path number (1-22)
        let lifePathValue = lifePathNumber(from: birthDate)
        
        // Birth date components for additional personalization
        let birthComponents = calendar.dateComponents([.day, .month, .year], from: birthDate)
        let birthSeed = (birthComponents.day ?? 0) * 100 + (birthComponents.month ?? 0)
        
        // Combine all values into a unique seed
        // Formula: (date * 1000000) + (sign * 10000) + (lifePath * 100) + birthSeed
        let personalizedValue = UInt64(dateSeed) * 1000000 + UInt64(signValue) * 10000 + UInt64(lifePathValue) * 100 + UInt64(birthSeed)
        
        return personalizedValue
    }
    
    /// Generate a default seed when no birth date is available
    func defaultSeed(for date: Date) -> UInt64 {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let dateSeed = (components.year ?? 0) * 10000 + (components.month ?? 0) * 100 + (components.day ?? 0)
        return UInt64(dateSeed)
    }
}
