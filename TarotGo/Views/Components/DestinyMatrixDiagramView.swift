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
    @Binding var selectedYear: YearlyEnergy?
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                // Outer ring with yearly energies
                OuterYearlyRingView(
                    yearlyEnergies: matrix.yearlyEnergies,
                    size: size,
                    selectedYear: $selectedYear
                )
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

// MARK: - Outer Yearly Ring View

struct OuterYearlyRingView: View {
    let yearlyEnergies: [YearlyEnergy]
    let size: CGFloat
    @Binding var selectedYear: YearlyEnergy?
    
    private let displayedAges = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70]
    
    var body: some View {
        ZStack {
            // Outer circle
            Circle()
                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                .frame(width: size * 0.95, height: size * 0.95)
            
            // Age markers and energy numbers
            ForEach(yearlyEnergies.filter { displayedAges.contains($0.age) }, id: \.id) { yearEnergy in
                YearMarkerView(
                    yearEnergy: yearEnergy,
                    size: size,
                    isSelected: selectedYear?.id == yearEnergy.id
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        selectedYear = yearEnergy
                    }
                    HapticService.shared.impact(.light)
                }
            }
        }
    }
}

// MARK: - Year Marker View

struct YearMarkerView: View {
    let yearEnergy: YearlyEnergy
    let size: CGFloat
    let isSelected: Bool
    
    var body: some View {
        let angle = angleForAge(yearEnergy.age)
        let radius = size * 0.475
        let x = size / 2 + radius * cos(angle)
        let y = size / 2 + radius * sin(angle)
        
        ZStack {
            // Small circle for energy number
            Circle()
                .fill(yearEnergy.isCurrentYear ? AppTheme.gold : AppTheme.deepNavy.opacity(0.6))
                .frame(width: isSelected ? 28 : 24, height: isSelected ? 28 : 24)
                .overlay(
                    Circle()
                        .stroke(
                            yearEnergy.isCurrentYear ? AppTheme.lightGold : AppTheme.gold.opacity(0.4),
                            lineWidth: isSelected ? 2 : 1
                        )
                )
            
            // Energy number
            Text("\(yearEnergy.primaryEnergy)")
                .font(.system(size: isSelected ? 11 : 10, weight: yearEnergy.isCurrentYear ? .bold : .medium, design: .rounded))
                .foregroundColor(yearEnergy.isCurrentYear ? .black : AppTheme.textPrimary)
            
            // Age label (outside the circle)
            Text("\(yearEnergy.age)")
                .font(.system(size: 9, weight: .regular))
                .foregroundColor(AppTheme.textTertiary.opacity(0.6))
                .offset(y: -18)
        }
        .position(x: x, y: y)
        .scaleEffect(isSelected ? 1.1 : 1.0)
        .animation(.spring(response: 0.2), value: isSelected)
    }
    
    /// Calculate angle for age position (clockwise from top)
    private func angleForAge(_ age: Int) -> CGFloat {
        // Start at top (270 degrees or -π/2 radians) and go clockwise
        // Full circle is 360 degrees for ages 0-70
        let maxAge: CGFloat = 70
        let progress = CGFloat(age) / maxAge
        let degrees = -90 + (progress * 360) // Start at top, go clockwise
        return degrees * .pi / 180
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedPosition: MatrixPosition?
        @State private var selectedYear: YearlyEnergy?
        let matrix: DestinyMatrix
        
        var body: some View {
            ZStack {
                AppTheme.backgroundGradient.ignoresSafeArea()
                DestinyMatrixDiagramView(
                    matrix: matrix,
                    selectedPosition: $selectedPosition,
                    selectedYear: $selectedYear
                )
                .padding(40)
            }
        }
    }
    
    let birthDate = Calendar.current.date(from: DateComponents(year: 1990, month: 5, day: 15))!
    let matrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)
    
    return PreviewWrapper(matrix: matrix)
}
