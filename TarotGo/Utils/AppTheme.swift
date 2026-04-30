//
//  AppTheme.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

// Card back design options
enum CardBackStyle: String, CaseIterable, Identifiable {
    case modern = "ReversCard1"
    case original = "ReversCard2"
    case standard = "ReversCard3"
    case classic = "ReversCard4"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .modern:
            return L10n.settingsCardBackModern
        case .original:
            return L10n.settingsCardBackOriginal
        case .standard:
            return L10n.settingsCardBackStandard
        case .classic:
            return L10n.settingsCardBackClassic
        }
    }
    
    var subtitle: String {
        switch self {
        case .modern:
            return L10n.settingsCardBackModernSubtitle
        case .original:
            return L10n.settingsCardBackOriginalSubtitle
        case .standard:
            return L10n.settingsCardBackStandardSubtitle
        case .classic:
            return L10n.settingsCardBackClassicSubtitle
        }
    }
}

struct AppTheme {
    // Gold colors matching the app icon
    static let gold = Color(red: 212/255, green: 175/255, blue: 55/255) // #D4AF37
    static let lightGold = Color(red: 255/255, green: 215/255, blue: 0/255) // #FFD700
    static let darkGold = Color(red: 184/255, green: 134/255, blue: 11/255) // #B8860B
    
    // Background colors
    static let deepNavy = Color(red: 10/255, green: 10/255, blue: 25/255)
    static let darkNavy = Color(red: 15/255, green: 15/255, blue: 35/255)
    static let midNavy = Color(red: 20/255, green: 20/255, blue: 45/255)
    
    // Accent colors
    static let mysticalPurple = Color(red: 138/255, green: 43/255, blue: 226/255)
    static let deepPurple = Color(red: 75/255, green: 0/255, blue: 130/255)
    
    // Gradients
    static let goldGradient = LinearGradient(
        colors: [lightGold, gold, darkGold],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let backgroundGradient = LinearGradient(
        colors: [deepNavy, darkNavy, Color.black],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let cardGradient = LinearGradient(
        colors: [midNavy.opacity(0.6), deepNavy.opacity(0.8)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Text colors
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.85)
    static let textTertiary = Color.white.opacity(0.6)
    
    // Fonts matching app icon
    static func serifFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }
    
    // Tarot card styling
    static let cardAspectRatio: CGFloat = 1108.0 / 1900.0
    
    /// Calculate corner radius for tarot cards based on their width
    /// Uses a ratio of ~0.06 (6% of width) for consistent rounded corners
    static func cardCornerRadius(forWidth width: CGFloat) -> CGFloat {
        return width * 0.06
    }
}

// Custom view modifiers for consistent styling
struct GoldBorderStyle: ViewModifier {
    let cornerRadius: CGFloat
    let lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(AppTheme.goldGradient, lineWidth: lineWidth)
            )
    }
}

struct ElegantCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.cardGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
            )
    }
}

extension View {
    func goldBorder(cornerRadius: CGFloat = 15, lineWidth: CGFloat = 2) -> some View {
        modifier(GoldBorderStyle(cornerRadius: cornerRadius, lineWidth: lineWidth))
    }
    
    func elegantCard() -> some View {
        modifier(ElegantCardStyle())
    }
}
