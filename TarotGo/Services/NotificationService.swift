//
//  NotificationService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation
import UserNotifications
import Combine

class NotificationService: ObservableObject {
    static let shared = NotificationService()
    
    @Published var isAuthorized: Bool = false
    
    private init() {
        checkAuthorizationStatus()
    }
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            await MainActor.run {
                self.isAuthorized = granted
            }
            return granted
        } catch {
            print("Failed to request notification authorization: \(error)")
            return false
        }
    }
    
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    func getAuthorizationStatus() async -> UNAuthorizationStatus {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        return settings.authorizationStatus
    }

    /// On first launch, prompts the user for notification permission. If granted,
    /// schedules the daily card and Mercury retrograde notifications. If denied,
    /// flips both toggles to off so Settings reflects reality.
    func requestInitialPermissionIfNeeded() async {
        let askedKey = "hasRequestedInitialNotificationPermission"
        let defaults = UserDefaults.standard
        guard !defaults.bool(forKey: askedKey) else { return }

        let status = await getAuthorizationStatus()

        if status == .notDetermined {
            let granted = await requestAuthorization()
            defaults.set(true, forKey: askedKey)
            if granted {
                await scheduleInitialNotifications()
            } else {
                defaults.set(false, forKey: "dailyCardNotificationEnabled")
                defaults.set(false, forKey: "mercuryRetrogradeAlertsEnabled")
            }
        } else {
            defaults.set(true, forKey: askedKey)
            if status == .authorized {
                await scheduleInitialNotifications()
            } else {
                defaults.set(false, forKey: "dailyCardNotificationEnabled")
                defaults.set(false, forKey: "mercuryRetrogradeAlertsEnabled")
            }
        }
    }

    private func scheduleInitialNotifications() async {
        let defaults = UserDefaults.standard
        let hour = defaults.object(forKey: "dailyCardNotificationHour") as? Int ?? 9
        let minute = defaults.object(forKey: "dailyCardNotificationMinute") as? Int ?? 0
        await scheduleDailyCardNotification(at: hour, minute: minute)
        await scheduleMercuryRetrogradeNotifications()
    }
    
    func scheduleDailyCardNotification(at hour: Int, minute: Int = 0) async {
        // Remove existing notifications
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_card"])
        
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = L10n.notificationTitle
        content.body = L10n.notificationBody
        content.sound = UNNotificationSound(named: UNNotificationSoundName("notification.caf"))
        content.badge = 1 // Set badge to 1
        content.userInfo = ["type": "daily_card"] // Identifier for navigation
        
        // Create date components for scheduling
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create trigger
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create request
        let request = UNNotificationRequest(
            identifier: "daily_card",
            content: content,
            trigger: trigger
        )
        
        // Schedule notification
        do {
            try await UNUserNotificationCenter.current().add(request)
            print("Daily card notification scheduled for \(hour):\(String(format: "%02d", minute))")
        } catch {
            print("Failed to schedule notification: \(error)")
        }
    }
    
    func cancelDailyCardNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_card"])
    }
    
    func clearBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }

    // MARK: - Mercury Retrograde

    private static let mercuryNotificationPrefix = "mercury_retrograde_"

    /// Schedules notifications for every Mercury retrograde milestone (pre-shadow start,
    /// retrograde start, retrograde end, post-shadow end) for all known upcoming periods.
    func scheduleMercuryRetrogradeNotifications() async {
        cancelMercuryRetrogradeNotifications()

        let now = Date()
        let upcoming = MercuryRetrogradeService.shared.upcomingPeriods(from: now, count: 12)
        let calendar = Calendar.current

        for period in upcoming {
            let events: [(date: Date, key: String, title: String, body: String)] = [
                (period.preShadowStart, "preShadow",
                 L10n.mercuryNotifPreShadowTitle, L10n.mercuryNotifPreShadowBody),
                (period.retrogradeStart, "retroStart",
                 L10n.mercuryNotifRetrogradeStartTitle, L10n.mercuryNotifRetrogradeStartBody),
                (period.retrogradeEnd, "retroEnd",
                 L10n.mercuryNotifRetrogradeEndTitle, L10n.mercuryNotifRetrogradeEndBody),
                (period.postShadowEnd, "postShadowEnd",
                 L10n.mercuryNotifPostShadowEndTitle, L10n.mercuryNotifPostShadowEndBody)
            ]

            for event in events {
                guard event.date > now else { continue }

                var triggerComponents = calendar.dateComponents(
                    [.year, .month, .day], from: event.date
                )
                triggerComponents.hour = 9
                triggerComponents.minute = 0

                let content = UNMutableNotificationContent()
                content.title = event.title
                content.body = event.body
                content.sound = UNNotificationSound(named: UNNotificationSoundName("notification.caf"))
                content.userInfo = ["type": "mercury_retrograde"]

                let trigger = UNCalendarNotificationTrigger(
                    dateMatching: triggerComponents, repeats: false
                )

                let identifier = "\(Self.mercuryNotificationPrefix)\(period.id.uuidString)_\(event.key)"
                let request = UNNotificationRequest(
                    identifier: identifier,
                    content: content,
                    trigger: trigger
                )

                do {
                    try await UNUserNotificationCenter.current().add(request)
                } catch {
                    print("Failed to schedule mercury notification: \(error)")
                }
            }
        }
    }

    func cancelMercuryRetrogradeNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let ids = requests
                .map(\.identifier)
                .filter { $0.hasPrefix(Self.mercuryNotificationPrefix) }
            if !ids.isEmpty {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
            }
        }
    }
}
