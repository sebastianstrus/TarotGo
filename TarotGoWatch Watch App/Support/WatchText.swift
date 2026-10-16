//
//  WatchText.swift
//  TarotGoWatch Watch App
//
//  Strings used by the watch UI, looked up in the in-app language bundle
//  (same approach as the iOS `L10n`). Computed so a language switch applies immediately.
//

import Foundation

nonisolated enum WatchText {
    static func string(_ key: String) -> String {
        Foundation.NSLocalizedString(key, bundle: SelectedLanguage.bundle, comment: "")
    }

    static var appName: String { string("app.name") }
    static var cardOfTheDay: String { string("home.cardOfDay") }
    static var moon: String { string("lunarCalendar.title") }
    static var mercury: String { string("mercury.title") }
    static var settings: String { string("tab.settings") }

    static var tapToReveal: String { string("interpretation.tapReveal") }
    static var reversed: String { string("interpretation.reversed") }
    static var todaysMessage: String { string("cardOfDay.todaysMessage") }
    static var birthDateHint: String { string("watch.birthDateHint") }

    static var illuminated: String { string("lunarCalendar.illuminated") }
    static var shadowTimeline: String { string("mercury.shadowTimeline") }

    static var language: String { string("settings.language") }
    static var version: String { string("settings.version") }
    static var notifications: String { string("settings.notifications") }
    static var dailyReminder: String { string("settings.dailyReminder") }
    static var reminderTime: String { string("settings.reminderTime") }
    static var permissionTitle: String { string("settings.notificationPermission.title") }
    static var permissionMessage: String { string("settings.notificationPermission.message") }
    static var cancel: String { string("settings.notificationPermission.cancel") }

    static var notificationTitle: String { string("notification.title") }
    static var notificationBody: String { string("notification.body") }
}
