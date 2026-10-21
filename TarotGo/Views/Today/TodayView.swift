//
//  TodayView.swift
//  TarotGo
//
//  The home screen: a personalized "your day" dashboard that combines the card of the
//  day, moon phase, Mercury status, zodiac sign, numerology and Destiny Matrix, all
//  driven by the user's birth date. Every tile opens the matching feature directly.
//

import SwiftUI

private enum TodayDestination: Hashable {
    case cardOfDay
    case newReading
    case lunarCalendar
    case mercury
    case horoscope
    case numerology
    case destinyMatrix
    case coupleMatrix
    case compatibility
    case cosmogram
}

struct TodayView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @EnvironmentObject var subscriptionService: SubscriptionService

    @State private var destination: TodayDestination?
    @State private var birthDate: Date? = AstrologyService.shared.userBirthDate
    @State private var isCardRevealed: Bool = false
    @State private var isCardReversed: Bool = false
    @State private var showBirthDateInput: Bool = false
    @State private var showSettings: Bool = false
    @State private var showPaywall: Bool = false
    @State private var glow: Bool = false

    private let today = Date()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())

                ScrollView {
                    VStack(spacing: 28) {
                        header

                        if birthDate == nil {
                            birthDatePrompt
                        }

                        heroCard

                        section(L10n.todayCosmicNow) { cosmicTiles }

                        guidanceCard

                        if let birthDate {
                            section(L10n.yourPersonalNumbers) { numbersTiles(for: birthDate) }
                        }

                        section(L10n.todayExplore) { exploreGrid }
                    }
                    .padding(.horizontal)
                    // Leaves room for the Today button that rises above the tab bar.
                    .padding(.bottom, 56)
                }
            }
            .overlay(alignment: .topTrailing) { settingsButton }
            .navigationBarHidden(true)
            .toolbarVisibility(.hidden, for: .tabBar)
            .navigationDestination(item: $destination) { dest in
                destinationView(for: dest)
            }
            .onChange(of: destination) { _, newValue in
                withAnimation(.easeInOut(duration: 0.25)) {
                    let shouldHide = newValue == .cardOfDay || newValue == .newReading
                    appViewModel.tabBarVisibility = shouldHide ? .hidden : .visible
                }
                if newValue == nil { refreshCardState() }
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss { destination = nil }
            }
            .fullScreenCover(isPresented: $showBirthDateInput) {
                BirthDateInputView(isPresented: $showBirthDateInput) { date in
                    birthDate = date
                    refreshCardState()
                }
            }
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView()
            }
            .sheet(isPresented: $showSettings, onDismiss: {
                birthDate = AstrologyService.shared.userBirthDate
                refreshCardState()
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
                refreshCardState()
                withAnimation(.easeInOut(duration: 2.2).repeatForever(autoreverses: true)) {
                    glow = true
                }
            }
        }
    }

    // MARK: - Navigation

    @ViewBuilder
    private func destinationView(for destination: TodayDestination) -> some View {
        switch destination {
        case .cardOfDay: CardOfTheDayView()
        case .newReading: NewReadingView()
        case .lunarCalendar: LunarCalendarView()
        case .mercury: MercuryRetrogradeView()
        case .horoscope: HoroscopeView()
        case .numerology: NumerologyView()
        case .destinyMatrix:
            DestinyMatrixResultView(
                matrix: DestinyMatrixCalculator.shared.calculate(from: birthDate ?? today)
            )
        case .coupleMatrix: CoupleDestinyView()
        case .compatibility: CompatibilityView()
        case .cosmogram: CosmogramView()
        }
    }

    private func open(_ destination: TodayDestination, isPremium: Bool = false) {
        HapticService.shared.impact(.light)
        SoundService.shared.play(.whoosh, volume: 0.4)
        if isPremium && !subscriptionService.isPremium {
            showPaywall = true
        } else {
            self.destination = destination
        }
    }

    // MARK: - Header

    private var greeting: String {
        switch Calendar.current.component(.hour, from: today) {
        case 5..<12: return L10n.todayGreetingMorning
        case 12..<18: return L10n.todayGreetingAfternoon
        default: return L10n.todayGreetingEvening
        }
    }

    private var header: some View {
        VStack(spacing: 8) {
            Text(greeting)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)

            Text(L10n.todayTitle)
                .font(AppTheme.serifFont(size: 36, weight: .regular))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .font(.system(size: 7))
                    .foregroundColor(AppTheme.gold)

                Text(today.formatted(date: .complete, time: .omitted))
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.gold.opacity(0.85))

                Image(systemName: "star.fill")
                    .font(.system(size: 7))
                    .foregroundColor(AppTheme.gold)
            }
        }
        .padding(.top, 36)
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
                    .foregroundColor(AppTheme.deepNavy)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(AppTheme.goldGradient)
                    .cornerRadius(12)
                    .padding(.top, 4)
            }
            .padding(20)
            .background(panelBackground)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Hero: card of the day

    private var heroCard: some View {
        let (card, _) = dailyCard()
        return Button {
            open(.cardOfDay)
        } label: {
            HStack(spacing: 20) {
                CardView(
                    card: card,
                    showFront: isCardRevealed,
                    isReversed: isCardRevealed && isCardReversed
                )
                .frame(width: 118)
                .shadow(color: AppTheme.gold.opacity(glow ? 0.65 : 0.25), radius: glow ? 18 : 8)

                VStack(alignment: .leading, spacing: 10) {
                    Text(L10n.homeCardOfDay)
                        .font(.system(size: 12, weight: .semibold))
                        .textCase(.uppercase)
                        .foregroundColor(AppTheme.gold.opacity(0.85))

                    if isCardRevealed {
                        Text(card.localizedName)
                            .font(AppTheme.serifFont(size: 26, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    } else {
                        Text(L10n.todayRevealPrompt)
                            .font(AppTheme.serifFont(size: 20, weight: .light))
                            .foregroundColor(AppTheme.textPrimary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer(minLength: 0)

                    HStack(spacing: 6) {
                        Text(isCardRevealed ? L10n.todayOpenCard : L10n.todayRevealButton)
                            .font(.system(size: 14, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .foregroundColor(AppTheme.deepNavy)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(AppTheme.goldGradient)
                    .clipShape(Capsule())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(
                        LinearGradient(
                            colors: [Color(red: 0.22, green: 0.12, blue: 0.42).opacity(0.85),
                                     AppTheme.darkNavy.opacity(0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(AppTheme.goldGradient, lineWidth: 1.2)
                    )
            )
            .shadow(color: AppTheme.gold.opacity(0.18), radius: 16, y: 6)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Cosmic tiles

    private var cosmicTiles: some View {
        let moon = LunarService.shared.moonPhase(for: today)
        let illumination = LunarService.shared.illuminationPercentage(for: today)
        let mercury = MercuryRetrogradeService.shared.currentPhase(for: today)

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                tile(
                    title: L10n.lunarCalendarTitle,
                    value: moon.rawValue,
                    detail: "\(L10n.lunarCalendarIlluminated) \(Int(illumination.rounded()))%",
                    progress: illumination / 100
                ) {
                    Text(moon.symbol).font(.system(size: 46))
                } action: {
                    open(.lunarCalendar)
                }

                tile(
                    title: L10n.mercuryTitle,
                    value: mercury.title,
                    detail: mercury.shortDescription
                ) {
                    Image("ic_cosmic_mercury")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 6)
                } action: {
                    open(.mercury)
                }

                if let birthDate {
                    let sign = AstrologyService.shared.zodiacSign(from: birthDate)
                    tile(
                        title: L10n.horoscopeTitle,
                        value: sign.name,
                        detail: nil
                    ) {
                        Text(sign.symbol).font(.system(size: 46))
                    } action: {
                        open(.horoscope)
                    }
                } else {
                    tile(
                        title: L10n.horoscopeTitle,
                        value: L10n.horoscopeTitle,
                        detail: nil
                    ) {
                        Image("ic_cosmic_horoscope")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 52, height: 52)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 6)
                    } action: {
                        open(.horoscope)
                    }
                }
            }
            .padding(.horizontal, 2)
            .padding(.vertical, 4)
        }
        .scrollClipDisabled()
    }

    // MARK: - Guidance

    private var guidanceCard: some View {
        let moon = LunarService.shared.moonPhase(for: today)
        let mercuryPhase = MercuryRetrogradeService.shared.currentPhase(for: today)
        let dos = MercuryRetrogradeService.shared.dosList(for: mercuryPhase).prefix(2)

        return VStack(alignment: .leading, spacing: 16) {
            Text(L10n.todayGuidance)
                .font(AppTheme.serifFont(size: 20, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)

            VStack(alignment: .leading, spacing: 6) {
                Label(L10n.todayMoonEnergy, systemImage: "moon.stars.fill")
                    .font(.system(size: 12, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundColor(AppTheme.gold.opacity(0.85))

                Text(moon.energy)
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Divider().overlay(AppTheme.gold.opacity(0.25))

            VStack(alignment: .leading, spacing: 8) {
                Label(L10n.todayMercuryAdvice, systemImage: mercuryPhase.iconName)
                    .font(.system(size: 12, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundColor(AppTheme.gold.opacity(0.85))

                ForEach(Array(dos), id: \.self) { item in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "sparkle")
                            .font(.system(size: 11))
                            .foregroundColor(AppTheme.gold)
                            .padding(.top, 4)
                        Text(item)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(panelBackground)
    }

    // MARK: - Numbers

    private func numbersTiles(for birthDate: Date) -> some View {
        let lifePath = AstrologyService.shared.lifePathNumber(from: birthDate)
        let center = DestinyMatrixCalculator.shared.calculate(from: birthDate).centerPosition

        return HStack(spacing: 12) {
            numberTile(
                title: L10n.numerologyTitle,
                number: "\(lifePath)",
                caption: L10n.yourLifePathNumber,
                isLocked: false
            ) {
                open(.numerology)
            }

            if let center {
                numberTile(
                    title: L10n.tabDestinyMatrix,
                    number: "\(center.number)",
                    caption: center.tarotCard?.localizedName ?? center.position.displayName,
                    isLocked: !subscriptionService.isPremium
                ) {
                    open(.destinyMatrix, isPremium: true)
                }
            }
        }
    }

    private func numberTile(
        title: String,
        number: String,
        caption: String,
        isLocked: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundColor(AppTheme.gold.opacity(0.85))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(number)
                    .font(.system(size: 64, weight: .thin))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)

                Text(caption)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 10)
            .background(panelBackground)
            .overlay(alignment: .topTrailing) {
                if isLocked {
                    PremiumBadge(size: .small)
                        .padding(8)
                }
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Explore

    private var exploreGrid: some View {
        let isPremium = subscriptionService.isPremium
        return LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
            exploreTile(icon: "ic_new_tarot_reading", title: L10n.homeNewReading, isLocked: !isPremium) {
                open(.newReading, isPremium: true)
            }
            exploreTile(icon: "ic_couple_destiny", title: L10n.homeCoupleDestiny, isLocked: !isPremium) {
                open(.coupleMatrix, isPremium: true)
            }
            exploreTile(icon: "ic_cosmic_compatibility", title: L10n.compatibilityTitle, isLocked: !isPremium) {
                open(.compatibility, isPremium: true)
            }
            exploreTile(icon: "ic_cosmic_cosmogram", title: L10n.cosmogramTitle, isLocked: false) {
                open(.cosmogram)
            }
        }
    }

    private func exploreTile(icon: String, title: String, isLocked: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 5)

                Text(title)
                    .font(AppTheme.serifFont(size: 15, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Spacer(minLength: 0)
            }
            .padding(14)
            .background(panelBackground)
            .overlay(alignment: .topTrailing) {
                if isLocked {
                    PremiumBadge(size: .small)
                        .scaleEffect(0.8, anchor: .topTrailing)
                        .offset(x: -4, y: 4)
                }
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Building blocks

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(AppTheme.serifFont(size: 20, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
                .padding(.leading, 2)
            content()
        }
    }

    private func tile<Icon: View>(
        title: String,
        value: String,
        detail: String?,
        progress: Double? = nil,
        @ViewBuilder icon: () -> Icon,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                icon()
                    .frame(height: 52)

                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                    .textCase(.uppercase)
                    .foregroundColor(AppTheme.gold.opacity(0.85))
                    .lineLimit(1)

                Text(value)
                    .font(AppTheme.serifFont(size: 19, weight: .regular))
                    .foregroundColor(AppTheme.textPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                if let progress {
                    ProgressView(value: min(max(progress, 0), 1))
                        .tint(AppTheme.gold)
                }

                if let detail {
                    Text(detail)
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }

                Spacer(minLength: 0)
            }
            .frame(width: 158, height: 200, alignment: .topLeading)
            .padding(16)
            .background(panelBackground)
        }
        .buttonStyle(.plain)
    }

    private var panelBackground: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(AppTheme.darkNavy.opacity(0.65))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
            )
    }

    // MARK: - Data

    /// Same seeding as `CardOfTheDayView`, so both screens always show the same card.
    private func dailyCard() -> (card: TarotCard, isReversed: Bool) {
        let seed: UInt64
        if let birthDate {
            seed = AstrologyService.shared.personalizedSeed(for: today, birthDate: birthDate)
        } else {
            seed = AstrologyService.shared.defaultSeed(for: today)
        }
        var generator = SeededRandomGenerator(seed: seed)
        let allCards = TarotDeck.allCards
        let card = allCards[Int(generator.next() % UInt64(allCards.count))]
        let reversed = generator.next() % 100 < 30
        return (card, reversed)
    }

    /// Reads the shared daily-card store so the hero reflects a reveal done in the app, widget or watch.
    private func refreshCardState() {
        let (card, reversed) = dailyCard()
        let stored = DailyCardStore.load()
        isCardRevealed = stored?.isToday == true && stored?.isRevealed == true && stored?.cardID == card.id
        isCardReversed = reversed
    }
}

#Preview {
    TodayView()
        .environmentObject(AppViewModel())
        .environmentObject(SubscriptionService.shared)
}
