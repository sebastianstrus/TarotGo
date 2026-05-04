//
//  FAQView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/4/26.
//

import SwiftUI

struct FAQView: View {
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
                        Text(L10n.faqTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.faqSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // FAQ items
                    VStack(alignment: .leading, spacing: 12) {
                        FAQItem(
                            id: 0,
                            question: L10n.faqQuestion1,
                            answer: L10n.faqAnswer1,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 1,
                            question: L10n.faqQuestion2,
                            answer: L10n.faqAnswer2,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 2,
                            question: L10n.faqQuestion3,
                            answer: L10n.faqAnswer3,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 3,
                            question: L10n.faqQuestion4,
                            answer: L10n.faqAnswer4,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 4,
                            question: L10n.faqQuestion5,
                            answer: L10n.faqAnswer5,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 5,
                            question: L10n.faqQuestion6,
                            answer: L10n.faqAnswer6,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 6,
                            question: L10n.faqQuestion7,
                            answer: L10n.faqAnswer7,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 7,
                            question: L10n.faqQuestion8,
                            answer: L10n.faqAnswer8,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 8,
                            question: L10n.faqQuestion9,
                            answer: L10n.faqAnswer9,
                            expandedQuestions: $expandedQuestions
                        )
                        
                        FAQItem(
                            id: 9,
                            question: L10n.faqQuestion10,
                            answer: L10n.faqAnswer10,
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
                                Text(L10n.faqDisclaimerTitle)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Text(L10n.faqDisclaimerText)
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

struct FAQItem: View {
    let id: Int
    let question: String
    let answer: String
    @Binding var expandedQuestions: Set<Int>
    
    private var isExpanded: Bool {
        expandedQuestions.contains(id)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                withAnimation(.spring(response: 0.3)) {
                    if isExpanded {
                        expandedQuestions.remove(id)
                    } else {
                        expandedQuestions.insert(id)
                    }
                    HapticService.shared.impact(.light)
                }
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: isExpanded ? "chevron.down.circle.fill" : "chevron.right.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(AppTheme.goldGradient)
                        .rotationEffect(.degrees(0))
                    
                    Text(question)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppTheme.cardGradient)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    Text(answer)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(AppTheme.textSecondary)
                        .lineSpacing(5)
                        .padding(16)
                        .padding(.top, 4)
                }
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppTheme.gold.opacity(0.05))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.top, 4)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
    }
}

#Preview {
    NavigationStack {
        FAQView()
    }
}
