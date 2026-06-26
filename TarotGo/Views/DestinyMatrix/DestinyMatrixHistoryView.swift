//
//  DestinyMatrixHistoryView.swift
//  TarotGo
//
//  Displays saved Destiny Matrix sessions and their details
//

import SwiftUI
import SwiftData

enum MatrixHistoryFilter: String, CaseIterable {
    case all
    case single
    case couple

    var title: String {
        switch self {
        case .all: return L10n.matrixHistoryFilterAll
        case .single: return L10n.matrixHistoryFilterSingle
        case .couple: return L10n.matrixHistoryFilterCouple
        }
    }
}

struct DestinyMatrixHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DestinyMatrixSession.date, order: .reverse) private var singleSessions: [DestinyMatrixSession]
    @Query(sort: \CoupleMatrixSession.date, order: .reverse) private var coupleSessions: [CoupleMatrixSession]
    @State private var filter: MatrixHistoryFilter = .all

    private var isEmpty: Bool {
        switch filter {
        case .all: return singleSessions.isEmpty && coupleSessions.isEmpty
        case .single: return singleSessions.isEmpty
        case .couple: return coupleSessions.isEmpty
        }
    }

    private var showSingles: Bool { filter == .all || filter == .single }
    private var showCouples: Bool { filter == .all || filter == .couple }

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            VStack(spacing: 0) {
                filterBar
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                if isEmpty {
                    emptyStateView
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            if showSingles {
                                ForEach(singleSessions) { session in
                                    NavigationLink {
                                        DestinyMatrixSessionDetailView(session: session)
                                    } label: {
                                        DestinyMatrixSessionCard(session: session)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            if showCouples {
                                ForEach(coupleSessions) { session in
                                    NavigationLink {
                                        CoupleMatrixSessionDetailView(session: session)
                                    } label: {
                                        CoupleMatrixSessionCard(session: session)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle(L10n.matrixHistoryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var filterBar: some View {
        HStack(spacing: 0) {
            ForEach(MatrixHistoryFilter.allCases, id: \.self) { option in
                Button {
                    HapticService.shared.impact(.light)
                    withAnimation(.spring(response: 0.3)) {
                        filter = option
                    }
                } label: {
                    Text(option.title)
                        .font(.system(size: 14, weight: filter == option ? .semibold : .regular))
                        .foregroundColor(filter == option ? .black : AppTheme.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            filter == option
                                ? AnyView(AppTheme.goldGradient)
                                : AnyView(Color.clear)
                        )
                        .cornerRadius(10)
                }
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1)
                )
        )
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
    @State private var sharePDFURL: URL?
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
        .sheet(isPresented: .constant(sharePDFURL != nil), onDismiss: {
            sharePDFURL = nil
        }) {
            if let pdfURL = sharePDFURL {
                ShareSheet(items: [pdfURL])
            }
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

            // Share button
            Button {
                shareMatrix()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16))
                    Text(L10n.sharePDF)
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(AppTheme.deepNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppTheme.goldGradient)
                .cornerRadius(12)
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)
            }

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

    private func shareMatrix() {
        guard let matrix = matrix else { return }
        sharePDFURL = PDFGenerationService.shared.generateDestinyMatrixPDF(
            matrix: matrix,
            notes: editedNotes.isEmpty ? nil : editedNotes,
            savedDate: session.date
        )
    }
}

// MARK: - Couple Matrix Session Card

struct CoupleMatrixSessionCard: View {
    let session: CoupleMatrixSession

    private var matrix: CoupleMatrix {
        CoupleMatrixCalculator.shared.calculate(
            birthDateA: session.birthDateA,
            birthDateB: session.birthDateB
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(L10n.coupleMatrixTitle)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)

                    Text("\(session.formattedBirthDateA) · \(session.formattedBirthDateB)")
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.7))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.gold.opacity(0.6))
            }

            if let union = matrix.unionPosition {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 44, height: 44)

                        Text("\(union.number)")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text(union.position.displayName)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)

                        if let card = union.tarotCard {
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

                Image(systemName: "heart.fill")
                    .font(.system(size: 12))
                    .foregroundColor(AppTheme.gold.opacity(0.7))
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

// MARK: - Couple Matrix Session Detail View

struct CoupleMatrixSessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let session: CoupleMatrixSession

    @State private var matrix: CoupleMatrix?
    @State private var selectedPosition: CoupleMatrixPosition?
    @State private var selectedYear: CoupleYearlyEnergy?
    @State private var selectedTab: CoupleMatrixResultView.Tab = .diagram
    @State private var showDeleteAlert: Bool = false
    @State private var sharePDFURL: URL?
    @State private var editedNotes: String
    @State private var isEditingNotes: Bool = false
    @FocusState private var isNotesFocused: Bool

    init(session: CoupleMatrixSession) {
        self.session = session
        _editedNotes = State(initialValue: session.notes ?? "")
    }

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            if let matrix = matrix {
                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Text(L10n.coupleMatrixYourMatrix)
                            .font(AppTheme.serifFont(size: 26, weight: .regular))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text("\(matrix.formattedBirthDateA) · \(matrix.formattedBirthDateB)")
                            .font(.system(size: 13))
                            .foregroundColor(AppTheme.textSecondary)

                        Text("\(L10n.matrixHistorySavedOn) \(session.formattedSaveDate)")
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                    }
                    .padding(.vertical, 16)

                    HStack(spacing: 0) {
                        ForEach(CoupleMatrixResultView.Tab.allCases, id: \.self) { tab in
                            CoupleMatrixTabButton(
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

                    TabView(selection: $selectedTab) {
                        ScrollView {
                            VStack(spacing: 20) {
                                CoupleDiagramTabView(
                                    matrix: matrix,
                                    selectedPosition: $selectedPosition,
                                    selectedYear: $selectedYear
                                )
                                .frame(minHeight: 540)

                                notesAndActionsSection
                                    .padding(.horizontal, 20)
                                    .padding(.bottom, 40)
                            }
                        }
                        .tag(CoupleMatrixResultView.Tab.diagram)

                        CouplePositionsTabView(matrix: matrix)
                            .tag(CoupleMatrixResultView.Tab.positions)

                        CoupleCardsTabView(matrix: matrix)
                            .tag(CoupleMatrixResultView.Tab.cards)

                        CoupleYearAnalysisTabView(matrix: matrix, selectedYear: $selectedYear)
                            .tag(CoupleMatrixResultView.Tab.yearAnalysis)
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
        .sheet(isPresented: .constant(sharePDFURL != nil), onDismiss: {
            sharePDFURL = nil
        }) {
            if let pdfURL = sharePDFURL {
                ShareSheet(items: [pdfURL])
            }
        }
        .onAppear {
            if matrix == nil {
                matrix = CoupleMatrixCalculator.shared.calculate(
                    birthDateA: session.birthDateA,
                    birthDateB: session.birthDateB
                )
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

            // Share button
            Button {
                shareMatrix()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16))
                    Text(L10n.sharePDF)
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(AppTheme.deepNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppTheme.goldGradient)
                .cornerRadius(12)
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)
            }

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

    private func shareMatrix() {
        guard let matrix = matrix else { return }
        sharePDFURL = PDFGenerationService.shared.generateCoupleMatrixPDF(
            matrix: matrix,
            notes: editedNotes.isEmpty ? nil : editedNotes,
            savedDate: session.date
        )
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
