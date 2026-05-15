//
//  NavigationButton.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

/// A reusable button component for navigation with elegant styling
struct NavigationButton: View {
    let icon: String
    let title: String
    let subtitle: String
    var isComingSoon: Bool = false
    
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
            .opacity(isComingSoon ? 0.5 : 1.0)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(title)
                        .font(AppTheme.serifFont(size: 18, weight: .medium))
                        .foregroundColor(isComingSoon ? AppTheme.textSecondary : AppTheme.textPrimary)
                    
                    if isComingSoon {
                        Text(L10n.comingSoon)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(AppTheme.gold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(AppTheme.gold.opacity(0.15))
                            )
                    }
                }
                
                Text(subtitle)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.gold.opacity(isComingSoon ? 0.3 : 0.6))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(isComingSoon ? 0.15 : 0.3), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(isComingSoon ? 0.05 : 0.1), radius: 10, x: 0, y: 5)
        )
        .contentShape(Rectangle())
        .opacity(isComingSoon ? 0.7 : 1.0)
    }
}

struct NavigationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    HapticService.shared.impact(.light)
                }
            }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 16) {
            NavigationButton(
                icon: "sparkles",
                title: "New Reading",
                subtitle: "Start a new tarot reading"
            )
            
            NavigationButton(
                icon: "moon.stars.fill",
                title: "Horoscope",
                subtitle: "Your daily horoscope",
                isComingSoon: true
            )
        }
        .padding()
    }
}
