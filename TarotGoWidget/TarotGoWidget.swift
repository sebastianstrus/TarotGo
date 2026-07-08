//
//  TarotGoWidget.swift
//  TarotGoWidget
//

import WidgetKit
import SwiftUI

// MARK: - Colors (mirrors AppTheme so widget stays consistent)

private enum WidgetTheme {
    static let gold = Color(red: 212/255, green: 175/255, blue: 55/255)
    static let lightGold = Color(red: 255/255, green: 215/255, blue: 0/255)
    static let darkGold = Color(red: 184/255, green: 134/255, blue: 11/255)
    static let deepNavy = Color(red: 10/255, green: 10/255, blue: 25/255)
    static let darkNavy = Color(red: 15/255, green: 15/255, blue: 35/255)
    static let midNavy = Color(red: 20/255, green: 20/255, blue: 45/255)

    static let goldGradient = LinearGradient(
        colors: [lightGold, gold, darkGold],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let backgroundGradient = LinearGradient(
        colors: [deepNavy, darkNavy, .black],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static func serifFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .serif)
    }
}

// MARK: - Localized strings

private enum WidgetStrings {
    static let title = NSLocalizedString(
        "widget.cardOfTheDay.title",
        value: "Card of the Day",
        comment: "Widget headline"
    )
    static let tapToReveal = NSLocalizedString(
        "widget.cardOfTheDay.tapToReveal",
        value: "Tap to reveal today's card",
        comment: "Widget hint shown before user reveals the card"
    )
    static let awaiting = NSLocalizedString(
        "widget.cardOfTheDay.awaiting",
        value: "Your card awaits",
        comment: "Short hint on the small widget"
    )
    static let todaysEnergy = NSLocalizedString(
        "widget.cardOfTheDay.todaysEnergy",
        value: "Today's energy",
        comment: "Label above the revealed card name"
    )
    static let reversed = NSLocalizedString(
        "widget.cardOfTheDay.reversed",
        value: "reversed",
        comment: "Suffix for reversed cards"
    )
}

// MARK: - Timeline

