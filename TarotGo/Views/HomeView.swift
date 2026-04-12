//
//  HomeView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct HomeView: View {
    @State private var navigateToOnboarding: Bool = false
    @State private var navigateToHistory: Bool = false
    @State private var navigateToDailyCard: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedBackgroundView()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // App title
                    VStack(spacing: 10) {
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white.opacity(0.8))
                        
                        Text("TarotGo")
                            .font(.system(size: 48, weight: .thin, design: .serif))
                            .foregroundColor(.white)
                        
                        Text("Your personal tarot companion")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    // Main actions
                    VStack(spacing: 20) {
                        // New reading
                        NavigationLink(destination: OnboardingView()) {
                            HomeButton(
                                icon: "sparkles",
                                title: "New Reading",
                                subtitle: "Discover what the cards reveal"
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // Card of the day
                        NavigationLink(destination: CardOfTheDayView()) {
                            HomeButton(
                                icon: "sun.max.fill",
                                title: "Card of the Day",
                                subtitle: "Today's guidance and insight"
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // History
                        NavigationLink(destination: HistoryView()) {
                            HomeButton(
                                icon: "book.fill",
                                title: "Reading History",
                                subtitle: "Review your past readings"
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // Settings
                        NavigationLink(destination: SettingsView()) {
                            HomeButton(
                                icon: "gearshape.fill",
                                title: "Settings",
                                subtitle: "Configure notifications and preferences"
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // Footer
                    Text("The cards are waiting for you")
                        .font(.system(size: 14, weight: .light, design: .serif))
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.bottom, 30)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeButton: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.5))
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .contentShape(Rectangle())
    }
}

struct HomeButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue {
                    HapticService.shared.impact(.light)
                }
            }
    }
}

#Preview {
    HomeView()
}
