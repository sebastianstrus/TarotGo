//
//  ARGalleryView.swift
//  TarotGo
//
//  AR Gallery view with multiple display modes for viewing all tarot cards
//

import SwiftUI
import RealityKit
import ARKit

// AR display modes
enum ARDisplayMode: String, CaseIterable, Identifiable {
    case tarotPark = "Tarot Park"
    case deckOnTable = "Deck on Table"
    case standCards = "Stand Cards"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .tarotPark:
            return "Tarot Park"
        case .deckOnTable:
            return "Deck on Table"
        case .standCards:
            return "Stand Cards"
        }
    }
    
    var subtitle: String {
        switch self {
        case .tarotPark:
            return "Walk among 78 cards"
        case .deckOnTable:
            return "Cards lying flat"
        case .standCards:
            return "Standing display"
        }
    }
    
    var icon: String {
        switch self {
        case .tarotPark:
            return "figure.walk"
        case .deckOnTable:
            return "square.grid.3x3"
        case .standCards:
            return "rectangle.portrait.on.rectangle.portrait"
        }
    }
}

// Main AR Gallery View with mode selection
struct ARGalleryView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showModeSelection = true
    @State private var selectedMode: ARDisplayMode?
    
    var body: some View {
        ZStack {
            if let mode = selectedMode {
                // Show the selected AR mode
                ARGalleryContainerView(mode: mode)
                    .ignoresSafeArea()
                
                // Close button overlay
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 5)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $showModeSelection) {
            ARModeSelectionSheet(selectedMode: $selectedMode, isPresented: $showModeSelection)
        }
        .onChange(of: selectedMode) { oldValue, newValue in
            if newValue == nil && !showModeSelection {
                dismiss()
            }
        }
    }
}

// Mode selection sheet (similar to time picker in Settings)
struct ARModeSelectionSheet: View {
    @Binding var selectedMode: ARDisplayMode?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                VStack(spacing: 20) {
                    Text("Choose AR Experience")
                        .font(AppTheme.serifFont(size: 24, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                        .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        ForEach(ARDisplayMode.allCases) { mode in
                            ARModeButton(mode: mode) {
                                selectedMode = mode
                                isPresented = false
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationTitle("AR Gallery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
    }
}

// Mode selection button
struct ARModeButton: View {
    let mode: ARDisplayMode
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: mode.icon)
                    .font(.system(size: 32))
                    .foregroundStyle(AppTheme.goldGradient)
                    .frame(width: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(mode.displayName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Text(mode.subtitle)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 16))
                    .foregroundColor(AppTheme.gold.opacity(0.6))
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
    }
}

// Container view that switches between AR modes
struct ARGalleryContainerView: View {
    let mode: ARDisplayMode
    @AppStorage("selectedCardBack") private var selectedCardBackRaw: String = CardBackStyle.modern.rawValue
    
    private var selectedCardBack: CardBackStyle {
        CardBackStyle(rawValue: selectedCardBackRaw) ?? .modern
    }
    
    var body: some View {
        switch mode {
        case .tarotPark:
            TarotParkARView(cardBackStyle: selectedCardBack)
        case .deckOnTable:
            DeckOnTableARView(cardBackStyle: selectedCardBack)
        case .standCards:
            StandCardsARView(cardBackStyle: selectedCardBack)
        }
    }
}

#Preview {
    ARGalleryView()
}
