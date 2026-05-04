//
//  CardBasicMeaningsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct CardBasicMeaningsView: View {
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
                        Text(L10n.basicMeaningsTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.basicMeaningsSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 18) {
                        // Introduction
                        ContentCard {
                            Text(L10n.basicMeaningsIntro)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(AppTheme.textPrimary)
                                .lineSpacing(6)
                        }
                        
                        // Major Arcana
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.basicMeaningsMajorTitle)
                                
                                Text(L10n.basicMeaningsMajorText)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Minor Arcana
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.basicMeaningsMinorTitle)
                                
                                Text(L10n.basicMeaningsMinorText)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                // Suits breakdown
                                VStack(alignment: .leading, spacing: 16) {
                                    SuitCard(
                                        icon: "heart.fill",
                                        title: L10n.basicMeaningsCupsTitle,
                                        subtitle: L10n.basicMeaningsCupsSubtitle
                                    )
                                    
                                    SuitCard(
                                        icon: "dollarsign.circle.fill",
                                        title: L10n.basicMeaningsPentaclesTitle,
                                        subtitle: L10n.basicMeaningsPentaclesSubtitle
                                    )
                                    
                                    SuitCard(
                                        icon: "arrow.up.right",
                                        title: L10n.basicMeaningsSwordsTitle,
                                        subtitle: L10n.basicMeaningsSwordsSubtitle
                                    )
                                    
                                    SuitCard(
                                        icon: "flame.fill",
                                        title: L10n.basicMeaningsWandsTitle,
                                        subtitle: L10n.basicMeaningsWandsSubtitle
                                    )
                                }
                                .padding(.top, 8)
                            }
                        }
                        
                        // Conclusion
                        ContentCard {
                            Text(L10n.basicMeaningsConclusion)
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(AppTheme.textPrimary)
                                .lineSpacing(6)
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

struct SuitCard: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(AppTheme.goldGradient)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(AppTheme.textSecondary)
            }
            
            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.gold.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        CardBasicMeaningsView()
    }
}
