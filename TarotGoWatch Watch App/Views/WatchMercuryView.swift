//
//  WatchMercuryView.swift
//  TarotGoWatch Watch App
//

import SwiftUI

struct WatchMercuryView: View {
    @Environment(LanguageManager.self) private var languageManager

    private let now = Date()

    var body: some View {
        let service = MercuryRetrogradeService.shared
        let phase = service.currentPhase(for: now)
        let days = service.daysUntilNextPhaseChange(from: now)
        let activePeriod = service.activePeriod(for: now)
        let period = activePeriod ?? service.nextPeriod(after: now)

        ScrollView {
            VStack(spacing: 6) {
                Image(systemName: phase.iconName)
                    .font(.title)
                    .foregroundStyle(WatchTheme.goldGradient)

                Text(statusTitle(for: phase))
                    .font(WatchTheme.serif(.headline, weight: .medium))
                    .foregroundStyle(WatchTheme.goldGradient)
                    .multilineTextAlignment(.center)

                if days > 0 {
                    Text("\(days)")
                        .font(.system(.largeTitle, design: .serif, weight: .light))
                        .foregroundStyle(WatchTheme.gold)

                    Text(daysLabel(for: phase))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }

                if activePeriod != nil {
                    ProgressView(value: service.windowProgress(for: now))
                        .tint(WatchTheme.gold)
                        .padding(.vertical, 2)
                }

                Text(phase.shortDescription)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.85))

                if let period {
                    Divider().padding(.vertical, 4)
                    timeline(for: period)
                }
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle(WatchText.mercury)
        .containerBackground(WatchTheme.backgroundGradient, for: .navigation)
        .id(languageManager.language)
    }

    private func timeline(for period: MercuryRetrogradePeriod) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(WatchText.shadowTimeline)
                .font(WatchTheme.serif(.footnote, weight: .medium))
                .foregroundStyle(WatchTheme.goldGradient)

            Text("\(period.zodiacSign.symbol) \(period.zodiacSign.name)")
                .font(.caption2)
                .foregroundStyle(.secondary)

            timelineRow(L10n.mercuryPhasePreShadow, from: period.preShadowStart, to: period.retrogradeStart)
            timelineRow(L10n.mercuryPhaseRetrograde, from: period.retrogradeStart, to: period.retrogradeEnd)
            timelineRow(L10n.mercuryPhasePostShadow, from: period.retrogradeEnd, to: period.postShadowEnd)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func timelineRow(_ title: String, from start: Date, to end: Date) -> some View {
        let format = Date.FormatStyle.dateTime.month(.abbreviated).day()
        return VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.caption)
            Text("\(Text(start, format: format)) – \(Text(end, format: format))")
                .font(.caption2)
                .foregroundStyle(WatchTheme.gold)
        }
    }

    private func statusTitle(for phase: MercuryRetrogradePhase) -> String {
        switch phase {
        case .direct: return WatchText.string("mercury.status.direct")
        case .preShadow: return WatchText.string("mercury.status.preShadow")
        case .retrograde: return WatchText.string("mercury.status.active")
        case .postShadow: return WatchText.string("mercury.status.postShadow")
        }
    }

    private func daysLabel(for phase: MercuryRetrogradePhase) -> String {
        switch phase {
        case .direct: return WatchText.string("mercury.daysUntilPreShadow")
        case .preShadow: return WatchText.string("mercury.daysUntilStart")
        case .retrograde: return WatchText.string("mercury.daysUntilEnd")
        case .postShadow: return WatchText.string("mercury.daysUntilPostShadowEnd")
        }
    }
}

#Preview {
    NavigationStack {
        WatchMercuryView()
    }
    .environment(LanguageManager.shared)
}
