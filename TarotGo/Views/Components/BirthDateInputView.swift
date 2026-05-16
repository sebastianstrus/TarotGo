//
//  BirthDateInputView.swift
//  TarotGo
//
//  Popup component for entering birth date
//

import SwiftUI

struct BirthDateInputView: View {
    @Binding var isPresented: Bool
    let onSave: (Date) -> Void
    
    @State private var selectedDate: Date = Date()
    @State private var showZodiacInfo: Bool = false
    
    private var zodiacSign: ZodiacSign {
        AstrologyService.shared.zodiacSign(from: selectedDate)
    }
    
    private var lifePathNumber: Int {
        AstrologyService.shared.lifePathNumber(from: selectedDate)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 12) {
                            Image(systemName: "star.circle.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                            
                            Text(L10n.birthDateInputTitle)
                                .font(AppTheme.serifFont(size: 28, weight: .light))
                                .foregroundStyle(AppTheme.goldGradient)
                                .multilineTextAlignment(.center)
                            
                            Text(L10n.birthDateInputDescription)
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding(.top, 20)
                        
                        // Date Picker
                        VStack(spacing: 16) {
                            Text(L10n.birthDateInputSelectDate)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            DatePicker(
                                "Birth Date",
                                selection: $selectedDate,
                                in: ...Date(),
                                displayedComponents: .date
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .colorScheme(.dark)
                            .onChange(of: selectedDate) { _, _ in
                                HapticService.shared.impact(.light)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(AppTheme.darkNavy.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .padding(.horizontal)
                        
                        // Astrological Info Preview
                        VStack(spacing: 12) {
                            HStack(spacing: 20) {
                                // Zodiac Sign
                                VStack(spacing: 8) {
                                    Text(zodiacSign.symbol)
                                        .font(.system(size: 40))
                                    
                                    Text(zodiacSign.name)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppTheme.gold)
                                    
                                    Text(L10n.birthDateInputZodiacSign)
                                        .font(.system(size: 11, weight: .light))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                .frame(maxWidth: .infinity)
                                
                                Divider()
                                    .frame(height: 60)
                                    .background(AppTheme.gold.opacity(0.3))
                                
                                // Life Path Number
                                VStack(spacing: 8) {
                                    Text("\(lifePathNumber)")
                                        .font(.system(size: 40, weight: .light))
                                        .foregroundStyle(AppTheme.goldGradient)
                                    
                                    Text(L10n.birthDateInputLifePath)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppTheme.gold)
                                    
                                    Text(L10n.birthDateInputNumerology)
                                        .font(.system(size: 11, weight: .light))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(AppTheme.darkNavy.opacity(0.6))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                                    )
                            )
                        }
                        .padding(.horizontal)
                        
                        // Privacy Note
                        HStack(spacing: 10) {
                            Image(systemName: "lock.fill")
                                .font(.system(size: 14))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                            
                            Text(L10n.birthDateInputPrivacy)
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(AppTheme.darkNavy.opacity(0.4))
                        )
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.skip) {
                        isPresented = false
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(L10n.save) {
                        saveBirthDate()
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private func saveBirthDate() {
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.success, volume: 0.6)
        
        AstrologyService.shared.userBirthDate = selectedDate
        onSave(selectedDate)
        isPresented = false
    }
}

#Preview {
    BirthDateInputView(isPresented: .constant(true)) { date in
        print("Saved date: \(date)")
    }
}
