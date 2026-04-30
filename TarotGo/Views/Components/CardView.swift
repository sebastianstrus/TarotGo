//
//  CardView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

/// Unified card view component that handles both front and back card displays
/// Supports flipping, reversing, and consistent styling across the app
struct CardView: View {
    // Card configuration
    let card: TarotCard?
    let showFront: Bool
    let isReversed: Bool
    let isSelected: Bool
    
    // Visual styling - only used for settings preview
    let showGoldShadow: Bool
    let cardBackStyleOverride: CardBackStyle?
    
    @AppStorage("selectedCardBack") private var selectedCardBackRaw: String = CardBackStyle.modern.rawValue
    
    private var selectedCardBack: CardBackStyle {
        cardBackStyleOverride ?? (CardBackStyle(rawValue: selectedCardBackRaw) ?? .modern)
    }
    
    /// Creates a card view
    /// - Parameters:
    ///   - card: The tarot card to display (nil shows card back)
    ///   - showFront: Whether to show the front of the card (default: false)
    ///   - isReversed: Whether the card is reversed (default: false)
    ///   - isSelected: Whether the card is selected (default: false)
    ///   - showGoldShadow: Whether to show gold shadow (only for settings preview, default: false)
    ///   - cardBackStyleOverride: Override the card back style (for settings preview, default: nil)
    init(
        card: TarotCard? = nil,
        showFront: Bool = false,
        isReversed: Bool = false,
        isSelected: Bool = false,
        showGoldShadow: Bool = false,
        cardBackStyleOverride: CardBackStyle? = nil
    ) {
        self.card = card
        self.showFront = showFront
        self.isReversed = isReversed
        self.isSelected = isSelected
        self.showGoldShadow = showGoldShadow
        self.cardBackStyleOverride = cardBackStyleOverride
    }
    
    var body: some View {
        GeometryReader { geometry in
            let cornerRadius = AppTheme.cardCornerRadius(forWidth: geometry.size.width)
            
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                
                if showFront, let card = card {
                    cardFrontContent(card: card, geometry: geometry, cornerRadius: cornerRadius)
                } else {
                    cardBackContent(cornerRadius: cornerRadius)
                }
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            }
            .if(showGoldShadow) { view in
                view.shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
            }
            .rotationEffect(.degrees((showFront && isReversed) ? 180 : 0))
        }
        .aspectRatio(1108.0 / 1900.0, contentMode: .fit)
    }
    
    private var borderColor: Color {
        if showFront {
            return .gray
        } else {
            switch selectedCardBack {
            case .modern, .standard:
                return AppTheme.gold
            case .original, .classic:
                return .gray
            }
        }
    }
    
    @ViewBuilder
    private func cardFrontContent(card: TarotCard, geometry: GeometryProxy, cornerRadius: CGFloat) -> some View {
        if let uiImage = UIImage(named: card.imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
                .cornerRadius(cornerRadius)
        } else {
            // Fallback if image not found
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(AppTheme.cardGradient)
            
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 40))
                    .foregroundStyle(AppTheme.goldGradient)
                Text("Image not found: \(card.id)")
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder
    private func cardBackContent(cornerRadius: CGFloat) -> some View {
        if let uiImage = UIImage(named: selectedCardBack.rawValue) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .cornerRadius(cornerRadius)
        } else {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(AppTheme.cardGradient)
            
            Image(systemName: "moon.stars.fill")
                .font(.system(size: 60))
                .foregroundStyle(AppTheme.goldGradient.opacity(0.3))
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview("Card Back") {
    CardView()
        .frame(width: 200, height: 300)
        .padding()
        .background(Color.black)
}

#Preview("Card Front") {
    CardView(
        card: TarotDeck.majorArcana[0],
        showFront: true
    )
    .frame(width: 200, height: 300)
    .padding()
    .background(Color.black)
}

#Preview("Card Front Reversed") {
    CardView(
        card: TarotDeck.majorArcana[0],
        showFront: true,
        isReversed: true
    )
    .frame(width: 200, height: 300)
    .padding()
    .background(Color.black)
}

#Preview("Card Selected") {
    CardView(
        isSelected: true
    )
    .frame(width: 200, height: 300)
    .padding()
    .background(Color.black)
}
