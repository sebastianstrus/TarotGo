//
//  LearnPalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct LearnPalmistryView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 20) {
                    // Top spacing
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(spacing: 8) {
                        Text(L10n.learnPalmistryTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.learnPalmistrySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 10)
                    
                    // Navigation options
                    VStack(spacing: 14) {
                        // 1. History of Palmistry
                        NavigationLink(destination: HistoryOfPalmistryView()) {
                            LearnOptionButton(
                                icon: "scroll.fill",
                                title: L10n.learnPalmistryHistoryTitle,
                                subtitle: L10n.learnPalmistryHistorySubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 2. How to Read
                        NavigationLink(destination: HowToReadPalmView()) {
                            LearnOptionButton(
                                icon: "book.pages.fill",
                                title: L10n.learnPalmistryHowToReadTitle,
                                subtitle: L10n.learnPalmistryHowToReadSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 3. Palmistry & Mind
                        NavigationLink(destination: PalmistryAndMindView()) {
                            LearnOptionButton(
                                icon: "brain.head.profile.fill",
                                title: L10n.learnPalmistryMindTitle,
                                subtitle: L10n.learnPalmistryMindSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 4. FAQ
                        NavigationLink(destination: PalmistryFAQView()) {
                            LearnOptionButton(
                                icon: "questionmark.circle.fill",
                                title: L10n.learnPalmistryFaqTitle,
                                subtitle: L10n.learnPalmistryFaqSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                        .frame(height: 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LearnPalmistryView()
    }
}
