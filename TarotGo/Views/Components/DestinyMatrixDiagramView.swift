//
//  DestinyMatrixDiagramView.swift
//  TarotGo
//
//  Visual diagram representation of Destiny Matrix
//

import SwiftUI

struct DestinyMatrixDiagramView: View {
    let matrix: DestinyMatrix
    @Binding var selectedPosition: MatrixPosition?
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                // Background square frame
                Path { path in
                    let padding: CGFloat = size * 0.2
                    path.move(to: CGPoint(x: padding, y: padding))
                    path.addLine(to: CGPoint(x: size - padding, y: padding))
                    path.addLine(to: CGPoint(x: size - padding, y: size - padding))
                    path.addLine(to: CGPoint(x: padding, y: size - padding))
                    path.closeSubpath()
                }
                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 2)
                
                // Diagonal lines
                Path { path in
                    let padding: CGFloat = size * 0.2
                    // Top-left to bottom-right
                    path.move(to: CGPoint(x: padding, y: padding))
                    path.addLine(to: CGPoint(x: size - padding, y: size - padding))
                    // Top-right to bottom-left
                    path.move(to: CGPoint(x: size - padding, y: padding))
                    path.addLine(to: CGPoint(x: padding, y: size - padding))
                }
                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1.5)
                
                // Vertical and horizontal center lines
                Path { path in
                    let padding: CGFloat = size * 0.2
                    let center = size / 2
                    // Vertical
                    path.move(to: CGPoint(x: center, y: padding))
                    path.addLine(to: CGPoint(x: center, y: size - padding))
                    // Horizontal
                    path.move(to: CGPoint(x: padding, y: center))
                    path.addLine(to: CGPoint(x: size - padding, y: center))
                }
                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1.5)
                
                // Positions
                ForEach(matrix.positions) { position in
                    PositionCircleView(
                        position: position,
                        size: size,
                        isSelected: selectedPosition?.id == position.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            selectedPosition = position
                        }
                        HapticService.shared.impact(.light)
                    }
                }
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PositionCircleView: View {
    let position: MatrixPosition
    let size: CGFloat
    let isSelected: Bool
    
    private var circleSize: CGFloat {
        switch position.position {
        case .center:
            return size * 0.15
        case .personalPower, .socialRealization, .spiritualDevelopment, .planetaryInfluence:
            return size * 0.11
        default:
            return size * 0.09
        }
    }
    
    private var fontSize: CGFloat {
        switch position.position {
        case .center:
            return 24
        case .personalPower, .socialRealization, .spiritualDevelopment, .planetaryInfluence:
            return 20
        default:
            return 16
        }
    }
    
    var body: some View {
        ZStack {
            // Main circle
            Circle()
                .fill(
                    LinearGradient(
                        colors: isSelected
                            ? [AppTheme.lightGold, AppTheme.gold]
                            : [AppTheme.midNavy.opacity(0.6), AppTheme.deepNavy.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: circleSize, height: circleSize)
                .overlay(
                    Circle()
                        .stroke(
                            isSelected ? AppTheme.lightGold : AppTheme.gold.opacity(0.6),
                            lineWidth: isSelected ? 3 : 2
                        )
                )
                .shadow(
                    color: isSelected ? AppTheme.gold.opacity(0.4) : AppTheme.gold.opacity(0.2),
                    radius: isSelected ? 8 : 6,
                    x: 0,
                    y: 4
                )
            
            // Number
            Text("\(position.number)")
                .font(.system(size: fontSize, weight: .bold, design: .rounded))
                .foregroundColor(isSelected ? .black : AppTheme.textPrimary)
        }
        .position(
            x: position.x * size,
            y: position.y * size
        )
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedPosition: MatrixPosition?
        let matrix: DestinyMatrix
        
        var body: some View {
            ZStack {
                AppTheme.backgroundGradient.ignoresSafeArea()
                DestinyMatrixDiagramView(matrix: matrix, selectedPosition: $selectedPosition)
                    .padding(40)
            }
        }
    }
    
    let birthDate = Calendar.current.date(from: DateComponents(year: 1990, month: 5, day: 15))!
    let matrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)
    
    return PreviewWrapper(matrix: matrix)
}
