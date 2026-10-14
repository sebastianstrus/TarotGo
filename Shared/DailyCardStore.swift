//
//  DailyCardStore.swift
//  TarotGo
//
//  Shared between the main app and the widget extension.
//  Stores the Card of the Day info in an App Group so the widget
//  can display the same card the app has selected for today.
//

import Foundation
import WidgetKit

/// Minimal, Codable snapshot of the Card of the Day that the widget can read.
struct DailyCardInfo: Codable, Equatable {
    let dateKey: String
    let cardID: String
    let localizedName: String
    let isReversed: Bool
    let isRevealed: Bool

    var isToday: Bool { dateKey == DailyCardStore.todayDateKey() }
}

enum DailyCardStore {
    static let appGroupID = "group.com.sebastianstrus.TarotGo"
    static let userDefaultsKey = "dailyCardInfo"
    static let cardBackKey = "selectedCardBack"
    static let widgetKind = "TarotGoWidget"

    /// Default card back asset name. Must match `CardBackStyle.modern.rawValue`.
    static let defaultCardBackName = "ReversCard1"

    static var shared: UserDefaults {
        UserDefaults(suiteName: appGroupID) ?? .standard
    }

    static func todayDateKey(for date: Date = Date()) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    static func load() -> DailyCardInfo? {
        guard let data = shared.data(forKey: userDefaultsKey) else { return nil }
        return try? JSONDecoder().decode(DailyCardInfo.self, from: data)
    }

    static func save(_ info: DailyCardInfo) {
        guard let data = try? JSONEncoder().encode(info) else { return }
        shared.set(data, forKey: userDefaultsKey)
        WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
    }

    /// Marks today's already-computed card as revealed in place, without needing the app to recompute it.
    /// Used by the widget's "Reveal" button so the card can be revealed without opening the app.
    static func markRevealed() {
        guard let info = load(), info.isToday, !info.isRevealed else { return }
        save(DailyCardInfo(
            dateKey: info.dateKey,
            cardID: info.cardID,
            localizedName: info.localizedName,
            isReversed: info.isReversed,
            isRevealed: true
        ))
    }

    static func loadCardBackName() -> String {
        shared.string(forKey: cardBackKey) ?? defaultCardBackName
    }

    static func saveCardBackName(_ name: String) {
        shared.set(name, forKey: cardBackKey)
        WidgetCenter.shared.reloadTimelines(ofKind: widgetKind)
    }
}
