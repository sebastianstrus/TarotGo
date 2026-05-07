//
//  PalmInterpretations.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation

struct PalmInterpretations {
    
    // Generate overall reading interpretation
    static func generateInterpretation(
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?
    ) -> String {
        var interpretation = ""
        
        // Analyze emotional-mental balance
        let emotionalDepth = heartLine.depth
        let mentalClarity = headLine.depth
        
        if emotionalDepth == .deep && mentalClarity == .deep {
            interpretation += L10n.palmInterpretationBalanceDeepBoth
        } else if emotionalDepth == .deep && mentalClarity == .faint {
            interpretation += L10n.palmInterpretationBalanceDeepHeartFaintHead
        } else if emotionalDepth == .faint && mentalClarity == .deep {
            interpretation += L10n.palmInterpretationBalanceFaintHeartDeepHead
        } else {
            interpretation += L10n.palmInterpretationBalanceGentle
        }
        
        // Analyze life force and continuity
        if lifeLine.depth == .deep && lifeLine.continuity == .continuous {
            interpretation += L10n.palmInterpretationLifeDeepContinuous
        } else if lifeLine.continuity == .broken {
            interpretation += L10n.palmInterpretationLifeBroken
        }
        
        // Analyze fate line if present
        if let fate = fateLine {
            if fate.depth == .deep {
                interpretation += L10n.palmInterpretationFateDeep
            } else {
                interpretation += L10n.palmInterpretationFateSubtle
            }
        } else {
            interpretation += L10n.palmInterpretationFateAbsent
        }
        
        // Add holistic summary
        interpretation += L10n.palmInterpretationSummaryIntro
        
        var summaryParts: [String] = []
        
        if heartLine.length == .long {
            summaryParts.append(L10n.palmInterpretationSummaryHeartLong)
        }
        if headLine.length == .long {
            summaryParts.append(L10n.palmInterpretationSummaryHeadLong)
        }
        if lifeLine.length == .long {
            summaryParts.append(L10n.palmInterpretationSummaryLifeLong)
        }
        
        if !summaryParts.isEmpty {
            interpretation += summaryParts.joined(separator: " ")
        }
        
        interpretation += L10n.palmInterpretationClosing
        
        return interpretation
    }
    
    // Get interpretation for individual line
    static func lineInterpretation(for characteristics: PalmLineCharacteristics) -> String {
        let line = characteristics.line
        let length = characteristics.length
        let depth = characteristics.depth
        let continuity = characteristics.continuity
        
        var interpretation = ""
        
        switch line {
        case .heart:
            interpretation += L10n.palmLineHeartTitle
            
            switch length {
            case .short:
                interpretation += L10n.palmLineHeartLengthShort
            case .medium:
                interpretation += L10n.palmLineHeartLengthMedium
            case .long:
                interpretation += L10n.palmLineHeartLengthLong
            }
            
            switch depth {
            case .deep:
                interpretation += L10n.palmLineHeartDepthDeep
            case .moderate:
                interpretation += L10n.palmLineHeartDepthModerate
            case .faint:
                interpretation += L10n.palmLineHeartDepthFaint
            }
            
        case .head:
            interpretation += L10n.palmLineHeadTitle
            
            switch length {
            case .short:
                interpretation += L10n.palmLineHeadLengthShort
            case .medium:
                interpretation += L10n.palmLineHeadLengthMedium
            case .long:
                interpretation += L10n.palmLineHeadLengthLong
            }
            
            switch depth {
            case .deep:
                interpretation += L10n.palmLineHeadDepthDeep
            case .moderate:
                interpretation += L10n.palmLineHeadDepthModerate
            case .faint:
                interpretation += L10n.palmLineHeadDepthFaint
            }
            
        case .life:
            interpretation += L10n.palmLineLifeTitle
            
            switch length {
            case .short:
                interpretation += L10n.palmLineLifeLengthShort
            case .medium:
                interpretation += L10n.palmLineLifeLengthMedium
            case .long:
                interpretation += L10n.palmLineLifeLengthLong
            }
            
            switch continuity {
            case .continuous:
                interpretation += L10n.palmLineLifeContinuityContinuous
            case .broken:
                interpretation += L10n.palmLineLifeContinuityBroken
            case .chained:
                interpretation += L10n.palmLineLifeContinuityChained
            }
            
        case .fate:
            interpretation += L10n.palmLineFateTitle
            
            switch depth {
            case .deep:
                interpretation += L10n.palmLineFateDepthDeep
            case .moderate:
                interpretation += L10n.palmLineFateDepthModerate
            case .faint:
                interpretation += L10n.palmLineFateDepthFaint
            }
            
            interpretation += L10n.palmLineFateClosing
        }
        
        return interpretation
    }
    
    // Get quick summary for a line
    static func quickSummary(for characteristics: PalmLineCharacteristics) -> String {
        let line = characteristics.line
        let length = characteristics.length.description
        let depth = characteristics.depth.description
        let continuity = characteristics.continuity.description
        
        switch line {
        case .heart:
            return L10n.palmQuickSummaryHeart(depth, length.lowercased())
        case .head:
            return L10n.palmQuickSummaryHead(depth, length.lowercased())
        case .life:
            return L10n.palmQuickSummaryLife(depth, continuity.lowercased())
        case .fate:
            return L10n.palmQuickSummaryFate(depth)
        }
    }
}
