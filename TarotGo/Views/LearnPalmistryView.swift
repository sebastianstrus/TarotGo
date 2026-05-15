//
//  LearnPalmistryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct LearnPalmistryView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "book.pages.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                    
                    Text(L10n.learnPalmistryTitle)
                        .font(AppTheme.serifFont(size: 32, weight: .regular))
                        .foregroundStyle(AppTheme.goldGradient)
                        .multilineTextAlignment(.center)
                    
                    Text(L10n.learnPalmistryComingSoon)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                // Content will be added later
                Text(L10n.learnPalmistryDescription)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    dismiss()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text(L10n.back)
                            .font(.system(size: 17))
                    }
                    .foregroundColor(AppTheme.gold)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LearnPalmistryView()
    }
}
