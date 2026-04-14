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
    
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var notes: String = ""
    @State private var showShareSheet: Bool = false
    @State private var sessionSaved: Bool = false
    @State private var shareText: String = ""
    @FocusState private var isNotesFocused: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text(L10n.summaryYourReading)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                        
                        if let question = customQuestion {
                            Text("\"\(question)\"")
                                .font(AppTheme.serifFont(size: 16, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Text(Date().formatted(date: .long, time: .omitted))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
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
                    returnToHome()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(AppTheme.goldGradient)
                }
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(L10n.done) {
                    isNotesFocused = false
                }
                .foregroundStyle(AppTheme.goldGradient)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isNotesFocused = false
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(items: [shareText])
        }
    }
    
    private var spreadLayoutView: some View {
        VStack(spacing: 15) {
            Text(spreadType.displayName)
                .font(AppTheme.serifFont(size: 20, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            // Simple grid layout for cards
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: min(drawnCards.count, 3)), spacing: 15) {
                ForEach(Array(drawnCards.enumerated()), id: \.element.id) { index, drawnCard in
                    VStack(spacing: 5) {
                        TarotCardFrontView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                            .frame(width: 80, height: 120)
                        
                        Text(drawnCard.position.name)
                            .font(.system(size: 10, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineLimit(1)
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private var overallSummarySection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(L10n.summaryOverallInsight)
                .font(AppTheme.serifFont(size: 22, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(TarotInterpretations.spreadSummary(for: drawnCards, category: category, spreadType: spreadType))
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textPrimary)
                .lineSpacing(6)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private var notesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(L10n.summaryReflections)
                .font(AppTheme.serifFont(size: 20, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            TextEditor(text: $notes)
                .frame(minHeight: 120)
                .padding(12)
                .background(AppTheme.darkNavy.opacity(0.4))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
                .foregroundColor(AppTheme.textPrimary)
                .font(.system(size: 16))
                .scrollContentBackground(.hidden)
                .focused($isNotesFocused)
                .tint(AppTheme.gold)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
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
                    Text(sessionSaved ? L10n.summaryReadingSaved : L10n.summarySaveReading)
                }
                .font(AppTheme.serifFont(size: 18, weight: .semibold))
                .foregroundColor(sessionSaved ? Color.green : AppTheme.deepNavy)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    sessionSaved ? 
                    LinearGradient(colors: [Color.green.opacity(0.3)], startPoint: .leading, endPoint: .trailing) :
                    AppTheme.goldGradient
                )
                .cornerRadius(15)
                .shadow(color: sessionSaved ? Color.green.opacity(0.3) : AppTheme.gold.opacity(0.5), radius: 10)
            }
            .disabled(sessionSaved)
            
            // Share button
            Button {
                prepareShareContent()
                showShareSheet = true
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text(L10n.summaryShareReading)
                }
                .font(AppTheme.serifFont(size: 18, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.6), lineWidth: 2)
                )
            }
            
            // Return home button
            Button {
                returnToHome()
            } label: {
                Text(L10n.summaryReturnToStart)
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
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
    
    private func prepareShareContent() {
        var text = "🔮 TarotGo Reading\n\n"
        
        if let question = customQuestion {
            text += "Question: \"\(question)\"\n\n"
        }
        
        text += "Spread: \(spreadType.displayName)\n"
        text += "Category: \(category.displayName)\n"
        text += "Date: \(Date().formatted(date: .long, time: .omitted))\n\n"
        
        text += "Cards:\n"
        for (index, drawnCard) in drawnCards.enumerated() {
            text += "\(index + 1). \(drawnCard.position.name): \(drawnCard.card.localizedName)"
            if drawnCard.isReversed {
                text += " \(L10n.interpretationReversed)"
            }
            text += "\n"
        }
        
        if !notes.isEmpty {
            text += "\nReflections:\n\(notes)\n"
        }
        
        shareText = text
    }
    
    private func returnToHome() {
        // Trigger the dismiss cascade
        appViewModel.returnToHome()
        
        // Also dismiss this view immediately
        dismiss()
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
                        .font(AppTheme.serifFont(size: 18, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    HStack {
                        Text(drawnCard.card.localizedName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        if drawnCard.isReversed {
                            Text("(R)")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.gold.opacity(0.7))
                        }
                    }
                }
                
                Spacer()
                
                TarotCardFrontView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                    .frame(width: 60, height: 90)
            }
            
            Text(drawnCard.card.interpretation(for: drawnCard.category, reversed: drawnCard.isReversed))
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .lineSpacing(5)
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// UIKit ShareSheet wrapper for SwiftUI
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    NavigationStack {
        SummaryView(
            drawnCards: [
                DrawnCard(
                    card: TarotDeck.majorArcana[0],
                    position: SpreadPosition(id: "past", nameKey: "past_short", descriptionKey: "past_short_desc"),
                    isReversed: false,
                    category: .love
                )
            ],
            category: .love,
            customQuestion: "Will I find love?",
            spreadType: .threeCard
        )
    }
    .environmentObject(AppViewModel())
    .modelContainer(for: ReadingSession.self)
}
