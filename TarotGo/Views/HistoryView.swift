//
//  HistoryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData

struct MiniTarotCardView: View {
    let card: TarotCard
    let isReversed: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let cornerRadius = AppTheme.cardCornerRadius(forWidth: geometry.size.width)
            
            ZStack {
                // White background to ensure no transparency
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                
                // Real tarot card image
                if let uiImage = UIImage(named: card.id) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .cornerRadius(cornerRadius)
                }
                
                // Gold border
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        LinearGradient(
                            colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 2
                    )
            }
            .shadow(color: AppTheme.gold.opacity(0.3), radius: 10)
            .rotationEffect(.degrees(isReversed ? 180 : 0))
        }
        .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
    }
}

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ReadingSession.date, order: .reverse) private var sessions: [ReadingSession]
    
    @State private var selectedCategory: IntentionCategory?
    @State private var showFilterMenu: Bool = false
    
    private var filteredSessions: [ReadingSession] {
        if let category = selectedCategory {
            return sessions.filter { $0.category == category }
        }
        return sessions
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 0) {
                // Header with filter
                headerView
                
                if filteredSessions.isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(filteredSessions) { session in
                                NavigationLink {
                                    SessionDetailView(session: session)
                                } label: {
                                    SessionCard(session: session)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle(L10n.historyTitle)
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerView: some View {
        HStack {
            Text(L10n.historyFilter)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
            
            Menu {
                Button(L10n.historyAllReadings) {
                    selectedCategory = nil
                }
                
                Divider()
                
                ForEach(IntentionCategory.allCases, id: \.self) { category in
                    Button(category.displayName) {
                        selectedCategory = category
                    }
                }
            } label: {
                HStack {
                    Text(selectedCategory?.displayName ?? L10n.historyAll)
                        .font(.system(size: 16, weight: .medium))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                }
                .foregroundColor(AppTheme.deepNavy)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(AppTheme.goldGradient)
                )
            }
            
            Spacer()
            
            Text(L10n.readingCount(filteredSessions.count))
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.gold.opacity(0.7))
        }
        .padding()
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundStyle(AppTheme.goldGradient.opacity(0.4))
            
            Text(L10n.historyNoReadings)
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(L10n.historyNoReadingsDesc)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SessionCard: View {
    let session: ReadingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(session.category.displayName)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(session.date.formatted(date: .long, time: .shortened))
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.7))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.gold.opacity(0.6))
            }
            
            if let question = session.customQuestion {
                Text("\"\(question)\"")
                    .font(AppTheme.serifFont(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .italic()
                    .lineLimit(2)
            }
            
            // Card preview
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(session.drawnCards) { drawnCard in
                        MiniTarotCardView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                            .frame(width: 50, height: 75)
                    }
                }
            }
            
            HStack {
                Label(session.spreadType.displayName, systemImage: "square.grid.3x3")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(AppTheme.gold.opacity(0.7))
                
                Spacer()
                
                if session.notes != nil {
                    Image(systemName: "note.text")
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.gold.opacity(0.7))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct SessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let session: ReadingSession
    
    @State private var editedNotes: String
    @State private var isEditingNotes: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var sharePDFURL: URL?
    @FocusState private var isNotesFocused: Bool
    
    init(session: ReadingSession) {
        self.session = session
        _editedNotes = State(initialValue: session.notes ?? "")
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text(session.category.displayName)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                        
                        if let question = session.customQuestion {
                            Text("\"\(question)\"")
                                .font(AppTheme.serifFont(size: 16, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Text(session.date.formatted(date: .long, time: .shortened))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                    }
                    .padding(.top, 20)
                    
                    // Spread visualization
                    VStack(spacing: 15) {
                        Text(session.spreadType.displayName)
                            .font(AppTheme.serifFont(size: 20, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: min(session.drawnCards.count, 3)), spacing: 15) {
                            ForEach(session.drawnCards) { drawnCard in
                                VStack(spacing: 5) {
                                    MiniTarotCardView(card: drawnCard.card, isReversed: drawnCard.isReversed)
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
                    
                    // Overall Insight
                    VStack(alignment: .leading, spacing: 15) {
                        Text(L10n.summaryOverallInsight)
                            .font(AppTheme.serifFont(size: 22, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        Text(TarotInterpretations.spreadSummary(for: session.drawnCards, category: session.category, spreadType: session.spreadType))
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
                    
                    // Cards detail
                    ForEach(Array(session.drawnCards.enumerated()), id: \.element.id) { index, drawnCard in
                        CardSummaryCard(drawnCard: drawnCard, index: index + 1)
                    }
                    
                    // Notes
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(L10n.summaryReflections)
                                .font(AppTheme.serifFont(size: 20, weight: .medium))
                                .foregroundStyle(AppTheme.goldGradient)
                            
                            Spacer()
                            
                            Button {
                                isEditingNotes.toggle()
                                if !isEditingNotes {
                                    saveNotes()
                                }
                            } label: {
                                Text(isEditingNotes ? L10n.done : L10n.edit)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(AppTheme.goldGradient)
                            }
                        }
                        
                        if isEditingNotes {
                            TextEditor(text: $editedNotes)
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
                                .onAppear {
                                    isNotesFocused = true
                                }
                        } else {
                            if !editedNotes.isEmpty {
                                Text(editedNotes)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                            } else {
                                Text(L10n.historyNoReflections)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                                    .italic()
                            }
                        }
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
                    
                    // Share button
                    Button {
                        prepareShareContent()
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
                    
                    // Delete button
                    Button {
                        showDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text(L10n.historyDeleteReading)
                        }
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.red.opacity(0.8))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.red.opacity(0.4), lineWidth: 2)
                        )
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(L10n.done) {
                    isNotesFocused = false
                    if isEditingNotes {
                        isEditingNotes = false
                        saveNotes()
                    }
                }
                .foregroundStyle(AppTheme.goldGradient)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isNotesFocused = false
        }
        .alert(L10n.historyDeleteAlert, isPresented: $showDeleteAlert) {
            Button(L10n.cancel, role: .cancel) { }
            Button(L10n.delete, role: .destructive) {
                deleteSession()
            }
        } message: {
            Text(L10n.historyDeleteMessage)
        }
        .sheet(isPresented: .constant(sharePDFURL != nil), onDismiss: {
            sharePDFURL = nil
        }) {
            if let pdfURL = sharePDFURL {
                ShareSheet(items: [pdfURL])
            }
        }
    }
    
    private func saveNotes() {
        session.notes = editedNotes.isEmpty ? nil : editedNotes
        try? modelContext.save()
    }
    
    private func deleteSession() {
        modelContext.delete(session)
        try? modelContext.save()
        dismiss()
    }
    
    private func prepareShareContent() {
        // Generate PDF and setting sharePDFURL will automatically trigger the sheet
        sharePDFURL = PDFGenerationService.shared.generateReadingPDF(
            drawnCards: session.drawnCards,
            category: session.category,
            customQuestion: session.customQuestion,
            spreadType: session.spreadType,
            notes: editedNotes.isEmpty ? nil : editedNotes,
            date: session.date
        )
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
    .modelContainer(for: ReadingSession.self)
}
