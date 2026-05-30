//
//  HowToReadPalmView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/17/26.
//

import SwiftUI

struct HowToReadPalmView: View {
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
                        Text(L10n.howToReadPalmTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                    .padding(.bottom, 10)
                    
                    // Content sections
                    VStack(alignment: .leading, spacing: 18) {
                        // Step 1: Choose the Hand
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 1, title: L10n.howToReadPalmStep1Title)
                                
                                Text(L10n.howToReadPalmStep1Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadPalmStep1Bullet1Title, text: L10n.howToReadPalmStep1Bullet1Text)
                                BulletPoint(title: L10n.howToReadPalmStep1Bullet2Title, text: L10n.howToReadPalmStep1Bullet2Text)
                                
                                ProTipBox(text: L10n.howToReadPalmStep1ProTip)
                            }
                        }
                        
                        // Step 2: Examine the Hand Shape
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 2, title: L10n.howToReadPalmStep2Title)
                                
                                Text(L10n.howToReadPalmStep2Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadPalmStep2Bullet1Title, text: L10n.howToReadPalmStep2Bullet1Text)
                                BulletPoint(title: L10n.howToReadPalmStep2Bullet2Title, text: L10n.howToReadPalmStep2Bullet2Text)
                                BulletPoint(title: L10n.howToReadPalmStep2Bullet3Title, text: L10n.howToReadPalmStep2Bullet3Text)
                                BulletPoint(title: L10n.howToReadPalmStep2Bullet4Title, text: L10n.howToReadPalmStep2Bullet4Text)
                            }
                        }
                        
                        // Step 3: Read the Major Lines
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 3, title: L10n.howToReadPalmStep3Title)
                                
                                Text(L10n.howToReadPalmStep3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadPalmStep3Bullet1Title, text: L10n.howToReadPalmStep3Bullet1Text)
                                BulletPoint(title: L10n.howToReadPalmStep3Bullet2Title, text: L10n.howToReadPalmStep3Bullet2Text)
                                BulletPoint(title: L10n.howToReadPalmStep3Bullet3Title, text: L10n.howToReadPalmStep3Bullet3Text)
                                
                                ProTipBox(text: L10n.howToReadPalmStep3ProTip)
                            }
                        }
                        
                        // Step 4: Study the Mounts
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 4, title: L10n.howToReadPalmStep4Title)
                                
                                Text(L10n.howToReadPalmStep4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadPalmStep4Bullet1Title, text: L10n.howToReadPalmStep4Bullet1Text)
                                BulletPoint(title: L10n.howToReadPalmStep4Bullet2Title, text: L10n.howToReadPalmStep4Bullet2Text)
                            }
                        }
                        
                        // Step 5: Interpret Together
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 5, title: L10n.howToReadPalmStep5Title)
                                
                                Text(L10n.howToReadPalmStep5Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadPalmStep5Bullet1Title, text: L10n.howToReadPalmStep5Bullet1Text)
                                BulletPoint(title: L10n.howToReadPalmStep5Bullet2Title, text: L10n.howToReadPalmStep5Bullet2Text)
                            }
                        }
                        
                        // Conclusion
                        ContentCard {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(AppTheme.goldGradient)
                                    
                                    Text(L10n.howToReadPalmRememberTitle)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(AppTheme.goldGradient)
                                }
                                
                                Text(L10n.howToReadPalmRememberText)
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

#Preview {
    NavigationStack {
        HowToReadPalmView()
    }
}
