//
//  SummaryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    let drawnCards: [DrawnCard]
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var notes: String = ""
    @State private var showShareSheet: Bool = false
    @State private var sessionSaved: Bool = false
    @FocusState private var isNotesFocused: Bool
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text("Your Reading")
                            .font(.system(size: 32, weight: .light, design: .serif))
                            .foregroundColor(.white)
                        
                        if let question = customQuestion {
                            Text("\"\(question)\"")
                                .font(.system(size: 16, weight: .light, design: .serif))
                                .foregroundColor(.white.opacity(0.8))
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Text(Date().formatted(date: .long, time: .omitted))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 20)
                    
                    // Spread layout visualization
                    spreadLayoutView
                    
                    // Overall summary
                    overallSummarySection
                    
                    // Individual card summaries
                    ForEach(Array(drawnCards.enumerated()), id: \.element.id) { index, drawnCard in
                        CardSummaryCard(drawnCard: drawnCard, index: index + 1)
                    }
                    
                    // Notes section
                    notesSection
                    
                    // Action buttons
                    actionButtons
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isNotesFocused = false
                }
                .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isNotesFocused = false
        }
    }
    
    private var spreadLayoutView: some View {
        VStack(spacing: 15) {
            Text(spreadType.rawValue)
                .font(.system(size: 20, weight: .medium, design: .serif))
                .foregroundColor(.white)
            
            // Simple grid layout for cards
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: min(drawnCards.count, 3)), spacing: 15) {
                ForEach(Array(drawnCards.enumerated()), id: \.element.id) { index, drawnCard in
                    VStack(spacing: 5) {
                        TarotCardFrontView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                            .frame(width: 80, height: 120)
                        
                        Text(drawnCard.position.name)
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private var overallSummarySection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Overall Insight")
                .font(.system(size: 22, weight: .medium, design: .serif))
                .foregroundColor(.white)
            
            Text(TarotInterpretations.spreadSummary(for: drawnCards, category: category, spreadType: spreadType))
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.white.opacity(0.9))
                .lineSpacing(6)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Reflections")
                .font(.system(size: 20, weight: .medium, design: .serif))
                .foregroundColor(.white)
            
            TextEditor(text: $notes)
                .frame(minHeight: 120)
                .padding(12)
                .background(Color.white.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.white)
                .font(.system(size: 16))
                .scrollContentBackground(.hidden)
                .focused($isNotesFocused)
                .tint(.white)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private var actionButtons: some View {
        VStack(spacing: 15) {
            // Save button
            Button {
                saveSession()
            } label: {
                HStack {
                    Image(systemName: sessionSaved ? "checkmark.circle.fill" : "square.and.arrow.down")
                    Text(sessionSaved ? "Reading Saved" : "Save Reading")
                }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: sessionSaved ? [Color.green.opacity(0.6), Color.green.opacity(0.6)] : [Color.purple.opacity(0.6), Color.blue.opacity(0.6)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(15)
            }
            .disabled(sessionSaved)
            
            // Share button
            Button {
                showShareSheet = true
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share Reading")
                }
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.4), lineWidth: 2)
                )
            }
            
            // Return home button
            Button {
                dismiss()
            } label: {
                Text("Return to Start")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white.opacity(0.8))
                    .padding()
            }
        }
    }
    
    private func saveSession() {
        let session = ReadingSession(
            category: category,
            customQuestion: customQuestion,
            spreadType: spreadType,
            drawnCards: drawnCards
        )
        session.notes = notes.isEmpty ? nil : notes
        
        modelContext.insert(session)
        
        do {
            try modelContext.save()
            withAnimation {
                sessionSaved = true
            }
            mediumHaptic()
        } catch {
            print("Failed to save session: \(error)")
        }
    }
    
    private func mediumHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

struct CardSummaryCard: View {
    let drawnCard: DrawnCard
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(index). \(drawnCard.position.name)")
                        .font(.system(size: 18, weight: .medium, design: .serif))
                        .foregroundColor(.white)
                    
                    HStack {
                        Text(drawnCard.card.name)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                        
                        if drawnCard.isReversed {
                            Text("(R)")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                }
                
                Spacer()
                
                TarotCardFrontView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                    .frame(width: 60, height: 90)
            }
            
            Text(drawnCard.card.interpretation(for: drawnCard.category, reversed: drawnCard.isReversed))
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white.opacity(0.8))
                .lineSpacing(5)
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        SummaryView(
            drawnCards: [
                DrawnCard(
                    card: TarotDeck.majorArcana[0],
                    position: SpreadPosition(id: "past", name: "Past", description: "What brought you here"),
                    isReversed: false,
                    category: .love
                )
            ],
            category: .love,
            customQuestion: "Will I find love?",
            spreadType: .threeCard
        )
    }
    .modelContainer(for: ReadingSession.self)
}
