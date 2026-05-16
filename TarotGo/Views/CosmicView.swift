//
//  CosmicView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct CosmicView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
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
                            Image(systemName: "moon.stars.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            Text(L10n.cosmicViewTitle)
                                .font(AppTheme.serifFont(size: 36, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text(L10n.cosmicViewSubtitle)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // Cosmic options
                        VStack(spacing: 14) {
                            // Horoscope
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                // TODO: Navigate to Horoscope
                            } label: {
                                NavigationButton(
                                    icon: "sparkle.magnifyingglass",
                                    title: L10n.horoscopeTitle,
                                    subtitle: L10n.horoscopeSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .disabled(true)
                            
                            // Cosmogram
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                // TODO: Navigate to Cosmogram
                            } label: {
                                NavigationButton(
                                    icon: "circle.grid.cross.fill",
                                    title: L10n.cosmogramTitle,
                                    subtitle: L10n.cosmogramSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .disabled(true)
                            
                            // Numerology
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                // TODO: Navigate to Numerology
                            } label: {
                                NavigationButton(
                                    icon: "number.circle.fill",
                                    title: L10n.numerologyTitle,
                                    subtitle: L10n.numerologySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .disabled(true)
                            
                            // Lunar Calendar
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                // TODO: Navigate to Lunar Calendar
                            } label: {
                                NavigationButton(
                                    icon: "moon.circle.fill",
                                    title: L10n.lunarCalendarTitle,
                                    subtitle: L10n.lunarCalendarSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .disabled(true)
                            
                            // Compatibility
                            Button {
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.whoosh, volume: 0.4)
                                // TODO: Navigate to Compatibility
                            } label: {
                                NavigationButton(
                                    icon: "heart.circle.fill",
                                    title: L10n.compatibilityTitle,
                                    subtitle: L10n.compatibilitySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            .disabled(true)
                        }
                        .padding(.horizontal, 30)
                        
                        // Footer with golden accent
                        HStack(spacing: 10) {
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 35, height: 1)
                            
                            Text(L10n.cosmicViewFooter)
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
        }
    }
}

#Preview {
    CosmicView()
        .environmentObject(AppViewModel())
}