struct DailyCardEntry: TimelineEntry {
    let date: Date
    let info: DailyCardInfo?
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DailyCardEntry {
        DailyCardEntry(date: Date(), info: nil)
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyCardEntry) -> Void) {
        completion(DailyCardEntry(date: Date(), info: DailyCardStore.load()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<DailyCardEntry>) -> Void) {
        let now = Date()
        let stored = DailyCardStore.load()
        let currentEntry = DailyCardEntry(date: now, info: stored?.isToday == true ? stored : nil)

        // Refresh at the next midnight so the widget resets to "awaiting" for a new day.
        let calendar = Calendar.current
        let startOfTomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now)) ?? now.addingTimeInterval(60 * 60 * 6)
        let midnightEntry = DailyCardEntry(date: startOfTomorrow, info: nil)

        let timeline = Timeline(entries: [currentEntry, midnightEntry], policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Views

struct TarotGoWidgetEntryView: View {
    @Environment(\.widgetFamily) private var family
    let entry: DailyCardEntry

    var body: some View {
        switch family {
        case .systemSmall:
            smallView
        case .systemMedium:
            mediumView
        case .accessoryRectangular:
            rectangularAccessory
        case .accessoryCircular:
            circularAccessory
        case .accessoryInline:
            inlineAccessory
        default:
            smallView
        }
    }

    // MARK: Home Screen - Small

    private var smallView: some View {
        VStack(spacing: 6) {
            cardBackIcon(size: 44)

            Text(WidgetStrings.title)
                .font(WidgetTheme.serifFont(size: 13, weight: .semibold))
                .foregroundStyle(WidgetTheme.goldGradient)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            if let info = entry.info, info.isRevealed {
                Text(info.localizedName)
                    .font(WidgetTheme.serifFont(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                if info.isReversed {
                    Text(WidgetStrings.reversed)
                        .font(.system(size: 9, weight: .light))
                        .foregroundColor(WidgetTheme.gold.opacity(0.8))
                }
            } else {
                Text(WidgetStrings.awaiting)
                    .font(.system(size: 10, weight: .light))
                    .foregroundColor(.white.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .widget) { WidgetTheme.backgroundGradient }
        .widgetURL(deepLinkURL)
    }

    // MARK: Home Screen - Medium

    private var mediumView: some View {
        HStack(spacing: 14) {
            cardBackIcon(size: 68)

            VStack(alignment: .leading, spacing: 6) {
                Text(WidgetStrings.title)
                    .font(WidgetTheme.serifFont(size: 17, weight: .semibold))
                    .foregroundStyle(WidgetTheme.goldGradient)

                if let info = entry.info, info.isRevealed {
                    Text(WidgetStrings.todaysEnergy)
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(.white.opacity(0.6))
                        .textCase(.uppercase)
                        .tracking(0.5)

                    Text(info.localizedName)
                        .font(WidgetTheme.serifFont(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)

                    if info.isReversed {
                        Text(WidgetStrings.reversed)
                            .font(.system(size: 11, weight: .light))
                            .italic()
                            .foregroundColor(WidgetTheme.gold.opacity(0.8))
                    }
                } else {
                    Text(WidgetStrings.tapToReveal)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(.white.opacity(0.85))
                        .lineLimit(3)

                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 10))
                            .foregroundStyle(WidgetTheme.goldGradient)
                        Text(Date(), style: .date)
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(WidgetTheme.gold.opacity(0.8))
                    }
                }
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .widget) { WidgetTheme.backgroundGradient }
        .widgetURL(deepLinkURL)
    }

    // MARK: Lock Screen

    private var rectangularAccessory: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                    .font(.system(size: 10, weight: .semibold))
                Text(WidgetStrings.title)
                    .font(.system(size: 12, weight: .semibold))
            }
            if let info = entry.info, info.isRevealed {
                Text(info.localizedName)
                    .font(.system(size: 13, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                if info.isReversed {
                    Text(WidgetStrings.reversed)
                        .font(.system(size: 10, weight: .light))
                        .opacity(0.75)
                }
            } else {
                Text(WidgetStrings.tapToReveal)
                    .font(.system(size: 11, weight: .light))
                    .lineLimit(2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .containerBackground(for: .widget) { Color.clear }
        .widgetURL(deepLinkURL)
    }

    private var circularAccessory: some View {
        ZStack {
            AccessoryWidgetBackground()
            if let info = entry.info, info.isRevealed {
                VStack(spacing: 1) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 10, weight: .semibold))
                    Text(shortName(for: info.localizedName))
                        .font(.system(size: 9, weight: .semibold))
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                }
                .padding(2)
            } else {
                Image(systemName: "sparkles")
                    .font(.system(size: 22, weight: .semibold))
            }
        }
        .containerBackground(for: .widget) { Color.clear }
        .widgetURL(deepLinkURL)
    }

    private var inlineAccessory: some View {
        Group {
            if let info = entry.info, info.isRevealed {
                Text("✨ \(info.localizedName)\(info.isReversed ? " (\(WidgetStrings.reversed))" : "")")
            } else {
                Text("✨ \(WidgetStrings.tapToReveal)")
            }
        }
        .widgetURL(deepLinkURL)
    }

    // MARK: Helpers

    private var deepLinkURL: URL? {
        URL(string: "tarotgo://daily-card")
    }

    private func shortName(for name: String) -> String {
        // For circular accessory, keep it short (first word or up to 6 chars)
        let firstWord = name.split(separator: " ").first.map(String.init) ?? name
        return String(firstWord.prefix(6))
    }

    /// Stylised card-back thumbnail rendered entirely in code so no shared assets are needed.
    private func cardBackIcon(size: CGFloat) -> some View {
        let width = size * (1108.0 / 1900.0)
        return ZStack {
            RoundedRectangle(cornerRadius: size * 0.09, style: .continuous)
                .fill(WidgetTheme.midNavy)
                .overlay(
                    RoundedRectangle(cornerRadius: size * 0.09, style: .continuous)
                        .stroke(WidgetTheme.goldGradient, lineWidth: 1.2)
                )

            // Inner ornament frame
            RoundedRectangle(cornerRadius: size * 0.06, style: .continuous)
                .stroke(WidgetTheme.gold.opacity(0.45), lineWidth: 0.6)
                .padding(size * 0.09)

            // Central emblem
            Image(systemName: "sparkles")
                .font(.system(size: size * 0.32, weight: .semibold))
                .foregroundStyle(WidgetTheme.goldGradient)
                .shadow(color: WidgetTheme.gold.opacity(0.5), radius: size * 0.05)
        }
        .frame(width: width, height: size)
    }
}

// MARK: - Widget

struct TarotGoWidget: Widget {
    let kind: String = DailyCardStore.widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TarotGoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(NSLocalizedString(
            "widget.cardOfTheDay.displayName",
            value: "Card of the Day",
            comment: "Widget picker display name"
        ))
        .description(NSLocalizedString(
            "widget.cardOfTheDay.description",
            value: "See when your daily tarot card is ready to be revealed.",
            comment: "Widget picker description"
        ))
        .supportedFamilies([
            .systemSmall,
            .systemMedium,
            .accessoryRectangular,
            .accessoryCircular,
            .accessoryInline
        ])
    }
}

// MARK: - Preview

#Preview("Small - awaiting", as: .systemSmall) {
    TarotGoWidget()
} timeline: {
    DailyCardEntry(date: .now, info: nil)
}

#Preview("Small - revealed", as: .systemSmall) {
    TarotGoWidget()
} timeline: {
    DailyCardEntry(
        date: .now,
        info: DailyCardInfo(
            dateKey: DailyCardStore.todayDateKey(),
            cardID: "the_star",
            localizedName: "The Star",
            isReversed: false,
            isRevealed: true
        )
    )
}

#Preview("Medium - revealed", as: .systemMedium) {
    TarotGoWidget()
} timeline: {
    DailyCardEntry(
        date: .now,
        info: DailyCardInfo(
            dateKey: DailyCardStore.todayDateKey(),
            cardID: "the_moon",
            localizedName: "The Moon",
            isReversed: true,
            isRevealed: true
        )
    )
}
