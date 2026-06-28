//
//  CoupleDestinyView.swift
//  TarotGo
//
//  Entry view for the Couple Matrix feature: collects two partner birth dates.
//

import SwiftUI

struct CoupleDestinyView: View {
    @State private var birthDateA = Date()
    @State private var birthDateB = Date()
    @State private var showResult = false
    @State private var calculatedMatrix: CoupleMatrix?
    @State private var useSavedDateForA: Bool = true
    @State private var isCalculating: Bool = false
    @State private var showBirthDateInput: Bool = false

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
                    Spacer().frame(height: 0)

                    header

                    descriptionCard

                    partnerASection
                    partnerBSection

                    calculateButton

                    Spacer().frame(height: 40)
                }
            }

            if isCalculating {
                MatrixCalculatingOverlay(title: L10n.coupleMatrixTitle)
                    .transition(.opacity)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(isCalculating)
        .navigationDestination(isPresented: $showResult) {
            if let matrix = calculatedMatrix {
                CoupleMatrixResultView(matrix: matrix)
            }
        }
        .sheet(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                birthDateA = date
            }
        }
        .onAppear {
            if let saved = AstrologyService.shared.userBirthDate {
                birthDateA = saved
            }
        }
        .onChange(of: useSavedDateForA) { _, newValue in
            HapticService.shared.impact(.light)
            if newValue, let saved = AstrologyService.shared.userBirthDate {
                birthDateA = saved
            }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 15) {
            Image("ic_couple_destiny")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)

            Text(L10n.coupleMatrixTitle)
                .font(AppTheme.serifFont(size: 32, weight: .regular))
                .foregroundStyle(AppTheme.goldGradient)
                .multilineTextAlignment(.center)

            Text(L10n.coupleMatrixSubtitle)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.bottom, 10)
    }

    private var descriptionCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.coupleMatrixWhatIs)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(AppTheme.gold)

            Text(L10n.coupleMatrixDescription)
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
    }

    // MARK: - Partner A

    private var partnerASection: some View {
        VStack(spacing: 16) {
            HStack {
                Text(L10n.coupleMatrixPartnerA)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                Spacer()
            }

            if hasSavedBirthDate {
                HStack {
                    Text(L10n.coupleMatrixUseMyBirthDate)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppTheme.textPrimary)
                    Spacer()
                    Toggle("", isOn: $useSavedDateForA)
                        .labelsHidden()
                        .tint(AppTheme.gold)
                }
            }

            Group {
                if useSavedDateForA && hasSavedBirthDate {
                    Button {
                        HapticService.shared.impact(.light)
                        showBirthDateInput = true
                    } label: {
                        savedBirthDateCard(date: birthDateA, label: L10n.coupleMatrixYourBirthDate)
                    }
                    .buttonStyle(.plain)
                } else {
                    datePickerCard(
                        title: L10n.coupleMatrixEnterPartnerABirthDate,
                        date: $birthDateA
                    )
                }
            }
            .animation(.easeInOut(duration: 0.25), value: useSavedDateForA)
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Partner B

    private var partnerBSection: some View {
        VStack(spacing: 16) {
            HStack {
                Text(L10n.coupleMatrixPartnerB)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                Spacer()
            }

            datePickerCard(
                title: L10n.coupleMatrixEnterPartnerBBirthDate,
                date: $birthDateB
            )
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Reusable cards

    private func datePickerCard(title: String, date: Binding<Date>) -> some View {
        VStack(spacing: 16) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)

            DatePicker(
                "",
                selection: date,
                in: minDate...maxDate,
                displayedComponents: .date
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            .colorScheme(.dark)
            .frame(maxWidth: .infinity)

            Text(formatted(date.wrappedValue))
                .font(AppTheme.serifFont(size: 18, weight: .medium))
                .foregroundColor(AppTheme.gold)
        }
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }

    private func savedBirthDateCard(date: Date, label: String) -> some View {
        VStack(spacing: 12) {
            Text(label)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppTheme.textPrimary)

            Text(formatted(date))
                .font(AppTheme.serifFont(size: 22, weight: .medium))
                .foregroundColor(AppTheme.gold)

            HStack(spacing: 6) {
                Image(systemName: "pencil")
                    .font(.system(size: 12, weight: .medium))
                Text(L10n.settingsChange)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundStyle(AppTheme.goldGradient)
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
        )
    }

    // MARK: - Calculate

    private var calculateButton: some View {
        Button {
            calculate()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.system(size: 20))
                Text(L10n.coupleMatrixCalculate)
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
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    private func calculate() {
        guard !isCalculating else { return }

        HapticService.shared.impact(.medium)

        // If the user has no saved birth date and they used Partner A as themselves,
        // save it for them.
        if !hasSavedBirthDate {
            AstrologyService.shared.userBirthDate = birthDateA
        }

        calculatedMatrix = CoupleMatrixCalculator.shared.calculate(
            birthDateA: birthDateA,
            birthDateB: birthDateB
        )

        withAnimation(.easeInOut(duration: 0.4)) {
            isCalculating = true
        }
        SoundService.shared.play(.generate, volume: 0.5)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            HapticService.shared.impact(.light)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            HapticService.shared.impact(.light)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.4) {
            HapticService.shared.impact(.success)
            showResult = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isCalculating = false
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CoupleDestinyView()
    }
}
