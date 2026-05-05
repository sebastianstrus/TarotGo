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
    @State private var selectedYear: YearlyEnergy?
    @State private var selectedTab: Tab = .diagram
    
    enum Tab: String, CaseIterable {
        case diagram
        case positions
        case cards
        case yearAnalysis
        
        var title: String {
            switch self {
            case .diagram: return L10n.matrixTabDiagram
            case .positions: return L10n.matrixTabPositions
            case .cards: return L10n.matrixTabCards
            case .yearAnalysis: return L10n.matrixTabYearAnalysis
            }
        }
        
        var icon: String {
            switch self {
            case .diagram: return "square.grid.3x3"
            case .positions: return "list.bullet"
            case .cards: return "rectangle.portrait.on.rectangle.portrait"
            case .yearAnalysis: return "calendar.circle"
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
                    DiagramTabView(matrix: matrix, selectedPosition: $selectedPosition, selectedYear: $selectedYear)
                        .tag(Tab.diagram)
                    
                    PositionsListTabView(matrix: matrix, selectedPosition: $selectedPosition)
                        .tag(Tab.positions)
                    
                    CardsGridTabView(matrix: matrix)
                        .tag(Tab.cards)
                    
                    YearAnalysisTabView(matrix: matrix, selectedYear: $selectedYear)
                        .tag(Tab.yearAnalysis)
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
    @Binding var selectedYear: YearlyEnergy?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Diagram
                DestinyMatrixDiagramView(matrix: matrix, selectedPosition: $selectedPosition, selectedYear: $selectedYear)
                    .frame(height: 380)
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

// MARK: - Year Analysis Tab

struct YearAnalysisTabView: View {
    let matrix: DestinyMatrix
    @Binding var selectedYear: YearlyEnergy?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Current Year Highlight
                if let currentYear = matrix.currentYearEnergy {
                    CurrentYearCard(yearEnergy: currentYear)
                        .padding(.horizontal, 20)
                }
                
                // Selected year detail (if different from current)
                if let selected = selectedYear, !selected.isCurrentYear {
                    YearDetailCard(yearEnergy: selected)
                        .padding(.horizontal, 20)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                }
                
                // Year Timeline
                VStack(alignment: .leading, spacing: 12) {
                    Text("Life Timeline")
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                        .padding(.horizontal, 20)
                    
                    // Group by decade
                    ForEach(Array(stride(from: 0, through: 70, by: 10)), id: \.self) { decade in
                        DecadeSection(
                            matrix: matrix,
                            decade: decade,
                            selectedYear: $selectedYear
                        )
                    }
                }
                .padding(.top, 10)
                
                Spacer(minLength: 40)
            }
            .padding(.top, 20)
        }
    }
}

// MARK: - Current Year Card

struct CurrentYearCard: View {
    let yearEnergy: YearlyEnergy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current Year Energy")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .textCase(.uppercase)
                        .tracking(1)
                    
                    Text("\(yearEnergy.year) • Age \(yearEnergy.age)")
                        .font(AppTheme.serifFont(size: 24, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Spacer()
                
                // Primary energy number
                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient)
                        .frame(width: 60, height: 60)
                    
                    Text("\(yearEnergy.primaryEnergy)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }
            }
            
            // Card preview if available
            if let card = yearEnergy.primaryCard {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))
                
                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 12) {
                        CardView(card: card)
                            .frame(width: 60)
                            .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(card.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text("Primary energy for this year")
                                .font(.system(size: 13))
                                .foregroundColor(AppTheme.textSecondary)
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
                        .stroke(AppTheme.lightGold, lineWidth: 2)
                )
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 20, x: 0, y: 10)
        )
    }
}

// MARK: - Year Detail Card

struct YearDetailCard: View {
    let yearEnergy: YearlyEnergy
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Selected Year")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .textCase(.uppercase)
                        .tracking(1)
                    
                    Text("\(yearEnergy.year) • Age \(yearEnergy.age)")
                        .font(AppTheme.serifFont(size: 20, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Circle()
                                .stroke(AppTheme.gold, lineWidth: 2)
                        )
                    
                    Text("\(yearEnergy.primaryEnergy)")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.textPrimary)
                }
            }
            
            if let card = yearEnergy.primaryCard {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))
                
                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 12) {
                        CardView(card: card)
                            .frame(width: 60)
                            .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(card.name)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Text("View card details")
                                .font(.system(size: 12))
                                .foregroundColor(AppTheme.gold)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(AppTheme.gold.opacity(0.6))
                    }
                }
            }
        }
        .padding(16)
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

// MARK: - Decade Section

struct DecadeSection: View {
    let matrix: DestinyMatrix
    let decade: Int
    @Binding var selectedYear: YearlyEnergy?
    
    private var yearsInDecade: [YearlyEnergy] {
        matrix.yearlyEnergies.filter { $0.age >= decade && $0.age < decade + 10 }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(decade)-\(decade + 9) years")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppTheme.textSecondary)
                .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(yearsInDecade) { year in
                        YearChipView(
                            yearEnergy: year,
                            isSelected: selectedYear?.id == year.id
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3)) {
                                selectedYear = year
                            }
                            HapticService.shared.impact(.light)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

// MARK: - Year Chip View

struct YearChipView: View {
    let yearEnergy: YearlyEnergy
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            // Age
            Text("\(yearEnergy.age)")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(AppTheme.textTertiary)
            
            // Energy circle
            ZStack {
                Circle()
                    .fill(
                        yearEnergy.isCurrentYear
                            ? AppTheme.goldGradient
                            : (isSelected
                                ? LinearGradient(colors: [AppTheme.gold.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                                : LinearGradient(colors: [AppTheme.deepNavy.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    )
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle()
                            .stroke(
                                yearEnergy.isCurrentYear ? AppTheme.lightGold : AppTheme.gold.opacity(isSelected ? 0.8 : 0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
                
                Text("\(yearEnergy.primaryEnergy)")
                    .font(.system(size: 16, weight: yearEnergy.isCurrentYear ? .bold : .semibold, design: .rounded))
                    .foregroundColor(yearEnergy.isCurrentYear ? .black : AppTheme.textPrimary)
            }
            
            // Year
            Text("\(yearEnergy.year)")
                .font(.system(size: 10))
                .foregroundColor(AppTheme.textTertiary.opacity(0.7))
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.2), value: isSelected)
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
