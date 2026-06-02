//
//  DestinyMatrixFAQView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct DestinyMatrixFAQView: View {
    @State private var expandedQuestions: Set<Int> = []
    
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
                        Text(L10n.matrixFaqTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.matrixFaqSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // FAQ items
                    VStack(alignment: .leading, spacing: 12) {
                        FAQItem(id: 0, question: L10n.matrixFaqQuestion1,  answer: L10n.matrixFaqAnswer1,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 1, question: L10n.matrixFaqQuestion2,  answer: L10n.matrixFaqAnswer2,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 2, question: L10n.matrixFaqQuestion3,  answer: L10n.matrixFaqAnswer3,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 3, question: L10n.matrixFaqQuestion4,  answer: L10n.matrixFaqAnswer4,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 4, question: L10n.matrixFaqQuestion5,  answer: L10n.matrixFaqAnswer5,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 5, question: L10n.matrixFaqQuestion6,  answer: L10n.matrixFaqAnswer6,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 6, question: L10n.matrixFaqQuestion7,  answer: L10n.matrixFaqAnswer7,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 7, question: L10n.matrixFaqQuestion8,  answer: L10n.matrixFaqAnswer8,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 8, question: L10n.matrixFaqQuestion9,  answer: L10n.matrixFaqAnswer9,  expandedQuestions: $expandedQuestions)
                        FAQItem(id: 9, question: L10n.matrixFaqQuestion10, answer: L10n.matrixFaqAnswer10, expandedQuestions: $expandedQuestions)
                    }
                    
                    // Disclaimer
                    ContentCard {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 18))
                                .foregroundColor(AppTheme.gold)
                                .padding(.top, 2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(L10n.matrixFaqDisclaimerTitle)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Text(L10n.matrixFaqDisclaimerText)
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
        DestinyMatrixFAQView()
    }
}
