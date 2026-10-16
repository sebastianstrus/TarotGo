//
//  WatchSyncService.swift
//  TarotGo
//
//  Sends the user's birth date to the Apple Watch app so the watch shows the same
//  personalized Card of the Day as the phone.
//

import Foundation
import WatchConnectivity

final class WatchSyncService: NSObject {
    static let shared = WatchSyncService()

    private var observerTask: Task<Void, Never>?
    private var lastSentBirthDate: Date??

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
                self?.pushBirthDate()
            }
        }
    }

    private func pushBirthDate() {
        let session = WCSession.default
        guard session.activationState == .activated, session.isPaired, session.isWatchAppInstalled else { return }

        let birthDate = AstrologyService.shared.userBirthDate
        guard lastSentBirthDate != .some(birthDate) else { return }

        var context: [String: Any] = ["birthDateSet": birthDate != nil]
        if let birthDate {
            context["birthDate"] = birthDate.timeIntervalSince1970
        }

        do {
            try session.updateApplicationContext(context)
            lastSentBirthDate = .some(birthDate)
        } catch {
            print("Failed to sync birth date to watch: \(error)")
        }
    }
}

extension WatchSyncService: WCSessionDelegate {
    nonisolated func session(_ session: WCSession,
                             activationDidCompleteWith activationState: WCSessionActivationState,
                             error: Error?) {
        Task { @MainActor in
            self.pushBirthDate()
        }
    }

    nonisolated func sessionWatchStateDidChange(_ session: WCSession) {
        Task { @MainActor in
            // The watch app may have just been installed; send the current value again.
            self.lastSentBirthDate = nil
            self.pushBirthDate()
        }
    }

    nonisolated func sessionDidBecomeInactive(_ session: WCSession) {}

    nonisolated func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}
