//
//  ShuffleRitualView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import Combine

enum ShufflePhase {
    case instruction
    case pressing
    case shuffling
    case complete
}

struct ShuffleRitualView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let category: IntentionCategory
    let customQuestion: String?
    
    @State private var phase: ShufflePhase = .instruction
    @State private var pressProgress: Double = 0.0
    @State private var isPressed: Bool = false
    @State private var navigateToReading: Bool = false
    @State private var shuffleRotation: Double = 0
    @State private var shuffleOffset: CGFloat = 0
    
    private let pressTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private let totalPressDuration: Double = 5.0
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 40) {
                Spacer()
                
                // Instruction text
                instructionText
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Deck of cards with long press
                deckView
                
                Spacer()
                
                // Progress indicator
                if phase == .pressing {
                    progressIndicator
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $navigateToReading) {
            CardSelectionView(
                category: category,
                customQuestion: customQuestion,
                spreadType: category.defaultSpreadType
            )
        }
        .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
            if shouldDismiss {
                navigateToReading = false
            }
        }
        .onReceive(pressTimer) { _ in
            if isPressed && phase == .pressing {
                pressProgress += 0.05
                
                // Haptic feedback every second
                if Int(pressProgress * 10) % 10 == 0 {
                    lightHaptic()
                }
                
                if pressProgress >= totalPressDuration {
                    completePress()
                }
            }
        }
    }
    
    private var instructionText: some View {
        VStack(spacing: 15) {
            switch phase {
            case .instruction:
                Text(L10n.shuffleTakeBreath)
                    .font(AppTheme.serifFont(size: 28, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
                Text(L10n.shuffleInstruction)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            case .pressing:
                Text(L10n.shuffleFocusing)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            case .shuffling:
                Text(L10n.shuffleShuffling)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            case .complete:
                Text(L10n.shuffleReady)
                    .font(AppTheme.serifFont(size: 24, weight: .light))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.3), radius: 8)
            }
        }
    }
    
    private var deckView: some View {
        ZStack {
            // Stack of cards to show depth
            ForEach(0..<5, id: \.self) { index in
                RoundedRectangle(cornerRadius: 20)
                    .fill(AppTheme.cardGradient)
                    .frame(width: 200, height: 300)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(AppTheme.gold.opacity(0.4), lineWidth: 2)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.2), radius: 5)
                    .offset(x: CGFloat(index) * 3, y: CGFloat(index) * -3)
                    .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation + Double(index * 10) : 0))
                    .offset(x: phase == .shuffling ? shuffleOffset * CGFloat(index) : 0)
            }
            
            // Top card with mystical pattern
            RoundedRectangle(cornerRadius: 20)
                .fill(AppTheme.cardGradient)
                .frame(width: 200, height: 300)
                .overlay(
                    ZStack {
                        // Mystical symbols
                        Image(systemName: "moon.stars.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(AppTheme.goldGradient.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                LinearGradient(
                                    colors: [AppTheme.lightGold, AppTheme.gold, AppTheme.darkGold],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 3
                            )
                    }
                )
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 15)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .rotationEffect(.degrees(phase == .shuffling ? shuffleRotation : 0))
        }
        .gesture(
            LongPressGesture(minimumDuration: totalPressDuration)
                .onChanged { _ in
                    if phase == .instruction {
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = true
                            phase = .pressing
                        }
                    }
                }
                .onEnded { _ in
                    // Handled in timer
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if phase == .instruction {
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = true
                            phase = .pressing
                        }
                    }
                }
                .onEnded { _ in
                    if phase == .pressing && pressProgress < totalPressDuration {
                        // Released too early
                        withAnimation(.spring(response: 0.3)) {
                            isPressed = false
                            phase = .instruction
                            pressProgress = 0
                        }
                    }
                }
        )
    }
    
    private var progressIndicator: some View {
        ZStack {
            Circle()
                .stroke(AppTheme.darkNavy.opacity(0.5), lineWidth: 8)
                .frame(width: 100, height: 100)
            
            Circle()
                .trim(from: 0, to: pressProgress / totalPressDuration)
                .stroke(
                    AppTheme.goldGradient,
                    style: StrokeStyle(lineWidth: 8, lineCap: .round)
                )
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.05), value: pressProgress)
                .shadow(color: AppTheme.gold.opacity(0.6), radius: 8)
            
            Text("\(Int((pressProgress / totalPressDuration) * 100))%")
                .font(AppTheme.serifFont(size: 24, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
        }
    }
    
    private func completePress() {
        isPressed = false
        phase = .shuffling
        HapticService.shared.impact(.heavy)
        SoundService.shared.play(.cardShuffle, volume: 0.7)
        
        // Shuffle animation with sound
        withAnimation(.easeInOut(duration: 2.5).repeatCount(3, autoreverses: true)) {
            shuffleRotation = 360
            shuffleOffset = 30
        }
        
        // Additional shuffle sounds during animation
        for i in 1...3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.8) {
                SoundService.shared.play(.cardShuffle, volume: 0.5)
                HapticService.shared.impact(.medium)
            }
        }
        
        // Navigate after shuffle
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                phase = .complete
            }
            SoundService.shared.play(.bellChime, volume: 0.6)
            HapticService.shared.impact(.success)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                navigateToReading = true
            }
        }
    }
    
    private func lightHaptic() {
        HapticService.shared.impact(.light)
    }
    
    private func strongHaptic() {
        HapticService.shared.impact(.heavy)
    }
}

#Preview {
    NavigationStack {
        ShuffleRitualView(category: .love, customQuestion: "Will I find love?")
    }
    .environmentObject(AppViewModel())
}
