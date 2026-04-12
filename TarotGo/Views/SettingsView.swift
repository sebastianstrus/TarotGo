//
//  SettingsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var notificationService = NotificationService.shared
    @AppStorage("dailyCardNotificationEnabled") private var notificationEnabled: Bool = false
    @AppStorage("dailyCardNotificationHour") private var notificationHour: Int = 9
    @AppStorage("dailyCardNotificationMinute") private var notificationMinute: Int = 0
    
    @State private var showingTimePicker: Bool = false
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            
            List {
                Section {
                    Toggle("Daily Card Reminder", isOn: $notificationEnabled)
                        .onChange(of: notificationEnabled) { oldValue, newValue in
                            handleNotificationToggle(newValue)
                        }
                    
                    if notificationEnabled {
                        HStack {
                            Text("Reminder Time")
                            Spacer()
                            Text(formattedTime)
                                .foregroundColor(.secondary)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showingTimePicker = true
                        }
                    }
                } header: {
                    Text("Notifications")
                } footer: {
                    Text("Receive a daily reminder to draw your Card of the Day")
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("About")
                }
                .listRowBackground(Color.white.opacity(0.1))
            }
            .scrollContentBackground(.hidden)
            .foregroundColor(.white)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
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
    
    private func handleNotificationToggle(_ enabled: Bool) {
        Task {
            if enabled {
                let granted = await notificationService.requestAuthorization()
                if granted {
                    await scheduleNotification()
                } else {
                    await MainActor.run {
                        notificationEnabled = false
                    }
                }
            } else {
                notificationService.cancelDailyCardNotification()
            }
        }
    }
    
    private func scheduleNotification() async {
        await notificationService.scheduleDailyCardNotification(
            at: notificationHour,
            minute: notificationMinute
        )
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
                AnimatedBackgroundView()
                
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
            .navigationTitle("Set Reminder Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let components = Calendar.current.dateComponents([.hour, .minute], from: selectedDate)
                        hour = components.hour ?? 9
                        minute = components.minute ?? 0
                        isPresented = false
                        onSave()
                    }
                    .foregroundColor(.white)
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
