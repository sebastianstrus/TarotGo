//
//  CardDictionaryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct CardDictionaryView: View {
    @State private var selectedSuit: TarotSuit? = nil
    @State private var searchText: String = ""
    @State private var showARGallery: Bool = false
    
    private var filteredCards: [TarotCard] {
        var cards = TarotDeck.allCards
        
        // Filter by suit if selected
        if let suit = selectedSuit {
            cards = cards.filter { $0.suit == suit }
        }
        
        // Filter by search text
        if !searchText.isEmpty {
            cards = cards.filter { card in
                card.name.localizedCaseInsensitiveContains(searchText) ||
                card.localizedKeywords.joined(separator: " ").localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return cards
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 0) {
                // Header
                headerView
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                // Suit filter
                suitFilterView
                    .padding(.vertical, 15)
                
                // Cards list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredCards) { card in
                            NavigationLink(destination: CardDetailView(card: card)) {
                                CardDictionaryRow(card: card)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, prompt: L10n.dictionarySearchPlaceholder)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showARGallery = true
                } label: {
                    Image(systemName: "cube.transparent")
                        .font(.system(size: 20))
                        .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
        .fullScreenCover(isPresented: $showARGallery) {
            ARGalleryView()
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            Image(systemName: "books.vertical.fill")
                .font(.system(size: 40))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
            
            Text(L10n.dictionaryTitle)
                .font(AppTheme.serifFont(size: 28, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            
            Text(L10n.dictionarySubtitle)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }
    
    private var suitFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // All cards button
                FilterChip(
                    title: L10n.dictionaryAllCards,
                    icon: "square.grid.2x2",
                    isSelected: selectedSuit == nil
                ) {
                    withAnimation {
                        selectedSuit = nil
                    }
                }
                
                // Major Arcana
                FilterChip(
                    title: TarotSuit.majorArcana.localizedName,
                    icon: "sparkles",
                    isSelected: selectedSuit == .majorArcana
                ) {
                    withAnimation {
                        selectedSuit = .majorArcana
                    }
                }
                
                // Cups
                FilterChip(
                    title: TarotSuit.cups.localizedName,
                    icon: "cup.and.saucer",
                    isSelected: selectedSuit == .cups
                ) {
                    withAnimation {
                        selectedSuit = .cups
                    }
                }
                
                // Pentacles
                FilterChip(
                    title: TarotSuit.pentacles.localizedName,
                    icon: "circle.hexagongrid",
                    isSelected: selectedSuit == .pentacles
                ) {
                    withAnimation {
                        selectedSuit = .pentacles
                    }
                }
                
                // Swords
                FilterChip(
                    title: TarotSuit.swords.localizedName,
                    icon: "flame",
                    isSelected: selectedSuit == .swords
                ) {
                    withAnimation {
                        selectedSuit = .swords
                    }
                }
                
                // Wands
                FilterChip(
                    title: TarotSuit.wands.localizedName,
                    icon: "wand.and.stars",
                    isSelected: selectedSuit == .wands
                ) {
                    withAnimation {
                        selectedSuit = .wands
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                Text(title)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Group {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.goldGradient)
                    } else {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.clear)
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isSelected ? Color.clear : AppTheme.gold.opacity(0.5),
                        lineWidth: 1
                    )
            )
            .foregroundColor(isSelected ? AppTheme.darkNavy : AppTheme.gold)
        }
    }
}

struct CardDictionaryRow: View {
    let card: TarotCard
    
    var body: some View {
        HStack(spacing: 15) {
            // Card image thumbnail
            CardView(card: card, showFront: true)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 6) {
                // Card name
                Text(card.localizedName)
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                // Suit and number
                HStack(spacing: 8) {
                    Text(card.suit.localizedName)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                    
                    if let number = card.arcanaNumber {
                        Text("•")
                            .foregroundColor(AppTheme.textSecondary.opacity(0.5))
                        Text(String(romanNumeral: number))
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                
                // Keywords preview
                Text(card.localizedKeywords.prefix(3).joined(separator: " • "))
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(AppTheme.gold.opacity(0.7))
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(AppTheme.gold.opacity(0.5))
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// Extension to convert numbers to Roman numerals
extension String {
    init(romanNumeral number: Int) {
        let romanValues = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        var result = ""
        var num = number
        
        for (value, numeral) in romanValues {
            while num >= value {
                result += numeral
                num -= value
            }
        }
        
        self = result
    }
}

#Preview {
    NavigationStack {
        CardDictionaryView()
    }
}
