//
//  PalmReadingHistoryView.swift
//  TarotGo
//
//  Displays saved Palm Reading sessions and their details
//

import SwiftUI
import SwiftData

struct PalmReadingHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PalmReadingSession.date, order: .reverse) private var sessions: [PalmReadingSession]

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
                                PalmReadingSessionDetailView(session: session)
                            } label: {
                                PalmReadingSessionCard(session: session)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(L10n.palmHistoryTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "hand.raised.palm.facing")
                .font(.system(size: 60))
                .foregroundStyle(AppTheme.goldGradient.opacity(0.4))

            Text(L10n.palmHistoryEmpty)
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)

            Text(L10n.palmHistoryEmptyDesc)
                .font(.system(size: 16, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Session Card

struct PalmReadingSessionCard: View {
    let session: PalmReadingSession

    private var thumbnailImage: UIImage? {
        guard let data = session.capturedImageData else { return nil }
        return UIImage(data: data)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 14) {
                if let image = thumbnailImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                        )
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(AppTheme.darkNavy.opacity(0.6))
                            .frame(width: 60, height: 60)
                        Image(systemName: "hand.raised.palm.facing.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(AppTheme.goldGradient)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(session.palmReading?.handShape.shapeType.description ?? L10n.palmReadingYourReading)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)

                    Text(session.formattedSaveDate)
                        .font(.system(size: 13, weight: .light))
                        .foregroundColor(AppTheme.gold.opacity(0.7))
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.gold.opacity(0.6))
            }

            HStack {
                Label("\(L10n.palmHistorySavedOn) \(session.formattedSaveDate)", systemImage: "clock")
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

struct PalmReadingSessionDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let session: PalmReadingSession

    @State private var editedNotes: String
    @State private var isEditingNotes: Bool = false
    @State private var showDeleteAlert: Bool = false
    @State private var sharePDFURL: URL?
    @FocusState private var isNotesFocused: Bool

    init(session: PalmReadingSession) {
        self.session = session
        _editedNotes = State(initialValue: session.notes ?? "")
    }

    private var capturedImage: UIImage? {
        guard let data = session.capturedImageData else { return nil }
        return UIImage(data: data)
    }

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            if let reading = session.palmReading {
                detailContent(reading: reading)
            } else {
                missingReadingView
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
        .alert(L10n.palmHistoryDeleteAlert, isPresented: $showDeleteAlert) {
            Button(L10n.cancel, role: .cancel) { }
            Button(L10n.delete, role: .destructive) {
                deleteSession()
            }
        } message: {
            Text(L10n.palmHistoryDeleteMessage)
        }
        .sheet(isPresented: .constant(sharePDFURL != nil), onDismiss: {
            sharePDFURL = nil
        }) {
            if let pdfURL = sharePDFURL {
                ShareSheet(items: [pdfURL])
            }
        }
    }

    private var missingReadingView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 60))
                .foregroundStyle(AppTheme.goldGradient.opacity(0.5))

            Text(L10n.palmHistoryEmpty)
                .font(AppTheme.serifFont(size: 22, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)

            Button {
                showDeleteAlert = true
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text(L10n.palmHistoryDelete)
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.red.opacity(0.8))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.red.opacity(0.4), lineWidth: 2)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 30)
    }

    @ViewBuilder
    private func detailContent(reading: PalmReading) -> some View {
        ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "hand.raised.palm.facing.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text(L10n.palmReadingYourReading)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)

                        Text("\(L10n.palmHistorySavedOn) \(session.formattedSaveDate)")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textTertiary)
                    }
                    .padding(.top, 10)

                    // Captured Image
                    if let image = capturedImage {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "photo.fill")
                                    .foregroundStyle(AppTheme.goldGradient)
                                Text(L10n.palmHistoryCapturedImage)
                                    .font(AppTheme.serifFont(size: 22, weight: .medium))
                                    .foregroundColor(AppTheme.textPrimary)
                            }

                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                                )
                                .shadow(color: AppTheme.gold.opacity(0.2), radius: 10, x: 0, y: 4)
                        }
                        .padding(.horizontal, 20)
                    }

                    // Overall interpretation
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundStyle(AppTheme.goldGradient)
                            Text(L10n.palmReadingOverall)
                                .font(AppTheme.serifFont(size: 22, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                        }

                        Text(reading.overallInterpretation)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineSpacing(6)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.cardGradient)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 20)

                    // Hand Shape Section
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "hand.raised.palm.facing.fill")
                                .foregroundStyle(AppTheme.goldGradient)
                            Text(NSLocalizedString("palm.handShape.title", comment: "Your Hand Shape"))
                                .font(AppTheme.serifFont(size: 22, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(reading.handShape.shapeType.description)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(AppTheme.gold)

                                Spacer()

                                Text("✦ \(reading.handShape.palmRatio.description) Palm")
                                    .font(.system(size: 13, weight: .light))
                                    .foregroundColor(AppTheme.textTertiary)
                            }

                            Text(PalmInterpretations.handShapeInterpretation(for: reading.handShape))
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)
                                .lineSpacing(5)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.cardGradient)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 20)

                    // Individual lines
                    VStack(spacing: 14) {
                        Text(L10n.palmReadingYourLines)
                            .font(AppTheme.serifFont(size: 22, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)

                        PalmLineCard(line: .heart, characteristics: reading.heartLine, reading: reading)
                        PalmLineCard(line: .head, characteristics: reading.headLine, reading: reading)
                        PalmLineCard(line: .life, characteristics: reading.lifeLine, reading: reading)
                        PalmLineCard(line: .fate, characteristics: reading.fateLine, reading: reading)
                    }
                    .padding(.horizontal, 20)

                    // Palm Mounts Section
                    if !reading.mounts.isEmpty {
                        VStack(spacing: 14) {
                            HStack {
                                Image(systemName: "mountain.2.fill")
                                    .foregroundStyle(AppTheme.goldGradient)
                                Text(NSLocalizedString("palm.mounts.title", comment: "Palm Mounts"))
                                    .font(AppTheme.serifFont(size: 22, weight: .medium))
                                    .foregroundColor(AppTheme.textPrimary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 20)

                            ForEach(reading.mounts, id: \.mount) { mount in
                                PalmMountCard(mount: mount)
                            }
                        }
                        .padding(.horizontal, 20)
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
                    .padding(.horizontal, 20)

                    // Share button
                    Button {
                        sharePalm(reading: reading)
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16))
                            Text(L10n.summaryShareReading)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(AppTheme.deepNavy)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(AppTheme.goldGradient)
                        .cornerRadius(12)
                        .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)
                    }
                    .padding(.horizontal, 20)

                    // Delete button
                    Button {
                        showDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text(L10n.palmHistoryDelete)
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
                    .padding(.horizontal, 20)

                    Spacer(minLength: 40)
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

    private func sharePalm(reading: PalmReading) {
        sharePDFURL = PDFGenerationService.shared.generatePalmReadingPDF(
            reading: reading,
            capturedImageData: session.capturedImageData,
            notes: editedNotes.isEmpty ? nil : editedNotes,
            savedDate: session.date
        )
    }
}

#Preview {
    NavigationStack {
        PalmReadingHistoryView()
    }
    .modelContainer(for: PalmReadingSession.self)
}
