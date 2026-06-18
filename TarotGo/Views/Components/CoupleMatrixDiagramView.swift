//
//  CoupleMatrixDiagramView.swift
//  TarotGo
//
//  Visual diagram representation of the Couple Matrix
//

import SwiftUI

struct CoupleMatrixDiagramView: View {
    let matrix: CoupleMatrix
    @Binding var selectedPosition: CoupleMatrixPosition?
    var selectedYear: Binding<CoupleYearlyEnergy?>? = nil
    var showsYearlyRing: Bool = true
    var pdfMode: Bool = false

    private let partnerAAccent = Color(red: 232/255, green: 120/255, blue: 160/255)
    private let partnerBAccent = Color(red: 110/255, green: 160/255, blue: 235/255)

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            ZStack {
                // 1. Outer yearly couple energy ring
                if showsYearlyRing, let yearBinding = selectedYear {
                    CoupleYearlyRingView(
                        yearlyEnergies: matrix.yearlyEnergies,
                        size: size,
                        selectedYear: yearBinding,
                        selectedPosition: $selectedPosition,
                        pdfMode: pdfMode
                    )
                }

                // 2. Decorative concentric outer rings
                Circle()
                    .stroke(AppTheme.gold.opacity(0.28), lineWidth: 1.4)
                    .frame(width: size * 0.94, height: size * 0.94)
                Circle()
                    .stroke(AppTheme.gold.opacity(0.12), lineWidth: 0.7)
                    .frame(width: size * 0.98, height: size * 0.98)

                // 3. Star of David — sacred symbol of two souls united
                CoupleStarOfDavidShape(
                    size: size,
                    upwardColor: partnerAAccent,
                    downwardColor: partnerBAccent
                )

                // 4. Vesica Piscis — two overlapping circles forming the mandorla
                CoupleVesicaPiscisShape(
                    size: size,
                    partnerAColor: partnerAAccent,
                    partnerBColor: partnerBAccent
                )

                // 5. Aspect connection lines
                CoupleConnectionLinesShape(size: size)

                // 6. Heart glyph centered behind the Union
                Image(systemName: "heart.fill")
                    .font(.system(size: size * 0.085))
                    .foregroundStyle(AppTheme.goldGradient)
                    .opacity(0.18)
                    .position(x: size * 0.50, y: size * 0.50)

                // 7. Partner banners above their core circles
                CouplePartnerBannerView(
                    text: L10n.coupleMatrixPartnerA,
                    systemImage: "person.fill",
                    accent: partnerAAccent
                )
                .position(x: size * 0.22, y: size * 0.085)

                CouplePartnerBannerView(
                    text: L10n.coupleMatrixPartnerB,
                    systemImage: "person.fill",
                    accent: partnerBAccent
                )
                .position(x: size * 0.78, y: size * 0.085)

                // 8. Position circles with subtle aspect labels
                ForEach(matrix.positions) { position in
                    CoupleMatrixPositionCircle(
                        position: position,
                        size: size,
                        isSelected: selectedPosition?.id == position.id,
                        partnerAAccent: partnerAAccent,
                        partnerBAccent: partnerBAccent,
                        pdfMode: pdfMode
                    )
                    .zIndex(selectedPosition?.id == position.id ? 1 : 0)
                    .onTapGesture {
                        let alreadySelected = selectedPosition?.id == position.id
                        withAnimation(.spring(response: 0.3)) {
                            if alreadySelected {
                                selectedPosition = nil
                            } else {
                                selectedPosition = position
                                selectedYear?.wrappedValue = nil
                            }
                        }
                        HapticService.shared.impact(.light)
                        if !alreadySelected {
                            SoundService.shared.play(.magicButton, volume: 0.5)
                        }
                    }
                }
            }
            .frame(width: size, height: size)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// MARK: - Star of David (Hexagram)

private struct CoupleStarOfDavidShape: View {
    let size: CGFloat
    let upwardColor: Color
    let downwardColor: Color

