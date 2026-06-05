//
//  TarotView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct TarotView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var destination: TarotDestination?

    var body: some View {
        NavigationStack(path: $appViewModel.navigationPath) {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                VStack(spacing: 0) {
                    Spacer().frame(height: 10)

                    // Section title with gold styling
                    VStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

                        Text(L10n.tarotViewTitle)
                            .font(AppTheme.serifFont(size: 36, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)

                            Text(L10n.tarotViewSubtitle)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 7))
                                .foregroundColor(AppTheme.gold)
                        }
                    }
                    .padding(.bottom, 20)

                    Spacer(minLength: 0)

                    // Circular wheel menu
                    TarotWheelMenuView(
                        options: wheelOptions,
                        onSelect: handleSelection
                    )
                    .padding(.horizontal, 20)

                    Spacer(minLength: 0)

                    // Footer with golden accent
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)

                        Text(L10n.homeFooter)
                            .font(AppTheme.serifFont(size: 13, weight: .light))
                            .foregroundColor(AppTheme.textTertiary)

                        Rectangle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 35, height: 1)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $destination) { dest in
                destinationView(for: dest)
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    destination = nil
                }
            }
            .onReceive(appViewModel.$shouldNavigateToDailyCard) { shouldNavigate in
                if shouldNavigate {
                    destination = .cardOfDay
                    // Reset the trigger
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        appViewModel.shouldNavigateToDailyCard = false
                    }
                }
            }
        }
    }

    private var wheelOptions: [TarotWheelOption] {
        [
            TarotWheelOption(
                icon: "sparkles",
                title: L10n.homeNewReading,
                destination: .newReading
            ),
            TarotWheelOption(
                icon: "sun.max.fill",
                title: L10n.homeCardOfDay,
                destination: .cardOfDay
            ),
            TarotWheelOption(
                icon: "books.vertical.fill",
                title: L10n.homeCardDictionary,
                destination: .dictionary
            ),
            TarotWheelOption(
                icon: "book.fill",
                title: L10n.homeHistory,
                destination: .history
            ),
            TarotWheelOption(
                icon: "graduationcap.fill",
                title: L10n.homeLearnTarot,
                destination: .learn
            )
        ]
    }

    private func handleSelection(_ option: TarotWheelOption) {
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
        destination = option.destination
    }

    @ViewBuilder
    private func destinationView(for destination: TarotDestination) -> some View {
        switch destination {
        case .newReading:
            NewReadingView()
                .toolbar(.hidden, for: .tabBar)
        case .cardOfDay:
            CardOfTheDayView()
        case .dictionary:
            CardDictionaryView()
        case .history:
            HistoryView()
        case .learn:
            LearnTarotView()
        }
    }
}

// MARK: - Wheel Menu Model

enum TarotDestination: Hashable {
    case newReading
    case cardOfDay
    case dictionary
    case history
    case learn
}

struct TarotWheelOption: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let destination: TarotDestination
}

// MARK: - Wheel Menu View

struct TarotWheelMenuView: View {
    let options: [TarotWheelOption]
    let onSelect: (TarotWheelOption) -> Void

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let center = CGPoint(x: size / 2, y: size / 2)
            let outerRadius = size / 2
            let innerRadius = size * 0.18
            let labelRadius = (outerRadius + innerRadius) / 2
            let segmentAngle = 360.0 / Double(options.count)

            ZStack {
                // Decorative outermost ring
                Circle()
                    .stroke(AppTheme.goldGradient, lineWidth: 2)
                    .frame(width: size, height: size)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)

                Circle()
                    .fill(AppTheme.deepPurple.opacity(0.35))
                    .frame(width: size - 4, height: size - 4)

                // Segments
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let startAngle = startAngleFor(index: index, segmentAngle: segmentAngle)
                    let endAngle = startAngle + segmentAngle

                    WheelSegmentShape(
                        startAngle: .degrees(startAngle),
                        endAngle: .degrees(endAngle),
                        innerRadius: innerRadius,
                        outerRadius: outerRadius - 8
                    )
                    .fill(
                        LinearGradient(
                            colors: [
                                AppTheme.midNavy.opacity(0.85),
                                AppTheme.deepNavy.opacity(0.9)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        WheelSegmentShape(
                            startAngle: .degrees(startAngle),
                            endAngle: .degrees(endAngle),
                            innerRadius: innerRadius,
                            outerRadius: outerRadius - 8
                        )
                        .stroke(AppTheme.gold.opacity(0.7), lineWidth: 1)
                    )
                    .contentShape(
                        WheelSegmentShape(
                            startAngle: .degrees(startAngle),
                            endAngle: .degrees(endAngle),
                            innerRadius: innerRadius,
                            outerRadius: outerRadius - 8
                        )
                    )
                    .onTapGesture {
                        onSelect(option)
                    }
                }

                // Icons + labels (overlaid so taps still hit segments below)
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    let midDegrees = startAngleFor(index: index, segmentAngle: segmentAngle) + segmentAngle / 2
                    let midRadians = midDegrees * .pi / 180
                    let x = center.x + cos(midRadians) * labelRadius
                    let y = center.y + sin(midRadians) * labelRadius

                    VStack(spacing: 6) {
                        Image(systemName: option.icon)
                            .font(.system(size: 22, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text(option.title)
                            .font(AppTheme.serifFont(size: 12, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(width: segmentLabelWidth(outerRadius: outerRadius, innerRadius: innerRadius))
                    .position(x: x, y: y)
                    .allowsHitTesting(false)
                }

                // Decorative dots between segments at the inner edge
                ForEach(0..<options.count, id: \.self) { index in
                    let degrees = startAngleFor(index: index, segmentAngle: segmentAngle)
                    let radians = degrees * .pi / 180
                    let x = center.x + cos(radians) * innerRadius
                    let y = center.y + sin(radians) * innerRadius

                    Circle()
                        .fill(AppTheme.gold)
                        .frame(width: 5, height: 5)
                        .shadow(color: AppTheme.gold.opacity(0.8), radius: 3)
                        .position(x: x, y: y)
                        .allowsHitTesting(false)
                }

                // Center circle
                ZStack {
                    Circle()
                        .fill(AppTheme.deepNavy)
                        .frame(width: innerRadius * 2, height: innerRadius * 2)

                    Circle()
                        .stroke(AppTheme.goldGradient, lineWidth: 2)
                        .frame(width: innerRadius * 2, height: innerRadius * 2)

                    Image(systemName: "sun.max.fill")
                        .font(.system(size: innerRadius * 1.1))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.6), radius: 6)
                }
                .position(center)
                .allowsHitTesting(false)
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    /// Returns the start angle (in degrees) for the segment at `index`.
    /// Orients the wheel so the first segment is centered at the top.
    private func startAngleFor(index: Int, segmentAngle: Double) -> Double {
        -90.0 - segmentAngle / 2 + Double(index) * segmentAngle
    }

    private func segmentLabelWidth(outerRadius: CGFloat, innerRadius: CGFloat) -> CGFloat {
        // Roughly the chord width at the label radius
        max(60, (outerRadius - innerRadius) * 0.95)
    }
}

// MARK: - Segment Shape

struct WheelSegmentShape: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let innerRadius: CGFloat
    let outerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        path.addArc(
            center: center,
            radius: outerRadius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        path.closeSubpath()
        return path
    }
}

#Preview {
    TarotView()
        .environmentObject(AppViewModel())
}
