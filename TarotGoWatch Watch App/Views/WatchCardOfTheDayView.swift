//
//  WatchCardOfTheDayView.swift
//  TarotGoWatch Watch App
//

import SwiftUI
import WatchKit

struct WatchCardOfTheDayView: View {
    @Environment(LanguageManager.self) private var languageManager
    @Environment(WatchConnectivityManager.self) private var connectivity
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage("watch.revealedToken") private var revealedToken = ""

    @State private var daily = WatchDailyCard.today()
    @State private var flip: Double = 0

    private var isRevealed: Bool { revealedToken == daily.revealToken }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                cardImage

                if isRevealed {
                    revealedDetails
                } else {
                    Text(WatchText.tapToReveal)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                if connectivity.birthDate == nil {
                    Text(WatchText.birthDateHint)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                }
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle(WatchText.cardOfTheDay)
        .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
        .id(languageManager.language)
        .onAppear(perform: refresh)
        .onChange(of: connectivity.birthDate) { refresh() }
        .onChange(of: scenePhase) {
            if scenePhase == .active { refresh() }
        }
    }

    private var cardImage: some View {
        ZStack {
            Image(connectivity.cardBackName)
                .resizable()
                .scaledToFit()
                .opacity(flip < 90 ? 1 : 0)
                .rotation3DEffect(.degrees(flip), axis: (x: 0, y: 1, z: 0))

            Image(daily.imageName)
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(daily.isReversed ? 180 : 0))
                .opacity(flip >= 90 ? 1 : 0)
                .rotation3DEffect(.degrees(flip - 180), axis: (x: 0, y: 1, z: 0))
        }
        .frame(height: 150)
        .shadow(color: WatchTheme.gold.opacity(isRevealed ? 0.4 : 0.2), radius: 8)
        .contentShape(Rectangle())
        .onTapGesture(perform: reveal)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(isRevealed ? daily.name : WatchText.tapToReveal)
        .accessibilityAddTraits(.isButton)
    }

    private var revealedDetails: some View {
        VStack(spacing: 6) {
            Text(daily.name)
                .font(WatchTheme.serif(.headline, weight: .medium))
                .foregroundStyle(WatchTheme.goldGradient)
                .multilineTextAlignment(.center)

            if daily.isReversed {
                Text(WatchText.reversed)
                    .font(.caption2)
                    .foregroundStyle(WatchTheme.gold.opacity(0.8))
            }

            Text(daily.keywords.joined(separator: " · "))
                .font(.caption2)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Divider().padding(.vertical, 4)

            Text(WatchText.todaysMessage)
                .font(WatchTheme.serif(.footnote, weight: .medium))
                .foregroundStyle(WatchTheme.goldGradient)

            Text(daily.message)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.85))
        }
        .transition(.opacity)
    }

    private func reveal() {
        guard !isRevealed else { return }
        WKInterfaceDevice.current().play(.success)
        withAnimation(.easeInOut(duration: 0.7)) {
            flip = 180
            revealedToken = daily.revealToken
        }
    }

    /// Recomputes today's card (new day, or birth date arrived) and shows it in the right state.
    private func refresh() {
        daily = .today()
        flip = isRevealed ? 180 : 0
    }
}

#Preview {
    NavigationStack {
        WatchCardOfTheDayView()
    }
    .environment(LanguageManager.shared)
    .environment(WatchConnectivityManager.shared)
}
