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
            // Delay slightly to ensure view hierarchy is ready
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("📱 Setting shouldNavigateToDailyCard = true")
                self.shouldNavigateToDailyCard = true
            }
        }
        
        pendingNotificationAction = nil
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
}
