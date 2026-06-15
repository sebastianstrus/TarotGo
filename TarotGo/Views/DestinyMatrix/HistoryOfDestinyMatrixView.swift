//
//  HistoryOfDestinyMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct HistoryOfDestinyMatrixView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.historyOfMatrixTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.historyOfMatrixSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        // Introduction
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(L10n.historyOfMatrixIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Ancient Roots
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfMatrixRootsTitle)
                                
                                Text(L10n.historyOfMatrixRootsIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyOfMatrixNumerologyTitle, text: L10n.historyOfMatrixNumerologyText)
                                BulletPoint(title: L10n.historyOfMatrixTarotTitle, text: L10n.historyOfMatrixTarotText)
                                BulletPoint(title: L10n.historyOfMatrixChakraTitle, text: L10n.historyOfMatrixChakraText)
                            }
                        }
                        
                        // Modern Formulation
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfMatrixModernTitle)
                                
                                Text(L10n.historyOfMatrixModernIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyOfMatrixLadiniTitle, text: L10n.historyOfMatrixLadiniText)
                                BulletPoint(title: L10n.historyOfMatrixGlobalTitle, text: L10n.historyOfMatrixGlobalText)
                            }
                        }
                        
                        // Timeline
                        ContentCard {
                            VStack(alignment: .leading, spacing: 16) {
                                SectionTitle(text: L10n.historyOfMatrixTimelineTitle)
                                
                                DestinyMatrixTimelineTable()
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

struct DestinyMatrixTimelineTable: View {
    let timelineData: [(era: String, milestone: String)] = [
        (L10n.historyOfMatrixTimelineEra1, L10n.historyOfMatrixTimelineMilestone1),
        (L10n.historyOfMatrixTimelineEra2, L10n.historyOfMatrixTimelineMilestone2),
        (L10n.historyOfMatrixTimelineEra3, L10n.historyOfMatrixTimelineMilestone3),
        (L10n.historyOfMatrixTimelineEra4, L10n.historyOfMatrixTimelineMilestone4),
        (L10n.historyOfMatrixTimelineEra5, L10n.historyOfMatrixTimelineMilestone5)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Table Header
            HStack(spacing: 0) {
                Text(L10n.historyOfMatrixTimelineEraHeader)
                    .font(AppTheme.serifFont(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                    .frame(width: 110, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                
                Rectangle()
                    .fill(AppTheme.gold.opacity(0.3))
                    .frame(width: 1)
                
                Text(L10n.historyOfMatrixTimelineMilestoneHeader)
                    .font(AppTheme.serifFont(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
            }
            .background(AppTheme.gold.opacity(0.1))
            
            Rectangle()
                .fill(AppTheme.gold.opacity(0.3))
                .frame(height: 1)
            
            // Table Rows
            ForEach(Array(timelineData.enumerated()), id: \.offset) { index, item in
                HStack(alignment: .top, spacing: 0) {
                    Text(item.era)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                        .frame(width: 110, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                    
                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.2))
                        .frame(width: 1)
                    
                    Text(item.milestone)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .lineSpacing(4)
                }
                .background(index % 2 == 0 ? Color.clear : AppTheme.gold.opacity(0.05))
                
                if index < timelineData.count - 1 {
                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.15))
                        .frame(height: 1)
                }
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    NavigationStack {
        HistoryOfDestinyMatrixView()
    }
}
