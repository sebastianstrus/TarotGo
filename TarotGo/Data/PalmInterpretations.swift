//
//  PalmInterpretations.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation

nonisolated struct PalmInterpretations {
    
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
    
    // MARK: - Hand Shape Interpretations
    
    static func handShapeInterpretation(for analysis: HandShapeAnalysis) -> String {
        var interpretation = ""
        
        // Main hand shape interpretation
        switch analysis.shapeType {
        case .earth:
            interpretation += NSLocalizedString("palm.handShape.earth.full", 
                comment: "Your Earth hand reveals a grounded, practical nature. You approach life with common sense and reliability, preferring tangible results over abstract theories. You're dependable, patient, and excel at bringing ideas into physical reality.")
        case .air:
            interpretation += NSLocalizedString("palm.handShape.air.full", 
                comment: "Your Air hand reflects an intellectual and communicative spirit. You thrive on mental stimulation, ideas, and social connections. You're naturally curious, analytical, and excel at processing and sharing information.")
        case .water:
            interpretation += NSLocalizedString("palm.handShape.water.full", 
                comment: "Your Water hand indicates deep emotional sensitivity and intuition. You experience life through feelings and are naturally empathetic. You're creative, compassionate, and drawn to artistic or healing pursuits.")
        case .fire:
            interpretation += NSLocalizedString("palm.handShape.fire.full", 
                comment: "Your Fire hand reveals an energetic, passionate nature. You're action-oriented, spontaneous, and driven by enthusiasm. You thrive on challenges, adventure, and making things happen quickly.")
        }
        
        interpretation += " "
        
        // Add finger length insight
        switch analysis.fingerLength {
        case .short:
            interpretation += NSLocalizedString("palm.fingerLength.short.desc", 
                comment: "Your relatively short fingers suggest you prefer getting straight to the point and taking action rather than overanalyzing.")
        case .average:
            interpretation += NSLocalizedString("palm.fingerLength.average.desc", 
                comment: "Your balanced finger length indicates a harmonious approach between thinking and doing.")
        case .long:
            interpretation += NSLocalizedString("palm.fingerLength.long.desc", 
                comment: "Your long fingers suggest you enjoy details, research, and taking time to thoroughly think things through before acting.")
        }
        
        return interpretation
    }
    
    // MARK: - Mount Interpretations
    
    static func mountInterpretation(for mount: PalmMountCharacteristics) -> String {
        let baseInterpretation: String
        
        switch mount.mount {
        case .jupiter:
            baseInterpretation = NSLocalizedString("palm.mount.jupiter.full", 
                comment: "The Jupiter Mount relates to your ambition, leadership qualities, and sense of confidence. It reflects your desire for success, recognition, and personal growth.")
        case .saturn:
            baseInterpretation = NSLocalizedString("palm.mount.saturn.full", 
                comment: "The Saturn Mount governs wisdom, discipline, and responsibility. It reveals your approach to serious matters, introspection, and long-term thinking.")
        case .apollo:
            baseInterpretation = NSLocalizedString("palm.mount.apollo.full", 
                comment: "The Apollo Mount (Sun) represents creativity, artistic talents, and success. It shows your relationship with beauty, self-expression, and recognition.")
        case .mercury:
            baseInterpretation = NSLocalizedString("palm.mount.mercury.full", 
                comment: "The Mercury Mount relates to communication, intelligence, and business acumen. It reflects your verbal skills, quick thinking, and commercial abilities.")
        case .venus:
            baseInterpretation = NSLocalizedString("palm.mount.venus.full", 
                comment: "The Venus Mount governs love, passion, and vitality. It reveals your capacity for affection, sensuality, and appreciation of life's pleasures.")
        case .marsUpper:
            baseInterpretation = NSLocalizedString("palm.mount.marsUpper.full", 
                comment: "The Upper Mars Mount represents mental courage and self-control. It shows your resilience in facing challenges and maintaining composure under pressure.")
        case .marsLower:
            baseInterpretation = NSLocalizedString("palm.mount.marsLower.full", 
                comment: "The Lower Mars Mount reflects physical courage and determination. It reveals your fighting spirit, assertiveness, and ability to take action.")
        case .moon:
            baseInterpretation = NSLocalizedString("palm.mount.moon.full", 
                comment: "The Moon Mount governs imagination, intuition, and emotional depth. It reflects your subconscious mind, creativity, and connection to the mystical.")
        case .neptune:
            baseInterpretation = NSLocalizedString("palm.mount.neptune.full", 
                comment: "The Neptune Mount represents spiritual connection and transition. It shows your link between the physical and spiritual realms, and your ability to transform.")
        }
        
        let prominenceNote: String
        switch mount.prominence {
        case .flat:
            prominenceNote = " " + NSLocalizedString("palm.mount.prominence.flat", 
                comment: "This mount is less developed, suggesting these qualities may be less emphasized in your personality or may manifest more subtly.")
        case .normal:
            prominenceNote = " " + NSLocalizedString("palm.mount.prominence.normal", 
                comment: "This mount is well-balanced, indicating a healthy and harmonious expression of these qualities in your life.")
        case .prominent:
            prominenceNote = " " + NSLocalizedString("palm.mount.prominence.prominent", 
                comment: "This mount is highly developed, suggesting these characteristics play a significant and powerful role in your personality and life path.")
        }
        
        return baseInterpretation + prominenceNote
    }
    
    static func mountQuickSummary(for mount: PalmMountCharacteristics) -> String {
        let prominence = mount.prominence.description
        return "\(prominence) - \(mount.mount.interpretation)"
    }
}
