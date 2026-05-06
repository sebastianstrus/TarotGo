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
    
    // Limit date range to reasonable bounds
    private let minDate = Calendar.current.date(from: DateComponents(year: 1900, month: 1, day: 1)) ?? Date()
    private let maxDate = Date()
    
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
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(AppTheme.goldGradient)
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
                    
                    // Date Picker
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
                        .padding(.horizontal, 20)
                        
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
                    .padding(.horizontal, 20)
                    
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showResult) {
            if let matrix = calculatedMatrix {
                DestinyMatrixResultView(matrix: matrix)
            }
        }
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDate)
    }
    
    private func calculateMatrix() {
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.whoosh, volume: 0.5)
        
        // Calculate matrix
        calculatedMatrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)
        
        // Show result
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showResult = true
        }
    }
}

#Preview {
    NavigationStack {
        DestinyMatrixInputView()
    }
}
