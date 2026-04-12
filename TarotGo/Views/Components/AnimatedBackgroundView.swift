//
//  AnimatedBackgroundView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var animateGradient = false
    
    var body: some View {
        ZStack {
            // Elegant dark gradient matching app icon
            AppTheme.backgroundGradient
                .ignoresSafeArea()
            
            // Subtle texture overlay - simplified with slower animation
            Rectangle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppTheme.deepNavy.opacity(0.2),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 100,
                        endRadius: 400
                    )
                )
                .ignoresSafeArea()
                .offset(y: animateGradient ? -30 : 30)
                .animation(.easeInOut(duration: 15).repeatForever(autoreverses: true), value: animateGradient)
            
            // Static golden stars with subtle opacity variation
            Canvas { context, size in
                // Draw stars using a seeded random for consistent positions
                var rng = SeededRandom(seed: 12345)
                
                for i in 0..<30 { // Reduced from 60 to 30 stars
                    let isGold = i % 5 == 0 // 20% golden stars (reduced from 25%)
                    let x = rng.next(max: size.width)
                    let y = rng.next(max: size.height)
                    let starSize = isGold ? rng.next(min: 3, max: 6) : rng.next(min: 1, max: 3)
                    let opacity = rng.next(min: 0.4, max: 0.7)
                    
                    let starColor = isGold ? AppTheme.gold.opacity(opacity) : Color.white.opacity(opacity * 0.6)
                    
                    context.fill(
                        Circle().path(in: CGRect(x: x, y: y, width: starSize, height: starSize)),
                        with: .color(starColor)
                    )
                }
            }
        }
        .onAppear {
            animateGradient = true
        }
    }
}

// Simple seeded random for consistent star positions
private struct SeededRandom {
    private var state: UInt64
    
    init(seed: UInt64) {
        state = seed
    }
    
    mutating func next(min: CGFloat = 0, max: CGFloat) -> CGFloat {
        state = state &* 6364136223846793005 &+ 1442695040888963407
        let value = Double(state) / Double(UInt64.max)
        return min + CGFloat(value) * (max - min)
    }
}
