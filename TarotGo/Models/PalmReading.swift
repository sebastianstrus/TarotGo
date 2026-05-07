//
//  PalmReading.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation

// Major palm lines analyzed in palmistry
enum PalmLine: String, Codable {
    case heart
    case head
    case life
    case fate
    
    var localizedName: String {
        switch self {
        case .heart:
            return NSLocalizedString("palm.line.heart", comment: "Heart Line")
        case .head:
            return NSLocalizedString("palm.line.head", comment: "Head Line")
        case .life:
            return NSLocalizedString("palm.line.life", comment: "Life Line")
        case .fate:
            return NSLocalizedString("palm.line.fate", comment: "Fate Line")
        }
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
            case .short:
                return NSLocalizedString("palm.lineLength.short", comment: "Short")
            case .medium:
                return NSLocalizedString("palm.lineLength.medium", comment: "Medium")
            case .long:
                return NSLocalizedString("palm.lineLength.long", comment: "Long")
            }
        }
    }
    
    enum LineDepth: String, Codable {
        case faint
        case moderate
        case deep
        
        var description: String {
            switch self {
            case .faint:
                return NSLocalizedString("palm.lineDepth.faint", comment: "Faint")
            case .moderate:
                return NSLocalizedString("palm.lineDepth.moderate", comment: "Moderate")
            case .deep:
                return NSLocalizedString("palm.lineDepth.deep", comment: "Deep")
            }
        }
    }
    
    enum LineContinuity: String, Codable {
        case continuous
        case broken
        case chained
        
        var description: String {
            switch self {
            case .continuous:
                return NSLocalizedString("palm.lineContinuity.continuous", comment: "Continuous")
            case .broken:
                return NSLocalizedString("palm.lineContinuity.broken", comment: "Broken")
            case .chained:
                return NSLocalizedString("palm.lineContinuity.chained", comment: "Chained")
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
                return NSLocalizedString("palm.fateLine.notVisible", comment: "The Fate Line is not prominently visible in your palm, which suggests a life path shaped by personal choices rather than external destiny. You have the freedom to create your own direction.")
            }
            characteristics = fate
        }
        
        return PalmInterpretations.lineInterpretation(for: characteristics)
    }
}
