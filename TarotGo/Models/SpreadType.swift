//
//  SpreadType.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

enum SpreadType: String, Codable {
    case threeCard = "Three Card"
    case celticCross = "Celtic Cross"
    case loveTriangle = "Love Triangle"
    case careerPath = "Career Path"
    
    var positions: [SpreadPosition] {
        switch self {
        case .threeCard:
            return [
                SpreadPosition(id: "past", name: "Past", description: "What brought you here"),
                SpreadPosition(id: "present", name: "Present", description: "Your current situation"),
                SpreadPosition(id: "future", name: "Future", description: "What's coming")
            ]
        case .celticCross:
            return [
                SpreadPosition(id: "present", name: "Present", description: "Your current situation"),
                SpreadPosition(id: "challenge", name: "Challenge", description: "What crosses you"),
                SpreadPosition(id: "past", name: "Past", description: "Foundation of the situation"),
                SpreadPosition(id: "future", name: "Future", description: "What's approaching"),
                SpreadPosition(id: "above", name: "Above", description: "Your goal or aspiration"),
                SpreadPosition(id: "below", name: "Below", description: "Unconscious influences"),
                SpreadPosition(id: "advice", name: "Advice", description: "Your best approach"),
                SpreadPosition(id: "external", name: "External", description: "Outside influences"),
                SpreadPosition(id: "hopes", name: "Hopes & Fears", description: "Your inner emotions"),
                SpreadPosition(id: "outcome", name: "Outcome", description: "Final result")
            ]
        case .loveTriangle:
            return [
                SpreadPosition(id: "you", name: "You", description: "Your emotional state"),
                SpreadPosition(id: "them", name: "Them", description: "Their emotional state"),
                SpreadPosition(id: "connection", name: "Connection", description: "The relationship dynamic")
            ]
        case .careerPath:
            return [
                SpreadPosition(id: "current", name: "Current Situation", description: "Where you are now"),
                SpreadPosition(id: "obstacles", name: "Obstacles", description: "What's blocking you"),
                SpreadPosition(id: "strengths", name: "Strengths", description: "Your assets"),
                SpreadPosition(id: "action", name: "Action", description: "What to do next"),
                SpreadPosition(id: "outcome", name: "Outcome", description: "Potential result")
            ]
        }
    }
}

struct SpreadPosition: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
}
