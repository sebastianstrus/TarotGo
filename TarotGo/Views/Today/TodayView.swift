//
//  TodayView.swift
//  TarotGo
//
//  A personalized "your day" summary that combines the card of the day, moon phase,
//  Mercury status, numerology, Destiny Matrix and zodiac sign, all driven by the
//  user's birth date. Each row opens the full module on its own tab.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var birthDate: Date? = AstrologyService.shared.userBirthDate
    @State private var showBirthDateInput: Bool = false
    @State private var showSettings: Bool = false

    private let today = Date()

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(spacing: 16) {
                    header

                    if birthDate == nil {
                        birthDatePrompt
                    }

                    dailyCardRow
                    moonRow
                    mercuryRow

                    if let birthDate {
                        personalRows(for: birthDate)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .overlay(alignment: .topTrailing) {
            settingsButton
        }
        .fullScreenCover(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                birthDate = date
            }
        }
        .sheet(isPresented: $showSettings, onDismiss: {
            birthDate = AstrologyService.shared.userBirthDate
        }) {
            NavigationStack {
                SettingsView()
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button(L10n.done) { showSettings = false }
                        }
                    }
            }
        }
        .onAppear {
            birthDate = AstrologyService.shared.userBirthDate
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 8) {
            Text(L10n.todayTitle)
                .font(AppTheme.serifFont(size: 36, weight: .regular))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

            Text(today.formatted(date: .complete, time: .omitted))
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.gold.opacity(0.8))

            Text(L10n.todaySubtitle)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.top, 30)
        .padding(.bottom, 8)
    }

    private var settingsButton: some View {
        Button {
            HapticService.shared.impact(.light)
            showSettings = true
        } label: {
            Image(systemName: "gearshape.fill")
                .font(.system(size: 20))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(12)
        }
        .accessibilityLabel(L10n.tabSettings)
        .padding(.trailing, 8)
    }

    private var birthDatePrompt: some View {
        Button {
            showBirthDateInput = true
        } label: {
            VStack(spacing: 8) {
                Text(L10n.enterYourBirthDate)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)

                Text(L10n.discoverNumerologyProfile)
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)

                Text(L10n.addBirthDate)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(AppTheme.goldGradient)
                    .cornerRadius(12)
                    .padding(.top, 4)
            }
            .padding(20)
            .background(cardBackground)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Rows

    private var dailyCardRow: some View {
        let card = dailyCard()
        return todayRow(
            icon: "rectangle.portrait.on.rectangle.portrait.angled.fill",
            title: L10n.homeCardOfDay,
            value: card.localizedName,
            detail: nil
        ) {
            appViewModel.navigateToDailyCard()
        }
    }

    private var moonRow: some View {
        let phase = LunarService.shared.moonPhase(for: today)
        let illumination = Int(LunarService.shared.illuminationPercentage(for: today).rounded())
        return todayRow(
            emoji: phase.symbol,
            title: L10n.lunarCalendarTitle,
            value: phase.rawValue,
            detail: "\(L10n.lunarCalendarIlluminated) \(illumination)%"
        ) {
            appViewModel.activeTab = .cosmic
        }
    }

    private var mercuryRow: some View {
        let phase = MercuryRetrogradeService.shared.currentPhase(for: today)
        return todayRow(
            icon: phase.iconName,
            title: L10n.mercuryTitle,
            value: phase.title,
            detail: phase.shortDescription
        ) {
            appViewModel.activeTab = .cosmic
        }
    }

    @ViewBuilder
    private func personalRows(for birthDate: Date) -> some View {
        let sign = AstrologyService.shared.zodiacSign(from: birthDate)
        let lifePath = AstrologyService.shared.lifePathNumber(from: birthDate)
        let matrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)

        todayRow(
            emoji: sign.symbol,
            title: L10n.horoscopeTitle,
            value: sign.name,
            detail: nil
        ) {
            appViewModel.activeTab = .cosmic
        }

        todayRow(
            icon: "number.circle.fill",
            title: L10n.numerologyTitle,
            value: "\(lifePath)",
            detail: L10n.yourLifePathNumber
        ) {
            appViewModel.activeTab = .cosmic
        }

        if let arcana = matrix.centerPosition?.tarotCard {
            todayRow(
                icon: "star.circle.fill",
                title: L10n.tabDestinyMatrix,
                value: arcana.localizedName,
                detail: MatrixPosition.PositionType.center.displayName
            ) {
                appViewModel.activeTab = .destinyMatrix
            }
        }
    }

    // MARK: - Row building

    private func todayRow(
        icon: String? = nil,
        emoji: String? = nil,
        title: String,
        value: String,
        detail: String?,
        action: @escaping () -> Void
    ) -> some View {
        Button {
            HapticService.shared.impact(.light)
            action()
        } label: {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(AppTheme.gold.opacity(0.12))
                        .frame(width: 48, height: 48)
                    if let emoji {
                        Text(emoji)
                            .font(.system(size: 26))
                    } else if let icon {
                        Image(systemName: icon)
                            .font(.system(size: 20))
                            .foregroundStyle(AppTheme.goldGradient)
                    }
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .textCase(.uppercase)
                        .foregroundColor(AppTheme.gold.opacity(0.8))

                    Text(value)
                        .font(AppTheme.serifFont(size: 20, weight: .regular))
                        .foregroundColor(AppTheme.textPrimary)

                    if let detail {
                        Text(detail)
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineLimit(2)
                    }
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(AppTheme.gold.opacity(0.5))
            }
            .padding(16)
            .background(cardBackground)
        }
        .buttonStyle(.plain)
    }

    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(AppTheme.darkNavy.opacity(0.6))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
            )
    }

    // MARK: - Data

    /// Same seeding as `CardOfTheDayView`, so both screens always show the same card.
    private func dailyCard() -> TarotCard {
        let seed: UInt64
        if let birthDate {
            seed = AstrologyService.shared.personalizedSeed(for: today, birthDate: birthDate)
        } else {
            seed = AstrologyService.shared.defaultSeed(for: today)
        }
        var generator = SeededRandomGenerator(seed: seed)
        let allCards = TarotDeck.allCards
        return allCards[Int(generator.next() % UInt64(allCards.count))]
    }
}

#Preview {
    TodayView()
        .environmentObject(AppViewModel())
}
