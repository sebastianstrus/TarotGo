//
//  SettingsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    private let notificationService = NotificationService.shared
    private let soundService = SoundService.shared
    @StateObject private var subscriptionService = SubscriptionService.shared
    @AppStorage("dailyCardNotificationEnabled") private var notificationEnabled: Bool = true
    @AppStorage("dailyCardNotificationHour") private var notificationHour: Int = 9
    @AppStorage("dailyCardNotificationMinute") private var notificationMinute: Int = 0
    @AppStorage("mercuryRetrogradeAlertsEnabled") private var mercuryAlertsEnabled: Bool = true
    @AppStorage("selectedCardBack") private var selectedCardBackRaw: String = CardBackStyle.modern.rawValue
    @AppStorage("isSoundEnabled") private var isSoundEnabled: Bool = true

    @State private var toggleState: Bool = false
    @State private var mercuryAlertsToggleState: Bool = false
    @State private var showOnboarding: Bool = false
    @State private var showPermissionAlert: Bool = false
    @State private var hasAppeared: Bool = false
    @State private var showBirthDateInput: Bool = false
    @State private var selectedDate: Date = Date()
    @State private var userBirthDate: Date? = AstrologyService.shared.userBirthDate
    @State private var showManageSubscriptions: Bool = false
    @State private var showPaywall: Bool = false
    
    private var selectedCardBack: CardBackStyle {
        CardBackStyle(rawValue: selectedCardBackRaw) ?? .modern
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            List {
                // Premium Section
                Section {
                    if subscriptionService.isPremium {
                        VStack(alignment: .leading, spacing: 14) {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(AppTheme.gold.opacity(0.15))
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(AppTheme.goldGradient)
                                        .font(.system(size: 18, weight: .semibold))
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(L10n.settingsPremiumActive)
                                        .foregroundColor(AppTheme.textPrimary)
                                        .font(.system(size: 16, weight: .semibold))
                                    if let planName = activePlanName {
                                        Text(planName)
                                            .foregroundColor(AppTheme.gold.opacity(0.8))
                                            .font(.system(size: 13))
                                    }
                                }
                                Spacer()
                            }

//                            Button {
//                                soundService.play(.click)
//                                HapticService.shared.impact(.light)
//                                showManageSubscriptions = true
//                            } label: {
//                                HStack {
//                                    Text(L10n.settingsPremiumManage)
//                                        .foregroundColor(AppTheme.textPrimary)
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                        .font(.system(size: 14))
//                                        .foregroundColor(AppTheme.gold.opacity(0.6))
//                                }
//                            }
//                            .buttonStyle(.plain)
                        }
                        .padding(.vertical, 4)
                        .listRowSeparator(.hidden)
                    } else {
                        Button {
                            soundService.play(.click)
                            HapticService.shared.impact(.light)
                            showPaywall = true
                        } label: {
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(AppTheme.gold.opacity(0.15))
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "crown.fill")
                                        .foregroundStyle(AppTheme.goldGradient)
                                        .font(.system(size: 18, weight: .semibold))
                                }

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(L10n.paywallTitle)
                                        .foregroundColor(AppTheme.textPrimary)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(L10n.paywallSubtitle)
                                        .foregroundColor(AppTheme.textSecondary)
                                        .font(.system(size: 12))
                                        .lineLimit(2)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(AppTheme.gold.opacity(0.6))
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text(L10n.settingsPremiumHeader)
                        .foregroundColor(AppTheme.gold)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)

                // Birth Date Section (at the top)
                Section {
                    if let birthDate = userBirthDate {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(L10n.settingsBirthDate)
                                    .foregroundColor(AppTheme.textPrimary)
                                Spacer()
                                Button(L10n.settingsChange) {
                                    showBirthDateInput = true
                                }
                                .foregroundStyle(AppTheme.goldGradient)
                                .font(.system(size: 14))
                            }
                            
                            HStack(spacing: 16) {
                                Text(birthDate.formatted(date: .long, time: .omitted))
                                    .foregroundColor(AppTheme.gold.opacity(0.8))
                                    .font(.system(size: 15))
                                
                                Spacer()
                                
                                let zodiacSign = AstrologyService.shared.zodiacSign(from: birthDate)
                                HStack(spacing: 4) {
                                    Text(zodiacSign.symbol)
                                        .font(.system(size: 18))
                                    Text(zodiacSign.name)
                                        .font(.system(size: 13))
                                        .foregroundColor(AppTheme.gold.opacity(0.7))
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    } else {
                        Button {
                            showBirthDateInput = true
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(L10n.settingsAddBirthDate)
                                        .foregroundColor(AppTheme.textPrimary)
                                    Text(L10n.settingsAddBirthDateDesc)
                                        .font(.system(size: 12))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundStyle(AppTheme.goldGradient)
                                    .font(.system(size: 24))
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                } header: {
                    Text(L10n.settingsPersonalization)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsBirthDateFooter)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Notifications Section
                Section {
                    VStack {
                        Toggle(L10n.settingsDailyReminder, isOn: $toggleState)
                            .listRowSeparator(.hidden)
                            .onChange(of: toggleState) { oldValue, newValue in
                                if hasAppeared && oldValue != newValue {
                                    soundService.play(.toggle)
                                }
                                handleNotificationToggle(newValue)
                            }
                            .tint(AppTheme.gold)
                        
                        if toggleState {
                            HStack {
                                Text(L10n.settingsReminderTime)
                                    .foregroundColor(AppTheme.textPrimary)
                                Spacer()
                                DatePicker(
                                    "",
                                    selection: $selectedDate,
                                    displayedComponents: .hourAndMinute
                                )
                                .labelsHidden()
                                .colorScheme(.dark)
                                .tint(AppTheme.gold)
                                .onChange(of: selectedDate) { oldValue, newValue in
                                    let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                                    notificationHour = components.hour ?? 9
                                    notificationMinute = components.minute ?? 0
                                    Task {
                                        await scheduleNotification()
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                } header: {
                    Text(L10n.settingsNotifications)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsDailyReminderDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Notifications Section
                Section {
                    Toggle(L10n.mercuryNotifications, isOn: $mercuryAlertsToggleState)
                        .listRowSeparator(.hidden)
                        .onChange(of: mercuryAlertsToggleState) { oldValue, newValue in
                            if hasAppeared && oldValue != newValue {
                                soundService.play(.toggle)
                            }
                            handleMercuryAlertsToggle(newValue)
                        }
                        .tint(AppTheme.gold)
                } footer: {
                    Text(L10n.mercuryNotificationsDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Sound Section
                Section {
                    Toggle(L10n.settingsSoundEnabled, isOn: $isSoundEnabled)
                        .listRowSeparator(.hidden)
                        .onChange(of: isSoundEnabled) { oldValue, newValue in
                            if hasAppeared && oldValue != newValue {
                                soundService.isSoundEnabled = newValue
                                if newValue {
                                    soundService.play(.toggle)
                                }
                            }
                        }
                        .tint(AppTheme.gold)
                } header: {
                    Text(L10n.settingsSound)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsSoundEnabledDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Appearance Section
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(L10n.settingsCardBack)
                            .foregroundColor(AppTheme.textPrimary)
                            .font(.system(size: 16))
                        
                        HStack(spacing: 4) {
                            ForEach(CardBackStyle.allCases) { style in
                                VStack(spacing: 6) {
                                    let isSelected = selectedCardBackRaw == style.rawValue
                                    
                                    ZStack {
                                        CardView(
                                            showGoldShadow: isSelected,
                                            cardBackStyleOverride: style
                                        )
                                        .padding(8)
                                        
                                        if isSelected {
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(AppTheme.goldGradient, lineWidth: 2.5)
                                        }
                                    }
                                    .frame(height: 120)
                                    
                                    VStack(spacing: 2) {
                                        Text(style.displayName)
                                            .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                                            .foregroundColor(isSelected ? AppTheme.gold : AppTheme.textPrimary)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                        
                                        Text(style.subtitle)
                                            .font(.system(size: 9, weight: .light))
                                            .foregroundColor(AppTheme.textSecondary.opacity(0.7))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.7)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedCardBackRaw = style.rawValue
                                    soundService.play(.click)
                                    HapticService.shared.impact(.light)
                                }
                            }
                        }
                        .frame(height: 140)
                    }
                    .padding(.vertical, 8)
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsAppearance)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsCardBackDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Info Section (Intro Slides Only)
                Section {
                    Button {
                        showOnboarding = true
                    } label: {
                        HStack {
                            Text(L10n.settingsIntroSlides)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }
                        .foregroundColor(AppTheme.textPrimary)
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsInfo)
                        .foregroundColor(AppTheme.gold)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)

                // Language Section (Now separated out)
                Section {
                    Button {
                        openLanguageSettings()
                    } label: {
                        HStack {
                            Text(L10n.settingsLanguage)
                            Spacer()
                            Text(currentLanguageName)
                                .foregroundColor(AppTheme.gold.opacity(0.8))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }
                        .foregroundColor(AppTheme.textPrimary)
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsLanguageSelection) // You can change this text to match your preference if you have a distinct header key
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsLanguageDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
                
                // Legal Section - Privacy Policy
                Section {
                    Button {
                        openURL("https://tarot-go.com/privacy.html")
                    } label: {
                        HStack {
                            Text(L10n.settingsPrivacyPolicy)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }
                        .foregroundColor(AppTheme.textPrimary)
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsLegal)
                        .foregroundColor(AppTheme.gold)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .listSectionSpacing(8)
                .padding(.top, 4)

                // Legal Section - Terms of Service
                Section {
                    Button {
                        openURL("https://tarot-go.com/terms.html")
                    } label: {
                        HStack {
                            Text(L10n.settingsTermsOfService)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }
                        .foregroundColor(AppTheme.textPrimary)
                    }
                    .listRowSeparator(.hidden)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.bottom, 4)
                
                // Rate App Section
                Section {
                    Button {
                        soundService.play(.click)
                        HapticService.shared.impact(.light)
                        ReviewService.shared.openWriteReviewPage()
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "star.fill")
                                .foregroundStyle(AppTheme.goldGradient)
                                .font(.system(size: 16))
                            Text(L10n.settingsRateApp)
                                .foregroundColor(AppTheme.textPrimary)
                            Spacer()
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsRateAppHeader)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsRateAppDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .buttonStyle(.plain)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)

                // About Section
                Section {
                    HStack {
                        Text(L10n.settingsVersion)
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?")
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                    }
                    .listRowSeparator(.hidden)
                } header: {
                    Text(L10n.settingsAbout)
                        .foregroundColor(AppTheme.gold)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.6))
                        .shadow(color: AppTheme.gold.opacity(0.1), radius: 2, x: 0, y: 1)
                )
                .listSectionSeparator(.hidden)
                .padding(.vertical, 4)
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .foregroundColor(AppTheme.textPrimary)
            .environment(\.defaultMinListRowHeight, 50)
        }
        .navigationTitle(L10n.settingsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            toggleState = notificationEnabled
            mercuryAlertsToggleState = mercuryAlertsEnabled
            soundService.isSoundEnabled = isSoundEnabled
            userBirthDate = AstrologyService.shared.userBirthDate

            // Initialize selectedDate from stored hour and minute
            var components = DateComponents()
            components.hour = notificationHour
            components.minute = notificationMinute
            if let date = Calendar.current.date(from: components) {
                selectedDate = date
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                hasAppeared = true
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingFlowView(isPresented: $showOnboarding)
        }
        .sheet(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                userBirthDate = date
            }
        }
        .manageSubscriptionsSheet(isPresented: $showManageSubscriptions)
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .alert(L10n.settingsNotificationPermissionTitle, isPresented: $showPermissionAlert) {
            Button(L10n.settingsNotificationPermissionCancel, role: .cancel) {
                toggleState = notificationEnabled
                mercuryAlertsToggleState = mercuryAlertsEnabled
            }
            Button(L10n.settingsNotificationPermissionSettings) {
                openNotificationSettings()
                toggleState = notificationEnabled
                mercuryAlertsToggleState = mercuryAlertsEnabled
            }
        } message: {
            Text(L10n.settingsNotificationPermissionMessage)
        }
    }
    
    private var activePlanName: String? {
        let purchased = subscriptionService.purchasedProductIDs
        if purchased.contains(SubscriptionProduct.yearly.rawValue) {
            return L10n.settingsPremiumPlanYearly
        }
        if purchased.contains(SubscriptionProduct.monthly.rawValue) {
            return L10n.settingsPremiumPlanMonthly
        }
        return nil
    }

    private var currentLanguageName: String {
        let currentLocale = Locale.current
        let languageCode = currentLocale.language.languageCode?.identifier ?? "en"
        
        // Get the localized language name in the current language
        if let languageName = currentLocale.localizedString(forLanguageCode: languageCode) {
            return languageName.capitalized
        }
        
        return "English"
    }
    
    private func handleNotificationToggle(_ enabled: Bool) {
        Task {
            if enabled {
                // Check current authorization status first
                let status = await notificationService.getAuthorizationStatus()
                
                if status == .denied {
                    // User previously denied, show alert to go to settings
                    await MainActor.run {
                        showPermissionAlert = true
                    }
                    return
                }
                
                let granted = await notificationService.requestAuthorization()
                if granted {
                    await scheduleNotification()
                    await MainActor.run {
                        notificationEnabled = true
                    }
                } else {
                    await MainActor.run {
                        toggleState = false
                        notificationEnabled = false
                    }
                }
            } else {
                notificationService.cancelDailyCardNotification()
                await MainActor.run {
                    notificationEnabled = false
                }
            }
        }
    }
    
    private func scheduleNotification() async {
        await notificationService.scheduleDailyCardNotification(
            at: notificationHour,
            minute: notificationMinute
        )
    }

    private func handleMercuryAlertsToggle(_ enabled: Bool) {
        Task {
            if enabled {
                let status = await notificationService.getAuthorizationStatus()
                if status == .denied {
                    await MainActor.run {
                        showPermissionAlert = true
                    }
                    return
                }
                let granted = await notificationService.requestAuthorization()
                if granted {
                    await notificationService.scheduleMercuryRetrogradeNotifications()
                    await MainActor.run {
                        mercuryAlertsEnabled = true
                    }
                } else {
                    await MainActor.run {
                        mercuryAlertsToggleState = false
                        mercuryAlertsEnabled = false
                    }
                }
            } else {
                notificationService.cancelMercuryRetrogradeNotifications()
                await MainActor.run {
                    mercuryAlertsEnabled = false
                }
            }
        }
    }
    
    private func openLanguageSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openNotificationSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
