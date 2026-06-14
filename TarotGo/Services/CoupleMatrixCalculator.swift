//
//  CoupleMatrixCalculator.swift
//  TarotGo
//
//  Service for calculating the Couple Matrix from two birth dates
//

import Foundation

class CoupleMatrixCalculator {
    static let shared = CoupleMatrixCalculator()

    private init() {}

    /// Calculate the full Couple Matrix from two partner birth dates
    func calculate(birthDateA: Date, birthDateB: Date) -> CoupleMatrix {
        let centerA = centerEnergy(from: birthDateA)
        let centerB = centerEnergy(from: birthDateB)

        let personalPowerA = personalPower(from: birthDateA)
        let personalPowerB = personalPower(from: birthDateB)

        let socialA = socialRealization(from: birthDateA)
        let socialB = socialRealization(from: birthDateB)

        let spiritualA = spiritualDevelopment(from: birthDateA)
        let spiritualB = spiritualDevelopment(from: birthDateB)

        let union = reduce(centerA + centerB)
        let love = reduce(personalPowerA + personalPowerB)
        let karma = reduce(centerA * centerB)
        let money = reduce(socialA + socialB)
        let sexuality = reduce(personalPowerA + personalPowerB + union)
        let children = reduce(spiritualA + spiritualB)
        let purpose = reduce(love + karma)
        let health = reduce(yearEnergy(from: birthDateA) + yearEnergy(from: birthDateB))

        // Build positions with diagram coordinates (normalized 0-1).
        // Layout: two partner circles top-left/right, union at center,
        // love & sexuality on the horizontal axis, karma & purpose on the
        // diagonals, money/children/health on the lower axes.
        let positions: [CoupleMatrixPosition] = [
            CoupleMatrixPosition(number: centerA,       position: .partnerA,   x: 0.22, y: 0.22),
            CoupleMatrixPosition(number: centerB,       position: .partnerB,   x: 0.78, y: 0.22),
            CoupleMatrixPosition(number: union,         position: .union,      x: 0.50, y: 0.50),
            CoupleMatrixPosition(number: love,          position: .love,       x: 0.22, y: 0.50),
            CoupleMatrixPosition(number: sexuality,     position: .sexuality,  x: 0.78, y: 0.50),
            CoupleMatrixPosition(number: karma,         position: .karma,      x: 0.36, y: 0.36),
            CoupleMatrixPosition(number: purpose,       position: .purpose,    x: 0.64, y: 0.36),
            CoupleMatrixPosition(number: money,         position: .money,      x: 0.22, y: 0.78),
            CoupleMatrixPosition(number: children,      position: .children,   x: 0.50, y: 0.85),
            CoupleMatrixPosition(number: health,        position: .health,     x: 0.78, y: 0.78),
        ]

        let yearlyEnergies = calculateYearlyEnergies(
            birthDateA: birthDateA,
            birthDateB: birthDateB,
            union: union
        )

        return CoupleMatrix(
            birthDateA: birthDateA,
            birthDateB: birthDateB,
            positions: positions,
            yearlyEnergies: yearlyEnergies
        )
    }

    // MARK: - Yearly Energies

    /// Calculate the next 30 years of couple energies starting from the current calendar year.
    func calculateYearlyEnergies(
        birthDateA: Date,
        birthDateB: Date,
        union: Int
    ) -> [CoupleYearlyEnergy] {
        let calendar = Calendar.current
        guard let currentYear = calendar.dateComponents([.year], from: Date()).year else {
            return []
        }

        let (dA, mA, _) = components(of: birthDateA)
        let (dB, mB, _) = components(of: birthDateB)

        var energies: [CoupleYearlyEnergy] = []
        for offset in 0..<30 {
            let year = currentYear + offset
            // Couple's "personal year" = day+month of both partners + current year
            let sum = dA + mA + dB + mB + year
            let reducedYear = reduce(year)
            let combined = reduce(sum + reducedYear + union)

            energies.append(
                CoupleYearlyEnergy(
                    yearsTogetherIndex: offset,
                    year: year,
                    primaryEnergy: combined,
                    isCurrentYear: offset == 0
                )
            )
        }
        return energies
    }

    // MARK: - Per-person Numerology Building Blocks

    private func centerEnergy(from date: Date) -> Int {
        let (d, m, y) = components(of: date)
        return reduce(d + m + y)
    }

    private func personalPower(from date: Date) -> Int {
        let (d, m, _) = components(of: date)
        return reduce(d + m)
    }

    private func socialRealization(from date: Date) -> Int {
        let (_, m, y) = components(of: date)
        return reduce(m + y)
    }

    private func spiritualDevelopment(from date: Date) -> Int {
        let (d, _, y) = components(of: date)
        return reduce(d + y)
    }

    private func yearEnergy(from date: Date) -> Int {
        let (_, _, y) = components(of: date)
        return reduce(y)
    }

    private func components(of date: Date) -> (Int, Int, Int) {
        let parts = Calendar.current.dateComponents([.day, .month, .year], from: date)
        return (parts.day ?? 0, parts.month ?? 0, parts.year ?? 0)
    }

    // MARK: - Numerology Helpers

    /// Reduce number to range 1-22 using numerology
    private func reduce(_ number: Int) -> Int {
        var result = abs(number)

        if result >= 1 && result <= 22 {
            return result
        }

        while result > 22 {
            result = sumDigits(result)
        }

        if result == 0 {
            return 22
        }

        return result
    }

    /// Sum all digits in a number
    private func sumDigits(_ number: Int) -> Int {
        var num = abs(number)
        var sum = 0

        while num > 0 {
            sum += num % 10
            num /= 10
        }

        return sum
    }
}
