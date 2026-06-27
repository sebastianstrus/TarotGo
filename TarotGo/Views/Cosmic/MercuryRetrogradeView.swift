//
//  MercuryRetrogradeView.swift
//  TarotGo
//
//  Mercury retrograde status, shadow timeline, personal impact, and alerts.
//

import SwiftUI

struct MercuryRetrogradeView: View {
    @AppStorage("mercuryRetrogradeAlertsEnabled") private var alertsEnabled: Bool = false

    @State private var now: Date = Date()
    @State private var userBirthDate: Date? = AstrologyService.shared.userBirthDate
    @State private var alertsToggleState: Bool = false
    @State private var hasAppeared: Bool = false
    @State private var showPermissionAlert: Bool = false

    private let service = MercuryRetrogradeService.shared
    private let notificationService = NotificationService.shared
    private let soundService = SoundService.shared

    private var activePeriod: MercuryRetrogradePeriod? {
        service.activePeriod(for: now)
    }

    private var displayedPeriod: MercuryRetrogradePeriod? {
        activePeriod ?? service.nextPeriod(after: now)
    }

    private var currentPhase: MercuryRetrogradePhase {
        service.currentPhase(for: now)
    }

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(spacing: 28) {
                    header

                    statusCard

                    if let period = displayedPeriod {
                        shadowTimeline(for: period)
                    }

                    personalImpactCard

                    dosAndDontsCard

                    upcomingRetrogradesCard

                    alertsCard

                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.mercuryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: LearnMercuryRetrogradeView()) {
                    Image(systemName: "book.fill")
                        .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
        .onAppear {
            now = Date()
            userBirthDate = AstrologyService.shared.userBirthDate
            alertsToggleState = alertsEnabled
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                hasAppeared = true
            }
        }
        .alert(L10n.settingsNotificationPermissionTitle, isPresented: $showPermissionAlert) {
            Button(L10n.settingsNotificationPermissionCancel, role: .cancel) {
                alertsToggleState = false
            }
            Button(L10n.settingsNotificationPermissionSettings) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
                alertsToggleState = false
            }
        } message: {
            Text(L10n.settingsNotificationPermissionMessage)
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 12) {
            Image("ic_cosmic_mercury")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 64, height: 64)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)

            Text(L10n.mercuryTitle)
                .font(AppTheme.serifFont(size: 32, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
                .multilineTextAlignment(.center)

            Text(now.formatted(date: .long, time: .omitted))
                .font(.system(size: 15, weight: .light))
                .foregroundColor(AppTheme.gold.opacity(0.8))
        }
        .padding(.top, 20)
    }

    // MARK: - Status Card

    private var statusCard: some View {
        VStack(spacing: 18) {
            let isRetrograde = currentPhase == .retrograde

            HStack(spacing: 12) {
                Image(systemName: currentPhase.iconName)
                    .font(.system(size: 28))
                    .foregroundStyle(AppTheme.goldGradient)

                VStack(alignment: .leading, spacing: 4) {
                    Text(statusHeadline)
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    if let signLine = currentSignLine {
                        Text(signLine)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                Spacer()
            }

            Text(currentPhase.shortDescription)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .lineSpacing(5)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let countdown = countdownLine {
                HStack(spacing: 10) {
                    Image(systemName: "hourglass")
                        .foregroundColor(AppTheme.gold)
                    Text(countdown)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            if isRetrograde {
                pulsingRetrogradeBadge
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.35), lineWidth: 1)
                )
        )
    }

    private var statusHeadline: String {
        switch currentPhase {
        case .direct:       return L10n.mercuryStatusDirect
        case .preShadow:    return L10n.mercuryStatusPreShadow
        case .retrograde:   return L10n.mercuryStatusActive
        case .postShadow:   return L10n.mercuryStatusPostShadow
        }
    }

    private var currentSignLine: String? {
        guard let period = displayedPeriod else { return nil }
        let connector = L10n.mercuryInSign
        let symbol = period.zodiacSign.symbol
        let name = period.zodiacSign.name
        if let secondary = period.secondaryZodiacSign {
            return "\(connector) \(symbol) \(name) / \(secondary.symbol) \(secondary.name)"
        }
        return "\(connector) \(symbol) \(name)"
    }

    private var countdownLine: String? {
        let days = service.daysUntilNextPhaseChange(from: now)
        guard days > 0 else { return nil }
        let label: String
        switch currentPhase {
        case .direct:       label = L10n.mercuryDaysUntilPreShadow
        case .preShadow:    label = L10n.mercuryDaysUntilStart
        case .retrograde:   label = L10n.mercuryDaysUntilEnd
        case .postShadow:   label = L10n.mercuryDaysUntilPostShadowEnd
        }
        return "\(days) \(label)"
    }

    private var pulsingRetrogradeBadge: some View {
        TimelineView(.animation(minimumInterval: 0.05)) { ctx in
            let t = ctx.date.timeIntervalSinceReferenceDate
            let pulse = (sin(t * 2) + 1) / 2
            HStack(spacing: 8) {
                Circle()
                    .fill(AppTheme.lightGold)
                    .frame(width: 8, height: 8)
                    .shadow(color: AppTheme.gold.opacity(0.7 + 0.3 * pulse),
                            radius: 4 + 4 * pulse)
                Text(L10n.mercuryStatusActive.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .tracking(2)
                    .foregroundColor(AppTheme.gold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Shadow Timeline

    private func shadowTimeline(for period: MercuryRetrogradePeriod) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(AppTheme.gold)
                Text(L10n.mercuryShadowTimeline)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            timelineBar(for: period)

            VStack(spacing: 10) {
                timelineRow(
                    label: L10n.mercuryPhasePreShadow,
                    date: period.preShadowStart,
                    isCurrent: currentPhase == .preShadow && service.activePeriod(for: now)?.id == period.id
                )
                timelineRow(
                    label: L10n.mercuryPhaseRetrograde,
                    date: period.retrogradeStart,
                    isCurrent: currentPhase == .retrograde && service.activePeriod(for: now)?.id == period.id
                )
                timelineRow(
                    label: L10n.mercuryStatusDirect,
                    date: period.retrogradeEnd,
                    isCurrent: false
                )
                timelineRow(
                    label: L10n.mercuryPhasePostShadow + " " + L10n.mercuryStatusDirect,
                    date: period.postShadowEnd,
                    isCurrent: currentPhase == .postShadow && service.activePeriod(for: now)?.id == period.id
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }

    private func timelineBar(for period: MercuryRetrogradePeriod) -> some View {
        let totalDuration = period.postShadowEnd.timeIntervalSince(period.preShadowStart)
        let preShadowWidth = period.retrogradeStart.timeIntervalSince(period.preShadowStart) / totalDuration
        let retrogradeWidth = period.retrogradeEnd.timeIntervalSince(period.retrogradeStart) / totalDuration
        let postShadowWidth = 1.0 - preShadowWidth - retrogradeWidth
        let isInPeriod = service.activePeriod(for: now)?.id == period.id
        let progress = isInPeriod ? service.windowProgress(for: now) : nil

        return GeometryReader { geo in
            let w = geo.size.width
            ZStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.25))
                        .frame(width: w * preShadowWidth)
                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.7))
                        .frame(width: w * retrogradeWidth)
                    Rectangle()
                        .fill(AppTheme.gold.opacity(0.25))
                        .frame(width: w * postShadowWidth)
                }
                .frame(height: 10)
                .clipShape(Capsule())

                if let progress {
                    Capsule()
                        .fill(AppTheme.lightGold)
                        .frame(width: 3, height: 18)
                        .shadow(color: AppTheme.gold, radius: 4)
                        .offset(x: w * CGFloat(progress) - 1.5)
                }
            }
            .frame(height: 18)
        }
        .frame(height: 18)
    }

    private func timelineRow(label: String, date: Date, isCurrent: Bool) -> some View {
        HStack {
            Circle()
                .fill(isCurrent ? AppTheme.lightGold : AppTheme.gold.opacity(0.4))
                .frame(width: 8, height: 8)
                .shadow(color: isCurrent ? AppTheme.gold : .clear, radius: 4)

            Text(label)
                .font(.system(size: 13, weight: isCurrent ? .semibold : .regular))
                .foregroundColor(isCurrent ? AppTheme.gold : AppTheme.textSecondary)

            Spacer()

            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.system(size: 13, weight: .light))
                .foregroundColor(AppTheme.gold.opacity(0.8))
        }
    }

    // MARK: - Personal Impact

    private var personalImpactCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "person.fill.viewfinder")
                    .foregroundColor(AppTheme.gold)
                Text(L10n.mercuryYourSignImpact)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            if let birthDate = userBirthDate, let period = displayedPeriod {
                let userSign = AstrologyService.shared.zodiacSign(from: birthDate)
                let impact = service.impactDescription(
                    userSign: userSign,
                    retrogradeSign: period.zodiacSign
                )

                HStack(spacing: 14) {
                    VStack(spacing: 2) {
                        Text(userSign.symbol)
                            .font(.system(size: 32))
                        Text(userSign.name)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(AppTheme.gold)
                    }
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.gold.opacity(0.6))
                    VStack(spacing: 2) {
                        Text(period.zodiacSign.symbol)
                            .font(.system(size: 32))
                        Text(period.zodiacSign.name)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(AppTheme.gold)
                    }
                    Spacer()
                }

                Text(impact)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(5)
            } else {
                Text(L10n.mercuryAddBirthDateForImpact)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(5)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }

    // MARK: - Do's & Don'ts

    private var dosAndDontsCard: some View {
        VStack(spacing: 16) {
            dosListView
            dontsListView
        }
    }

    private var dosListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(AppTheme.gold)
                Text(L10n.mercuryDos)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            ForEach(service.dosList(for: currentPhase), id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 8))
                        .foregroundColor(AppTheme.gold)
                        .padding(.top, 6)
                    Text(item)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1)
                )
        )
    }

    private var dontsListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "xmark.seal.fill")
                    .foregroundColor(AppTheme.gold.opacity(0.8))
                Text(L10n.mercuryDonts)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            ForEach(service.dontsList(for: currentPhase), id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 6))
                        .foregroundColor(AppTheme.gold.opacity(0.6))
                        .padding(.top, 7)
                    Text(item)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1)
                )
        )
    }

    // MARK: - Upcoming Retrogrades

    private var upcomingRetrogradesCard: some View {
        let upcoming = service.upcomingPeriods(from: now, count: 5)

        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                Image(systemName: "list.star")
                    .foregroundColor(AppTheme.gold)
                Text(L10n.mercuryUpcoming)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(spacing: 10) {
                ForEach(upcoming) { period in
                    HStack(spacing: 12) {
                        Text(period.zodiacSign.symbol)
                            .font(.system(size: 26))

                        VStack(alignment: .leading, spacing: 2) {
                            Text(rangeText(start: period.retrogradeStart, end: period.retrogradeEnd))
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(AppTheme.gold)
                            Text(period.zodiacSign.name)
                                .font(.system(size: 12, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                        }

                        Spacer()

                        if period.contains(now) {
                            Text(L10n.lunarCalendarToday)
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(AppTheme.gold)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule().fill(AppTheme.gold.opacity(0.2))
                                )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppTheme.darkNavy.opacity(0.4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                            )
                    )
                }
            }
        }
    }

    private func rangeText(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        let startStr = formatter.string(from: start)
        let endStr = formatter.string(from: end)
        let year = Calendar.current.component(.year, from: start)
        return "\(startStr) – \(endStr), \(year)"
    }

    // MARK: - Alerts toggle

    private var alertsCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle(isOn: $alertsToggleState) {
                HStack(spacing: 10) {
                    Image(systemName: "bell.badge.fill")
                        .foregroundColor(AppTheme.gold)
                    Text(L10n.mercuryNotifications)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                }
            }
            .tint(AppTheme.gold)
            .onChange(of: alertsToggleState) { oldValue, newValue in
                if hasAppeared && oldValue != newValue {
                    soundService.play(.toggle)
                }
                handleAlertsToggle(newValue)
            }

            Text(L10n.mercuryNotificationsDesc)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }

    private func handleAlertsToggle(_ enabled: Bool) {
        Task {
            if enabled {
                let status = await notificationService.getAuthorizationStatus()
                if status == .denied {
                    await MainActor.run { showPermissionAlert = true }
                    return
                }
                let granted = await notificationService.requestAuthorization()
                if granted {
                    await notificationService.scheduleMercuryRetrogradeNotifications()
                    await MainActor.run { alertsEnabled = true }
                } else {
                    await MainActor.run {
                        alertsToggleState = false
                        alertsEnabled = false
                    }
                }
            } else {
                notificationService.cancelMercuryRetrogradeNotifications()
                await MainActor.run { alertsEnabled = false }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MercuryRetrogradeView()
    }
}
