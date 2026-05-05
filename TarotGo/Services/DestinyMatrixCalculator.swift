//
//  DestinyMatrixCalculator.swift
//  TarotGo
//
//  Service for calculating Destiny Matrix from birth date
//

import Foundation

class DestinyMatrixCalculator {
    static let shared = DestinyMatrixCalculator()
    
    private init() {}
    
    /// Calculate complete Destiny Matrix from birth date
    func calculate(from birthDate: Date) -> DestinyMatrix {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: birthDate)
        
        guard let day = components.day,
              let month = components.month,
              let year = components.year else {
            fatalError("Invalid date components")
        }
        
        // Calculate all positions according to Destiny Matrix methodology
        var positions: [MatrixPosition] = []
        
        // Extract individual digits from year
        let yearDigits = extractDigits(from: year)
        
        // Center (main life energy) - sum of day + month + year
        let centerNumber = reduce(day + month + year)
        positions.append(MatrixPosition(
            number: centerNumber,
            position: .center,
            x: 0.5,
            y: 0.5
        ))
        
        // Personal Power (top of square)
        let personalPower = reduce(day + month)
        positions.append(MatrixPosition(
            number: personalPower,
            position: .personalPower,
            x: 0.5,
            y: 0.18
        ))
        
        // Social Realization (right of square)
        let socialRealization = reduce(month + year)
        positions.append(MatrixPosition(
            number: socialRealization,
            position: .socialRealization,
            x: 0.82,
            y: 0.5
        ))
        
        // Spiritual Development (bottom of square)
        let spiritualDevelopment = reduce(day + year)
        positions.append(MatrixPosition(
            number: spiritualDevelopment,
            position: .spiritualDevelopment,
            x: 0.5,
            y: 0.82
        ))
        
        // Planetary Influence (left of square)
        let planetaryInfluence = reduce(personalPower + socialRealization + spiritualDevelopment)
        positions.append(MatrixPosition(
            number: planetaryInfluence,
            position: .planetaryInfluence,
            x: 0.18,
            y: 0.5
        ))
        
        // Money (top-right diagonal)
        let money = reduce(personalPower + socialRealization)
        positions.append(MatrixPosition(
            number: money,
            position: .money,
            x: 0.65,
            y: 0.35
        ))
        
        // Relationships (bottom-right diagonal)
        let relationships = reduce(socialRealization + spiritualDevelopment)
        positions.append(MatrixPosition(
            number: relationships,
            position: .relationships,
            x: 0.65,
            y: 0.65
        ))
        
        // Talents (bottom-left diagonal)
        let talents = reduce(spiritualDevelopment + planetaryInfluence)
        positions.append(MatrixPosition(
            number: talents,
            position: .talents,
            x: 0.35,
            y: 0.65
        ))
        
        // Purpose (top-left diagonal)
        let purpose = reduce(planetaryInfluence + personalPower)
        positions.append(MatrixPosition(
            number: purpose,
            position: .purpose,
            x: 0.35,
            y: 0.35
        ))
        
        // Male Line (top-right corner area)
        let maleLine = reduce(day)
        positions.append(MatrixPosition(
            number: maleLine,
            position: .male,
            x: 0.75,
            y: 0.25
        ))
        
        // Female Line (top-left corner area)
        let femaleLine = reduce(month)
        positions.append(MatrixPosition(
            number: femaleLine,
            position: .female,
            x: 0.25,
            y: 0.25
        ))
        
        // Sky (upper center, between karma and personal power)
        let sky = reduce(personalPower + centerNumber)
        positions.append(MatrixPosition(
            number: sky,
            position: .sky,
            x: 0.5,
            y: 0.34
        ))
        
        // Earth (lower center, between center and spiritual development)
        let earth = reduce(spiritualDevelopment + centerNumber)
        positions.append(MatrixPosition(
            number: earth,
            position: .earth,
            x: 0.5,
            y: 0.66
        ))
        
        // Karma (above square, top)
        let karma = reduce(centerNumber)
        positions.append(MatrixPosition(
            number: karma,
            position: .karma,
            x: 0.5,
            y: 0.04
        ))
        
