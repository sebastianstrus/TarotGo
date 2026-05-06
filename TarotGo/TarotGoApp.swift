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
        
        // Set up notification delegate with shared instance
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appViewModel)
                .onAppear {
                    // Connect the app view model to the notification delegate
                    NotificationDelegate.shared.appViewModel = appViewModel
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
    static let shared = NotificationDelegate()
    weak var appViewModel: AppViewModel?
    
    private override init() {
        super.init()
    }
    
    // Handle notification tap when app is in foreground or background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print("📬 Notification tapped with userInfo: \(userInfo)")
        
        // Check if this is a daily card notification
        if let type = userInfo["type"] as? String, type == "daily_card" {
            print("📬 Daily card notification detected")
            Task { @MainActor in
                if let viewModel = appViewModel {
                    print("📬 AppViewModel found - showSplashScreen: \(viewModel.showSplashScreen), hasCompletedOnboarding: \(viewModel.hasCompletedOnboarding)")
                    // If app is ready (no splash screen), navigate immediately
                    if !viewModel.showSplashScreen && viewModel.hasCompletedOnboarding {
                        print("📬 App ready - navigating immediately")
                        viewModel.shouldNavigateToDailyCard = true
                    } else {
                        // Otherwise, store the action to process after app is ready
                        print("📬 App not ready - storing pending action")
                        viewModel.pendingNotificationAction = "daily_card"
                    }
                } else {
                    print("📬 WARNING: AppViewModel is nil!")
                }
            }
        }
        
        completionHandler()
    }
    
    // Handle notification when app is in foreground (optional - shows banner)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

