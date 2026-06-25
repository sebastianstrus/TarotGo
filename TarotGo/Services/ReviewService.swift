//
//  ReviewService.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/25/26.
//

import SwiftUI
import StoreKit

/// Coordinates App Store rating prompts.
///
/// Strategy:
/// - Tracks "significant events" (completed readings) across the app via `recordSignificantEvent()`.
/// - Triggers the system `requestReview` sheet only at specific milestones (3rd, 10th, 30th event),
///   and only after the user has had the app installed for at least 2 days, so the prompt lands
///   at a "moment of delight" rather than at first launch.
/// - Apple throttles `requestReview` to ~3 prompts per user per 365 days; we never call it from a
///   tap handler since Apple may silently drop those calls.
/// - The manual "Rate" entry in Settings opens the App Store write-review deep link directly,
///   which always works.
@MainActor
final class ReviewService {
    static let shared = ReviewService()

    private let appStoreID = "6762875158"

    private enum Keys {
        static let eventCount = "review.significantEventCount"
        static let lastPromptedAtVersion = "review.lastPromptedAtVersion"
        static let firstLaunchDate = "review.firstLaunchDate"
    }

    private let milestones: Set<Int> = [3, 10, 30]
    private let minimumDaysInstalled: TimeInterval = 2 * 24 * 60 * 60

    private init() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: Keys.firstLaunchDate) == nil {
            defaults.set(Date(), forKey: Keys.firstLaunchDate)
        }
    }

    /// Call this after the user completes a meaningful action (a tarot reading,
    /// a palm reading, a destiny matrix result, etc.). Safe to call repeatedly —
    /// the prompt is gated internally.
    func recordSignificantEvent() {
        let defaults = UserDefaults.standard
        let newCount = defaults.integer(forKey: Keys.eventCount) + 1
        defaults.set(newCount, forKey: Keys.eventCount)

#if DEBUG
        // Bypass all gates during development so we can see the sheet on every event.
        // The system still throttles in TestFlight (suppressed) and production (~3/year),
        // so this only affects local debug builds.
        requestSystemReview()
        return
#else
        guard milestones.contains(newCount) else { return }
        guard hasBeenInstalledLongEnough else { return }
        guard !hasAlreadyPromptedForCurrentVersion else { return }
        
        requestSystemReview()
#endif
    }

    /// Opens the App Store write-review page directly. Use this for the manual
    /// "Rate App" button in Settings — unlike `requestReview`, it always works.
    func openWriteReviewPage() {
        let urlString = "https://apps.apple.com/app/id\(appStoreID)?action=write-review"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }

    private var hasBeenInstalledLongEnough: Bool {
        guard let firstLaunch = UserDefaults.standard.object(forKey: Keys.firstLaunchDate) as? Date else {
            return false
        }
        return Date().timeIntervalSince(firstLaunch) >= minimumDaysInstalled
    }

    private var currentAppVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
    }

    private var hasAlreadyPromptedForCurrentVersion: Bool {
        let last = UserDefaults.standard.string(forKey: Keys.lastPromptedAtVersion)
        return last == currentAppVersion
    }

    private func requestSystemReview() {
        guard let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
            return
        }
        AppStore.requestReview(in: scene)
        UserDefaults.standard.set(currentAppVersion, forKey: Keys.lastPromptedAtVersion)
    }
}
