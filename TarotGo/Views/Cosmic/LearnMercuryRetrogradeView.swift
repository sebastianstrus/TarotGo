//
//  LearnMercuryRetrogradeView.swift
//  TarotGo
//
//  Educational landing page for Mercury retrograde — explains the phenomenon,
//  the three phases of the shadow window, why it matters, and dispels myths.
//

import SwiftUI

struct LearnMercuryRetrogradeView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)

                    // Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.learnMercuryTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        Text(L10n.learnMercurySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 6)

                    // Navigation to History
                    NavigationLink(destination: HistoryOfMercuryRetrogradeView()) {
                        MercuryLearnLinkRow(
                            icon: "scroll.fill",
                            title: L10n.learnMercuryHistoryTitle,
                            subtitle: L10n.learnMercuryHistorySubtitle
                        )
                    }
                    .buttonStyle(.plain)

                    // Educational content
                    VStack(alignment: .leading, spacing: 24) {
                        // What is Mercury Retrograde?
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.learnMercuryWhatIsTitle)

                                Text(L10n.learnMercuryWhatIsIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                Text(L10n.learnMercuryWhatIsBody)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }

                        // The Three Phases
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.learnMercuryPhasesTitle)

                                Text(L10n.learnMercuryPhasesIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                BulletPoint(
                                    title: L10n.learnMercuryPhasePreShadowTitle,
                                    text: L10n.learnMercuryPhasePreShadowText
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryPhaseRetrogradeTitle,
                                    text: L10n.learnMercuryPhaseRetrogradeText
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryPhasePostShadowTitle,
                                    text: L10n.learnMercuryPhasePostShadowText
                                )
                            }
                        }

                        // Why it matters
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.learnMercuryWhyTitle)

                                Text(L10n.learnMercuryWhyIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                BulletPoint(
                                    title: L10n.learnMercuryWhyCommunicationTitle,
                                    text: L10n.learnMercuryWhyCommunicationText
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryWhyTechnologyTitle,
                                    text: L10n.learnMercuryWhyTechnologyText
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryWhyReflectionTitle,
                                    text: L10n.learnMercuryWhyReflectionText
                                )
                            }
                        }

                        // Common myths
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionTitle(text: L10n.learnMercuryMythsTitle)

                                Text(L10n.learnMercuryMythsIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)

                                BulletPoint(
                                    title: L10n.learnMercuryMyth1Title,
                                    text: L10n.learnMercuryMyth1Text
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryMyth2Title,
                                    text: L10n.learnMercuryMyth2Text
                                )
                                BulletPoint(
                                    title: L10n.learnMercuryMyth3Title,
                                    text: L10n.learnMercuryMyth3Text
                                )
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

// MARK: - Local Learn Link Row (uses SF Symbol so no new asset is required)

private struct MercuryLearnLinkRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: 46, height: 46)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.5)
                    )

                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)

                Text(subtitle)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.gold.opacity(0.6))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.1), radius: 6, x: 0, y: 3)
        )
    }
}

#Preview {
    NavigationStack {
        LearnMercuryRetrogradeView()
    }
}
