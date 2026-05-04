//
//  HistoryOfTarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct HistoryOfTarotView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Top spacing
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.historyTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.historySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 24) {
                        // Introduction
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(L10n.historyIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Section 1: Evolution of Playing Cards
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyEvolutionTitle)
                                
                                Text(L10n.historyEvolutionIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyMamlukTitle, text: L10n.historyMamlukText)
                                BulletPoint(title: L10n.historySpreadTitle, text: L10n.historySpreadText)
                                BulletPoint(title: L10n.historySuitsTitle, text: L10n.historySuitsText)
                            }
                        }
                        
                        // Section 2: Birth of Tarocchi
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyBirthTitle)
                                
                                Text(L10n.historyBirthIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                SubsectionTitle(text: L10n.historyTrumpsTitle)
                                
                                Text(L10n.historyTrumpsIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyViscontiTitle, text: L10n.historyViscontiText)
                                BulletPoint(title: L10n.historyClassicalTitle, text: L10n.historyClassicalText)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Supporting components
struct ContentCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            content
        }
        .padding(20)
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

struct SectionTitle: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "star.fill")
                .font(.system(size: 10))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(text)
                .font(AppTheme.serifFont(size: 22, weight: .semibold))
                .foregroundStyle(AppTheme.goldGradient)
        }
        .padding(.bottom, 4)
    }
}

struct SubsectionTitle: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(AppTheme.serifFont(size: 18, weight: .medium))
            .foregroundColor(AppTheme.textPrimary)
            .padding(.top, 6)
    }
}

struct BulletPoint: View {
    let title: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(AppTheme.gold)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(text)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HistoryOfTarotView()
    }
}
