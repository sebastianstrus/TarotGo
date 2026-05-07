//
//  PalmReading.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation

// Major palm lines analyzed in palmistry
enum PalmLine: String, Codable {
    case heart = "Heart Line"
    case head = "Head Line"
    case life = "Life Line"
    case fate = "Fate Line"
    
    var localizedName: String {
        rawValue
    }
}

// Characteristics of a palm line
struct PalmLineCharacteristics: Codable {
    let line: PalmLine
    let length: LineLength
    let depth: LineDepth
    let continuity: LineContinuity
    
    enum LineLength: String, Codable {
        case short
        case medium
        case long
        
        var description: String {
            switch self {
            case .short: return "Short"
            case .medium: return "Medium"
            case .long: return "Long"
            }
        }
    }
    
    enum LineDepth: String, Codable {
        case faint
        case moderate
        case deep
        
        var description: String {
            switch self {
            case .faint: return "Faint"
            case .moderate: return "Moderate"
            case .deep: return "Deep"
            }
        }
    }
    
    enum LineContinuity: String, Codable {
        case continuous
        case broken
        case chained
        
        var description: String {
            switch self {
            case .continuous: return "Continuous"
            case .broken: return "Broken"
            case .chained: return "Chained"
            }
        }
    }
}

// Complete palm reading result
struct PalmReading: Identifiable, Codable {
    let id: UUID
    let date: Date
    let heartLine: PalmLineCharacteristics
    let headLine: PalmLineCharacteristics
    let lifeLine: PalmLineCharacteristics
    let fateLine: PalmLineCharacteristics?
    let overallInterpretation: String
    
    init(
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?
    ) {
        self.id = UUID()
        self.date = Date()
        self.heartLine = heartLine
        self.headLine = headLine
        self.lifeLine = lifeLine
        self.fateLine = fateLine
        self.overallInterpretation = PalmInterpretations.generateInterpretation(
            heartLine: heartLine,
            headLine: headLine,
            lifeLine: lifeLine,
            fateLine: fateLine
        )
    }
    
    // Get interpretation for specific line
    func interpretation(for line: PalmLine) -> String {
        let characteristics: PalmLineCharacteristics
        switch line {
        case .heart:
            characteristics = heartLine
        case .head:
            characteristics = headLine
        case .life:
            characteristics = lifeLine
        case .fate:
            guard let fate = fateLine else {
                return "The Fate Line is not prominently visible in your palm, which suggests a life path shaped by personal choices rather than external destiny. You have the freedom to create your own direction."
            }
            characteristics = fate
        }
        
        return PalmInterpretations.lineInterpretation(for: characteristics)
    }
}
