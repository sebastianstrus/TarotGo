//
//  CardSelectionView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct CardSelectionView: View {
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType
    
    @StateObject private var viewModel: ReadingViewModel
    @State private var currentPositionIndex: Int = 0
    @State private var showInstruction: Bool = true
    @State private var navigateToInterpretation: Bool = false
    @State private var selectedCardId: String?
    
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
            
            VStack(spacing: 30) {
                // Progress indicator
                progressIndicator
                
                // Instruction or position description
                if let position = currentPosition {
                    VStack(spacing: 10) {
                        Text("Card \(currentPositionIndex + 1) of \(positions.count)")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                        
                        Text(position.name)
                            .font(AppTheme.serifFont(size: 28, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                        
                        Text(position.description)
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
                
                Spacer()
                
                // Card fan for selection
                if showInstruction && currentPosition != nil {
                    HStack(spacing: 8) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                        
                        Text("Choose a card that calls to you")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Image(systemName: "sparkles")
                            .font(.system(size: 12))
                            .foregroundColor(AppTheme.gold.opacity(0.7))
                    }
                    .padding(.bottom, 20)
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
        .padding(.top, 20)
    }
    
    private var cardFanView: some View {
        GeometryReader { geometry in
            let cardCount = min(viewModel.availableCards.count, 15)
            let totalWidth = geometry.size.width - 60
            let spacing = totalWidth / CGFloat(cardCount)
            
            ZStack {
                ForEach(Array(viewModel.availableCards.prefix(cardCount).enumerated()), id: \.element.id) { index, card in
                    let angle = Double(index - cardCount / 2) * 5
                    let xOffset = CGFloat(index - cardCount / 2) * spacing / 2
                    
                    CardBackView(isSelected: selectedCardId == card.id)
                        .frame(width: 100, height: 150)
                        .rotationEffect(.degrees(angle))
                        .offset(x: xOffset, y: abs(angle) * 5)
                        .zIndex(selectedCardId == card.id ? 100 : Double(cardCount - abs(index - cardCount / 2)))
                        .scaleEffect(selectedCardId == card.id ? 1.1 : 1.0)
                        .onTapGesture {
                            selectCard(card)
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
        HapticService.shared.impact(.medium)
        SoundService.shared.play(.whoosh, volume: 0.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let drawnCard = viewModel.drawCard(at: position) {
                selectedCardId = nil
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
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.cardGradient)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isSelected ? AppTheme.goldGradient : LinearGradient(colors: [AppTheme.gold.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing),
                    lineWidth: isSelected ? 3 : 2
                )
            
            // Decorative pattern
            VStack(spacing: 10) {
                Image(systemName: "moon.stars.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(AppTheme.goldGradient.opacity(0.4))
                
                Rectangle()
                    .fill(AppTheme.gold.opacity(0.5))
                    .frame(width: 40, height: 2)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 20))
                    .foregroundStyle(AppTheme.goldGradient.opacity(0.4))
            }
        }
        .shadow(color: isSelected ? AppTheme.gold.opacity(0.6) : Color.clear, radius: 15)
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
}
