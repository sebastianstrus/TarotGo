//
//  WatchMoonView.swift
//  TarotGoWatch Watch App
//

import SwiftUI

struct WatchMoonView: View {
    @Environment(LanguageManager.self) private var languageManager

    private let now = Date()

    var body: some View {
        let service = LunarService.shared
        let phase = service.moonPhase(for: now)
        let illumination = Int(service.illuminationPercentage(for: now).rounded())

        ScrollView {
            VStack(spacing: 6) {
                Text(phase.symbol)
                    .font(.system(size: 54))

                Text(phase.rawValue)
                    .font(WatchTheme.serif(.headline, weight: .medium))
                    .foregroundStyle(WatchTheme.goldGradient)
                    .multilineTextAlignment(.center)

                Text("\(illumination)% \(WatchText.illuminated)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Divider().padding(.vertical, 4)

                nextPhaseRow(.fullMoon)
                nextPhaseRow(.newMoon)

                Divider().padding(.vertical, 4)

                Text(phase.energy)
                    .font(WatchTheme.serif(.footnote, weight: .medium))
                    .foregroundStyle(WatchTheme.goldGradient)
                    .multilineTextAlignment(.center)

                Text(phase.description)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.85))
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle(WatchText.moon)
        .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
        .id(languageManager.language)
    }

    private func nextPhaseRow(_ target: MoonPhase) -> some View {
        HStack(spacing: 6) {
            Text(target.symbol)
            Text(target.rawValue)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Spacer(minLength: 4)
            if let date = nextDate(of: target) {
                Text(date, format: .dateTime.month(.abbreviated).day())
                    .foregroundStyle(WatchTheme.gold)
            }
        }
        .font(.footnote)
    }

    /// First day on which the moon enters the given phase (today if it is already in it).
    private func nextDate(of target: MoonPhase) -> Date? {
        let service = LunarService.shared
        var previous = service.moonPhase(for: now)
        if previous == target { return now }

        for offset in 1...35 {
            guard let day = Calendar.current.date(byAdding: .day, value: offset, to: now) else { continue }
            let phase = service.moonPhase(for: day)
            if phase == target && previous != target { return day }
            previous = phase
        }
        return nil
    }
}

#Preview {
    NavigationStack {
        WatchMoonView()
    }
    .environment(LanguageManager.shared)
}
