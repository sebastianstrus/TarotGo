//
//  MercuryRetrogradeService.swift
//  TarotGo
//
//  Service for tracking Mercury retrograde periods, shadow phases,
//  and the impact on personal zodiac signs.
//

import Foundation

enum MercuryRetrogradePhase {
    case direct
    case preShadow
    case retrograde
    case postShadow

    var title: String {
        switch self {
        case .direct: return L10n.mercuryPhaseDirect
        case .preShadow: return L10n.mercuryPhasePreShadow
        case .retrograde: return L10n.mercuryPhaseRetrograde
        case .postShadow: return L10n.mercuryPhasePostShadow
        }
    }

    var shortDescription: String {
        switch self {
        case .direct: return L10n.mercuryPhaseDirectDesc
        case .preShadow: return L10n.mercuryPhasePreShadowDesc
        case .retrograde: return L10n.mercuryPhaseRetrogradeDesc
        case .postShadow: return L10n.mercuryPhasePostShadowDesc
        }
    }

    var iconName: String {
        switch self {
        case .direct: return "arrow.right.circle.fill"
        case .preShadow: return "moon.circle.fill"
        case .retrograde: return "arrow.counterclockwise.circle.fill"
        case .postShadow: return "moon.stars.circle.fill"
        }
    }
}

struct MercuryRetrogradePeriod: Identifiable, Hashable {
    let id = UUID()
    let preShadowStart: Date
    let retrogradeStart: Date
    let retrogradeEnd: Date
    let postShadowEnd: Date
    let zodiacSign: ZodiacSign
    let secondaryZodiacSign: ZodiacSign?

    var year: Int {
        Calendar.current.component(.year, from: retrogradeStart)
    }

    func phase(for date: Date) -> MercuryRetrogradePhase {
        if date < preShadowStart || date > postShadowEnd {
            return .direct
        }
        if date < retrogradeStart {
            return .preShadow
        }
        if date <= retrogradeEnd {
            return .retrograde
        }
        return .postShadow
    }

    /// Whether the given date falls anywhere within this entire shadow-to-shadow window.
    func contains(_ date: Date) -> Bool {
        date >= preShadowStart && date <= postShadowEnd
    }
}

final class MercuryRetrogradeService {
    static let shared = MercuryRetrogradeService()

    private init() {}

    // MARK: - Hardcoded retrograde periods
    //
    // Shadow periods are computed as ~14 days before and after the retrograde
    // station to approximate the time Mercury spends crossing the same degrees.
    // These are based on commonly published astronomical ephemerides for 2025–2028.

    private lazy var periods: [MercuryRetrogradePeriod] = buildPeriods()

    private func buildPeriods() -> [MercuryRetrogradePeriod] {
        let raw: [(start: (Int, Int, Int),
                   end: (Int, Int, Int),
                   sign: ZodiacSign,
                   secondary: ZodiacSign?)] = [
            // 2025
            ((2025, 3, 15), (2025, 4, 7),  .aries,       .pisces),
            ((2025, 7, 18), (2025, 8, 11), .leo,          nil),
            ((2025, 11, 9), (2025, 11, 29),.sagittarius, .scorpio),
            // 2026
            ((2026, 2, 26), (2026, 3, 20), .pisces,      .aquarius),
            ((2026, 6, 29), (2026, 7, 23), .leo,         .cancer),
            ((2026, 10, 24),(2026, 11, 13),.sagittarius, .scorpio),
            // 2027
            ((2027, 2, 9),  (2027, 3, 3),  .pisces,       nil),
            ((2027, 6, 10), (2027, 7, 4),  .cancer,       nil),
            ((2027, 10, 7), (2027, 10, 28),.scorpio,     .libra),
            // 2028
            ((2028, 1, 24), (2028, 2, 14), .aquarius,    .pisces),
            ((2028, 5, 21), (2028, 6, 14), .gemini,       nil),
            ((2028, 9, 19), (2028, 10, 11),.libra,       .scorpio)
        ]

        let calendar = Calendar(identifier: .gregorian)
        let shadowDays = 14

        return raw.compactMap { entry in
            guard let start = calendar.date(from: DateComponents(
                    year: entry.start.0, month: entry.start.1, day: entry.start.2)),
                  let end = calendar.date(from: DateComponents(
                    year: entry.end.0, month: entry.end.1, day: entry.end.2,
                    hour: 23, minute: 59, second: 59)),
                  let preShadow = calendar.date(byAdding: .day, value: -shadowDays, to: start),
                  let postShadow = calendar.date(byAdding: .day, value: shadowDays, to: end)
            else { return nil }

            return MercuryRetrogradePeriod(
                preShadowStart: preShadow,
                retrogradeStart: start,
                retrogradeEnd: end,
                postShadowEnd: postShadow,
                zodiacSign: entry.sign,
                secondaryZodiacSign: entry.secondary
            )
        }
    }

    // MARK: - Public API

    func allPeriods() -> [MercuryRetrogradePeriod] {
        periods
    }

    /// Returns the period that the given date falls into (including shadow periods),
    /// or nil when Mercury is direct.
    func activePeriod(for date: Date) -> MercuryRetrogradePeriod? {
        periods.first { $0.contains(date) }
    }

    /// Returns the next retrograde whose pre-shadow has not yet started.
    func nextPeriod(after date: Date) -> MercuryRetrogradePeriod? {
        periods.first { $0.preShadowStart > date }
    }

