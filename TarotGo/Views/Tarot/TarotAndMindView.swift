//
//  TarotAndMindView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct TarotAndMindView: View {
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
                        Text(L10n.tarotMindTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.tarotMindSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 18) {
                        // Section 1: Mirror for Self-Reflection
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.tarotMindSection1Title)
                                
                                Text(L10n.tarotMindSection1Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Section 2: Universal Archetypes
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.tarotMindSection2Title)
                                
                                Text(L10n.tarotMindSection2Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                InsightBox(text: L10n.tarotMindSection2Insight)
                            }
                        }
                        
                        // Section 3: Understanding Thoughts
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.tarotMindSection3Title)
                                
                                Text(L10n.tarotMindSection3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.tarotMindSection3Bullet1Title, text: L10n.tarotMindSection3Bullet1Text)
                                BulletPoint(title: L10n.tarotMindSection3Bullet2Title, text: L10n.tarotMindSection3Bullet2Text)
                            }
                        }
                        
                        // Section 4: Mindfulness Practice
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.tarotMindSection4Title)
                                
                                Text(L10n.tarotMindSection4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.tarotMindSection4Bullet1Title, text: L10n.tarotMindSection4Bullet1Text)
                                BulletPoint(title: L10n.tarotMindSection4Bullet2Title, text: L10n.tarotMindSection4Bullet2Text)
                            }
                        }
                        
                        // Insight conclusion
                        ContentCard {
                            InsightBox(text: L10n.tarotMindConclusion)
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

struct InsightBox: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 20))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.tarotMindInsightLabel)
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
        TarotAndMindView()
    }
}
