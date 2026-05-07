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
            interpretation += "Your palm reveals a powerful balance between heart and mind. You possess both emotional depth and intellectual clarity, allowing you to navigate life with wisdom and compassion. "
        } else if emotionalDepth == .deep && mentalClarity == .faint {
            interpretation += "Your heart leads the way in your life's journey. You feel deeply and passionately, though you may benefit from bringing more analytical thinking into your decision-making process. "
        } else if emotionalDepth == .faint && mentalClarity == .deep {
            interpretation += "You approach life through the lens of logic and reason. Your sharp intellect serves you well, though opening yourself to emotional experiences could bring greater fulfillment. "
        } else {
            interpretation += "Your palm shows a gentle, balanced approach to life. You navigate between heart and mind with flexibility, adapting to what each situation requires. "
        }
        
        // Analyze life force and continuity
        if lifeLine.depth == .deep && lifeLine.continuity == .continuous {
            interpretation += "Your Life Line indicates strong vitality and resilience. You have the energy and determination to overcome challenges and pursue your goals with vigor. "
        } else if lifeLine.continuity == .broken {
            interpretation += "The breaks in your Life Line suggest significant transitions or transformative periods in your journey. These are opportunities for renewal and reinvention. "
        }
        
        // Analyze fate line if present
        if let fate = fateLine {
            if fate.depth == .deep {
                interpretation += "A prominent Fate Line indicates that external forces and opportunities play a significant role in your path. You are someone whose life may be shaped by destiny and synchronicity. "
            } else {
                interpretation += "Your subtle Fate Line suggests you have great freedom in crafting your own destiny. You are the architect of your own path. "
            }
        } else {
            interpretation += "The absence of a prominent Fate Line reveals that you are a true free spirit, unbound by predetermined paths. Your life is yours to create. "
        }
        
        // Add holistic summary
        interpretation += "\n\nOverall, your palm tells the story of "
        
        if heartLine.length == .long {
            interpretation += "a compassionate soul who forms deep connections, "
        }
        if headLine.length == .long {
            interpretation += "a thoughtful mind that considers many perspectives, "
        }
        if lifeLine.length == .long {
            interpretation += "and a vibrant life force that will carry you through many years and experiences. "
        }
        
        interpretation += "Remember, your palm is a map of potentials, not fixed destinies. The lines you see today may evolve as you do."
        
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
            interpretation += "**Heart Line - Emotions & Relationships**\n\n"
            
            switch length {
            case .short:
                interpretation += "Your Heart Line is relatively short, suggesting you may be selective in your emotional expressions. You value quality over quantity in relationships and may prefer a small circle of deep connections.\n\n"
            case .medium:
                interpretation += "Your Heart Line shows a balanced approach to emotions. You can connect deeply with others while maintaining healthy boundaries.\n\n"
            case .long:
                interpretation += "Your long Heart Line reveals a generous, loving nature. You have much love to give and form deep, lasting emotional bonds with others.\n\n"
            }
            
            switch depth {
            case .deep:
                interpretation += "The depth of your Heart Line indicates intense emotional experiences. You feel things profoundly and are capable of great passion and empathy."
            case .moderate:
                interpretation += "Your Heart Line's moderate depth suggests emotional stability and resilience. You can feel deeply without being overwhelmed."
            case .faint:
                interpretation += "A subtle Heart Line can indicate a more reserved emotional nature, or someone who expresses feelings through actions rather than words."
            }
            
        case .head:
            interpretation += "**Head Line - Intellect & Mental Approach**\n\n"
            
            switch length {
            case .short:
                interpretation += "Your shorter Head Line suggests you're decisive and direct in your thinking. You focus on practical matters and get to the point quickly.\n\n"
            case .medium:
                interpretation += "Your Head Line indicates balanced mental abilities. You can think both practically and creatively as situations require.\n\n"
            case .long:
                interpretation += "Your long Head Line reveals a complex, analytical mind. You consider many angles and enjoy deep thinking and planning.\n\n"
            }
            
            switch depth {
            case .deep:
                interpretation += "The deep imprint of your Head Line shows strong mental focus and concentration. You have the ability to deeply analyze and solve complex problems."
            case .moderate:
                interpretation += "Your Head Line's clarity suggests reliable mental processes and good judgment. You think things through without overthinking."
            case .faint:
                interpretation += "A lighter Head Line can indicate flexibility in thinking, or someone who trusts intuition as much as logic."
            }
            
        case .life:
            interpretation += "**Life Line - Vitality & Life Path**\n\n"
            
            switch length {
            case .short:
                interpretation += "The length of your Life Line speaks to the intensity rather than duration of your vitality. You live fully in each moment.\n\n"
            case .medium:
                interpretation += "Your Life Line indicates steady, reliable energy throughout your journey. You have the stamina for what life brings.\n\n"
            case .long:
                interpretation += "Your long Life Line suggests robust vitality and endurance. You have the energy and resilience for a full, dynamic life.\n\n"
            }
            
            switch continuity {
            case .continuous:
                interpretation += "The continuous flow of your Life Line indicates a steady life path with smooth transitions. You adapt well to life's changes."
            case .broken:
                interpretation += "Breaks in your Life Line suggest major life changes or transformative periods. These are opportunities for reinvention and growth."
            case .chained:
                interpretation += "A chained pattern in your Life Line can indicate fluctuating energy levels or a path marked by various challenges that ultimately strengthen you."
            }
            
        case .fate:
            interpretation += "**Fate Line - Destiny & External Influences**\n\n"
            
            switch depth {
            case .deep:
                interpretation += "Your prominent Fate Line indicates a life strongly influenced by external forces, opportunities, and synchronicities. Events and people may play significant roles in shaping your path.\n\n"
            case .moderate:
                interpretation += "Your Fate Line suggests a balance between predetermined circumstances and personal choice. You work with what life brings while steering your own course.\n\n"
            case .faint:
                interpretation += "A subtle Fate Line reveals that you have great freedom in creating your destiny. You are less bound by external circumstances and more empowered to forge your own path.\n\n"
            }
            
            interpretation += "The Fate Line reminds us that while certain opportunities and challenges come our way, how we respond to them is always within our control."
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
            return "\(depth) and \(length.lowercased()) - reflects your emotional depth and capacity for connection"
        case .head:
            return "\(depth) and \(length.lowercased()) - indicates your mental approach and decision-making style"
        case .life:
            return "\(depth) and \(continuity.lowercased()) - represents your vitality and life journey"
        case .fate:
            return "\(depth) - shows the role of destiny and external influences in your path"
        }
    }
}
