//
//  WatchHomeView.swift
//  TarotGoWatch Watch App
//

import SwiftUI

struct WatchHomeView: View {
    @Environment(LanguageManager.self) private var languageManager

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    NavigationLink {
                        WatchCardOfTheDayView()
                    } label: {
                        heroCard
                    }

                    HStack(spacing: 8) {
                        NavigationLink {
                            WatchMoonView()
                        } label: {
                            tile(title: WatchText.moon) {
                                Text(LunarService.shared.moonPhase(for: Date()).symbol)
                                    .font(.system(size: 26))
                            }
                        }

                        NavigationLink {
                            WatchMercuryView()
                        } label: {
                            tile(title: WatchText.mercury) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(WatchTheme.goldGradient)
                            }
                        }
                    }

                    NavigationLink {
                        WatchSettingsView()
                    } label: {
                        settingsRow
                    }
                }
                .buttonStyle(.plain)
            }
            .navigationTitle(WatchText.appName)
            .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
            // Rebuild the content when the language changes so every string is looked up again.
            .id(languageManager.language)
        }
    }

    // MARK: - Components

    /// Featured entry point with a soft gold glow and a gradient hairline.
    private var heroCard: some View {
        HStack(spacing: 10) {
            Image(systemName: "sparkles")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(WatchTheme.goldGradient)
                .shadow(color: WatchTheme.gold.opacity(0.6), radius: 6)

            Text(WatchText.cardOfTheDay)
                .font(WatchTheme.serif(.headline, weight: .semibold))
                .foregroundStyle(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(WatchTheme.gold.opacity(0.8))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(cardBackground(glow: 0.22, cornerRadius: 22))
    }

    private func tile<Icon: View>(title: String, @ViewBuilder icon: () -> Icon) -> some View {
        VStack(spacing: 6) {
            icon()
                .frame(height: 30)

            Text(title)
                .font(WatchTheme.serif(.caption2, weight: .medium))
                .foregroundStyle(.white.opacity(0.9))
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, minHeight: 82)
        .background(cardBackground(glow: 0.10, cornerRadius: 20))
    }

    private var settingsRow: some View {
        HStack(spacing: 8) {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 13))
                .foregroundStyle(WatchTheme.goldGradient)

            Text(WatchText.settings)
                .font(WatchTheme.serif(.footnote, weight: .medium))
                .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(cardBackground(glow: 0.05, cornerRadius: 18))
    }

    private func cardBackground(glow: Double, cornerRadius: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(
                LinearGradient(
                    colors: [WatchTheme.gold.opacity(glow), .white.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [WatchTheme.lightGold.opacity(0.55), WatchTheme.darkGold.opacity(0.15)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 0.75
                    )
            )
    }
}

#Preview {
    WatchHomeView()
        .environment(LanguageManager.shared)
        .environment(WatchConnectivityManager.shared)
}
