//
//  CoupleMatrixSession.swift
//  TarotGo
//
//  Saved Couple Matrix calculation session
//

import Foundation
import SwiftData

@Model
final class CoupleMatrixSession {
    var id: UUID
    var date: Date
    var birthDateA: Date
    var birthDateB: Date
    var notes: String?

    init(birthDateA: Date, birthDateB: Date) {
        self.id = UUID()
        self.date = Date()
        self.birthDateA = birthDateA
        self.birthDateB = birthDateB
        self.notes = nil
    }

    var formattedBirthDateA: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDateA)
    }

    var formattedBirthDateB: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDateB)
    }

    var formattedSaveDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
