//
//  HapticService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import UIKit

enum HapticStyle {
    case light
    case medium
    case heavy
    case soft
    case rigid
    case success
    case warning
    case error
    case selection
}

class HapticService {
    static let shared = HapticService()
    
    private init() {}
    
    func impact(_ style: HapticStyle) {
        switch style {
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .soft:
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred()
        case .rigid:
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    func pulse(count: Int = 3, interval: TimeInterval = 0.1) {
        for i in 0..<count {
            DispatchQueue.main.asyncAfter(deadline: .now() + (interval * Double(i))) {
                self.impact(.light)
            }
        }
    }
    
    func customPattern(pattern: [HapticStyle], interval: TimeInterval = 0.15) {
        for (index, style) in pattern.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (interval * Double(index))) {
                self.impact(style)
            }
        }
    }
}
