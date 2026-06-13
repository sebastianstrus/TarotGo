//
//  DestinyMatrixInputView.swift
//  TarotGo
//
//  View for entering birth date to calculate Destiny Matrix
//

import SwiftUI

struct DestinyMatrixInputView: View {
    @State private var birthDate = Date()
    @State private var showResult = false
    @State private var calculatedMatrix: DestinyMatrix?
    @State private var calculateForOther: Bool = false
    @State private var isCalculating: Bool = false
    
    // Limit date range to reasonable bounds
    private let minDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1)) ?? Date()
    private let maxDate = Date()
    
    private var hasSavedBirthDate: Bool {
        AstrologyService.shared.userBirthDate != nil
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                        .frame(height: 0)
                    
                    // Header
                    VStack(spacing: 15) {
                        Image("ic_destiny_matrix")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72, height: 72)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.matrixTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(L10n.matrixSubtitle)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }
                    .padding(.bottom, 20)
                    
                    // Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text(L10n.matrixWhatIs)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.gold)
                        
                        Text(L10n.matrixDescription)
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(AppTheme.cardGradient)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 20)
                    
                    // Date Display/Picker Section
                    VStack(spacing: 20) {
                        // Toggle for calculating for someone else (only show if user has saved birth date)
                        if hasSavedBirthDate {
                            HStack {
                                Text(L10n.matrixCalculateForOther)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                Spacer()
                                
                                Toggle("", isOn: $calculateForOther)
                                    .labelsHidden()
                                    .tint(AppTheme.gold)
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // Show date picker only if calculating for someone else or no saved date
                        Group {
                            if calculateForOther || !hasSavedBirthDate {
                                VStack(spacing: 20) {
                                    Text(L10n.matrixEnterBirthDate)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(AppTheme.textPrimary)
                                    
                                    DatePicker(
                                        "",
                                        selection: $birthDate,
                                        in: minDate...maxDate,
                                        displayedComponents: .date
                                    )
                                    .datePickerStyle(.wheel)
                                    .labelsHidden()
                                    .colorScheme(.dark)
                                    .frame(maxWidth: .infinity)
                                    
                                    Text(formattedDate)
                                        .font(AppTheme.serifFont(size: 20, weight: .medium))
                                        .foregroundColor(AppTheme.gold)
                                }
                                .padding(.vertical, 25)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(AppTheme.cardGradient)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                                        )
                                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
                                )
                                .transition(.opacity.combined(with: .scale))
                            } else {
                                // Show saved birth date
                                VStack(spacing: 12) {
                                    Text(L10n.matrixYourBirthDate)
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(AppTheme.textPrimary)
                                    
                                    Text(formattedDate)
                                        .font(AppTheme.serifFont(size: 24, weight: .medium))
                                        .foregroundColor(AppTheme.gold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 30)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(AppTheme.cardGradient)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                                        )
                                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
                                )
                                .transition(.opacity.combined(with: .scale))
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .animation(.easeInOut(duration: 0.3), value: calculateForOther)
                    
                    // Calculate Button
                    Button {
                        calculateMatrix()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 20))
                            
                            Text(L10n.matrixCalculate)
                                .font(.system(size: 18, weight: .semibold))
                        }
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.4), radius: 10, x: 0, y: 5)
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Spacer()
                        .frame(height: 40)
                }
            }

            if isCalculating {
                MatrixCalculatingOverlay()
                    .transition(.opacity)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(isCalculating)
        .navigationDestination(isPresented: $showResult) {
            if let matrix = calculatedMatrix {
                DestinyMatrixResultView(matrix: matrix)
            }
        }
        .onAppear {
            // Load birth date from settings if available
            if let savedBirthDate = AstrologyService.shared.userBirthDate {
                birthDate = savedBirthDate
            }
        }
        .onChange(of: calculateForOther) { _, newValue in
            HapticService.shared.impact(.light)
            // Reset to saved date when toggling off, or to current date when toggling on
            if !newValue, let savedBirthDate = AstrologyService.shared.userBirthDate {
                birthDate = savedBirthDate
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDate)
    }
    
    private func calculateMatrix() {
        guard !isCalculating else { return }

        HapticService.shared.impact(.medium)

        // Save birth date if this is for the user (not for someone else) and no saved date exists
        if !calculateForOther && !hasSavedBirthDate {
            AstrologyService.shared.userBirthDate = birthDate
        }

        // Calculate matrix immediately so it's ready when the ritual ends
        calculatedMatrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)

        // Begin mystical reveal
        withAnimation(.easeInOut(duration: 0.4)) {
            isCalculating = true
        }
        SoundService.shared.play(.generate, volume: 0.5)

        // Mid-ritual heartbeat haptics
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            HapticService.shared.impact(.light)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            HapticService.shared.impact(.light)
        }

        // Reveal the result after the ritual completes
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.4) {
            HapticService.shared.impact(.success)
            // Push the result view while the overlay still covers the input view,
            // so the input view is never exposed during the transition.
            showResult = true
            // Dismiss the overlay after the navigation push completes.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isCalculating = false
                }
            }
        }
    }
}

