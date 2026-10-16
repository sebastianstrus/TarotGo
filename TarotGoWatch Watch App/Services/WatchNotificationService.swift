//
//  WatchNotificationService.swift
//  TarotGoWatch Watch App
//
//  Daily "your card awaits" reminder scheduled on the watch itself.
//

import Foundation
import UserNotifications

final class WatchNotificationService {
    static let shared = WatchNotificationService()

    nonisolated static let enabledKey = "watch.dailyCard.enabled"
    nonisolated static let hourKey = "watch.dailyCard.hour"
    nonisolated static let minuteKey = "watch.dailyCard.minute"
    private static let askedKey = "watch.hasRequestedNotificationPermission"
    private static let identifier = "watch_daily_card"

    private init() {}

    func authorizationStatus() async -> UNAuthorizationStatus {
        await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
    }

    func requestAuthorization() async -> Bool {
        let granted = try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
        return granted ?? false
    }

    func scheduleDailyCard(hour: Int, minute: Int) async {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Self.identifier])

        let content = UNMutableNotificationContent()
        content.title = WatchText.notificationTitle
        content.body = WatchText.notificationBody
        content.sound = .default

        let components = DateComponents(hour: hour, minute: minute)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: Self.identifier, content: content, trigger: trigger)

        do {
            try await center.add(request)
        } catch {
            print("Failed to schedule watch notification: \(error)")
        }
    }

    func cancelDailyCard() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Self.identifier])
    }

    /// Re-schedules with the stored time, e.g. after a language change so the text matches.
    func refreshIfEnabled() async {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: Self.enabledKey) as? Bool ?? true else { return }
        guard await authorizationStatus() == .authorized else { return }
        await scheduleDailyCard(
            hour: defaults.object(forKey: Self.hourKey) as? Int ?? 9,
            minute: defaults.object(forKey: Self.minuteKey) as? Int ?? 0
        )
    }

    /// On first launch, asks for permission and schedules the reminder if granted.
    /// If denied, switches the setting off so it reflects reality.
    func requestInitialPermissionIfNeeded() async {
        let defaults = UserDefaults.standard
        guard !defaults.bool(forKey: Self.askedKey) else { return }

        let status = await authorizationStatus()
        let granted: Bool
        if status == .notDetermined {
            granted = await requestAuthorization()
        } else {
            granted = status == .authorized
        }
        defaults.set(true, forKey: Self.askedKey)
        defaults.set(granted, forKey: Self.enabledKey)
        if granted {
            await refreshIfEnabled()
        }
    }
}
