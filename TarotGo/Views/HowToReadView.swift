//
//  HowToReadView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct HowToReadView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Top spacing
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.howToReadTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 18) {
                        // Step 1: Focus on Your Question
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 1, title: L10n.howToReadStep1Title)
                                
                                Text(L10n.howToReadStep1Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                Text(L10n.howToReadStep1Example)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .italic()
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(AppTheme.gold.opacity(0.1))
                                    )
                                
                                ProTipBox(text: L10n.howToReadStep1ProTip)
                            }
                        }
                        
                        // Step 2: Draw Your Cards
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 2, title: L10n.howToReadStep2Title)
                                
                                Text(L10n.howToReadStep2Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadStep2Bullet1Title, text: L10n.howToReadStep2Bullet1Text)
                                BulletPoint(title: L10n.howToReadStep2Bullet2Title, text: L10n.howToReadStep2Bullet2Text)
                            }
                        }
                        
                        // Step 3: Interpret the Message
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 3, title: L10n.howToReadStep3Title)
                                
                                Text(L10n.howToReadStep3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadStep3Bullet1Title, text: L10n.howToReadStep3Bullet1Text)
                                BulletPoint(title: L10n.howToReadStep3Bullet2Title, text: L10n.howToReadStep3Bullet2Text)
                                
                                ProTipBox(text: L10n.howToReadStep3ProTip)
                            }
                        }
                        
                        // Step 4: Reflect
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 4, title: L10n.howToReadStep4Title)
                                
                                Text(L10n.howToReadStep4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadStep4Bullet1Title, text: L10n.howToReadStep4Bullet1Text)
                                BulletPoint(title: L10n.howToReadStep4Bullet2Title, text: L10n.howToReadStep4Bullet2Text)
                            }
                        }
                        
                        // Conclusion
                        ContentCard {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(AppTheme.goldGradient)
                                    
                                    Text(L10n.howToReadRememberTitle)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(AppTheme.goldGradient)
                                }
                                
                                Text(L10n.howToReadRememberText)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StepHeader: View {
    let number: Int
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            // Step number circle
            ZStack {
                Circle()
                    .fill(AppTheme.goldGradient)
                    .frame(width: 32, height: 32)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 4)
                
                Text("\(number)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
            }
            
            Text(title)
                .font(AppTheme.serifFont(size: 20, weight: .semibold))
                .foregroundStyle(AppTheme.goldGradient)
        }
        .padding(.bottom, 4)
    }
}

struct ProTipBox: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "star.circle.fill")
                .font(.system(size: 18))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(L10n.howToReadProTipLabel)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(text)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineSpacing(4)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppTheme.gold.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        HowToReadView()
    }
}
