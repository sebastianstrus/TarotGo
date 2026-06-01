//
//  PalmReadingSession.swift
//  TarotGo
//
//  Saved Palm Reading session
//

import Foundation
import SwiftData

@Model
final class PalmReadingSession {
    var id: UUID
    var date: Date
    @Attribute(.externalStorage) var capturedImageData: Data?
    // SwiftData's @Model macro mishandles complex nested Codable types
    // (string-backed enums inside structs inside structs), causing a
    // runtime cast crash on read. Store the reading as a JSON blob and
    // decode it lazily through the computed property below.
    var palmReadingData: Data
    var notes: String?

    init(palmReading: PalmReading, capturedImageData: Data? = nil) {
        self.id = UUID()
        self.date = Date()
        self.capturedImageData = capturedImageData
        self.palmReadingData = (try? JSONEncoder().encode(palmReading)) ?? Data()
        self.notes = nil
    }

    var palmReading: PalmReading? {
        try? JSONDecoder().decode(PalmReading.self, from: palmReadingData)
    }

    var formattedSaveDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
