// Copy of TarotGo/Utils/SeededRandomGenerator.swift for the watch target (kept in sync manually).
import Foundation

/// Seeded random number generator for consistent results across devices and sessions
struct SeededRandomGenerator: RandomNumberGenerator {
    private var state: UInt64
    
    init(seed: UInt64) {
        state = seed
    }
    
    mutating func next() -> UInt64 {
        // Linear Congruential Generator
        state = state &* 6364136223846793005 &+ 1442695040888963407
        return state
    }
}
