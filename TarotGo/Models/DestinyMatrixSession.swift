//
//  DestinyMatrixSession.swift
//  TarotGo
//
//  Saved Destiny Matrix calculation session
//

import Foundation
import SwiftData

@Model
final class DestinyMatrixSession {
    var id: UUID
    var date: Date
    var birthDate: Date
    var notes: String?
    
    init(birthDate: Date) {
        self.id = UUID()
        self.date = Date()
        self.birthDate = birthDate
        self.notes = nil
    }
    
    var formattedBirthDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: birthDate)
    }
    
    var formattedSaveDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