    var body: some View {
        ZStack {
            HexagramTriangle(pointsUp: true)
                .stroke(
                    LinearGradient(
                        colors: [upwardColor.opacity(0.45), AppTheme.gold.opacity(0.45)],
                        startPoint: .top, endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: 1.2, lineCap: .round, lineJoin: .round)
                )
                .frame(width: size * 0.74, height: size * 0.74)

            HexagramTriangle(pointsUp: false)
                .stroke(
                    LinearGradient(
                        colors: [AppTheme.gold.opacity(0.45), downwardColor.opacity(0.45)],
                        startPoint: .top, endPoint: .bottom
                    ),
                    style: StrokeStyle(lineWidth: 1.2, lineCap: .round, lineJoin: .round)
                )
                .frame(width: size * 0.74, height: size * 0.74)
        }
    }
}

private struct HexagramTriangle: Shape {
    let pointsUp: Bool

    func path(in rect: CGRect) -> Path {
        Path { p in
            if pointsUp {
                p.move(to: CGPoint(x: rect.midX, y: rect.minY))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.86))
                p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY * 0.86))
            } else {
                p.move(to: CGPoint(x: rect.minX, y: rect.maxY * 0.14))
                p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.14))
                p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            }
            p.closeSubpath()
        }
    }
}

// MARK: - Vesica Piscis

private struct CoupleVesicaPiscisShape: View {
    let size: CGFloat
    let partnerAColor: Color
    let partnerBColor: Color

    var body: some View {
        ZStack {
            Circle()
                .stroke(partnerAColor.opacity(0.32), lineWidth: 1)
                .frame(width: size * 0.44, height: size * 0.44)
                .position(x: size * 0.40, y: size * 0.50)

            Circle()
                .stroke(partnerBColor.opacity(0.32), lineWidth: 1)
                .frame(width: size * 0.44, height: size * 0.44)
                .position(x: size * 0.60, y: size * 0.50)

            // Golden mandorla glow at the intersection
            Circle()
                .fill(AppTheme.goldGradient)
                .frame(width: size * 0.14, height: size * 0.14)
                .opacity(0.10)
                .blur(radius: 8)
                .position(x: size * 0.50, y: size * 0.50)
        }
    }
}

// MARK: - Connection Lines

private struct CoupleConnectionLinesShape: View {
    let size: CGFloat

    var body: some View {
        ZStack {
            // Primary union lines
            Path { path in
                // Partner A → Union → Partner B
                path.move(to: pt(0.22, 0.22))
                path.addLine(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.78, 0.22))
                // Union → Karma, Purpose (upper diagonals)
                path.move(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.36, 0.36))
                path.move(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.64, 0.36))
                // Love ↔ Union ↔ Sexuality
                path.move(to: pt(0.22, 0.50))
                path.addLine(to: pt(0.78, 0.50))
                // Union → bottom triad
                path.move(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.22, 0.78))
                path.move(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.50, 0.85))
                path.move(to: pt(0.50, 0.50))
                path.addLine(to: pt(0.78, 0.78))
            }
            .stroke(AppTheme.gold.opacity(0.38), style: StrokeStyle(lineWidth: 1.0, lineCap: .round))

            // Secondary partner aspect web (dashed)
            Path { path in
                // Partner A → side aspects
                path.move(to: pt(0.22, 0.22))
                path.addLine(to: pt(0.22, 0.50))
                path.move(to: pt(0.22, 0.22))
                path.addLine(to: pt(0.22, 0.78))
                // Partner B → side aspects
                path.move(to: pt(0.78, 0.22))
                path.addLine(to: pt(0.78, 0.50))
                path.move(to: pt(0.78, 0.22))
                path.addLine(to: pt(0.78, 0.78))
                // Both partners → Children (creative legacy)
                path.move(to: pt(0.22, 0.22))
                path.addLine(to: pt(0.50, 0.85))
                path.move(to: pt(0.78, 0.22))
                path.addLine(to: pt(0.50, 0.85))
                // Karma ↔ Purpose
                path.move(to: pt(0.36, 0.36))
                path.addLine(to: pt(0.64, 0.36))
            }
            .stroke(AppTheme.gold.opacity(0.18), style: StrokeStyle(lineWidth: 0.7, dash: [3, 3]))
        }
    }

    private func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: x * size, y: y * size)
    }
}

