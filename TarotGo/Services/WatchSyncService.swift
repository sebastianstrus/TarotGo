//
//  WatchSyncService.swift
//  TarotGo
//
//  Sends the user's birth date and chosen card back to the Apple Watch app so the watch
//  shows the same personalized Card of the Day as the phone.
//

import Foundation
import WatchConnectivity

final class WatchSyncService: NSObject {
    static let shared = WatchSyncService()

    private var observerTask: Task<Void, Never>?
    private var lastSentBirthDate: Date??
    private var lastSentCardBack: String?

    private override init() {
        super.init()
    }

    func start() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()

        // Birth date can be saved from several screens, so watch for any change to it.
        observerTask = Task { [weak self] in
            for await _ in NotificationCenter.default.notifications(named: UserDefaults.didChangeNotification) {
                self?.pushContext()
            }
        }
    }

    private func pushContext() {
        let session = WCSession.default
        guard session.activationState == .activated, session.isPaired, session.isWatchAppInstalled else { return }

        let birthDate = AstrologyService.shared.userBirthDate
        let cardBack = UserDefaults.standard.string(forKey: DailyCardStore.cardBackKey) ?? DailyCardStore.defaultCardBackName
        guard lastSentBirthDate != .some(birthDate) || lastSentCardBack != cardBack else { return }

        var context: [String: Any] = ["birthDateSet": birthDate != nil, "cardBack": cardBack]
        if let birthDate {
            context["birthDate"] = birthDate.timeIntervalSince1970
        }

        do {
            try session.updateApplicationContext(context)
            lastSentBirthDate = .some(birthDate)
            lastSentCardBack = cardBack
        } catch {
            print("Failed to sync context to watch: \(error)")
        }
    }
}

extension WatchSyncService: WCSessionDelegate {
    nonisolated func session(_ session: WCSession,
                             activationDidCompleteWith activationState: WCSessionActivationState,
                             error: Error?) {
        Task { @MainActor in
            self.pushContext()
        }
    }

    nonisolated func sessionWatchStateDidChange(_ session: WCSession) {
        Task { @MainActor in
            // The watch app may have just been installed; send the current value again.
            self.lastSentBirthDate = nil
            self.lastSentCardBack = nil
            self.pushContext()
        }
    }

    nonisolated func sessionDidBecomeInactive(_ session: WCSession) {}

    nonisolated func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}
