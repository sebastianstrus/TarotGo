//
//  PalmistryFAQView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/17/26.
//

import SwiftUI

struct PalmistryFAQView: View {
    @State private var expandedQuestions: Set<Int> = []
    
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
                        Text(L10n.palmistryFaqTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.palmistryFaqSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // FAQ items
                    VStack(alignment: .leading, spacing: 12) {
                        FAQItem(
                            id: 0,
                            question: L10n.palmistryFaqQuestion1,
                            answer: L10n.palmistryFaqAnswer1,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 1,
                            question: L10n.palmistryFaqQuestion2,
                            answer: L10n.palmistryFaqAnswer2,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 2,
                            question: L10n.palmistryFaqQuestion3,
                            answer: L10n.palmistryFaqAnswer3,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 3,
                            question: L10n.palmistryFaqQuestion4,
                            answer: L10n.palmistryFaqAnswer4,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 4,
                            question: L10n.palmistryFaqQuestion5,
                            answer: L10n.palmistryFaqAnswer5,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 5,
                            question: L10n.palmistryFaqQuestion6,
                            answer: L10n.palmistryFaqAnswer6,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 6,
                            question: L10n.palmistryFaqQuestion7,
                            answer: L10n.palmistryFaqAnswer7,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 7,
                            question: L10n.palmistryFaqQuestion8,
                            answer: L10n.palmistryFaqAnswer8,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 8,
                            question: L10n.palmistryFaqQuestion9,
                            answer: L10n.palmistryFaqAnswer9,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 9,
                            question: L10n.palmistryFaqQuestion10,
                            answer: L10n.palmistryFaqAnswer10,
                            expandedQuestions: $expandedQuestions
                        )
                    }
                    
                    // Disclaimer
                    ContentCard {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.gold)
                                .padding(.top, 2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(L10n.palmistryFaqDisclaimerTitle)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Text(L10n.palmistryFaqDisclaimerText)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .lineSpacing(4)
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
        PalmistryFAQView()
    }
}
