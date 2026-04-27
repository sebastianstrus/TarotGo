//
//  CardDetailView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct CardDetailView: View {
    let card: TarotCard
    @State private var showReversed: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Card image
                    cardImageView
                        .padding(.top, 20)
                    
                    // Card name and suit
                    cardHeaderView
                    
                    // Upright/Reversed toggle
                    orientationToggle
                    
                    // Keywords
                    keywordsSection
                    
                    // Interpretations
                    interpretationsSection
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var cardImageView: some View {
        ZStack {
            // White background
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
            
            if let uiImage = UIImage(named: card.imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .cornerRadius(12)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.cardGradient)
                
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 80))
                    .foregroundStyle(AppTheme.goldGradient.opacity(0.3))
            }
            
            // Gold border
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    LinearGradient(
                        colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
        }
        .aspectRatio(1108/1900, contentMode: .fit)
        .frame(maxWidth: 280)
        .shadow(color: AppTheme.gold.opacity(0.4), radius: 20)
        .rotationEffect(.degrees(showReversed ? 180 : 0))
        .animation(.spring(response: 0.6, dampingFraction: 0.7), value: showReversed)
    }
    
    private var cardHeaderView: some View {
        VStack(spacing: 12) {
            Text(card.localizedName)
                .font(AppTheme.serifFont(size: 32, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
                .multilineTextAlignment(.center)
                .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            
            HStack(spacing: 10) {
                Text(card.suit.localizedName)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.gold.opacity(0.9))
                
                if let number = card.arcanaNumber {
                    Text("•")
                        .foregroundColor(AppTheme.gold.opacity(0.5))
                    Text(String(romanNumeral: number))
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.9))
                }
            }
        }
    }
    
    private var orientationToggle: some View {
        HStack(spacing: 0) {
            // Upright
            Button {
                withAnimation {
                    showReversed = false
                }
            } label: {
                Text(L10n.dictionaryUpright)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(showReversed ? AppTheme.gold.opacity(0.7) : AppTheme.darkNavy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Group {
                            if showReversed {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.clear)
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(AppTheme.goldGradient)
                            }
                        }
                    )
            }
            
            // Reversed
            Button {
                withAnimation {
                    showReversed = true
                }
            } label: {
                Text(L10n.dictionaryReversed)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(showReversed ? AppTheme.darkNavy : AppTheme.gold.opacity(0.7))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Group {
                            if showReversed {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(AppTheme.goldGradient)
                            } else {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.clear)
                            }
                        }
                    )
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private var keywordsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(L10n.dictionaryKeywords)
                .font(AppTheme.serifFont(size: 22, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            let keywords = showReversed ? card.localizedReversedKeywords : card.localizedKeywords
            FlowLayout(spacing: 8) {
                ForEach(keywords, id: \.self) { keyword in
                    Text(keyword)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textPrimary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(AppTheme.darkNavy.opacity(0.5))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                                )
                        )
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private var interpretationsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(L10n.dictionaryMeanings)
                .font(AppTheme.serifFont(size: 22, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            // General meaning
            InterpretationCard(
                title: L10n.dictionaryGeneral,
                icon: "sparkles",
                text: card.interpretation(for: .general, reversed: showReversed)
            )
            
            // Love meaning
            InterpretationCard(
                title: L10n.categoryLove,
                icon: "heart.fill",
                text: card.interpretation(for: .love, reversed: showReversed)
            )
            
            // Career meaning
            InterpretationCard(
                title: L10n.categoryCareer,
                icon: "briefcase.fill",
                text: card.interpretation(for: .career, reversed: showReversed)
            )
            
            // Finance meaning
            InterpretationCard(
                title: L10n.categoryFinance,
                icon: "dollarsign.circle.fill",
                text: card.interpretation(for: .finance, reversed: showReversed)
            )
            
            // Health meaning
            InterpretationCard(
                title: L10n.categoryHealth,
                icon: "cross.fill",
                text: card.interpretation(for: .health, reversed: showReversed)
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct InterpretationCard: View {
    let title: String
    let icon: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(AppTheme.gold)
                
                Text(title)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
            }
            
            Text(text)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(AppTheme.textPrimary)
                .lineSpacing(6)
        }
        .padding(15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppTheme.darkNavy.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

// FlowLayout for keywords that wrap
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var frames: [CGRect] = []
        var size: CGSize = .zero
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += lineHeight + spacing
                    lineHeight = 0
                }
                
                frames.append(CGRect(x: x, y: y, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                x += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: y + lineHeight)
        }
    }
}

#Preview {
    NavigationStack {
        CardDetailView(card: TarotDeck.allCards[0])
    }
}
