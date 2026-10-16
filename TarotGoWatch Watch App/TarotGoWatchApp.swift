//
//  TarotGoWatchApp.swift
//  TarotGoWatch Watch App
//
//  Created by Sebastian Strus on 2026-10-16.
//

import SwiftUI

@main
struct TarotGoWatchApp: App {
    @State private var languageManager = LanguageManager.shared
    @State private var connectivity = WatchConnectivityManager.shared

    init() {
        WatchConnectivityManager.shared.activate()
    }

    var body: some Scene {
        WindowGroup {
            WatchHomeView()
                .environment(languageManager)
                .environment(connectivity)
                .environment(\.locale, languageManager.interfaceLocale)
                .tint(WatchTheme.gold)
                .task {
                    await WatchNotificationService.shared.requestInitialPermissionIfNeeded()
                }
        }
    }
}
