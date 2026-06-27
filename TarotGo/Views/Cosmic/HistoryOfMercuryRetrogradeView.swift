//
//  HistoryOfMercuryRetrogradeView.swift
//  TarotGo
//
//  History of how astrologers and astronomers understood Mercury retrograde
//  from ancient observations to modern psychological astrology.
//

import SwiftUI

struct HistoryOfMercuryRetrogradeView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.historyOfMercuryTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        Text(L10n.historyOfMercurySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)

                    VStack(alignment: .leading, spacing: 24) {
                        // Introduction
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(L10n.historyOfMercuryIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }

                        // Ancient Roots
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfMercuryAncientTitle)

                                Text(L10n.historyOfMercuryAncientIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                BulletPoint(
                                    title: L10n.historyOfMercuryBabyloniansTitle,
                                    text: L10n.historyOfMercuryBabyloniansText
                                )
                                BulletPoint(
                                    title: L10n.historyOfMercuryGreeksTitle,
                                    text: L10n.historyOfMercuryGreeksText
                                )
                                BulletPoint(
                                    title: L10n.historyOfMercuryMedievalTitle,
                                    text: L10n.historyOfMercuryMedievalText
                                )
                            }
                        }

                        // Modern Era
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.historyOfMercuryModernTitle)

                                Text(L10n.historyOfMercuryModernIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                BulletPoint(
                                    title: L10n.historyOfMercuryPsychologicalTitle,
                                    text: L10n.historyOfMercuryPsychologicalText
                                )
                                BulletPoint(
                                    title: L10n.historyOfMercuryDigitalTitle,
                                    text: L10n.historyOfMercuryDigitalText
                                )
                            }
                        }

                        // Timeline
                        ContentCard {
                            VStack(alignment: .leading, spacing: 16) {
                                SectionTitle(text: L10n.historyOfMercuryTimelineTitle)

                                MercuryRetrogradeTimelineTable()
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

struct MercuryRetrogradeTimelineTable: View {
    let timelineData: [(era: String, milestone: String)] = [
        (L10n.historyOfMercuryTimelineEra1, L10n.historyOfMercuryTimelineMilestone1),
        (L10n.historyOfMercuryTimelineEra2, L10n.historyOfMercuryTimelineMilestone2),
        (L10n.historyOfMercuryTimelineEra3, L10n.historyOfMercuryTimelineMilestone3),
        (L10n.historyOfMercuryTimelineEra4, L10n.historyOfMercuryTimelineMilestone4),
        (L10n.historyOfMercuryTimelineEra5, L10n.historyOfMercuryTimelineMilestone5)
    ]

    var body: some View {
        VStack(spacing: 0) {
            // Table Header
            HStack(spacing: 0) {
                Text(L10n.historyOfMercuryTimelineEraHeader)
                    .font(AppTheme.serifFont(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                    .frame(width: 110, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)

                Rectangle()
                    .fill(AppTheme.gold.opacity(0.3))
                    .frame(width: 1)

                Text(L10n.historyOfMercuryTimelineMilestoneHeader)
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
        HistoryOfMercuryRetrogradeView()
    }
}
