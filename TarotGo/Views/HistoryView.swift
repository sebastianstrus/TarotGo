//
//  HistoryView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import SwiftData

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
            AnimatedBackgroundView()
            
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
        .navigationTitle("Reading History")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var headerView: some View {
        HStack {
            Text("Filter:")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.white.opacity(0.8))
            
            Menu {
                Button("All Readings") {
                    selectedCategory = nil
                }
                
                Divider()
                
                ForEach(IntentionCategory.allCases, id: \.self) { category in
                    Button(category.rawValue) {
                        selectedCategory = category
                    }
                }
            } label: {
                HStack {
                    Text(selectedCategory?.rawValue ?? "All")
                        .font(.system(size: 16, weight: .medium))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                )
            }
            
            Spacer()
            
            Text("\(filteredSessions.count) reading\(filteredSessions.count == 1 ? "" : "s")")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white.opacity(0.6))
        }
        .padding()
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundColor(.white.opacity(0.3))
            
            Text("No readings yet")
                .font(.system(size: 24, weight: .light, design: .serif))
                .foregroundColor(.white)
            
            Text("Your saved readings will appear here")
                .font(.system(size: 16, weight: .light))
                .foregroundColor(.white.opacity(0.7))
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
                    Text(session.category.rawValue)
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundColor(.white)
                    
                    Text(session.date.formatted(date: .long, time: .shortened))
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.5))
            }
            
            if let question = session.customQuestion {
                Text("\"\(question)\"")
                    .font(.system(size: 14, weight: .light, design: .serif))
                    .foregroundColor(.white.opacity(0.8))
                    .italic()
                    .lineLimit(2)
            }
            
            // Card preview
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(session.drawnCards.prefix(5)) { drawnCard in
                        TarotCardFrontView(card: drawnCard.card, isReversed: drawnCard.isReversed)
                            .frame(width: 50, height: 75)
                    }
                    
                    if session.drawnCards.count > 5 {
                        Text("+\(session.drawnCards.count - 5)")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                            .frame(width: 50, height: 75)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
            }
            
            HStack {
                Label(session.spreadType.rawValue, systemImage: "square.grid.3x3")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.white.opacity(0.6))
                
                Spacer()
                
                if session.notes != nil {
                    Image(systemName: "note.text")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

struct SessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let session: ReadingSession
    
    @State private var editedNotes: String
    @State private var isEditingNotes: Bool = false
    @State private var showDeleteAlert: Bool = false
    @FocusState private var isNotesFocused: Bool
    
    init(session: ReadingSession) {
        self.session = session
        _editedNotes = State(initialValue: session.notes ?? "")
    }
    
    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 10) {
                        Text(session.category.rawValue)
                            .font(.system(size: 32, weight: .light, design: .serif))
                            .foregroundColor(.white)
                        
                        if let question = session.customQuestion {
                            Text("\"\(question)\"")
                                .font(.system(size: 16, weight: .light, design: .serif))
                                .foregroundColor(.white.opacity(0.8))
                                .italic()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        Text(session.date.formatted(date: .long, time: .shortened))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.top, 20)
                    
                    // Spread visualization
                    VStack(spacing: 15) {
                        Text(session.spreadType.rawValue)
                            .font(.system(size: 20, weight: .medium, design: .serif))
                            .foregroundColor(.white)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: min(session.drawnCards.count, 3)), spacing: 15) {
                            ForEach(session.drawnCards) { drawnCard in
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
                    
                    // Cards detail
                    ForEach(Array(session.drawnCards.enumerated()), id: \.element.id) { index, drawnCard in
                        CardSummaryCard(drawnCard: drawnCard, index: index + 1)
                    }
                    
                    // Notes
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Your Reflections")
                                .font(.system(size: 20, weight: .medium, design: .serif))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                isEditingNotes.toggle()
                                if !isEditingNotes {
                                    saveNotes()
                                }
                            } label: {
                                Text(isEditingNotes ? "Done" : "Edit")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        if isEditingNotes {
                            TextEditor(text: $editedNotes)
                                .frame(minHeight: 120)
                                .padding(12)
                                .background(Color.white.opacity(0.1))
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                                .scrollContentBackground(.hidden)
                                .focused($isNotesFocused)
                                .tint(.white)
                                .onAppear {
                                    isNotesFocused = true
                                }
                        } else {
                            if !editedNotes.isEmpty {
                                Text(editedNotes)
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.white.opacity(0.9))
                                    .lineSpacing(6)
                            } else {
                                Text("No reflections added")
                                    .font(.system(size: 16, weight: .light))
                                    .foregroundColor(.white.opacity(0.5))
                                    .italic()
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
                    
                    // Delete button
                    Button {
                        showDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete Reading")
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
                Button("Done") {
                    isNotesFocused = false
                    if isEditingNotes {
                        isEditingNotes = false
                        saveNotes()
                    }
                }
                .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isNotesFocused = false
        }
        .alert("Delete Reading", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                deleteSession()
            }
        } message: {
            Text("Are you sure you want to delete this reading? This action cannot be undone.")
        }
    }
    
    private func saveNotes() {
        session.notes = editedNotes.isEmpty ? nil : editedNotes
        try? modelContext.save()
    }
    
    private func deleteSession() {
        modelContext.delete(session)
        try? modelContext.save()
    }
}

#Preview {
    NavigationStack {
        HistoryView()
    }
    .modelContainer(for: ReadingSession.self)
}
