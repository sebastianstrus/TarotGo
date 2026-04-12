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
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 30) {
                        // Top spacing for safe area
                        Spacer()
                            .frame(height: 60)
                        
                        // App title with gold styling
                        VStack(spacing: 15) {
                            // App icon image
                            Image("tarotgo512")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100)
                                .cornerRadius(22)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 22)
                                        .stroke(AppTheme.goldGradient, lineWidth: 2)
                                )
                                .shadow(color: AppTheme.gold.opacity(0.3), radius: 15, x: 0, y: 8)
                            
                            Text("TarotGo")
                                .font(AppTheme.serifFont(size: 48, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            HStack(spacing: 8) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 8))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text("Your personal tarot companion")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 8))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 20)
                        
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
                        
                        // Footer with golden accent
                        HStack(spacing: 12) {
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 40, height: 1)
                            
                            Text("The cards are waiting for you")
                                .font(AppTheme.serifFont(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                            
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 40, height: 1)
                        }
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                    }
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
            // Gold icon background
            ZStack {
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.5)
                    )
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundStyle(AppTheme.goldGradient)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16))
                .foregroundColor(AppTheme.gold.opacity(0.6))
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
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
