//
//  LearnDestinyMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct LearnDestinyMatrixView: View {
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
                        Text(L10n.learnDestinyMatrixTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.learnDestinyMatrixSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 10)
                    
                    // Navigation options
                    VStack(spacing: 14) {
                        // 1. History of the Matrix
                        NavigationLink(destination: HistoryOfDestinyMatrixView()) {
                            LearnOptionButton(
                                icon: "ic_matrix_learn_history",
                                title: L10n.learnDestinyMatrixHistoryTitle,
                                subtitle: L10n.learnDestinyMatrixHistorySubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 2. The 22 Energies
                        NavigationLink(destination: DestinyMatrixBasicMeaningsView()) {
                            LearnOptionButton(
                                icon: "ic_matrix_learn_energies",
                                title: L10n.learnDestinyMatrixBasicMeaningsTitle,
                                subtitle: L10n.learnDestinyMatrixBasicMeaningsSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 3. How to Read Your Matrix
                        NavigationLink(destination: HowToReadMatrixView()) {
                            LearnOptionButton(
                                icon: "ic_matrix_learn_how_to_read",
                                title: L10n.learnDestinyMatrixHowToReadTitle,
                                subtitle: L10n.learnDestinyMatrixHowToReadSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 4. Matrix & Mind
                        NavigationLink(destination: DestinyMatrixAndMindView()) {
                            LearnOptionButton(
                                icon: "ic_matrix_learn_mind",
                                title: L10n.learnDestinyMatrixMindTitle,
                                subtitle: L10n.learnDestinyMatrixMindSubtitle
                            )
                        }
                        .buttonStyle(MainButtonStyle())
                        
                        // 5. FAQ
                        NavigationLink(destination: DestinyMatrixFAQView()) {
                            LearnOptionButton(
                                icon: "ic_faq",
                                title: L10n.learnDestinyMatrixFaqTitle,
                                subtitle: L10n.learnDestinyMatrixFaqSubtitle
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
        LearnDestinyMatrixView()
    }
}
