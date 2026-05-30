//
//  PalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct PalmistryView: View {
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
                            Image(systemName: "hand.raised.palm.facing.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            Text(L10n.palmistryViewTitle)
                                .font(AppTheme.serifFont(size: 36, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text(L10n.palmistryViewSubtitle)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // Palmistry options
                        VStack(spacing: 14) {
                            // Palm Reading
                            NavigationLink(destination: PalmReadingView()
                                .toolbar(.hidden, for: .tabBar)
                            ) {
                                NavigationButton(
                                    icon: "hand.raised.palm.facing.fill",
                                    title: L10n.palmReadingTitle,
                                    subtitle: L10n.palmReadingSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                            
                            // Learn Palmistry
                            NavigationLink(destination: LearnPalmistryView()) {
                                NavigationButton(
                                    icon: "book.pages.fill",
                                    title: L10n.learnPalmistryTitle,
                                    subtitle: L10n.learnPalmistrySubtitle
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
                            
                            Text(L10n.palmistryViewFooter)
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
    PalmistryView()
        .environmentObject(AppViewModel())
}
