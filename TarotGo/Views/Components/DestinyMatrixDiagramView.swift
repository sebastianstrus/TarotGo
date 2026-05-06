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
                    .zIndex(selectedPosition?.id == position.id ? 1 : 0)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3)) {
                            selectedPosition = position
                            selectedYear = nil // Clear year selection when position is selected
                        }
                        HapticService.shared.impact(.light)
                        SoundService.shared.play(.magicButton, volume: 0.5)
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
            // Outer circle - positioned to align with year circle centers
            Circle()
                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                .frame(width: size * 1.02, height: size * 1.02)
                .position(x: size / 2, y: size / 2)
            
            // Age markers and energy numbers - display all years 1-80
            ForEach(yearlyEnergies.filter { $0.age > 0 }, id: \.id) { yearEnergy in
                YearMarkerView(
                    yearEnergy: yearEnergy,
                    size: size,
                    isSelected: selectedYear?.id == yearEnergy.id
                )
                .zIndex(selectedYear?.id == yearEnergy.id ? 1 : 0)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        selectedYear = yearEnergy
                        selectedPosition = nil // Clear position selection when year is selected
                    }
                    HapticService.shared.impact(.light)
                    SoundService.shared.play(.magicButton, volume: 0.5)
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
        // Outer ring diameter is size * 1.02, so radius is size * 0.51
        // Position circle centers ON the ring stroke
        let ringRadius = size * 0.51
        let labelRadius = size * 0.47 // Further in for the label
        let circleX = size / 2 + ringRadius * cos(angle)
        let circleY = size / 2 + ringRadius * sin(angle)
        let labelX = size / 2 + labelRadius * cos(angle)
        let labelY = size / 2 + labelRadius * sin(angle)
        
        ZStack {
            // Circle with energy number
            ZStack {
                Circle()
                    .fill(
                        isSelected
                            ? AppTheme.goldGradient
                            : (yearEnergy.isCurrentYear
                                ? LinearGradient(colors: [AppTheme.gold.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                : LinearGradient(colors: [AppTheme.deepNavy.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    )
                    .frame(width: 11, height: 11)
                    .overlay(
                        Circle()
                            .stroke(
                                isSelected
                                    ? AppTheme.lightGold
                                    : (yearEnergy.isCurrentYear ? AppTheme.gold : AppTheme.gold.opacity(0.4)),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
                    .shadow(
                        color: isSelected ? AppTheme.gold.opacity(0.5) : .clear,
                        radius: isSelected ? 6 : 0,
                        x: 0,
                        y: 3
                    )
                
                // Energy number
                Text("\(yearEnergy.primaryEnergy)")
                    .font(.system(size: isSelected ? 7 : 5, weight: isSelected ? .bold : (yearEnergy.isCurrentYear ? .semibold : .medium), design: .rounded))
                    .foregroundColor(isSelected ? .black : (yearEnergy.isCurrentYear ? .black.opacity(0.8) : AppTheme.textPrimary))
            }
            .scaleEffect(isSelected ? 1.5 : 1.0)
            .position(x: circleX, y: circleY)
            
            // Age label positioned further out from center - show for all ages
            Text("\(yearEnergy.age)")
                .font(.system(size: 8, weight: isSelected ? .bold : .medium))
                .foregroundColor(isSelected ? AppTheme.gold : AppTheme.textTertiary.opacity(0.7))
                .position(x: labelX, y: labelY)
        }
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
