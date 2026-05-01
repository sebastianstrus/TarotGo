//
//  DestinyMatrixResultView.swift
//  TarotGo
//
//  View displaying Destiny Matrix results and interpretations
//

import SwiftUI

struct DestinyMatrixResultView: View {
    let matrix: DestinyMatrix
    @State private var selectedPosition: MatrixPosition?
    @State private var selectedTab: Tab = .diagram
    
    enum Tab: String, CaseIterable {
        case diagram
        case positions
        case cards
        
        var title: String {
            switch self {
            case .diagram: return L10n.matrixTabDiagram
            case .positions: return L10n.matrixTabPositions
            case .cards: return L10n.matrixTabCards
            }
        }
        
        var icon: String {
            switch self {
            case .diagram: return "square.grid.3x3"
            case .positions: return "list.bullet"
            case .cards: return "rectangle.portrait.on.rectangle.portrait"
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            VStack(spacing: 0) {
                // Header
                VStack(spacing: 8) {
                    Text(L10n.matrixYourMatrix)
                        .font(AppTheme.serifFont(size: 28, weight: .regular))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(matrix.formattedBirthDate)
                        .font(.system(size: 15))
                        .foregroundColor(AppTheme.textSecondary)
                }
                .padding(.vertical, 20)
                
                // Tab Selector
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.self) { tab in
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
                    DiagramTabView(matrix: matrix, selectedPosition: $selectedPosition)
                        .tag(Tab.diagram)
                    
                    PositionsListTabView(matrix: matrix, selectedPosition: $selectedPosition)
                        .tag(Tab.positions)
                    
                    CardsGridTabView(matrix: matrix)
                        .tag(Tab.cards)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Tab Button

struct TabButton: View {
    let tab: DestinyMatrixResultView.Tab
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18))
                
                Text(tab.title)
                    .font(.system(size: 12, weight: isSelected ? .semibold : .regular))
            }
            .foregroundColor(isSelected ? .black : AppTheme.textSecondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                isSelected ?
                    AnyView(AppTheme.goldGradient) :
                    AnyView(Color.clear)
            )
            .cornerRadius(10)
        }
    }
}

// MARK: - Diagram Tab

struct DiagramTabView: View {
    let matrix: DestinyMatrix
    @Binding var selectedPosition: MatrixPosition?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Diagram
                DestinyMatrixDiagramView(matrix: matrix, selectedPosition: $selectedPosition)
                    .frame(height: 350)
                    .padding(.horizontal, 20)
                
                // Selected position details
                if let position = selectedPosition {
                    PositionDetailCard(position: position)
                        .padding(.horizontal, 20)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "hand.tap")
                            .font(.system(size: 30))
                            .foregroundColor(AppTheme.gold.opacity(0.6))
                        
                        Text(L10n.matrixTapCircle)
                            .font(.system(size: 15))
                            .foregroundColor(AppTheme.textTertiary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 40)
                }
                
                Spacer(minLength: 40)
            }
            .padding(.top, 20)
        }
    }
}

// MARK: - Positions List Tab

struct PositionsListTabView: View {
    let matrix: DestinyMatrix
    @Binding var selectedPosition: MatrixPosition?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(sortedPositions) { position in
                    NavigationLink(destination: PositionDetailView(position: position)) {
                        PositionRowView(position: position, isSelected: selectedPosition?.id == position.id)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        HapticService.shared.impact(.light)
                    })
                }
            }
            .padding(20)
        }
    }
    
    private var sortedPositions: [MatrixPosition] {
        // Sort by importance: center first, then main positions, then others
        matrix.positions.sorted { pos1, pos2 in
            priorityOrder(for: pos1.position) < priorityOrder(for: pos2.position)
        }
    }
    
    private func priorityOrder(for type: MatrixPosition.PositionType) -> Int {
        switch type {
        case .center: return 0
        case .personalPower: return 1
        case .socialRealization: return 2
        case .spiritualDevelopment: return 3
        case .planetaryInfluence: return 4
        case .purpose: return 5
        case .talents: return 6
        case .money: return 7
        case .relationships: return 8
        case .health: return 9
        case .karma: return 10
        default: return 100
        }
    }
}

// MARK: - Cards Grid Tab