// MARK: - Partner Banner

private struct CouplePartnerBannerView: View {
    let text: String
    let systemImage: String
    let accent: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: systemImage)
                .font(.system(size: 8, weight: .semibold))
            Text(text)
                .font(.system(size: 9, weight: .semibold))
                .tracking(0.7)
                .textCase(.uppercase)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .foregroundColor(accent)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(AppTheme.deepNavy.opacity(0.78))
                .overlay(
                    Capsule()
                        .stroke(accent.opacity(0.55), lineWidth: 0.8)
                )
        )
        .shadow(color: accent.opacity(0.3), radius: 4)
        .fixedSize()
    }
}

// MARK: - Position Circle

private struct CoupleMatrixPositionCircle: View {
    let position: CoupleMatrixPosition
    let size: CGFloat
    let isSelected: Bool
    let partnerAAccent: Color
    let partnerBAccent: Color
    var pdfMode: Bool = false

    private var circleSize: CGFloat {
        switch position.position {
        case .union: return size * (pdfMode ? 0.15 : 0.14)
        case .partnerA, .partnerB: return size * (pdfMode ? 0.125 : 0.115)
        default: return size * (pdfMode ? 0.095 : 0.088)
        }
    }

    private var fontSize: CGFloat {
        switch position.position {
        case .union: return pdfMode ? 64 : 22
        case .partnerA, .partnerB: return pdfMode ? 52 : 18
        default: return pdfMode ? 40 : 14
        }
    }

    private var labelFontSize: CGFloat {
        switch position.position {
        case .union: return pdfMode ? 24 : 9
        case .partnerA, .partnerB: return pdfMode ? 22 : 8
        default: return pdfMode ? 20 : 7.5
        }
    }

