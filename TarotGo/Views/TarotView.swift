//
//  TarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct TarotView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateToNewReading: Bool = false
    @State private var navigateToDailyCard: Bool = false
    
    var body: some View {
        NavigationStack(path: $appViewModel.navigationPath) {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Top spacing for safe area
                        Spacer()
                            .frame(height: 10)
                        
                        // Section title with gold styling
                        VStack(spacing: 10) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 50))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            Text(L10n.tarotViewTitle)
                                .font(AppTheme.serifFont(size: 36, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text(L10n.tarotViewSubtitle)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // Tarot options
                        VStack(spacing: 14) {
                            // New reading
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                navigateToNewReading = true
                            } label: {
                                NavigationButton(
                                    icon: "sparkles",
                                    title: L10n.homeNewReading,
                                    subtitle: L10n.homeNewReadingSubtitle
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // Destiny Matrix
                            NavigationLink(destination: DestinyMatrixInputView()
                                .toolbar(.hidden, for: .tabBar)) {
                                NavigationButton(
                                    icon: "star.circle.fill",
                                    title: L10n.homeDestinyMatrix,
                                    subtitle: L10n.homeDestinyMatrixSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            
                            // Card of the day
                            NavigationLink(destination: CardOfTheDayView()) {
                                NavigationButton(
                                    icon: "sun.max.fill",
                                    title: L10n.homeCardOfDay,
                                    subtitle: L10n.homeCardOfDaySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            
                            // Card Dictionary
                            NavigationLink(destination: CardDictionaryView()) {
                                NavigationButton(
                                    icon: "books.vertical.fill",
                                    title: L10n.homeCardDictionary,
                                    subtitle: L10n.homeCardDictionarySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            
                            // History
                            NavigationLink(destination: HistoryView()) {
                                NavigationButton(
                                    icon: "book.fill",
                                    title: L10n.homeHistory,
                                    subtitle: L10n.homeHistorySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            
                            // Learn Tarot
                            NavigationLink(destination: LearnTarotView()) {
                                NavigationButton(
                                    icon: "graduationcap.fill",
                                    title: L10n.homeLearnTarot,
                                    subtitle: L10n.homeLearnTarotSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
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
                NewReadingView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .navigationDestination(isPresented: $navigateToDailyCard) {
                CardOfTheDayView()
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    navigateToNewReading = false
                }
            }
            .onReceive(appViewModel.$shouldNavigateToDailyCard) { shouldNavigate in
                if shouldNavigate {
                    navigateToDailyCard = true
                    // Reset the trigger
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appViewModel.shouldNavigateToDailyCard = false
                    }
                }
            }
        }
    }
}

#Preview {
    TarotView()
        .environmentObject(AppViewModel())
}
