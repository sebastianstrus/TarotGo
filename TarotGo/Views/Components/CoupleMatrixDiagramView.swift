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

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)

            ZStack {
                // Outer frame
                Circle()
                    .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1.5)
                    .frame(width: size * 0.94, height: size * 0.94)

                // Infinity-loop / vesica lines connecting the two partners through the union
                Path { path in
                    let padding: CGFloat = size * 0.20
                    // Partner A → Union → Partner B
                    path.move(to: CGPoint(x: padding, y: padding))
                    path.addLine(to: CGPoint(x: size / 2, y: size / 2))
                    path.addLine(to: CGPoint(x: size - padding, y: padding))
                    // Lower triangle Union → Money/Children/Health
                    path.move(to: CGPoint(x: size / 2, y: size / 2))
                    path.addLine(to: CGPoint(x: padding, y: size - padding))
                    path.move(to: CGPoint(x: size / 2, y: size / 2))
                    path.addLine(to: CGPoint(x: size - padding, y: size - padding))
                    path.move(to: CGPoint(x: size / 2, y: size / 2))
                    path.addLine(to: CGPoint(x: size / 2, y: size * 0.85))
                    // Love line — across the heart
                    path.move(to: CGPoint(x: size * 0.22, y: size / 2))
                    path.addLine(to: CGPoint(x: size * 0.78, y: size / 2))
                }
                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1.5)

                // Positions
                ForEach(matrix.positions) { position in
                    CoupleMatrixPositionCircle(
                        position: position,
                        size: size,
                        isSelected: selectedPosition?.id == position.id
                    )
                    .zIndex(selectedPosition?.id == position.id ? 1 : 0)
                    .onTapGesture {
                        let alreadySelected = selectedPosition?.id == position.id
                        withAnimation(.spring(response: 0.3)) {
                            selectedPosition = alreadySelected ? nil : position
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

// MARK: - Position Circle

private struct CoupleMatrixPositionCircle: View {
    let position: CoupleMatrixPosition
    let size: CGFloat
    let isSelected: Bool

    private var circleSize: CGFloat {
        switch position.position {
        case .union:
            return size * 0.16
        case .partnerA, .partnerB:
            return size * 0.13
        default:
            return size * 0.10
        }
    }

    private var fontSize: CGFloat {
        switch position.position {
        case .union: return 26
        case .partnerA, .partnerB: return 22
        default: return 18
        }
    }

    var body: some View {
        ZStack {
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

            Text("\(position.number)")
                .font(.system(size: fontSize, weight: .bold, design: .rounded))
                .foregroundColor(isSelected ? .black : AppTheme.textPrimary)
        }
        .position(x: position.x * size, y: position.y * size)
        .scaleEffect(isSelected ? 1.08 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selected: CoupleMatrixPosition?
        let matrix: CoupleMatrix

        var body: some View {
            ZStack {
                AppTheme.backgroundGradient.ignoresSafeArea()
                CoupleMatrixDiagramView(matrix: matrix, selectedPosition: $selected)
                    .padding(40)
            }
        }
    }

    let date = Calendar.current.date(from: DateComponents(year: 1990, month: 5, day: 15))!
    let matrix = CoupleMatrixCalculator.shared.calculate(birthDateA: date, birthDateB: date)
    return PreviewWrapper(matrix: matrix)
}
