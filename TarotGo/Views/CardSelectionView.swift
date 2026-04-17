//
//  CardSelectionView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct CardSelectionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType
    
    @StateObject private var viewModel: ReadingViewModel
    @State private var currentPositionIndex: Int = 0
    @State private var showInstruction: Bool = true
    @State private var navigateToInterpretation: Bool = false
    @State private var selectedCardId: String?
    @State private var selectedCards: [TarotCard] = []
    @State private var animatingCardId: String?
    
    init(category: IntentionCategory, customQuestion: String?, spreadType: SpreadType) {
        self.category = category
        self.customQuestion = customQuestion
        self.spreadType = spreadType
        _viewModel = StateObject(wrappedValue: ReadingViewModel(
            category: category,
            customQuestion: customQuestion,
            spreadType: spreadType
        ))
    }
    
    private var positions: [SpreadPosition] {
        spreadType.positions
    }
    
    private var currentPosition: SpreadPosition? {
        guard currentPositionIndex < positions.count else { return nil }
        return positions[currentPositionIndex]
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 20) {
                // Progress indicator
                progressIndicator
                
                // Selected cards at the top
                selectedCardsView
                
                // Instruction or position description
                if let position = currentPosition {
                    VStack(spacing: 10) {
                        Text(L10n.cardPosition(currentPositionIndex + 1, positions.count))
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                        
                        Text(position.name)
                            .font(AppTheme.serifFont(size: 24, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                        
                        Text(position.description)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                // Card fan for selection
                if showInstruction && currentPosition != nil {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                        
                        Text(L10n.selectionChooseCard)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Image(systemName: "sparkles")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                    }
                }
                
                cardFanView
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToInterpretation) {
            InterpretationView(
                drawnCards: viewModel.drawnCards,
                category: category,
                customQuestion: customQuestion,
                spreadType: spreadType
            )
        }
        .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
            if shouldDismiss {
                navigateToInterpretation = false
            }
        }
        .onAppear {
            setupCards()
            SoundService.shared.playAmbient(.ambientMystic, volume: 0.15)
        }
        .onDisappear {
            SoundService.shared.stopAmbient()
        }
    }
    
    private var progressIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<positions.count, id: \.self) { index in
                Capsule()
                    .fill(index < currentPositionIndex ? AppTheme.goldGradient : LinearGradient(colors: [AppTheme.gold.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 40)
        .padding(.top, 10)
    }
    
    private var selectedCardsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(selectedCards, id: \.id) { card in
                    ZStack {
                        // White background
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.white)
                        
                        // Card back image
                        if let uiImage = UIImage(named: "ReversCard") {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(1108/1900, contentMode: .fit)
                                .cornerRadius(6)
                        }
                        
                        // Border
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(
                                LinearGradient(
                                    colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    }
                    .aspectRatio(1108/1900, contentMode: .fit)
                    .frame(height: 80)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 5)
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
        .frame(height: 95)
    }
    
    private var cardFanView: some View {
        GeometryReader { geometry in
            let cardCount = viewModel.availableCards.count
            let totalWidth = geometry.size.width - 40
            // Tighter spacing for more cards
            let spacing = min(totalWidth / CGFloat(max(cardCount, 1)), 8)
            
            ZStack {
                ForEach(Array(viewModel.availableCards.enumerated()), id: \.element.id) { index, card in
                    // Smaller angle increment for smoother fan with more cards
                    let angle = Double(index - cardCount / 2) * 2.5
                    let xOffset = CGFloat(index - cardCount / 2) * spacing
                    let isCardSelected = viewModel.selectedCardIds.contains(card.id)
                    
                    CardBackView(isSelected: selectedCardId == card.id)
                        .frame(width: 100, height: 150)
                        .rotationEffect(.degrees(angle))
                        .offset(x: xOffset, y: abs(angle) * 3)
                        .zIndex(selectedCardId == card.id ? 100 : Double(cardCount - abs(index - cardCount / 2)))
                        .scaleEffect(selectedCardId == card.id ? 1.1 : 1.0)
                        .opacity(isCardSelected ? 0 : 1)
                        .allowsHitTesting(!isCardSelected)
                        .onTapGesture {
                            if !isCardSelected {
                                selectCard(card)
                            }
                        }
                }
            }
            .frame(width: geometry.size.width, height: 300)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 400)
    }
    
    private func setupCards() {
        // Cards already shuffled in ViewModel
    }
    
    private func selectCard(_ card: TarotCard) {
        guard let position = currentPosition else { return }
        
        selectedCardId = card.id
        animatingCardId = card.id
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.whoosh, volume: 0.5)
        
        // Add card to selected cards with animation
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            selectedCards.append(card)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            if let drawnCard = viewModel.drawCard(at: position, selectedCard: card) {
                selectedCardId = nil
                animatingCardId = nil
                currentPositionIndex += 1
                
                // Check if all cards have been drawn
                if currentPositionIndex >= positions.count {
                    HapticService.shared.impact(.success)
                    SoundService.shared.play(.success, volume: 0.6)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        navigateToInterpretation = true
                    }
                } else {
                    showInstruction = true
                }
            }
        }
    }
}

struct CardBackView: View {
    let isSelected: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // White background to ensure no transparency
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                
                // Real card back image
                if let uiImage = UIImage(named: "ReversCard") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    // Fallback if image not found
                    RoundedRectangle(cornerRadius: 12)
                        .fill(AppTheme.cardGradient)
                    
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 40))
                            .foregroundStyle(AppTheme.goldGradient)
                        Text("ReversCard image not found")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                }
                
                // Border
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isSelected ? AppTheme.goldGradient : LinearGradient(colors: [AppTheme.gold.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing),
                        lineWidth: isSelected ? 3 : 2
                    )
            }
            .shadow(color: isSelected ? AppTheme.gold.opacity(0.6) : Color.clear, radius: 15)
        }
        .aspectRatio(1108/1900, contentMode: .fit)
    }
}

#Preview {
    NavigationStack {
        CardSelectionView(
            category: .love,
            customQuestion: "Will I find love?",
            spreadType: .threeCard
        )
    }
    .environmentObject(AppViewModel())
}