    /// Current phase for any given date.
    func currentPhase(for date: Date) -> MercuryRetrogradePhase {
        activePeriod(for: date)?.phase(for: date) ?? .direct
    }

    /// Returns the next N upcoming periods (those whose post-shadow has not ended).
    func upcomingPeriods(from date: Date, count: Int) -> [MercuryRetrogradePeriod] {
        Array(periods.filter { $0.postShadowEnd >= date }.prefix(count))
    }

    /// Calendar-day countdown to the next phase boundary for the given date.
    /// Returns 0 when Mercury is direct.
    func daysUntilNextPhaseChange(from date: Date) -> Int {
        guard let period = activePeriod(for: date) else {
            guard let next = nextPeriod(after: date) else { return 0 }
            return daysBetween(date, next.preShadowStart)
        }
        let target: Date
        switch period.phase(for: date) {
        case .preShadow:    target = period.retrogradeStart
        case .retrograde:   target = period.retrogradeEnd
        case .postShadow:   target = period.postShadowEnd
        case .direct:       return 0
        }
        return daysBetween(date, target)
    }

    /// Progress (0–1) through the entire shadow-to-shadow window.
    func windowProgress(for date: Date) -> Double {
        guard let period = activePeriod(for: date) else { return 0 }
        let total = period.postShadowEnd.timeIntervalSince(period.preShadowStart)
        let elapsed = date.timeIntervalSince(period.preShadowStart)
        return max(0, min(1, elapsed / total))
    }

    // MARK: - Impact for user's sign

    /// Returns a localized description of how the current/upcoming retrograde
    /// might affect a given sun sign. Mapping is based on the angular relation
    /// between the user's sign and the retrograde sign.
    func impactDescription(userSign: ZodiacSign, retrogradeSign: ZodiacSign) -> String {
        let userIndex = userSign.rawValue
        let retroIndex = retrogradeSign.rawValue
        let distance = ((retroIndex - userIndex) % 12 + 12) % 12

        switch distance {
        case 0:
            return L10n.mercuryImpactSelf
        case 1, 11:
            return L10n.mercuryImpactAdjacent
        case 2, 10:
            return L10n.mercuryImpactSextile
        case 3, 9:
            return L10n.mercuryImpactSquare
        case 4, 8:
            return L10n.mercuryImpactTrine
        case 5, 7:
            return L10n.mercuryImpactInconjunct
        case 6:
            return L10n.mercuryImpactOpposite
        default:
            return L10n.mercuryImpactAdjacent
        }
    }

    /// Suggested do's for the current phase.
    func dosList(for phase: MercuryRetrogradePhase) -> [String] {
        switch phase {
        case .direct:
            return [L10n.mercuryDoDirect1, L10n.mercuryDoDirect2, L10n.mercuryDoDirect3]
        case .preShadow:
            return [L10n.mercuryDoPreShadow1, L10n.mercuryDoPreShadow2, L10n.mercuryDoPreShadow3]
        case .retrograde:
            return [L10n.mercuryDoRetrograde1, L10n.mercuryDoRetrograde2, L10n.mercuryDoRetrograde3, L10n.mercuryDoRetrograde4]
        case .postShadow:
            return [L10n.mercuryDoPostShadow1, L10n.mercuryDoPostShadow2, L10n.mercuryDoPostShadow3]
        }
    }

    /// Couple-focused guidance for the current phase.
    /// Empty when Mercury is direct (no special couple advice needed).
    func coupleAdvice(for phase: MercuryRetrogradePhase) -> [String] {
        switch phase {
        case .direct:
            return []
        case .preShadow:
            return [
                L10n.mercuryCoupleAdvicePreShadow1,
                L10n.mercuryCoupleAdvicePreShadow2,
                L10n.mercuryCoupleAdvicePreShadow3
            ]
        case .retrograde:
            return [
                L10n.mercuryCoupleAdviceRetrograde1,
                L10n.mercuryCoupleAdviceRetrograde2,
                L10n.mercuryCoupleAdviceRetrograde3,
                L10n.mercuryCoupleAdviceRetrograde4,
                L10n.mercuryCoupleAdviceRetrograde5
            ]
        case .postShadow:
            return [
                L10n.mercuryCoupleAdvicePostShadow1,
                L10n.mercuryCoupleAdvicePostShadow2,
                L10n.mercuryCoupleAdvicePostShadow3
            ]
        }
    }

    /// Suggested don'ts for the current phase.
    func dontsList(for phase: MercuryRetrogradePhase) -> [String] {
        switch phase {
        case .direct:
            return [L10n.mercuryDontDirect1, L10n.mercuryDontDirect2]
        case .preShadow:
            return [L10n.mercuryDontPreShadow1, L10n.mercuryDontPreShadow2, L10n.mercuryDontPreShadow3]
        case .retrograde:
            return [L10n.mercuryDontRetrograde1, L10n.mercuryDontRetrograde2, L10n.mercuryDontRetrograde3, L10n.mercuryDontRetrograde4]
        case .postShadow:
            return [L10n.mercuryDontPostShadow1, L10n.mercuryDontPostShadow2]
        }
    }

    // MARK: - Helpers

    private func daysBetween(_ from: Date, _ to: Date) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: from)
        let end = calendar.startOfDay(for: to)
        let comps = calendar.dateComponents([.day], from: start, to: end)
        return max(0, comps.day ?? 0)
    }
}
