//
//  HomeView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateToNewReading: Bool = false
    @State private var navigateToHistory: Bool = false
    @State private var navigateToDailyCard: Bool = false
    @State private var navigateToSettings: Bool = false
    
    var body: some View {
        NavigationStack(path: $appViewModel.navigationPath) {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Top spacing for safe area
                        Spacer()
                            .frame(height: 40)
                        
                        // App title with gold styling
                        VStack(spacing: 10) {
                            // App icon image
                            Image("tarotgo512")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 85, height: 85)
                                .cornerRadius(18)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(AppTheme.goldGradient, lineWidth: 2)
                                )
                                .shadow(color: AppTheme.gold.opacity(0.3), radius: 10, x: 0, y: 5)
                            
                            Text(L10n.homeTitle)
                                .font(AppTheme.serifFont(size: 40, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text(L10n.homeSubtitle)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // Main actions
                        VStack(spacing: 14) {
                            // New reading
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                navigateToNewReading = true
                            } label: {
                                HomeButton(
                                    icon: "sparkles",
                                    title: L10n.homeNewReading,
                                    subtitle: L10n.homeNewReadingSubtitle
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Card of the day
                            NavigationLink(destination: CardOfTheDayView()) {
                                HomeButton(
                                    icon: "sun.max.fill",
                                    title: L10n.homeCardOfDay,
                                    subtitle: L10n.homeCardOfDaySubtitle
                                )
                            }
                            .buttonStyle(HomeButtonStyle())
                            
                            // History
                            NavigationLink(destination: HistoryView()) {
                                HomeButton(
                                    icon: "book.fill",
                                    title: L10n.homeHistory,
                                    subtitle: L10n.homeHistorySubtitle
                                )
                            }
                            .buttonStyle(HomeButtonStyle())
                            
                            // Settings
                            NavigationLink(destination: SettingsView()) {
                                HomeButton(
                                    icon: "gearshape.fill",
                                    title: L10n.homeSettings,
                                    subtitle: L10n.homeSettingsSubtitle
                                )
                            }
                            .buttonStyle(HomeButtonStyle())
                        }
                        .padding(.horizontal, 30)
                        
                        // Footer with golden accent
                        HStack(spacing: 10) {
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 35, height: 1)
                            
                            Text(L10n.homeFooter)
                                .font(AppTheme.serifFont(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                            
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 35, height: 1)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToNewReading) {
                OnboardingView()
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToNewReading = false
                }
            }
        }
    }
}

struct HomeButton: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 14) {
            // Gold icon background
            ZStack {
                Circle()
                    .fill(AppTheme.cardGradient)
                    .frame(width: 46, height: 46)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.5)
                    )
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(AppTheme.goldGradient)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(subtitle)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.gold.opacity(0.6))
        }
        .padding(16)
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
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    HapticService.shared.impact(.light)
                }
            }
    }
}

#Preview {
    HomeView()
}
