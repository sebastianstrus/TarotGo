//
//  OpenDailyCardIntent.swift
//  TarotGo
//

import AppIntents

/// Lets Siri / Shortcuts open the app straight on the Card of the Day.
/// Runs in the foreground app process and drives `AppViewModel` directly, which
/// also handles cold launch, splash screen and onboarding via the pending action.
struct OpenDailyCardIntent: AppIntent {
    static let title: LocalizedStringResource = "Open Card of the Day"
    static let description = IntentDescription("Opens TarotGo on your Card of the Day.")
    static let supportedModes: IntentModes = .foreground

    @MainActor
    func perform() async throws -> some IntentResult {
        AppViewModel.openDailyCardFromIntent()
        return .result()
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
