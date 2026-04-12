//
//  LoadingView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct LoadingView: View {
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    
    let message: String
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 3)
                    .frame(width: 60, height: 60)
                
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        LinearGradient(
                            colors: [Color.purple, Color.blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                    .frame(width: 60, height: 60)
                    .rotationEffect(.degrees(rotation))
                
                Image(systemName: "sparkles")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .scaleEffect(scale)
            }
            
            Text(message)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.white.opacity(0.8))
        }
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                rotation = 360
            }
            
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                scale = 1.3
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        LoadingView(message: "Drawing your cards...")
    }
}
