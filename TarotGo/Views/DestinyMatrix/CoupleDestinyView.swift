//
//  CoupleDestinyView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/9/26.
//

import SwiftUI

struct CoupleDestinyView: View {
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            VStack(spacing: 16) {
                Image(systemName: "heart.circle.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

                Text(L10n.homeCoupleDestiny)
                    .font(AppTheme.serifFont(size: 32, weight: .regular))
                    .foregroundStyle(AppTheme.goldGradient)

                Text(L10n.comingSoon)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CoupleDestinyView()
}
