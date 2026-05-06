//
//  SettingsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct SettingsView: View {
    private let notificationService = NotificationService.shared
    private let soundService = SoundService.shared
    @AppStorage("dailyCardNotificationEnabled") private var notificationEnabled: Bool = false
    @AppStorage("dailyCardNotificationHour") private var notificationHour: Int = 9
    @AppStorage("dailyCardNotificationMinute") private var notificationMinute: Int = 0
    @AppStorage("selectedCardBack") private var selectedCardBackRaw: String = CardBackStyle.modern.rawValue
    @AppStorage("isSoundEnabled") private var isSoundEnabled: Bool = true
    
    @State private var showingTimePicker: Bool = false
    @State private var toggleState: Bool = false
    @State private var showOnboarding: Bool = false
    @State private var showPermissionAlert: Bool = false
    @State private var hasAppeared: Bool = false
    
    private var selectedCardBack: CardBackStyle {
        CardBackStyle(rawValue: selectedCardBackRaw) ?? .modern
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            List {
                Section {
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
                            Spacer()
                            Text(formattedTime)
                                .foregroundColor(AppTheme.gold.opacity(0.8))
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showingTimePicker = true
                        }
                        .listRowSeparator(.hidden)
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
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
                
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
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
                
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
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
                
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
                    Text(L10n.settingsInfo)
                        .foregroundColor(AppTheme.gold)
                } footer: {
                    Text(L10n.settingsLanguageDesc)
                        .foregroundColor(AppTheme.textSecondary)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
                
                Section {
                    Button {
                        openURL("https://tarotgo.app/privacy.html")
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
                    
                    Button {
                        openURL("https://tarotgo.app/terms.html")
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
                } header: {
                    Text(L10n.settingsLegal)
                        .foregroundColor(AppTheme.gold)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
                
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
                        .fill(AppTheme.darkNavy.opacity(0.5))
                )
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(AppTheme.textPrimary)
        }
        .navigationTitle(L10n.settingsTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            toggleState = notificationEnabled
            soundService.isSoundEnabled = isSoundEnabled
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                hasAppeared = true
            }
        }
        .sheet(isPresented: $showingTimePicker) {
            TimePickerSheet(
                hour: $notificationHour,
                minute: $notificationMinute,
                isPresented: $showingTimePicker
            ) {
                Task {
                    await scheduleNotification()
                }
            }
        }
        .fullScreenCover(isPresented: $showOnboarding) {
            OnboardingFlowView(isPresented: $showOnboarding)
        }
        .alert(L10n.settingsNotificationPermissionTitle, isPresented: $showPermissionAlert) {
            Button(L10n.settingsNotificationPermissionCancel, role: .cancel) {
                toggleState = false
            }
            Button(L10n.settingsNotificationPermissionSettings) {
                openNotificationSettings()
                toggleState = false
            }
        } message: {
            Text(L10n.settingsNotificationPermissionMessage)
        }
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        var components = DateComponents()
        components.hour = notificationHour
        components.minute = notificationMinute
        
        if let date = Calendar.current.date(from: components) {
            return formatter.string(from: date)
        }
        return "\(notificationHour):\(String(format: "%02d", notificationMinute))"
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

struct TimePickerSheet: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var isPresented: Bool
    let onSave: () -> Void
    
    @State private var selectedDate: Date
    
    init(hour: Binding<Int>, minute: Binding<Int>, isPresented: Binding<Bool>, onSave: @escaping () -> Void) {
        self._hour = hour
        self._minute = minute
        self._isPresented = isPresented
        self.onSave = onSave
        
        var components = DateComponents()
        components.hour = hour.wrappedValue
        components.minute = minute.wrappedValue
        _selectedDate = State(initialValue: Calendar.current.date(from: components) ?? Date())
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                VStack {
                    DatePicker(
                        "Time",
                        selection: $selectedDate,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .colorScheme(.dark)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(L10n.settingsSetReminderTime)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(L10n.cancel) {
                        isPresented = false
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(L10n.save) {
                        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
                        hour = components.hour ?? 9
                        minute = components.minute ?? 0
                        isPresented = false
                        onSave()
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
