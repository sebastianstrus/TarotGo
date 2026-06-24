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
    @State private var poppingCardId: String?

    // Drag gesture state
    @State private var draggedCardId: String? = nil
    @State private var dragOffset: CGSize = .zero

    // Initial fan-in animation state
    @State private var fanAppeared: Bool = false

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
                            .lineLimit(1)

                        Text(position.description)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .lineLimit(2, reservesSpace: true)
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
            if !fanAppeared {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    SoundService.shared.play(.cardDraw, volume: 0.6)
                    fanAppeared = true
                }
            }
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
            let fanInSelection = geometry.frame(in: .named("selection"))

            let angleStep: Double = cardCount > 30 ? 1.6 : 3.0
            let pivotDistance: CGFloat = 110.0
            let centerYOffset: CGFloat = -25.0

            ZStack {
                ForEach(Array(viewModel.availableCards.enumerated()), id: \.element.id) { index, card in
                    let angle = Double(index - cardCount / 2) * angleStep
                    let angleRad = angle * .pi / 180.0
                    let visualOffsetX = pivotDistance * CGFloat(sin(angleRad))
                    let visualOffsetY = pivotDistance * CGFloat(1.0 - cos(angleRad))
                    let isCardSelected = viewModel.selectedCardIds.contains(card.id)
                    let isFlying = flying?.card.id == card.id

                    let srcCenter = CGPoint(
                        x: fanInSelection.midX + visualOffsetX,
                        y: fanInSelection.minY + geometry.size.height / 2 + centerYOffset + visualOffsetY
                    )

                    if !isCardSelected && !isFlying {
                        let isPopping = poppingCardId == card.id
                        let isDragging = draggedCardId == card.id
                        let effectiveAngle = fanAppeared ? angle : 0
                        let effectiveOffsetX = fanAppeared ? visualOffsetX : 0
                        let effectiveOffsetY = fanAppeared ? visualOffsetY : 0
                        
                        CardView()
                            .frame(width: 100, height: 150)
                            .shadow(color: .black.opacity(0.45), radius: 2, x: 0, y: 2)
                            .rotationEffect(.degrees(effectiveAngle))
                            .offset(
                                x: effectiveOffsetX + (isDragging ? dragOffset.width : 0),
                                y: effectiveOffsetY - (isPopping ? 70 : 0) + (isDragging ? dragOffset.height : 0)
                            )
                            .scaleEffect(isPopping ? 1.15 : 1.0)
                            .zIndex(Double(index))
                            .allowsHitTesting(fanAppeared && !isProcessingSelection)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: dragOffset)
                            .animation(.spring(response: 0.9, dampingFraction: 0.82), value: fanAppeared)
                            .onTapGesture {
                                selectCard(card, srcCenter: srcCenter, srcAngle: angle, bypassDelay: false, dynamicDragOffset: .zero)
                            }
                            .gesture(
                                DragGesture(coordinateSpace: .named("selection"))
                                    .onChanged { value in
                                        guard !isProcessingSelection else { return }
                                        if draggedCardId == nil {
                                            draggedCardId = card.id
                                            HapticService.shared.impact(.light)
                                        }
                                        dragOffset = value.translation
                                    }
                                    .onEnded { value in
                                        guard draggedCardId == card.id else { return }
                                        
                                        if value.translation.height < -90 {
                                            // Capture the exact offset state right now to bridge into the fly animation
                                            let finalTranslation = value.translation
                                            
                                            // Clear states cleanly first so it doesn't try to snap backwards
                                            draggedCardId = nil
                                            dragOffset = .zero
                                            
                                            // Execute dynamic fly selection directly from current location
                                            selectCard(card, srcCenter: srcCenter, srcAngle: angle, bypassDelay: true, dynamicDragOffset: finalTranslation)
                                        } else {
                                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                                draggedCardId = nil
                                                dragOffset = .zero
                                            }
                                        }
                                    }
                            )
                    }
                }

                if let f = flying,
                   let originalFanIndex = viewModel.availableCards.firstIndex(where: { $0.id == f.card.id }) {
                    let phase = f.phase
                    let targetCenter: CGPoint = {
                        switch phase {
                        case .rest: return f.srcCenter
                        case .popped: return CGPoint(x: f.srcCenter.x, y: f.srcCenter.y - 70)
                        case .landed: return f.dstCenter
                        }
                    }()
                    
                    let offsetX = targetCenter.x - fanInSelection.midX
                    let offsetY = targetCenter.y - fanInSelection.minY - (geometry.size.height / 2 + centerYOffset)
                    let size: CGSize = (phase == .landed) ? f.dstSize : f.srcSize
                    let angle: Double = (phase == .landed) ? 0 : f.srcAngle
                    let scale: CGFloat = (phase == .popped) ? 1.15 : 1.0

                    CardView()
                        .frame(width: size.width, height: size.height)
                        .shadow(color: .black.opacity(0.45), radius: 6, x: 0, y: 4)
                        .rotationEffect(.degrees(angle))
                        .scaleEffect(scale)
                        .offset(x: offsetX, y: offsetY)
                        .zIndex(999) // Force the master flying overlay to sit on top of everything
                        .allowsHitTesting(false)
                }
            }
            .frame(width: geometry.size.width, height: 240)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 + centerYOffset)
        }
        .frame(height: 280)
    }
    
    private func setupCards() {
        // Cards already shuffled in ViewModel
    }
    
    private func selectCard(_ card: TarotCard, srcCenter: CGPoint, srcAngle: Double, bypassDelay: Bool, dynamicDragOffset: CGSize) {
        guard !isProcessingSelection else { return }
        guard let position = currentPosition else { return }

        let cardWidth: CGFloat = 80.0 * 1108.0 / 1900.0
        let dstFrame: CGRect = slotFrames[selectedCards.count]
            ?? CGRect(x: srcCenter.x - cardWidth / 2, y: srcCenter.y - 40, width: cardWidth, height: 80)

        isProcessingSelection = true

        HapticService.shared.impact(.medium)
        SoundService.shared.play(.cardDraw, volume: 0.7)

        if bypassDelay {
            // DRAG PATH: Convert the origin point into the active dragged finger location directly
            let currentDraggedCenter = CGPoint(
                x: srcCenter.x + dynamicDragOffset.width,
                y: srcCenter.y + dynamicDragOffset.height
            )
            
            // Hand off instantly to the high-level flying layer directly at the drop position
            flying = FlyingCardState(
                card: card,
                srcCenter: currentDraggedCenter,
                srcSize: CGSize(width: 100, height: 150),
                srcAngle: srcAngle,
                dstCenter: CGPoint(x: dstFrame.midX, y: dstFrame.midY),
                dstSize: dstFrame.size,
                phase: .rest
            )
            
            // Animate straight up into the chosen card slot frame
            withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                flying?.phase = .landed
            }
            
            // Complete layout commit
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                completeCardSelection(card: card, position: position)
            }
            
        } else {
            // TAP PATH: Standard localized hover pop animation
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                poppingCardId = card.id
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                flying = FlyingCardState(
                    card: card,
                    srcCenter: srcCenter,
                    srcSize: CGSize(width: 100, height: 150),
                    srcAngle: srcAngle,
                    dstCenter: CGPoint(x: dstFrame.midX, y: dstFrame.midY),
                    dstSize: dstFrame.size,
                    phase: .popped
                )
                poppingCardId = nil

                withAnimation(.spring(response: 0.6, dampingFraction: 0.85)) {
                    flying?.phase = .landed
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    completeCardSelection(card: card, position: position)
                }
            }
        }
    }
    
    private func completeCardSelection(card: TarotCard, position: SpreadPosition) {
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
