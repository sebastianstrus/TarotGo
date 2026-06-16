//
//  CardSelectionView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

private struct SlotFramesKey: PreferenceKey {
    static var defaultValue: [Int: CGRect] = [:]
    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct CardSelectionView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let category: IntentionCategory
    let customQuestion: String?
    let spreadType: SpreadType

    @StateObject private var viewModel: ReadingViewModel
    @State private var currentPositionIndex: Int = 0
    @State private var showInstruction: Bool = true
    @State private var navigateToInterpretation: Bool = false
    @State private var selectedCards: [TarotCard] = []
    @State private var isProcessingSelection: Bool = false
    @State private var showExitConfirmation: Bool = false

    // Flying-card animation state
    @State private var slotFrames: [Int: CGRect] = [:]
    @State private var flying: FlyingCardState?

    @Environment(\.dismiss) private var dismiss

    private struct FlyingCardState: Equatable {
        let card: TarotCard
        let srcCenter: CGPoint
        let srcSize: CGSize
        let srcAngle: Double
        let dstCenter: CGPoint
        let dstSize: CGSize
        var phase: Phase

        enum Phase { case rest, popped, landed }
    }
    
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

            if let f = flying {
                flyingCardView(f)
                    .allowsHitTesting(false)
            }
        }
        .coordinateSpace(name: "selection")
        .onPreferenceChange(SlotFramesKey.self) { slotFrames = $0 }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showExitConfirmation = true
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
        .confirmationDialog(
            L10n.exitReadingTitle,
            isPresented: $showExitConfirmation,
            titleVisibility: .visible
        ) {
            Button(L10n.exitReadingConfirm, role: .destructive) {
                appViewModel.returnToHome()
                dismiss()
            }
            Button(L10n.exitReadingCancel, role: .cancel) {}
        } message: {
            Text(L10n.exitReadingMessage)
        }
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
        VStack(spacing: 8) {
            if positions.count == 10 {
                HStack(spacing: 10) {
                    ForEach(0..<5, id: \.self) { index in
                        cardSlot(at: index)
                    }
                }
                HStack(spacing: 10) {
                    ForEach(5..<10, id: \.self) { index in
                        cardSlot(at: index)
                    }
                }
            } else {
                HStack(spacing: 10) {
                    ForEach(0..<positions.count, id: \.self) { index in
                        cardSlot(at: index)
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
        .frame(height: positions.count == 10 ? 185 : 95)
    }

    @ViewBuilder
    private func cardSlot(at index: Int) -> some View {
        Group {
            if index < selectedCards.count {
                CardView()
                    .frame(height: 80)
            } else {
                Color.clear
                    .frame(width: 80 * 1108.0 / 1900.0, height: 80)
            }
        }
        .background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: SlotFramesKey.self,
                    value: [index: geo.frame(in: .named("selection"))]
                )
            }
        )
    }
    
    private var cardFanView: some View {
        GeometryReader { geometry in
            let cardCount = viewModel.availableCards.count
            let totalWidth = geometry.size.width - 40
            // Tighter spacing for more cards
            let spacing = min(totalWidth / CGFloat(max(cardCount, 1)), 8)
            let fanInSelection = geometry.frame(in: .named("selection"))

            ZStack {
                ForEach(Array(viewModel.availableCards.enumerated()), id: \.element.id) { index, card in
                    // Smaller angle increment for smoother fan with more cards
                    let angle = Double(index - cardCount / 2) * 2.5
                    let xOffset = CGFloat(index - cardCount / 2) * spacing
                    let yOffset = abs(angle) * 3
                    let isCardSelected = viewModel.selectedCardIds.contains(card.id)
                    let isFlying = flying?.card.id == card.id

                    // Card center in the "selection" coordinate space — inner
                    // ZStack is centered in the fan's GeometryReader, so each
                    // card's center is (fan.midX + xOffset, fan.midY + yOffset).
                    let srcCenter = CGPoint(
                        x: fanInSelection.midX + xOffset,
                        y: fanInSelection.minY + geometry.size.height / 2 + yOffset
                    )

                    if !isCardSelected && !isFlying {
                        CardView()
                            .frame(width: 100, height: 150)
                            .rotationEffect(.degrees(angle))
                            .offset(x: xOffset, y: yOffset)
                            .zIndex(Double(cardCount - abs(index - cardCount / 2)))
                            .onTapGesture {
                                selectCard(card, srcCenter: srcCenter, srcAngle: angle)
                            }
                    }
                }
            }
            .frame(width: geometry.size.width, height: 300)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .frame(height: 400)
    }

    @ViewBuilder
    private func flyingCardView(_ f: FlyingCardState) -> some View {
        let center: CGPoint = {
            switch f.phase {
            case .rest: return f.srcCenter
            case .popped: return CGPoint(x: f.srcCenter.x, y: f.srcCenter.y - 70)
            case .landed: return f.dstCenter
            }
        }()
        let size: CGSize = (f.phase == .landed) ? f.dstSize : f.srcSize
        let angle: Double = (f.phase == .landed) ? 0 : f.srcAngle
        let scale: CGFloat = (f.phase == .popped) ? 1.15 : 1.0

        CardView()
            .frame(width: size.width, height: size.height)
            .rotationEffect(.degrees(angle))
            .scaleEffect(scale)
            .position(center)
    }
    
    private func setupCards() {
        // Cards already shuffled in ViewModel
    }
    
    private func selectCard(_ card: TarotCard, srcCenter: CGPoint, srcAngle: Double) {
        // Prevent race condition - only process one selection at a time
        guard !isProcessingSelection else { return }
        guard let position = currentPosition else { return }

        // Use the captured slot frame if available; otherwise fall back to a
        // small frame at the src position so the animation still runs.
        let cardWidth: CGFloat = 80.0 * 1108.0 / 1900.0
        let dstFrame: CGRect = slotFrames[selectedCards.count]
            ?? CGRect(x: srcCenter.x - cardWidth / 2, y: srcCenter.y - 40, width: cardWidth, height: 80)

        // Mark as processing immediately to prevent multiple rapid taps
        isProcessingSelection = true

        HapticService.shared.impact(.medium)
        SoundService.shared.play(.cardDraw, volume: 0.7)

        // Spawn the flying card at the fan card's current pose. The fan card
        // is removed in the same frame (because `flying?.card.id == card.id`
        // becomes true), so visually nothing changes at this instant.
        flying = FlyingCardState(
            card: card,
            srcCenter: srcCenter,
            srcSize: CGSize(width: 100, height: 150),
            srcAngle: srcAngle,
            dstCenter: CGPoint(x: dstFrame.midX, y: dstFrame.midY),
            dstSize: dstFrame.size,
            phase: .rest
        )

        // Phase 1: pop — scale up, lift up, KEEP the fan rotation.
        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
            flying?.phase = .popped
        }

        // Phase 2: glide to the slot — position, size, AND rotation animate.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.85)) {
                flying?.phase = .landed
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                // Commit: slot card replaces the flying card at the same spot
                selectedCards.append(card)
                _ = viewModel.drawCard(at: position, selectedCard: card)
                flying = nil
                currentPositionIndex += 1

                if currentPositionIndex >= positions.count {
                    HapticService.shared.impact(.success)
                    SoundService.shared.play(.success, volume: 0.6)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        navigateToInterpretation = true
                    }
                } else {
                    showInstruction = true
                    isProcessingSelection = false
                }
            }
        }
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
