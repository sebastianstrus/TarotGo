//
//  TarotGoApp.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData
import UserNotifications

@main
struct TarotGoApp: App {
    @StateObject private var appViewModel = AppViewModel()
    private let notificationDelegate = NotificationDelegate()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ReadingSession.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        // Preload sounds on app launch
        SoundService.shared.preloadSounds()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appViewModel)
                .onAppear {
                    notificationDelegate.appViewModel = appViewModel
                    UNUserNotificationCenter.current().delegate = notificationDelegate
                }
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            if appViewModel.showSplashScreen {
                SplashScreenView {
                    appViewModel.completeSplashScreen()
                }
                .transition(.opacity)
            } else {
                if appViewModel.hasCompletedOnboarding {
                    HomeView()
                        .transition(.opacity)
                } else {
                    OnboardingFlowView()
                        .transition(.opacity)
                }
            }
        }
        .animation(.easeInOut(duration: 0.5), value: appViewModel.showSplashScreen)
        .animation(.easeInOut(duration: 0.5), value: appViewModel.hasCompletedOnboarding)
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .active {
                // Clear badge when app becomes active
                NotificationService.shared.clearBadge()
            }
        }
    }
}
// Notification Delegate to handle notification taps
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    weak var appViewModel: AppViewModel?
    
    // Handle notification tap when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Check if this is a daily card notification
        if let type = userInfo["type"] as? String, type == "daily_card" {
            Task { @MainActor in
                appViewModel?.shouldNavigateToDailyCard = true
            }
        }
        
        completionHandler()
    }
    
    // Handle notification when app is in foreground (optional - shows banner)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

