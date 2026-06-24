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
    @State private var bringDrawnCardToFront: Bool = false // Tracks mid-air lift state

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
                progressIndicator
                selectedCardsView
                
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

                    if !isCardSelected {
                        let isPopping = poppingCardId == card.id
                        let isDragging = draggedCardId == card.id
                        let effectiveAngle = fanAppeared ? angle : 0
                        let effectiveOffsetX = fanAppeared ? visualOffsetX : 0
                        let effectiveOffsetY = fanAppeared ? visualOffsetY : 0
                        
                        let cardLayout: (width: CGFloat, height: CGFloat, offsetX: CGFloat, offsetY: CGFloat, angle: Double, scale: CGFloat, zIndex: Double) = {
                            if isFlying, let f = flying {
                                let targetCenter: CGPoint = {
                                    switch f.phase {
                                    case .rest: return f.srcCenter
                                    case .popped: return CGPoint(x: f.srcCenter.x, y: f.srcCenter.y - 70)
                                    case .landed: return f.dstCenter
                                    }
                                }()
                                let dx = targetCenter.x - fanInSelection.midX
                                let dy = targetCenter.y - fanInSelection.minY - (geometry.size.height / 2 + centerYOffset)
                                return (
                                    width: f.phase == .landed ? f.dstSize.width : f.srcSize.width,
                                    height: f.phase == .landed ? f.dstSize.height : f.srcSize.height,
                                    offsetX: dx,
                                    offsetY: dy,
                                    angle: f.phase == .landed ? 0 : f.srcAngle,
                                    scale: f.phase == .popped ? 1.15 : 1.0,
                                    // Use bringDrawnCardToFront layer check here to keep it stacked until it flies clear
                                    zIndex: (f.phase == .landed && bringDrawnCardToFront) ? 1000 : Double(index)
                                )
                            } else {
                                return (
                                    width: 100,
                                    height: 150,
                                    offsetX: effectiveOffsetX + (isDragging ? dragOffset.width : 0),
                                    offsetY: effectiveOffsetY - (isPopping ? 70 : 0) + (isDragging ? dragOffset.height : 0),
                                    angle: effectiveAngle,
                                    scale: isPopping ? 1.15 : 1.0,
                                    zIndex: Double(index)
                                )
                            }
                        }()

                        CardView()
                            .frame(width: cardLayout.width, height: cardLayout.height)
                            .shadow(color: .black.opacity(0.45), radius: isFlying ? 6 : 2, x: 0, y: isFlying ? 4 : 2)
                            .rotationEffect(.degrees(cardLayout.angle))
                            .scaleEffect(cardLayout.scale)
                            .offset(x: cardLayout.offsetX, y: cardLayout.offsetY)
                            .zIndex(cardLayout.zIndex)
                            .allowsHitTesting(fanAppeared && !isProcessingSelection && !isFlying)
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
                                            let finalTranslation = value.translation
                                            draggedCardId = nil
                                            dragOffset = .zero
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
            let currentDraggedCenter = CGPoint(
                x: srcCenter.x + dynamicDragOffset.width,
                y: srcCenter.y + dynamicDragOffset.height
            )
            
            // Drag release happens clear of the deck; bring to front immediately
            bringDrawnCardToFront = true
            
            flying = FlyingCardState(
                card: card,
                srcCenter: currentDraggedCenter,
                srcSize: CGSize(width: 100, height: 150),
                srcAngle: srcAngle,
                dstCenter: CGPoint(x: dstFrame.midX, y: dstFrame.midY),
                dstSize: dstFrame.size,
                phase: .rest
            )
            
            withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                flying?.phase = .landed
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                completeCardSelection(card: card, position: position)
            }
            
        } else {
            // Tap branch sequence:
            bringDrawnCardToFront = false // Start launch deep inside natural index layer
            
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
                
                // Delay lifting the Z-index by 150ms so it clears its neighbor cards physically before coming to the front
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    bringDrawnCardToFront = true
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
        bringDrawnCardToFront = false // Reset state for subsequent draws
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