        // Health (below square, bottom)
        let health = reduce(year)
        positions.append(MatrixPosition(
            number: health,
            position: .health,
            x: 0.5,
            y: 0.96
        ))
        
        // Comfort zone (far right)
        let comfort = reduce(money + relationships + talents + purpose)
        positions.append(MatrixPosition(
            number: comfort,
            position: .comfort,
            x: 0.96,
            y: 0.5
        ))
        
        // Timeline energies (far left vertical)
        // Future (top left)
        let future = reduce(yearDigits[2] + yearDigits[3])
        positions.append(MatrixPosition(
            number: future,
            position: .future,
            x: 0.04,
            y: 0.15
        ))
        
        // Present (middle left)
        let present = reduce(day + month)
        positions.append(MatrixPosition(
            number: present,
            position: .present,
            x: 0.04,
            y: 0.5
        ))
        
        // Past (bottom left)
        let past = reduce(yearDigits[0] + yearDigits[1])
        positions.append(MatrixPosition(
            number: past,
            position: .past,
            x: 0.04,
            y: 0.85
        ))
        
        // Calculate yearly energies
        let yearlyEnergies = calculateYearlyEnergies(from: birthDate, positions: positions)
        
        return DestinyMatrix(birthDate: birthDate, positions: positions, yearlyEnergies: yearlyEnergies)
    }
    
    // MARK: - Helper Methods
    
    /// Reduce number to range 1-22 using numerology
    private func reduce(_ number: Int) -> Int {
        var result = number
        
        // Special case: if already in range, return
        if result >= 1 && result <= 22 {
            return result
        }
        
        // Keep summing digits until we get a number between 1-22
        while result > 22 {
            result = sumDigits(result)
        }
        
        // If result is 0, return 22 (The Fool can be 0 or 22)
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
    
    /// Extract individual digits from a number
    private func extractDigits(from number: Int) -> [Int] {
        String(number).compactMap { Int(String($0)) }
    }
    
    // MARK: - Yearly Energy Calculations
    
    /// Calculate yearly energies for ages 0-60+
    /// This shows how energies evolve throughout a person's life
    func calculateYearlyEnergies(from birthDate: Date, positions: [MatrixPosition]) -> [YearlyEnergy] {
        var yearlyEnergies: [YearlyEnergy] = []
        
        let components = Calendar.current.dateComponents([.day, .month, .year], from: birthDate)
        guard let day = components.day,
              let month = components.month,
              let birthYear = components.year else {
            return []
        }
        
        // Get center position number (main life energy)
        let centerNumber = positions.first(where: { $0.position == .center })?.number ?? 22
        
        // Calculate energies for ages 0 to 70
        for age in 0...70 {
            let currentYear = birthYear + age
            
            // Calculate year energy based on birth date + current year
            let yearSum = day + month + currentYear
            let yearEnergy = reduce(yearSum)
            
            // Calculate personal year energy (day + month + reduced current year)
            let reducedYear = reduce(currentYear)
            let personalYearEnergy = reduce(day + month + reducedYear)
            
            // Create yearly energy entry
            let yearlyEnergy = YearlyEnergy(
                age: age,
                year: currentYear,
                primaryEnergy: yearEnergy,
                secondaryEnergy: personalYearEnergy,
                isCurrentYear: isCurrentYear(age: age, birthDate: birthDate)
            )
            
            yearlyEnergies.append(yearlyEnergy)
        }
        
        return yearlyEnergies
    }
    
    /// Check if a given age represents the current year
    private func isCurrentYear(age: Int, birthDate: Date) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        
        guard let birthYear = calendar.dateComponents([.year], from: birthDate).year,
              let currentYear = calendar.dateComponents([.year], from: now).year else {
            return false
        }
        
        let currentAge = currentYear - birthYear
        return age == currentAge
    }
    
    /// Get energy for a specific age
    func energyForAge(_ age: Int, from birthDate: Date) -> YearlyEnergy? {
        let yearlyEnergies = calculateYearlyEnergies(from: birthDate, positions: [])
        return yearlyEnergies.first(where: { $0.age == age })
    }
}
