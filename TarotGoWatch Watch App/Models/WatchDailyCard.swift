//
//  WatchDailyCard.swift
//  TarotGoWatch Watch App
//
//  Card of the Day. Uses the same seed, deck order and reversal rule as the iOS
//  `CardOfTheDayView`, so both devices show the same card for the same birth date.
//

import Foundation

struct WatchDailyCard {
    let card: WatchTarotCard
    let isReversed: Bool

    static func today(date: Date = Date()) -> WatchDailyCard {
        let astrology = AstrologyService.shared
        let seed: UInt64
        if let birthDate = astrology.userBirthDate {
            seed = astrology.personalizedSeed(for: date, birthDate: birthDate)
        } else {
            seed = astrology.defaultSeed(for: date)
        }

        var generator = SeededRandomGenerator(seed: seed)
        let cards = WatchDeck.allCards
        let card = cards[Int(generator.next() % UInt64(cards.count))]
        // 30% chance of being reversed
        let isReversed = generator.next() % 100 < 30
        return WatchDailyCard(card: card, isReversed: isReversed)
    }

    /// Identifies today's card so a reveal is remembered for the day, and forgotten if the
    /// card changes (e.g. when the birth date arrives from the iPhone).
    var revealToken: String {
        let parts = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let day = String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
        return "\(day):\(card.id)"
    }

    var imageName: String { card.id }

    var name: String { WatchText.string("card.\(card.id)") }

    var keywords: [String] {
        (isReversed ? card.reversedKeywordKeys : card.keywordKeys).map(WatchText.string)
    }

    var message: String {
        WatchText.string("interpretation.\(card.id)_general_\(isReversed ? "reversed" : "upright")")
    }
}
