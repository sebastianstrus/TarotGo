//
//  WatchHomeView.swift
//  TarotGoWatch Watch App
//

import SwiftUI

struct WatchHomeView: View {
    @Environment(LanguageManager.self) private var languageManager

    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    WatchCardOfTheDayView()
                } label: {
                    Label {
                        Text(WatchText.cardOfTheDay)
                    } icon: {
                        Image(systemName: "sparkles").foregroundStyle(WatchTheme.gold)
                    }
                }

                NavigationLink {
                    WatchMoonView()
                } label: {
                    Label {
                        Text(WatchText.moon)
                    } icon: {
                        Text(LunarService.shared.moonPhase(for: Date()).symbol)
                    }
                }

                NavigationLink {
                    WatchMercuryView()
                } label: {
                    Label {
                        Text(WatchText.mercury)
                    } icon: {
                        Image(systemName: "arrow.triangle.2.circlepath").foregroundStyle(WatchTheme.gold)
                    }
                }

                NavigationLink {
                    WatchSettingsView()
                } label: {
                    Label {
                        Text(WatchText.settings)
                    } icon: {
                        Image(systemName: "gearshape.fill").foregroundStyle(WatchTheme.gold)
                    }
                }
            }
            .navigationTitle(WatchText.appName)
            .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
            // Rebuild the list when the language changes so every string is looked up again.
            .id(languageManager.language)
        }
    }
}

#Preview {
    WatchHomeView()
        .environment(LanguageManager.shared)
        .environment(WatchConnectivityManager.shared)
}
