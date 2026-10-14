//
//  RevealCardIntent.swift
//  TarotGoWidget
//
//  Lets people reveal today's tarot card directly from the widget, without opening the app.
//

import AppIntents
import WidgetKit

struct RevealCardIntent: AppIntent {
    static var title: LocalizedStringResource = "Reveal Card"
    static var description = IntentDescription("Reveals today's tarot card directly in the widget.")

    func perform() async throws -> some IntentResult {
        DailyCardStore.markRevealed()
        return .result()
    }
}
