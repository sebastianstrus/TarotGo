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
                    selectedYear: $selectedYear,
                    selectedPosition: $selectedPosition
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
                            selectedYear = nil // Clear year selection when position is selected
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
    @Binding var selectedPosition: MatrixPosition?
    
    var body: some View {
        ZStack {
            // Outer circle - slightly larger to accommodate all years
            Circle()
                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                .frame(width: size * 0.98, height: size * 0.98)
            
            // Age markers and energy numbers - display all years 1-80
            ForEach(yearlyEnergies.filter { $0.age > 0 }, id: \.id) { yearEnergy in
                YearMarkerView(
                    yearEnergy: yearEnergy,
                    size: size,
                    isSelected: selectedYear?.id == yearEnergy.id
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        selectedYear = yearEnergy
                        selectedPosition = nil // Clear position selection when year is selected
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
        let radius = size * 0.49 // Slightly larger radius for the ring
        let x = size / 2 + radius * cos(angle)
        let y = size / 2 + radius * sin(angle)
        
        ZStack {
            // Smaller circle for energy number to fit all 80 years
            Circle()
                .fill(
                    isSelected
                        ? AppTheme.goldGradient
                        : (yearEnergy.isCurrentYear
                            ? LinearGradient(colors: [AppTheme.gold.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                            : LinearGradient(colors: [AppTheme.deepNavy.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                )
                .frame(width: 16, height: 16) // Reduced from 26 to 16
                .overlay(
                    Circle()
                        .stroke(
                            isSelected
                                ? AppTheme.lightGold
                                : (yearEnergy.isCurrentYear ? AppTheme.gold : AppTheme.gold.opacity(0.4)),
                            lineWidth: isSelected ? 2 : 1 // Reduced stroke width
                        )
                )
                .shadow(
                    color: isSelected ? AppTheme.gold.opacity(0.5) : .clear,
                    radius: isSelected ? 6 : 0, // Reduced shadow radius
                    x: 0,
                    y: 3
                )
            
            // Energy number - smaller font
            Text("\(yearEnergy.primaryEnergy)")
                .font(.system(size: 7, weight: isSelected ? .bold : (yearEnergy.isCurrentYear ? .semibold : .medium), design: .rounded)) // Reduced from 11 to 7
                .foregroundColor(isSelected ? .black : (yearEnergy.isCurrentYear ? .black.opacity(0.8) : AppTheme.textPrimary))
            
            // Age label (outside the circle) - only show for multiples of 5
            if yearEnergy.age % 5 == 0 {
                Text("\(yearEnergy.age)")
                    .font(.system(size: 7, weight: isSelected ? .semibold : .regular)) // Reduced from 9 to 7
                    .foregroundColor(isSelected ? AppTheme.gold : AppTheme.textTertiary.opacity(0.6))
                    .offset(y: -12) // Adjusted offset for smaller circle
            }
        }
        .position(x: x, y: y)
        .animation(.spring(response: 0.2), value: isSelected)
    }
    
    /// Calculate angle for age position (clockwise from top)
    private func angleForAge(_ age: Int) -> CGFloat {
        // Start at top (270 degrees or -π/2 radians) and go clockwise
        // Full circle is 360 degrees for ages 0-80
        let maxAge: CGFloat = 80
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
