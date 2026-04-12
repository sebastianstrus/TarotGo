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
            // Base dark gradient
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.0, blue: 0.2),
                    Color(red: 0.05, green: 0.0, blue: 0.15),
                    Color.black
                ],
                startPoint: animateGradient ? .topLeading : .bottomLeading,
                endPoint: animateGradient ? .bottomTrailing : .topTrailing
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 8).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
            
            // Particles/stars
            GeometryReader { geometry in
                ForEach(0..<50, id: \.self) { index in
                    Circle()
                        .fill(Color.white.opacity(Double.random(in: 0.1...0.4)))
                        .frame(width: CGFloat.random(in: 1...3))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
            }
        }
    }
}
