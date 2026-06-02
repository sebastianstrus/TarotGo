//
//  HowToReadMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct HowToReadMatrixView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.howToReadMatrixTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                    }
                    .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        // Step 1: Calculate Your Chart
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 1, title: L10n.howToReadMatrixStep1Title)
                                
                                Text(L10n.howToReadMatrixStep1Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadMatrixStep1Bullet1Title, text: L10n.howToReadMatrixStep1Bullet1Text)
                                BulletPoint(title: L10n.howToReadMatrixStep1Bullet2Title, text: L10n.howToReadMatrixStep1Bullet2Text)
                                
                                ProTipBox(text: L10n.howToReadMatrixStep1ProTip)
                            }
                        }
                        
                        // Step 2: Find the Central Square
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 2, title: L10n.howToReadMatrixStep2Title)
                                
                                Text(L10n.howToReadMatrixStep2Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadMatrixStep2Bullet1Title, text: L10n.howToReadMatrixStep2Bullet1Text)
                                BulletPoint(title: L10n.howToReadMatrixStep2Bullet2Title, text: L10n.howToReadMatrixStep2Bullet2Text)
                                BulletPoint(title: L10n.howToReadMatrixStep2Bullet3Title, text: L10n.howToReadMatrixStep2Bullet3Text)
                                BulletPoint(title: L10n.howToReadMatrixStep2Bullet4Title, text: L10n.howToReadMatrixStep2Bullet4Text)
                            }
                        }
                        
                        // Step 3: Read the Life Lines
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 3, title: L10n.howToReadMatrixStep3Title)
                                
                                Text(L10n.howToReadMatrixStep3Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadMatrixStep3Bullet1Title, text: L10n.howToReadMatrixStep3Bullet1Text)
                                BulletPoint(title: L10n.howToReadMatrixStep3Bullet2Title, text: L10n.howToReadMatrixStep3Bullet2Text)
                                BulletPoint(title: L10n.howToReadMatrixStep3Bullet3Title, text: L10n.howToReadMatrixStep3Bullet3Text)
                                
                                ProTipBox(text: L10n.howToReadMatrixStep3ProTip)
                            }
                        }
                        
                        // Step 4: Look at Your Mission
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 4, title: L10n.howToReadMatrixStep4Title)
                                
                                Text(L10n.howToReadMatrixStep4Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadMatrixStep4Bullet1Title, text: L10n.howToReadMatrixStep4Bullet1Text)
                                BulletPoint(title: L10n.howToReadMatrixStep4Bullet2Title, text: L10n.howToReadMatrixStep4Bullet2Text)
                            }
                        }
                        
                        // Step 5: Bring It All Together
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                StepHeader(number: 5, title: L10n.howToReadMatrixStep5Title)
                                
                                Text(L10n.howToReadMatrixStep5Intro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                BulletPoint(title: L10n.howToReadMatrixStep5Bullet1Title, text: L10n.howToReadMatrixStep5Bullet1Text)
                                BulletPoint(title: L10n.howToReadMatrixStep5Bullet2Title, text: L10n.howToReadMatrixStep5Bullet2Text)
                            }
                        }
                        
                        // Remember
                        ContentCard {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 6) {
                                    Image(systemName: "lightbulb.fill")
                                        .font(.system(size: 16))
                                        .foregroundStyle(AppTheme.goldGradient)
                                    
                                    Text(L10n.howToReadMatrixRememberTitle)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(AppTheme.goldGradient)
                                }
                                
                                Text(L10n.howToReadMatrixRememberText)
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
        HowToReadMatrixView()
    }
}
