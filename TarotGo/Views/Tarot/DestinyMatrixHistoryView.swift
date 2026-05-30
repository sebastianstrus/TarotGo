//
//  DestinyMatrixHistoryView.swift
//  TarotGo
//
//  Displays saved Destiny Matrix sessions and their details
//

import SwiftUI
import SwiftData

struct DestinyMatrixHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DestinyMatrixSession.date, order: .reverse) private var sessions: [DestinyMatrixSession]

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            if sessions.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    LazyVStack(spacing: 15) {
                        ForEach(sessions) { session in
                            NavigationLink {
                                DestinyMatrixSessionDetailView(session: session)
                            } label: {
                                DestinyMatrixSessionCard(session: session)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(L10n.matrixHistoryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.circle")
                .font(.system(size: 60))
                .foregroundStyle(AppTheme.goldGradient.opacity(0.4))

            Text(L10n.matrixHistoryEmpty)
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)

            Text(L10n.matrixHistoryEmptyDesc)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Session Card

struct DestinyMatrixSessionCard: View {
    let session: DestinyMatrixSession

    private var matrix: DestinyMatrix {
        DestinyMatrixCalculator.shared.calculate(from: session.birthDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(L10n.matrixTitle)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)

                    Text(session.formattedBirthDate)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.7))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.gold.opacity(0.6))
            }

            // Center energy preview
            if let centerPos = matrix.centerPosition {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 44, height: 44)

                        Text("\(centerPos.number)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(centerPos.position.displayName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)

                        if let card = centerPos.tarotCard {
                            Text(card.name)
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                                .lineLimit(1)
                        }
                    }

                    Spacer()
                }
            }

            HStack {
                Label("\(L10n.matrixHistorySavedOn) \(session.formattedSaveDate)", systemImage: "clock")
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

// MARK: - Session Detail View

struct DestinyMatrixSessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let session: DestinyMatrixSession

    @State private var matrix: DestinyMatrix?
    @State private var selectedPosition: MatrixPosition?
    @State private var selectedYear: YearlyEnergy?
    @State private var selectedTab: DestinyMatrixResultView.Tab = .diagram
    @State private var editedNotes: String
    @State private var isEditingNotes: Bool = false
    @State private var showDeleteAlert: Bool = false
    @FocusState private var isNotesFocused: Bool

    init(session: DestinyMatrixSession) {
        self.session = session
        _editedNotes = State(initialValue: session.notes ?? "")
    }

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            if let matrix = matrix {
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 8) {
                        Text(L10n.matrixYourMatrix)
                            .font(AppTheme.serifFont(size: 28, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text(matrix.formattedBirthDate)
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.textSecondary)

                        Text("\(L10n.matrixHistorySavedOn) \(session.formattedSaveDate)")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                    }
                    .padding(.vertical, 16)

                    // Tab Selector
                    HStack(spacing: 0) {
                        ForEach(DestinyMatrixResultView.Tab.allCases, id: \.self) { tab in
                            TabButton(
                                tab: tab,
                                isSelected: selectedTab == tab
                            ) {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedTab = tab
                                }
                                HapticService.shared.impact(.light)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)

                    // Content
                    TabView(selection: $selectedTab) {
                        ScrollView {
                            VStack(spacing: 20) {
                                DiagramTabView(matrix: matrix, selectedPosition: $selectedPosition, selectedYear: $selectedYear)
                                    .frame(minHeight: 500)

                                notesAndActionsSection
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 40)
                            }
                        }
                        .tag(DestinyMatrixResultView.Tab.diagram)

                        PositionsListTabView(matrix: matrix, selectedPosition: $selectedPosition)
                            .tag(DestinyMatrixResultView.Tab.positions)

                        CardsGridTabView(matrix: matrix)
                            .tag(DestinyMatrixResultView.Tab.cards)

                        YearAnalysisTabView(matrix: matrix, selectedYear: $selectedYear)
                            .tag(DestinyMatrixResultView.Tab.yearAnalysis)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
            } else {
                ProgressView()
                    .tint(AppTheme.gold)
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
        .alert(L10n.matrixHistoryDeleteAlert, isPresented: $showDeleteAlert) {
            Button(L10n.cancel, role: .cancel) { }
            Button(L10n.delete, role: .destructive) {
                deleteSession()
            }
        } message: {
            Text(L10n.matrixHistoryDeleteMessage)
        }
        .onAppear {
            if matrix == nil {
                matrix = DestinyMatrixCalculator.shared.calculate(from: session.birthDate)
            }
        }
    }

    private var notesAndActionsSection: some View {
        VStack(spacing: 20) {
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text(L10n.historyNoReflections)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.textSecondary.opacity(0.6))
                            .italic()
                            .frame(maxWidth: .infinity, alignment: .leading)
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

            // Delete button
            Button {
                showDeleteAlert = true
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text(L10n.matrixHistoryDelete)
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
        }
    }

    private func saveNotes() {
        session.notes = editedNotes.isEmpty ? nil : editedNotes
        try? modelContext.save()
        HapticService.shared.impact(.light)
    }

    private func deleteSession() {
        modelContext.delete(session)
        try? modelContext.save()
        HapticService.shared.impact(.medium)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        DestinyMatrixHistoryView()
    }
    .modelContainer(for: DestinyMatrixSession.self)
}
