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

                    // Palm image with floating buttons positioned on each fingertip
                    GeometryReader { geo in
                        ZStack {
                            Image("gold_palm")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .shadow(color: AppTheme.gold.opacity(0.35), radius: 30)
                                .padding(.horizontal, 8)
                                .frame(width: geo.size.width, height: geo.size.height)

                            // Thumb — Saved Readings
                            NavigationLink(destination: PalmReadingHistoryView()) {
                                PalmFingerButton(
                                    icon: "book.fill",
                                    title: L10n.palmHistoryButtonTitle,
                                    subtitle: L10n.palmHistoryButtonSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.12, y: geo.size.height * 0.42)

                            // Index — History of Palmistry
                            NavigationLink(destination: HistoryOfPalmistryView()) {
                                PalmFingerButton(
                                    icon: "scroll.fill",
                                    title: L10n.learnPalmistryHistoryTitle,
                                    subtitle: L10n.learnPalmistryHistorySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.30, y: geo.size.height * 0.14)

                            // Middle — How to Read
                            NavigationLink(destination: HowToReadPalmView()) {
                                PalmFingerButton(
                                    icon: "book.pages.fill",
                                    title: L10n.learnPalmistryHowToReadTitle,
                                    subtitle: L10n.learnPalmistryHowToReadSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.48, y: geo.size.height * 0.07)

                            // Ring — Palmistry & Mind
                            NavigationLink(destination: PalmistryAndMindView()) {
                                PalmFingerButton(
                                    icon: "brain.head.profile.fill",
                                    title: L10n.learnPalmistryMindTitle,
                                    subtitle: L10n.learnPalmistryMindSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.66, y: geo.size.height * 0.11)

                            // Pinky — FAQ
                            NavigationLink(destination: PalmistryFAQView()) {
                                PalmFingerButton(
                                    icon: "questionmark.circle.fill",
                                    title: L10n.learnPalmistryFaqTitle,
                                    subtitle: L10n.learnPalmistryFaqSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.84, y: geo.size.height * 0.18)

                            // Center of palm — Palm Reading (larger)
                            NavigationLink(destination: PalmReadingView()
                                .toolbar(.hidden, for: .tabBar)
                            ) {
                                PalmCenterButton(
                                    icon: "hand.raised.palm.facing.fill",
                                    title: L10n.palmReadingTitle,
                                    subtitle: L10n.palmReadingSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .position(x: geo.size.width * 0.5, y: geo.size.height * 0.58)
                        }
                    }

                    Spacer(minLength: 0)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

/// Compact fingertip button — gold-circle icon with title and subtitle below.
private struct PalmFingerButton: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(AppTheme.deepNavy.opacity(0.65))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.6), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.25), radius: 10)

                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(spacing: 1) {
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(subtitle)
                    .font(.system(size: 8, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: 96)
    }
}

/// Larger center-of-palm button — gold-circle icon with title and subtitle below.
private struct PalmCenterButton: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(AppTheme.deepNavy.opacity(0.75))
                    .frame(width: 76, height: 76)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.7), lineWidth: 1.5)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 16)

                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(spacing: 2) {
                Text(title)
                    .font(AppTheme.serifFont(size: 15, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineLimit(1)

                Text(subtitle)
                    .font(.system(size: 11, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: 200)
    }
}

#Preview {
    PalmistryView()
        .environmentObject(AppViewModel())
}
