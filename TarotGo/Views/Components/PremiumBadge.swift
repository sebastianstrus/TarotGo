//
//  PremiumBadge.swift
//  TarotGo
//
//  Subtle gold pill indicating a feature requires a Premium subscription.
//

import SwiftUI

struct PremiumBadge: View {
    enum Size {
        case small
        case regular

        var iconSize: CGFloat {
            switch self {
            case .small: return 6
            case .regular: return 8
            }
        }

        var fontSize: CGFloat {
            switch self {
            case .small: return 7
            case .regular: return 8.5
            }
        }

        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 5
            case .regular: return 7
            }
        }

        var verticalPadding: CGFloat {
            switch self {
            case .small: return 2
            case .regular: return 3
            }
        }
    }

    var size: Size = .regular
    var iconOnly: Bool = false

    var body: some View {
        HStack(spacing: iconOnly ? 0 : 3) {
            Image(systemName: "crown.fill")
                .font(.system(size: size.iconSize, weight: .semibold))
                .foregroundStyle(AppTheme.goldGradient)

            if !iconOnly {
                Text("PREMIUM")
                    .font(.system(size: size.fontSize, weight: .bold, design: .serif))
                    .tracking(0.6)
                    .foregroundStyle(AppTheme.goldGradient)
            }
        }
        .padding(.horizontal, size.horizontalPadding)
        .padding(.vertical, size.verticalPadding)
        .background(
            Capsule()
                .fill(AppTheme.deepNavy.opacity(0.85))
                .overlay(
                    Capsule()
                        .stroke(AppTheme.gold.opacity(0.65), lineWidth: 0.6)
                )
        )
        .shadow(color: AppTheme.gold.opacity(0.35), radius: 3)
        .accessibilityLabel(Text("Premium feature"))
    }
}

#Preview {
    ZStack {
        AppTheme.deepNavy.ignoresSafeArea()
        VStack(spacing: 16) {
            PremiumBadge(size: .small)
            PremiumBadge(size: .regular)
            PremiumBadge(size: .regular, iconOnly: true)
        }
    }
}
