//
//  PalmistryAndMindView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/17/26.
//

import SwiftUI

struct PalmistryAndMindView: View {
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
                        Text(L10n.palmistryMindTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.palmistryMindSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 18) {
                        // Section 1: Self-Discovery Tool
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.palmistryMindSection1Title)
                                
                                Text(L10n.palmistryMindSection1Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Section 2: Physical Manifestation
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.palmistryMindSection2Title)
                                
                                Text(L10n.palmistryMindSection2Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                PalmistryInsightBox(text: L10n.palmistryMindSection2Insight)
                            }
                        }
                        
                        // Section 3: Personality Insights
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.palmistryMindSection3Title)
                                
                                Text(L10n.palmistryMindSection3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.palmistryMindSection3Bullet1Title, text: L10n.palmistryMindSection3Bullet1Text)
                                BulletPoint(title: L10n.palmistryMindSection3Bullet2Title, text: L10n.palmistryMindSection3Bullet2Text)
                                BulletPoint(title: L10n.palmistryMindSection3Bullet3Title, text: L10n.palmistryMindSection3Bullet3Text)
                            }
                        }
                        
                        // Section 4: Awareness and Growth
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.palmistryMindSection4Title)
                                
                                Text(L10n.palmistryMindSection4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.palmistryMindSection4Bullet1Title, text: L10n.palmistryMindSection4Bullet1Text)
                                BulletPoint(title: L10n.palmistryMindSection4Bullet2Title, text: L10n.palmistryMindSection4Bullet2Text)
                            }
                        }
                        
                        // Section 5: Connection to Self
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.palmistryMindSection5Title)
                                
                                Text(L10n.palmistryMindSection5Text)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Insight conclusion
                        ContentCard {
                            PalmistryInsightBox(text: L10n.palmistryMindConclusion)
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

struct PalmistryInsightBox: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "hand.raised.fill")
                .font(.system(size: 20))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.palmistryMindInsightLabel)
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
        PalmistryAndMindView()
    }
}
