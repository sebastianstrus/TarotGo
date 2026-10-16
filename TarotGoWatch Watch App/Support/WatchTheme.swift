//
//  WatchTheme.swift
//  TarotGoWatch Watch App
//
//  Brand colors matching the iOS `AppTheme`.
//

import SwiftUI

enum WatchTheme {
    static let gold = Color(red: 212/255, green: 175/255, blue: 55/255)
    static let lightGold = Color(red: 255/255, green: 215/255, blue: 0/255)
    static let darkGold = Color(red: 184/255, green: 134/255, blue: 11/255)

    static let deepNavy = Color(red: 10/255, green: 10/255, blue: 25/255)
    static let darkNavy = Color(red: 15/255, green: 15/255, blue: 35/255)

    static let goldGradient = LinearGradient(
        colors: [lightGold, gold, darkGold],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let backgroundGradient = LinearGradient(
        colors: [deepNavy, darkNavy, .black],
        startPoint: .top,
        endPoint: .bottom
    )

    static func serif(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        .system(style, design: .serif, weight: weight)
    }
}
