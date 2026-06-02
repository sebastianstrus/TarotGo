//
//  DestinyMatrixAndMindView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct DestinyMatrixAndMindView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.matrixMindTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.matrixMindSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        // Section 1: Map of Inner Archetypes
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.matrixMindSection1Title)
                                
                                Text(L10n.matrixMindSection1Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Section 2: Working with the Shadow
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.matrixMindSection2Title)
                                
                                Text(L10n.matrixMindSection2Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                MatrixInsightBox(text: L10n.matrixMindSection2Insight)
                            }
                        }
                        
                        // Section 3: Patterns of Behavior
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.matrixMindSection3Title)
                                
                                Text(L10n.matrixMindSection3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.matrixMindSection3Bullet1Title, text: L10n.matrixMindSection3Bullet1Text)
                                BulletPoint(title: L10n.matrixMindSection3Bullet2Title, text: L10n.matrixMindSection3Bullet2Text)
                                BulletPoint(title: L10n.matrixMindSection3Bullet3Title, text: L10n.matrixMindSection3Bullet3Text)
                            }
                        }
                        
                        // Section 4: Mindful Practice
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.matrixMindSection4Title)
                                
                                Text(L10n.matrixMindSection4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.matrixMindSection4Bullet1Title, text: L10n.matrixMindSection4Bullet1Text)
                                BulletPoint(title: L10n.matrixMindSection4Bullet2Title, text: L10n.matrixMindSection4Bullet2Text)
                            }
                        }
                        
                        // Section 5: From Insight to Choice
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.matrixMindSection5Title)
                                
                                Text(L10n.matrixMindSection5Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Conclusion insight
                        ContentCard {
                            MatrixInsightBox(text: L10n.matrixMindConclusion)
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

struct MatrixInsightBox: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "star.circle.fill")
                .font(.system(size: 20))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.matrixMindInsightLabel)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(text)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineSpacing(4)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.gold.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        DestinyMatrixAndMindView()
    }
}