struct CardsGridTabView: View {
    let matrix: DestinyMatrix
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(uniqueCards, id: \.id) { card in
                    NavigationLink(destination: CardDetailView(card: card)) {
                        VStack(spacing: 8) {
                            CardView(card: card)
                                .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
                            
                            Text(card.name)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                        }
                    }
                }
            }
            .padding(20)
        }
    }
    
    private var uniqueCards: [TarotCard] {
        let cards = matrix.positions.compactMap { $0.tarotCard }
        var seen = Set<String>()
        return cards.filter { card in
            if seen.contains(card.id) {
                return false
            }
            seen.insert(card.id)
            return true
        }
    }
}

// MARK: - Position Detail Card

struct PositionDetailCard: View {
    let position: MatrixPosition
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Position name and number
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(position.position.displayName)
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(position.position.description)
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.textSecondary)
                }
                
                Spacer()
                
                // Number circle
                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient)
                        .frame(width: 50, height: 50)
                    
                    Text("\(position.number)")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }
            }
            
            // Associated tarot card
            if let card = position.tarotCard {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))
                
                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 16) {
                        CardView(card: card)
                            .frame(width: 80)
                            .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text(card.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text(L10n.matrixViewCardDetails)
                                .font(.system(size: 13))
                                .foregroundColor(AppTheme.gold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(AppTheme.gold.opacity(0.6))
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1.5)
                )
                .shadow(color: AppTheme.gold.opacity(0.2), radius: 15, x: 0, y: 8)
        )
    }
}

// MARK: - Position Row View

struct PositionRowView: View {
    let position: MatrixPosition
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Number circle
            ZStack {
                Circle()
                    .fill(isSelected ? AppTheme.goldGradient : AppTheme.cardGradient)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle()
                            .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.5)
                    )
                
                Text("\(position.number)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(isSelected ? .black : AppTheme.textPrimary)
            }
            
            // Position info
            VStack(alignment: .leading, spacing: 4) {
                Text(position.position.displayName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(position.position.description)
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textTertiary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(AppTheme.gold.opacity(0.6))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? AppTheme.cardGradient : LinearGradient(colors: [AppTheme.darkNavy.opacity(0.4)], startPoint: .top, endPoint: .bottom))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            isSelected ? AppTheme.gold.opacity(0.6) : AppTheme.gold.opacity(0.2),
                            lineWidth: isSelected ? 1.5 : 1
                        )
                )
        )
    }
}

// MARK: - Card Link View Helper

struct CardLinkView: View {
    let card: TarotCard
    
    var body: some View {
        HStack(spacing: 20) {
            CardView(card: card)
                .frame(width: 100)
                .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
                .shadow(color: AppTheme.gold.opacity(0.2), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(card.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(L10n.matrixViewCardDetails)
                    .font(.system(size: 14))
                    .foregroundColor(AppTheme.gold)
                
                Spacer()
                
                Text(card.suit.rawValue)
                    .font(.system(size: 12))
                    .foregroundColor(AppTheme.textTertiary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppTheme.gold.opacity(0.6))
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// MARK: - Position Detail View

struct PositionDetailView: View {
    let position: MatrixPosition
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header with number
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 100, height: 100)
                            .shadow(color: AppTheme.gold.opacity(0.4), radius: 20, x: 0, y: 10)
                        
                        Text("\(position.number)")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    }
                    
                    Text(position.position.displayName)
                        .font(AppTheme.serifFont(size: 28, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 20)
                
                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text(position.position.description)
                        .font(.system(size: 17))
                        .foregroundColor(AppTheme.textPrimary)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(AppTheme.cardGradient)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                        )
                )
                
                // Associated Tarot Card
                if let card = position.tarotCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(L10n.matrixAssociatedCard)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppTheme.textSecondary)
                            .textCase(.uppercase)
                            .tracking(1)
                        
                        NavigationLink(destination: CardDetailView(card: card)) {
                            CardLinkView(card: card)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(20)
        }
        .background(AppTheme.backgroundGradient.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let birthDate = Calendar.current.date(from: DateComponents(year: 1990, month: 5, day: 15))!
    let matrix = DestinyMatrixCalculator.shared.calculate(from: birthDate)
    
    return NavigationStack {
        DestinyMatrixResultView(matrix: matrix)
    }
}
