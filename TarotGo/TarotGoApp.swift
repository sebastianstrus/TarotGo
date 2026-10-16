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
    @StateObject private var subscriptionService = SubscriptionService.shared
    @State private var languageManager = LanguageManager.shared
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ReadingSession.self,
            DestinyMatrixSession.self,
            CoupleMatrixSession.self,
            PalmReadingSession.self
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

        // Mirror the user's selected card back into the App Group so the widget can read it.
        let selected = UserDefaults.standard.string(forKey: "selectedCardBack") ?? CardBackStyle.modern.rawValue
        DailyCardStore.saveCardBackName(selected)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appViewModel)
                .environmentObject(subscriptionService)
                .environment(languageManager)
                .environment(\.locale, languageManager.interfaceLocale)
                // Rebuild the view tree on language change so every
                // `L10n` string is looked up again.
                .id(languageManager.language)
                .onAppear {
                    // Connect the app view model to the notification delegate
                    NotificationDelegate.shared.appViewModel = appViewModel
                }
                .onOpenURL { url in
                    appViewModel.handleDeepLink(url)
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
                    MainTabView()
                        .transition(.opacity)
                } else {
                    OnboardingFlowView()
                        .transition(.opacity)
                }
            }
        }
        .preferredColorScheme(.dark)
        .animation(.easeInOut(duration: 0.5), value: appViewModel.showSplashScreen)
        .animation(.easeInOut(duration: 0.5), value: appViewModel.hasCompletedOnboarding)
        .task(id: appViewModel.hasCompletedOnboarding) {
            if appViewModel.hasCompletedOnboarding {
                await NotificationService.shared.requestInitialPermissionIfNeeded()
            }
        }
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
                        viewModel.navigateToDailyCard()
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

