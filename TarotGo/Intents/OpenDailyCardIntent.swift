//
//  OpenDailyCardIntent.swift
//  TarotGo
//

import AppIntents

/// Lets Siri / Shortcuts open the app straight on the Card of the Day.
/// Reuses the existing `tarotgo://daily-card` deep link handled by `AppViewModel.handleDeepLink`.
struct OpenDailyCardIntent: AppIntent {
    static let title: LocalizedStringResource = "Open Card of the Day"
    static let description = IntentDescription("Opens TarotGo on your Card of the Day.")

    @MainActor
    func perform() async throws -> some IntentResult & OpensIntent {
        guard let url = URL(string: "tarotgo://daily-card") else {
            return .result(opensIntent: OpenURLIntent(URL(fileURLWithPath: "/")))
        }
        return .result(opensIntent: OpenURLIntent(url))
    }
}

struct TarotGoShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenDailyCardIntent(),
            phrases: [
                "Open my card of the day in \(.applicationName)",
                "Show my daily card in \(.applicationName)",
                "Open \(.applicationName) card of the day"
            ],
            shortTitle: "Card of the Day",
            systemImageName: "sparkles"
        )
    }
}
