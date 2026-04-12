//
//  TarotGoApp.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData

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
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
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
    }
}
