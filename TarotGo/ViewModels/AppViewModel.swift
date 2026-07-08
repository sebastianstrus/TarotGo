//
//  AppViewModel.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class AppViewModel: ObservableObject {
    @Published var isFirstLaunch: Bool = true
    @Published var hasCompletedOnboarding: Bool = false
    @Published var showSplashScreen: Bool = true
    @Published var navigationPath = NavigationPath()
    @Published var shouldDismissToRoot: Bool = false
    @Published var shouldNavigateToDailyCard: Bool = false
    @Published var tabBarVisibility: Visibility = .visible
    @Published var activeTab: TarotTab = .tarot
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @AppStorage("hasCompletedOnboardingFlow") private var hasCompletedOnboardingFlow: Bool = false
    
    // Store pending notification action
    var pendingNotificationAction: String?
    
    init() {
        self.isFirstLaunch = !hasLaunchedBefore
        self.hasCompletedOnboarding = hasCompletedOnboardingFlow
    }
    
    func completeSplashScreen() {
        withAnimation(.easeOut(duration: 0.5)) {
            showSplashScreen = false
        }
        
        print("📱 Splash screen completed - processing pending notification")
        // Process pending notification after splash screen
        processPendingNotification()
    }
    
    func processPendingNotification() {
        print("📱 processPendingNotification called - pendingAction: \(pendingNotificationAction ?? "nil")")
        guard let action = pendingNotificationAction else { return }

        if action == "daily_card" {
            print("📱 Processing daily_card action")
            navigateToDailyCard()
        }

        pendingNotificationAction = nil
    }

    /// Switches to the Tarot tab and triggers navigation to Card of the Day.
    /// Called from deep-link and notification handlers so the destination
    /// resolves on the Tarot tab regardless of which tab the user was on.
    func navigateToDailyCard() {
        activeTab = .tarot
        // Delay slightly so the tab switch settles before pushing the destination.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            print("📱 Setting shouldNavigateToDailyCard = true")
            self.shouldNavigateToDailyCard = true
        }
    }
    
    func completeOnboarding() {
        hasLaunchedBefore = true
        hasCompletedOnboardingFlow = true
        
        withAnimation {
            hasCompletedOnboarding = true
        }
        
        HapticService.shared.impact(.success)
        
        print("📱 Onboarding completed - processing pending notification")
        // Process pending notification after onboarding
        processPendingNotification()
    }
    
    func resetOnboarding() {
        hasLaunchedBefore = false
        hasCompletedOnboardingFlow = false
        isFirstLaunch = true
        hasCompletedOnboarding = false
    }
    
    func returnToHome() {
        navigationPath = NavigationPath()
        shouldDismissToRoot = true
        // Reset after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldDismissToRoot = false
        }
    }

    /// Handles deep links from widgets and other external sources.
    /// Supported: tarotgo://daily-card
    func handleDeepLink(_ url: URL) {
        guard url.scheme == "tarotgo" else { return }
        let host = url.host?.lowercased() ?? url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/")).lowercased()

        if host == "daily-card" {
            if !showSplashScreen && hasCompletedOnboarding {
                navigateToDailyCard()
            } else {
                pendingNotificationAction = "daily_card"
            }
        }
    }
}
