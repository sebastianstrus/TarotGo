//
//  PalmReading.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import Foundation

// Which hand was photographed. Inferred from MediaPipe's handedness
// classifier together with a 3D palm-orientation check.
enum Handedness: String, Codable {
    case left
    case right

    var localizedName: String {
        switch self {
        case .left:
            return NSLocalizedString("palm.handedness.left", comment: "Left Hand")
        case .right:
            return NSLocalizedString("palm.handedness.right", comment: "Right Hand")
        }
    }
}

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

// Palm mounts (raised areas on the palm)
enum PalmMount: String, Codable, CaseIterable {
    case jupiter
    case saturn
    case apollo
    case mercury
    case venus
    case marsUpper
    case marsLower
    case moon
    case neptune
    
    var localizedName: String {
        switch self {
        case .jupiter:
            return NSLocalizedString("palm.mount.jupiter", comment: "Jupiter Mount")
        case .saturn:
            return NSLocalizedString("palm.mount.saturn", comment: "Saturn Mount")
        case .apollo:
            return NSLocalizedString("palm.mount.apollo", comment: "Apollo Mount")
        case .mercury:
            return NSLocalizedString("palm.mount.mercury", comment: "Mercury Mount")
        case .venus:
            return NSLocalizedString("palm.mount.venus", comment: "Venus Mount")
        case .marsUpper:
            return NSLocalizedString("palm.mount.marsUpper", comment: "Upper Mars")
        case .marsLower:
            return NSLocalizedString("palm.mount.marsLower", comment: "Lower Mars")
        case .moon:
            return NSLocalizedString("palm.mount.moon", comment: "Moon Mount")
        case .neptune:
            return NSLocalizedString("palm.mount.neptune", comment: "Neptune Mount")
        }
    }
    
