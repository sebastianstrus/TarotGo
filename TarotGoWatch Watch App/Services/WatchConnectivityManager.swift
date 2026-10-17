//
//  WatchConnectivityManager.swift
//  TarotGoWatch Watch App
//
//  Receives the user's birth date from the iPhone app so the personalized
//  Card of the Day matches the one shown on the phone.
//

import Foundation
import Observation
import WatchConnectivity

@Observable
final class WatchConnectivityManager: NSObject {
    static let shared = WatchConnectivityManager()

    /// Latest known birth date. Views observe this to recompute the personalized card.
    private(set) var birthDate: Date? = AstrologyService.shared.userBirthDate

    /// Asset name of the card back chosen on the iPhone (`ReversCard1`…`ReversCard4`).
    private(set) var cardBackName: String = UserDefaults.standard.string(forKey: "selectedCardBack") ?? "ReversCard1"

    private override init() {
        super.init()
    }

    func activate() {
        guard WCSession.isSupported() else { return }
        let session = WCSession.default
        session.delegate = self
        session.activate()
    }

    private func apply(isSet: Bool, interval: Double?) {
        let date = isSet ? interval.map(Date.init(timeIntervalSince1970:)) : nil
        AstrologyService.shared.userBirthDate = date
        birthDate = date
    }

    private nonisolated func handle(_ context: [String: Any]) {
        let cardBack = context["cardBack"] as? String
        let isSet = context["birthDateSet"] as? Bool
        let interval = context["birthDate"] as? Double
        Task { @MainActor in
            if let cardBack {
                UserDefaults.standard.set(cardBack, forKey: "selectedCardBack")
                self.cardBackName = cardBack
            }
            if let isSet {
                self.apply(isSet: isSet, interval: interval)
            }
        }
    }
}

extension WatchConnectivityManager: WCSessionDelegate {
    nonisolated func session(_ session: WCSession,
                             activationDidCompleteWith activationState: WCSessionActivationState,
                             error: Error?) {
        guard activationState == .activated else { return }
        handle(session.receivedApplicationContext)
    }

    nonisolated func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        handle(applicationContext)
    }
}