    private var unselectedFill: LinearGradient {
        switch position.position {
        case .union:
            return LinearGradient(
                colors: [AppTheme.lightGold, AppTheme.gold],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .partnerA:
            return LinearGradient(
                colors: [partnerAAccent.opacity(0.65), AppTheme.midNavy.opacity(0.85)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case .partnerB:
            return LinearGradient(
                colors: [partnerBAccent.opacity(0.65), AppTheme.midNavy.opacity(0.85)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                colors: [AppTheme.midNavy.opacity(0.7), AppTheme.deepNavy.opacity(0.9)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
    }

    private var strokeColor: Color {
        switch position.position {
        case .union: return AppTheme.lightGold
        case .partnerA: return partnerAAccent.opacity(0.9)
        case .partnerB: return partnerBAccent.opacity(0.9)
        default: return AppTheme.gold.opacity(0.7)
        }
    }

    private var numberColor: Color {
        if position.position == .union { return .black }
        if isSelected { return .black }
        return AppTheme.textPrimary
    }

    private var glowColor: Color {
        switch position.position {
        case .union: return AppTheme.gold
        case .partnerA: return partnerAAccent
        case .partnerB: return partnerBAccent
        default: return AppTheme.gold
        }
    }

    /// Where the position label sits relative to its circle
    private var labelOffset: CGSize {
        let radius = circleSize / 2
        let gap = labelFontSize + 2
        switch position.position {
        case .partnerA, .partnerB:
            // Below the circle, between it and the karma/purpose row
            return CGSize(width: 0, height: radius + gap)
        case .children:
            // Above so it doesn't collide with the yearly ring
            return CGSize(width: 0, height: -(radius + gap))
        default:
            return CGSize(width: 0, height: radius + gap)
        }
    }

    var body: some View {
        ZStack {
            // Outer glow
            Circle()
                .fill(glowColor.opacity(isSelected ? 0.45 : 0.18))
                .frame(width: circleSize * 1.6, height: circleSize * 1.6)
                .blur(radius: 8)

            // Main circle
            Circle()
                .fill(
                    isSelected
                        ? LinearGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold],
                            startPoint: .topLeading, endPoint: .bottomTrailing
                        )
                        : unselectedFill
                )
                .frame(width: circleSize, height: circleSize)
                .overlay(
                    Circle()
                        .stroke(
                            isSelected ? AppTheme.lightGold : strokeColor,
                            lineWidth: isSelected ? 3 : 2
                        )
                )
                .shadow(
                    color: isSelected ? AppTheme.gold.opacity(0.5) : glowColor.opacity(0.3),
                    radius: isSelected ? 10 : 6,
                    x: 0, y: 4
                )

            // Number
            Text("\(position.number)")
                .font(.system(size: fontSize, weight: .bold, design: .rounded))
                .foregroundColor(numberColor)

            // Aspect name label
            Text(position.position.displayName)
                .font(.system(size: labelFontSize, weight: .semibold))
                .foregroundColor(isSelected ? AppTheme.lightGold : AppTheme.textSecondary.opacity(0.95))
                .tracking(0.3)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
                .frame(width: max(circleSize * 2.2, 76))
                .offset(labelOffset)
                .shadow(color: AppTheme.deepNavy.opacity(0.85), radius: 2)
        }
        .position(x: position.x * size, y: position.y * size)
        .scaleEffect(isSelected ? 1.08 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

// MARK: - Outer Yearly Couple Energy Ring

private struct CoupleYearlyRingView: View {
    let yearlyEnergies: [CoupleYearlyEnergy]
    let size: CGFloat
    @Binding var selectedYear: CoupleYearlyEnergy?
    @Binding var selectedPosition: CoupleMatrixPosition?
    var pdfMode: Bool = false

    /// All projected couple years arranged around the ring
    private var visibleYears: Int { yearlyEnergies.count }

    var body: some View {
        let displayed = yearlyEnergies

        ZStack {
            Circle()
                .stroke(AppTheme.gold.opacity(0.22), lineWidth: 1)
                .frame(width: size * 1.02, height: size * 1.02)
                .position(x: size / 2, y: size / 2)

            ForEach(displayed, id: \.id) { yearEnergy in
                CoupleYearMarkerView(
                    yearEnergy: yearEnergy,
                    totalYears: visibleYears,
                    size: size,
                    isSelected: selectedYear?.id == yearEnergy.id,
                    pdfMode: pdfMode
                )
                .zIndex(selectedYear?.id == yearEnergy.id ? 1 : 0)
                .onTapGesture {
                    let alreadySelected = selectedYear?.id == yearEnergy.id
                    withAnimation(.spring(response: 0.3)) {
                        if alreadySelected {
                            selectedYear = nil
                        } else {
                            selectedYear = yearEnergy
                            selectedPosition = nil
                        }
                    }
                    HapticService.shared.impact(.light)
                    if !alreadySelected {
                        SoundService.shared.play(.magicButton, volume: 0.5)
                    }
                }
            }
        }
    }
}

private struct CoupleYearMarkerView: View {
    let yearEnergy: CoupleYearlyEnergy
    let totalYears: Int
    let size: CGFloat
    let isSelected: Bool
    var pdfMode: Bool = false

    /// Visually accent the decade boundaries so the ring stays readable at 44 markers
    private var isDecadeMarker: Bool {
        yearEnergy.year % 10 == 0
    }

    var body: some View {
        let angle = angleForIndex(yearEnergy.yearsTogetherIndex)
        let ringRadius = size * 0.51
        let labelRadius = size * 0.455
        let circleX = size / 2 + ringRadius * cos(angle)
        let circleY = size / 2 + ringRadius * sin(angle)
        let labelX = size / 2 + labelRadius * cos(angle)
        let labelY = size / 2 + labelRadius * sin(angle)

        let baseDiameter: CGFloat = pdfMode ? 28 : 11
        let energyFontSize: CGFloat = pdfMode ? (isSelected ? 16 : 14) : (isSelected ? 7 : 5)
        let yearLabelFontSize: CGFloat = pdfMode ? (isSelected ? 18 : 16) : (isSelected ? 8 : 7)

        ZStack {
            ZStack {
                Circle()
                    .fill(
                        isSelected
                            ? AppTheme.goldGradient
                            : (yearEnergy.isCurrentYear
                                ? LinearGradient(colors: [AppTheme.gold.opacity(0.85)], startPoint: .top, endPoint: .bottom)
                                : (isDecadeMarker
                                    ? LinearGradient(colors: [AppTheme.gold.opacity(0.32)], startPoint: .top, endPoint: .bottom)
                                    : LinearGradient(colors: [AppTheme.deepNavy.opacity(0.7)], startPoint: .top, endPoint: .bottom)))
                    )
                    .frame(width: baseDiameter, height: baseDiameter)
                    .overlay(
                        Circle()
                            .stroke(
                                isSelected
                                    ? AppTheme.lightGold
                                    : (yearEnergy.isCurrentYear
                                        ? AppTheme.gold
                                        : (isDecadeMarker ? AppTheme.gold.opacity(0.8) : AppTheme.gold.opacity(0.4))),
                                lineWidth: isSelected ? 1.6 : (isDecadeMarker ? 1.1 : 1)
                            )
                    )
                    .shadow(
                        color: isSelected ? AppTheme.gold.opacity(0.5) : .clear,
                        radius: isSelected ? 6 : 0
                    )

                Text("\(yearEnergy.primaryEnergy)")
                    .font(.system(
                        size: energyFontSize,
                        weight: isSelected ? .bold : (yearEnergy.isCurrentYear ? .semibold : .medium),
                        design: .rounded
                    ))
                    .foregroundColor(
                        isSelected
                            ? .black
                            : (yearEnergy.isCurrentYear ? .black.opacity(0.85) : AppTheme.textPrimary)
                    )
            }
            .scaleEffect(isSelected ? 1.55 : 1.0)
            .position(x: circleX, y: circleY)

            // Every marker gets a year label
            Text(yearLabel)
                .font(.system(
                    size: yearLabelFontSize,
                    weight: isSelected ? .bold : (yearEnergy.isCurrentYear || isDecadeMarker ? .semibold : .medium)
                ))
                .foregroundColor(
                    isSelected
                        ? AppTheme.gold
                        : (yearEnergy.isCurrentYear || isDecadeMarker
                            ? AppTheme.gold.opacity(0.9)
                            : AppTheme.textTertiary.opacity(0.8))
                )
                .position(x: labelX, y: labelY)
        }
        .animation(.spring(response: 0.2), value: isSelected)
    }

    /// Two-digit calendar year (e.g. "'26")
    private var yearLabel: String {
        let lastTwo = yearEnergy.year % 100
        return String(format: "'%02d", lastTwo)
    }

    private func angleForIndex(_ index: Int) -> CGFloat {
        let progress = CGFloat(index) / CGFloat(totalYears)
        let degrees = -90 + progress * 360
        return degrees * .pi / 180
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected: CoupleMatrixPosition?
        @State private var selectedYear: CoupleYearlyEnergy?
        let matrix: CoupleMatrix

        var body: some View {
            ZStack {
                AppTheme.backgroundGradient.ignoresSafeArea()
                CoupleMatrixDiagramView(
                    matrix: matrix,
                    selectedPosition: $selected,
                    selectedYear: $selectedYear
                )
                .padding(40)
            }
        }
    }

    let date = Calendar.current.date(from: DateComponents(year: 1990, month: 5, day: 15))!
    let matrix = CoupleMatrixCalculator.shared.calculate(birthDateA: date, birthDateB: date)
    return PreviewWrapper(matrix: matrix)
}
