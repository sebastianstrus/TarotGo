//
//  LearnTarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct LearnTarotView: View {
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
                        Text(L10n.learnTarotTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.learnTarotSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 10)
                    
                    // Navigation options
                    VStack(spacing: 14) {
                        // 1. History of Tarot
                        NavigationLink(destination: HistoryOfTarotView()) {
                            LearnOptionButton(
                                icon: "scroll.fill",
                                title: L10n.learnHistoryTitle,
                                subtitle: L10n.learnHistorySubtitle
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // 2. Card Basic Meanings
                        NavigationLink(destination: CardBasicMeaningsView()) {
                            LearnOptionButton(
                                icon: "square.grid.2x2.fill",
                                title: L10n.learnBasicMeaningsTitle,
                                subtitle: L10n.learnBasicMeaningsSubtitle
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // 3. How to Read
                        NavigationLink(destination: HowToReadView()) {
                            LearnOptionButton(
                                icon: "book.pages.fill",
                                title: L10n.learnHowToReadTitle,
                                subtitle: L10n.learnHowToReadSubtitle
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // 4. Tarot & Mind
                        NavigationLink(destination: TarotAndMindView()) {
                            LearnOptionButton(
                                icon: "brain.head.profile.fill",
                                title: L10n.learnTarotMindTitle,
                                subtitle: L10n.learnTarotMindSubtitle
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
                        
                        // 5. FAQ
                        NavigationLink(destination: FAQView()) {
                            LearnOptionButton(
                                icon: "questionmark.circle.fill",
                                title: L10n.learnFaqTitle,
                                subtitle: L10n.learnFaqSubtitle
                            )
                        }
                        .buttonStyle(HomeButtonStyle())
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

// Reusable button component for learn options
struct LearnOptionButton: View {
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

#Preview {
    NavigationStack {
        LearnTarotView()
    }
}