// MARK: - Mystical Calculating Overlay

private struct MatrixCalculatingOverlay: View {
    @State private var outerRotation: Double = 0
    @State private var innerRotation: Double = 0
    @State private var ringRotation: Double = 0
    @State private var pulse: CGFloat = 0.85
    @State private var glow: Double = 0.35
    @State private var sparkleScale: CGFloat = 0.8
    @State private var appear: Bool = false

    var body: some View {
        ZStack {
            // Dimmed mystical backdrop
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .background(.ultraThinMaterial.opacity(0.9))

            // Radiant glow behind the geometry
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppTheme.gold.opacity(glow),
                            AppTheme.mysticalPurple.opacity(glow * 0.6),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 220
                    )
                )
                .frame(width: 440, height: 440)
                .blur(radius: 30)

            // Sacred geometry: octagram from two rotating squares
            ZStack {
                // Outer rotating ring with orbiting golden dots
                ZStack {
                    Circle()
                        .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1)
                        .frame(width: 260, height: 260)

                    ForEach(0..<12, id: \.self) { i in
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 6, height: 6)
                            .shadow(color: AppTheme.gold.opacity(0.8), radius: 6)
                            .offset(y: -130)
                            .rotationEffect(.degrees(Double(i) * 30))
                    }
                }
                .rotationEffect(.degrees(ringRotation))

                // Outer square
                RoundedRectangle(cornerRadius: 4)
                    .stroke(AppTheme.goldGradient, lineWidth: 2)
                    .frame(width: 200, height: 200)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 12)
                    .rotationEffect(.degrees(outerRotation))

                // Inner square (counter-rotating) — together forms an octagram
                RoundedRectangle(cornerRadius: 4)
                    .stroke(AppTheme.goldGradient, lineWidth: 2)
                    .frame(width: 200, height: 200)
                    .shadow(color: AppTheme.lightGold.opacity(0.6), radius: 12)
                    .rotationEffect(.degrees(innerRotation))

                // Diamond connecting points
                RoundedRectangle(cornerRadius: 2)
                    .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1)
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-outerRotation * 0.5))

                // Pulsing inner core
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold.opacity(0.0)],
                            center: .center,
                            startRadius: 2,
                            endRadius: 60
                        )
                    )
                    .frame(width: 120, height: 120)
                    .scaleEffect(pulse)
                    .shadow(color: AppTheme.gold.opacity(0.9), radius: 20)
            }
            .opacity(appear ? 1 : 0)
            .scaleEffect(appear ? 1 : 0.6)

            // Title beneath geometry
            VStack {
                Spacer()
                Text(L10n.matrixTitle)
                    .font(AppTheme.serifFont(size: 24, weight: .regular))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 8)
                    .opacity(appear ? 1 : 0)
                    .padding(.bottom, 120)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                appear = true
            }
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                outerRotation = 360
            }
            withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
                innerRotation = -360
            }
            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                ringRotation = 360
            }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                pulse = 1.15
                glow = 0.7
                sparkleScale = 1.15
            }
        }
    }
}

#Preview {
    NavigationStack {
        DestinyMatrixInputView()
    }
}
