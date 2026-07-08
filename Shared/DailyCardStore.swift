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
    static let appGroupID = "group.com.sebastianstrus.tarot"
    static let userDefaultsKey = "dailyCardInfo"
    static let widgetKind = "TarotGoWidget"

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
}
