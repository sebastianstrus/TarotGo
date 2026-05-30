//
//  HistoryOfPalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/17/26.
//

import SwiftUI

struct HistoryOfPalmistryView: View {
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
                        Text(L10n.historyOfPalmistryTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.historyOfPalmistrySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 24) {
                        // Introduction
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(L10n.historyOfPalmistryIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                        
                        // Section 1: Ancient Origins
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfPalmistryAncientTitle)
                                
                                Text(L10n.historyOfPalmistryAncientIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyOfPalmistryIndiaTitle, text: L10n.historyOfPalmistryIndiaText)
                                BulletPoint(title: L10n.historyOfPalmistryChinaTitle, text: L10n.historyOfPalmistryChinaText)
                                BulletPoint(title: L10n.historyOfPalmistryEgyptTitle, text: L10n.historyOfPalmistryEgyptText)
                            }
                        }
                        
                        // Section 2: Western Development
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfPalmistryWesternTitle)
                                
                                Text(L10n.historyOfPalmistryWesternIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.historyOfPalmistryGreeceTitle, text: L10n.historyOfPalmistryGreeceText)
                                BulletPoint(title: L10n.historyOfPalmistryRenaissanceTitle, text: L10n.historyOfPalmistryRenaissanceText)
                                BulletPoint(title: L10n.historyOfPalmistryModernTitle, text: L10n.historyOfPalmistryModernText)
                            }
                        }
                        
                        // Timeline Section
                        ContentCard {
                            VStack(alignment: .leading, spacing: 16) {
                                SectionTitle(text: L10n.historyOfPalmistryTimelineTitle)
                                
                                PalmistryTimelineTable()
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

struct PalmistryTimelineTable: View {
    let timelineData: [(era: String, milestone: String)] = [
        (L10n.historyOfPalmistryTimelineEra1, L10n.historyOfPalmistryTimelineMilestone1),
        (L10n.historyOfPalmistryTimelineEra2, L10n.historyOfPalmistryTimelineMilestone2),
        (L10n.historyOfPalmistryTimelineEra3, L10n.historyOfPalmistryTimelineMilestone3),
        (L10n.historyOfPalmistryTimelineEra4, L10n.historyOfPalmistryTimelineMilestone4),
        (L10n.historyOfPalmistryTimelineEra5, L10n.historyOfPalmistryTimelineMilestone5)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Table Header
            HStack(spacing: 0) {
                Text(L10n.historyOfPalmistryTimelineEraHeader)
                    .font(AppTheme.serifFont(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                    .frame(width: 100, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                
                Rectangle()
                    .fill(AppTheme.gold.opacity(0.3))
                    .frame(width: 1)
                
                Text(L10n.historyOfPalmistryTimelineMilestoneHeader)
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
                        .frame(width: 100, alignment: .leading)
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
        HistoryOfPalmistryView()
    }
}
