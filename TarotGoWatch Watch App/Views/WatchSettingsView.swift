//
//  WatchSettingsView.swift
//  TarotGoWatch Watch App
//

import SwiftUI
import UserNotifications
import WatchKit

struct WatchSettingsView: View {
    @Environment(LanguageManager.self) private var languageManager
    @AppStorage(WatchNotificationService.enabledKey) private var remindersEnabled = true
    @AppStorage(WatchNotificationService.hourKey) private var reminderHour = 9
    @AppStorage(WatchNotificationService.minuteKey) private var reminderMinute = 0
    @State private var showPermissionAlert = false

    private var versionText: String {
        let info = Bundle.main.infoDictionary
        let version = info?["CFBundleShortVersionString"] as? String ?? "?"
        let build = info?["CFBundleVersion"] as? String ?? "?"
        return "\(version) (\(build))"
    }

    var body: some View {
        List {
            Section {
                NavigationLink {
                    WatchLanguagePickerView()
                } label: {
                    HStack {
                        Text(WatchText.language)
                        Spacer()
                        Text("\(languageManager.language.flag) \(languageManager.language.displayName)")
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                }
            }

            Section(WatchText.notifications) {
                Toggle(WatchText.dailyReminder, isOn: remindersBinding)

                if remindersEnabled {
                    DatePicker(
                        WatchText.reminderTime,
                        selection: reminderTimeBinding,
                        displayedComponents: .hourAndMinute
                    )
                }
            }

            Section {
                HStack {
                    Text(WatchText.version)
                    Spacer()
                    Text(versionText)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle(WatchText.settings)
        .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
        .id(languageManager.language)
        .alert(WatchText.permissionTitle, isPresented: $showPermissionAlert) {
            Button(WatchText.cancel, role: .cancel) {}
        } message: {
            Text(WatchText.permissionMessage)
        }
        .onChange(of: languageManager.language) {
            // The notification text is baked in when scheduled, so refresh it.
            Task { await WatchNotificationService.shared.refreshIfEnabled() }
        }
    }

    private var remindersBinding: Binding<Bool> {
        Binding(
            get: { remindersEnabled },
            set: { newValue in
                if newValue {
                    Task { await enableReminders() }
                } else {
                    remindersEnabled = false
                    WatchNotificationService.shared.cancelDailyCard()
                }
            }
        )
    }

    private var reminderTimeBinding: Binding<Date> {
        Binding(
            get: {
                Calendar.current.date(from: DateComponents(hour: reminderHour, minute: reminderMinute)) ?? Date()
            },
            set: { date in
                let parts = Calendar.current.dateComponents([.hour, .minute], from: date)
                reminderHour = parts.hour ?? 9
                reminderMinute = parts.minute ?? 0
                Task {
                    await WatchNotificationService.shared.scheduleDailyCard(hour: reminderHour, minute: reminderMinute)
                }
            }
        )
    }

    private func enableReminders() async {
        let service = WatchNotificationService.shared
        var status = await service.authorizationStatus()
        if status == .notDetermined {
            _ = await service.requestAuthorization()
            status = await service.authorizationStatus()
        }

        guard status == .authorized else {
            remindersEnabled = false
            showPermissionAlert = true
            return
        }
        remindersEnabled = true
        await service.scheduleDailyCard(hour: reminderHour, minute: reminderMinute)
    }
}

struct WatchLanguagePickerView: View {
    @Environment(LanguageManager.self) private var languageManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List(AppLanguage.allCases) { language in
            Button {
                languageManager.language = language
                WKInterfaceDevice.current().play(.click)
                dismiss()
            } label: {
                HStack {
                    Text(language.flag)
                    Text(language.displayName)
                    Spacer()
                    if language == languageManager.language {
                        Image(systemName: "checkmark")
                            .foregroundStyle(WatchTheme.gold)
                    }
                }
            }
        }
        .navigationTitle(WatchText.language)
        .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
    }
}

#Preview {
    NavigationStack {
        WatchSettingsView()
    }
    .environment(LanguageManager.shared)
}