    var interpretation: String {
        switch self {
        case .jupiter:
            return NSLocalizedString("palm.mount.jupiter.desc", comment: "Ambition, leadership, confidence")
        case .saturn:
            return NSLocalizedString("palm.mount.saturn.desc", comment: "Wisdom, responsibility, introspection")
        case .apollo:
            return NSLocalizedString("palm.mount.apollo.desc", comment: "Creativity, artistic talents, success")
        case .mercury:
            return NSLocalizedString("palm.mount.mercury.desc", comment: "Communication, intelligence, business acumen")
        case .venus:
            return NSLocalizedString("palm.mount.venus.desc", comment: "Love, passion, vitality, sensuality")
        case .marsUpper:
            return NSLocalizedString("palm.mount.marsUpper.desc", comment: "Mental courage, resilience, self-control")
        case .marsLower:
            return NSLocalizedString("palm.mount.marsLower.desc", comment: "Physical courage, determination, aggression")
        case .moon:
            return NSLocalizedString("palm.mount.moon.desc", comment: "Imagination, intuition, creativity, emotions")
        case .neptune:
            return NSLocalizedString("palm.mount.neptune.desc", comment: "Spiritual connection, mysticism, transition")
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

// Palm mount characteristics
struct PalmMountCharacteristics: Codable {
    let mount: PalmMount
    let prominence: MountProminence
    
    enum MountProminence: String, Codable {
        case flat
        case normal
        case prominent
        
        var description: String {
            switch self {
            case .flat:
                return NSLocalizedString("palm.mountProminence.flat", comment: "Flat")
            case .normal:
                return NSLocalizedString("palm.mountProminence.normal", comment: "Normal")
            case .prominent:
                return NSLocalizedString("palm.mountProminence.prominent", comment: "Prominent")
            }
        }
    }
}

// Hand shape analysis
struct HandShapeAnalysis: Codable {
    let shapeType: HandShapeType
    let fingerLength: FingerLength
    let palmRatio: PalmRatio
    
    enum HandShapeType: String, Codable {
        case earth     // Square palm, short fingers
        case air       // Square palm, long fingers
        case water     // Rectangular palm, long fingers
        case fire      // Rectangular palm, short fingers
        
        var description: String {
            switch self {
            case .earth:
                return NSLocalizedString("palm.handShape.earth", comment: "Earth Hand")
            case .air:
                return NSLocalizedString("palm.handShape.air", comment: "Air Hand")
            case .water:
                return NSLocalizedString("palm.handShape.water", comment: "Water Hand")
            case .fire:
                return NSLocalizedString("palm.handShape.fire", comment: "Fire Hand")
            }
        }
        
        var interpretation: String {
            switch self {
            case .earth:
                return NSLocalizedString("palm.handShape.earth.desc", comment: "Practical, reliable, grounded")
            case .air:
                return NSLocalizedString("palm.handShape.air.desc", comment: "Intellectual, analytical, communicative")
            case .water:
                return NSLocalizedString("palm.handShape.water.desc", comment: "Emotional, intuitive, sensitive")
            case .fire:
                return NSLocalizedString("palm.handShape.fire.desc", comment: "Energetic, passionate, spontaneous")
            }
        }
    }
    
    enum FingerLength: String, Codable {
        case short
        case average
        case long
        
        var description: String {
            switch self {
            case .short:
                return NSLocalizedString("palm.fingerLength.short", comment: "Short")
            case .average:
                return NSLocalizedString("palm.fingerLength.average", comment: "Average")
            case .long:
                return NSLocalizedString("palm.fingerLength.long", comment: "Long")
            }
        }
    }
    
    enum PalmRatio: String, Codable {
        case square      // Width ≈ Height
        case rectangular // Height > Width
        
        var description: String {
            switch self {
            case .square:
                return NSLocalizedString("palm.palmRatio.square", comment: "Square")
            case .rectangular:
                return NSLocalizedString("palm.palmRatio.rectangular", comment: "Rectangular")
            }
        }
    }
}

// Complete palm reading result
struct PalmReading: Identifiable, Codable {
    let id: UUID
    let date: Date
    
    // Major lines
    let heartLine: PalmLineCharacteristics
    let headLine: PalmLineCharacteristics
    let lifeLine: PalmLineCharacteristics
    let fateLine: PalmLineCharacteristics?
    
    // Mounts
    let mounts: [PalmMountCharacteristics]
    
    // Hand shape
    let handShape: HandShapeAnalysis

    // Which hand the user photographed. Optional for backwards compatibility
    // with readings persisted before handedness detection was added.
    let handedness: Handedness?

    let overallInterpretation: String

    init(
        heartLine: PalmLineCharacteristics,
        headLine: PalmLineCharacteristics,
        lifeLine: PalmLineCharacteristics,
        fateLine: PalmLineCharacteristics?,
        mounts: [PalmMountCharacteristics] = [],
        handShape: HandShapeAnalysis? = nil,
        handedness: Handedness? = nil
    ) {
        self.id = UUID()
        self.date = Date()
        self.heartLine = heartLine
        self.headLine = headLine
        self.lifeLine = lifeLine
        self.fateLine = fateLine
        self.mounts = mounts
        self.handedness = handedness

        // Default hand shape if not provided
        self.handShape = handShape ?? HandShapeAnalysis(
            shapeType: .earth,
            fingerLength: .average,
            palmRatio: .square
        )
        
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
    
    // Get interpretation for specific mount
    func interpretation(for mount: PalmMount) -> String? {
        guard let mountChar = mounts.first(where: { $0.mount == mount }) else {
            return nil
        }
        
        let baseInterpretation = mount.interpretation
        let prominenceNote: String
        
        switch mountChar.prominence {
        case .flat:
            prominenceNote = NSLocalizedString("palm.mount.flat.note", comment: "This area is less developed, suggesting these traits may be less prominent in your personality.")
        case .normal:
            prominenceNote = NSLocalizedString("palm.mount.normal.note", comment: "This mount is well-balanced, indicating healthy expression of these qualities.")
        case .prominent:
            prominenceNote = NSLocalizedString("palm.mount.prominent.note", comment: "This mount is highly developed, suggesting strong emphasis on these characteristics.")
        }
        
        return "\(baseInterpretation) \(prominenceNote)"
    }
}
