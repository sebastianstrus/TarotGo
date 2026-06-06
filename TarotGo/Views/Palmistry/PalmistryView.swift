//
//  PalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct PalmistryView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    // Section title with gold styling
                    VStack(spacing: 8) {
                        Text(L10n.palmistryViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.palmistryViewSubtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.top, 10)

                    // Palm image with floating buttons
                    ZStack {
                        Image("gold_palm")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .shadow(color: AppTheme.gold.opacity(0.35), radius: 30)
                            .padding(.horizontal, 8)

                        VStack {
                            HStack(alignment: .top) {
                                NavigationLink(destination: PalmReadingView()
                                    .toolbar(.hidden, for: .tabBar)
                                ) {
                                    PalmFloatingButton(
                                        icon: "hand.raised.palm.facing.fill",
                                        title: L10n.palmReadingTitle,
                                        subtitle: L10n.palmReadingSubtitle
                                    )
                                }
                                .buttonStyle(NavigationButtonStyle())

                                Spacer()

                                NavigationLink(destination: PalmReadingHistoryView()) {
                                    PalmFloatingIconButton(
                                        icon: "book.fill",
                                        label: L10n.palmHistoryButtonTitle
                                    )
                                }
                                .buttonStyle(NavigationButtonStyle())
                            }

                            Spacer()

                            NavigationLink(destination: LearnPalmistryView()) {
                                PalmFloatingButton(
                                    icon: "book.pages.fill",
                                    title: L10n.learnPalmistryTitle,
                                    subtitle: L10n.learnPalmistrySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 24)
                    }

                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

/// Pill-shaped floating button with icon, title, and subtitle for the palmistry overlay.
private struct PalmFloatingButton: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: 38, height: 38)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.6), lineWidth: 1)
                    )

                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTheme.serifFont(size: 14, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineLimit(1)

                Text(subtitle)
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
                    .lineLimit(1)
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 14)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(AppTheme.deepNavy.opacity(0.65))
                .overlay(
                    Capsule()
                        .stroke(AppTheme.gold.opacity(0.45), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.25), radius: 12)
        )
    }
}

/// Compact circular floating button with an icon and small caption label.
private struct PalmFloatingIconButton: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(AppTheme.deepNavy.opacity(0.65))
                    .frame(width: 46, height: 46)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.6), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.25), radius: 10)

                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
                .lineLimit(1)
        }
    }
}

#Preview {
    PalmistryView()
        .environmentObject(AppViewModel())
}
