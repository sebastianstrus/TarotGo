//
//  CoupleMatrixResultView.swift
//  TarotGo
//
//  Displays the result of a Couple Matrix calculation
//

import SwiftUI
import SwiftData

struct CoupleMatrixResultView: View {
    let matrix: CoupleMatrix
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var selectedPosition: CoupleMatrixPosition?
    @State private var selectedYear: CoupleYearlyEnergy?
    @State private var selectedTab: Tab = .diagram
    @State private var sessionSaved: Bool = false

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
                header

                tabSelector

                TabView(selection: $selectedTab) {
                    CoupleDiagramTabView(
                        matrix: matrix,
                        selectedPosition: $selectedPosition,
                        selectedYear: $selectedYear
                    )
                    .tag(Tab.diagram)

                    CouplePositionsTabView(matrix: matrix)
                        .tag(Tab.positions)

                    CoupleCardsTabView(matrix: matrix)
                        .tag(Tab.cards)

                    CoupleYearAnalysisTabView(
                        matrix: matrix,
                        selectedYear: $selectedYear
                    )
                    .tag(Tab.yearAnalysis)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    appViewModel.returnToHome()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
        .onAppear {
            if !sessionSaved {
                saveSession()
            }
        }
    }

    private var header: some View {
        VStack(spacing: 10) {
            Text(L10n.coupleMatrixYourMatrix)
                .font(AppTheme.serifFont(size: 26, weight: .regular))
                .foregroundStyle(AppTheme.goldGradient)

            VStack(spacing: 4) {
                Text("\(L10n.coupleMatrixPartnerA): \(matrix.formattedBirthDateA)")
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textSecondary)

                Text("\(L10n.coupleMatrixPartnerB): \(matrix.formattedBirthDateB)")
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
    }

    private var tabSelector: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { tab in
                CoupleMatrixTabButton(
                    tab: tab,
                    isSelected: selectedTab == tab
                ) {
                    if selectedTab != tab {
                        SoundService.shared.play(.click)
                    }
                    withAnimation(.spring(response: 0.3)) {
                        selectedTab = tab
                    }
                    HapticService.shared.impact(.light)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 15)
    }

    private func saveSession() {
        let session = CoupleMatrixSession(birthDateA: matrix.birthDateA, birthDateB: matrix.birthDateB)
        modelContext.insert(session)
        do {
            try modelContext.save()
            sessionSaved = true
        } catch {
            print("Failed to save couple matrix session: \(error)")
        }
    }
}

// MARK: - Tab Button

struct CoupleMatrixTabButton: View {
    let tab: CoupleMatrixResultView.Tab
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18))

                Text(tab.title)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
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

struct CoupleDiagramTabView: View {
    let matrix: CoupleMatrix
    @Binding var selectedPosition: CoupleMatrixPosition?
    @Binding var selectedYear: CoupleYearlyEnergy?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                CoupleMatrixDiagramView(
                    matrix: matrix,
                    selectedPosition: $selectedPosition,
                    selectedYear: $selectedYear
                )
                .frame(height: 400)
                .padding(.horizontal, 12)

                if let position = selectedPosition {
                    CouplePositionDetailCard(position: position)
                        .padding(.horizontal, 20)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                } else if let year = selectedYear {
                    CoupleYearCard(yearEnergy: year, isHighlighted: year.isCurrentYear)
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

// MARK: - Position Detail Card

struct CouplePositionDetailCard: View {
    let position: CoupleMatrixPosition

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
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

                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient)
                        .frame(width: 50, height: 50)

                    Text("\(position.number)")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }
            }

            if let card = position.tarotCard {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))

                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 16) {
                        CardView(card: card, showFront: true)
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

// MARK: - Positions Tab

struct CouplePositionsTabView: View {
    let matrix: CoupleMatrix

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(matrix.positions) { position in
                    CouplePositionRowView(position: position)
                }
            }
            .padding(20)
        }
    }
}

struct CouplePositionRowView: View {
    let position: CoupleMatrixPosition

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(AppTheme.goldGradient)
                        .frame(width: 50, height: 50)

                    Text("\(position.number)")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(position.position.displayName)
                        .font(AppTheme.serifFont(size: 20, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)

                    Text(position.position.description)
                        .font(.system(size: 13))
                        .foregroundColor(AppTheme.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()
            }

            if let card = position.tarotCard {
                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 14) {
                        CardView(card: card, showFront: true)
                            .frame(width: 60)
                            .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(card.name)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)

                            Text(L10n.matrixViewCardDetails)
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
            RoundedRectangle(cornerRadius: 14)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                )
                .shadow(color: AppTheme.gold.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

// MARK: - Cards Grid Tab

struct CoupleCardsTabView: View {
    let matrix: CoupleMatrix

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
                            CardView(card: card, showFront: true)
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

// MARK: - Year Analysis Tab

struct CoupleYearAnalysisTabView: View {
    let matrix: CoupleMatrix
    @Binding var selectedYear: CoupleYearlyEnergy?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let currentYear = matrix.currentYearEnergy {
                    CoupleYearCard(yearEnergy: currentYear, isHighlighted: true)
                        .padding(.horizontal, 20)
                }

                if let selected = selectedYear, !selected.isCurrentYear {
                    CoupleYearCard(yearEnergy: selected, isHighlighted: false)
                        .padding(.horizontal, 20)
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                }

                VStack(alignment: .leading, spacing: 18) {
                    Text(L10n.coupleMatrixYearsTogether)
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                        .padding(.horizontal, 20)

                    ForEach(decadeGroups, id: \.key) { group in
                        CoupleYearGroupSection(
                            yearsInGroup: group.years,
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

    /// Group years so each row ends at a decade boundary
    /// (e.g. 2026–2030, 2031–2040, 2041–2050, 2051–2060, 2061–2069).
    private var decadeGroups: [(key: Int, years: [CoupleYearlyEnergy])] {
        let grouped = Dictionary(grouping: matrix.yearlyEnergies) { year in
            (year.year - 1) / 10
        }
        return grouped
            .map { (key: $0.key, years: $0.value.sorted { $0.year < $1.year }) }
            .sorted { $0.key < $1.key }
    }
}

// MARK: - Year Group Section

struct CoupleYearGroupSection: View {
    let yearsInGroup: [CoupleYearlyEnergy]
    @Binding var selectedYear: CoupleYearlyEnergy?

    private var sectionTitle: String {
        guard let first = yearsInGroup.first, let last = yearsInGroup.last else { return "" }
        if first.year == last.year {
            return "\(first.year)"
        }
        return "\(first.year) – \(last.year)"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(sectionTitle)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppTheme.textSecondary)
                .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(yearsInGroup) { year in
                        CoupleYearChipView(
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

struct CoupleYearCard: View {
    let yearEnergy: CoupleYearlyEnergy
    let isHighlighted: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(isHighlighted ? L10n.coupleMatrixCurrentYearEnergy : L10n.coupleMatrixYearEnergy)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .textCase(.uppercase)
                        .tracking(1)

                    Text("\(yearEnergy.year)")
                        .font(AppTheme.serifFont(size: 24, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(isHighlighted ? AppTheme.goldGradient : AppTheme.cardGradient)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Circle()
                                .stroke(AppTheme.gold, lineWidth: 2)
                        )

                    Text("\(yearEnergy.primaryEnergy)")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(isHighlighted ? .black : AppTheme.textPrimary)
                }
            }

            if let card = yearEnergy.primaryCard {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))

                NavigationLink(destination: CardDetailView(card: card)) {
                    HStack(spacing: 12) {
                        CardView(card: card, showFront: true)
                            .frame(width: 60)
                            .aspectRatio(AppTheme.cardAspectRatio, contentMode: .fit)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(card.name)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(AppTheme.textPrimary)

                            Text(L10n.coupleMatrixEnergyForYear)
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
                        .stroke(
                            isHighlighted ? AppTheme.lightGold : AppTheme.gold.opacity(0.4),
                            lineWidth: isHighlighted ? 2 : 1.5
                        )
                )
                .shadow(
                    color: isHighlighted ? AppTheme.gold.opacity(0.4) : AppTheme.gold.opacity(0.15),
                    radius: isHighlighted ? 20 : 15,
                    x: 0,
                    y: 8
                )
        )
    }
}

struct CoupleYearChipView: View {
    let yearEnergy: CoupleYearlyEnergy
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(
                        yearEnergy.isCurrentYear
                            ? AppTheme.goldGradient
                            : (isSelected
                                ? LinearGradient(colors: [AppTheme.gold.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                                : LinearGradient(colors: [AppTheme.deepNavy.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                    )
                    .frame(width: 50, height: 50)
                    .overlay(
                        Circle()
                            .stroke(
                                yearEnergy.isCurrentYear ? AppTheme.lightGold : AppTheme.gold.opacity(isSelected ? 0.8 : 0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )

                Text("\(yearEnergy.primaryEnergy)")
                    .font(.system(size: 18, weight: yearEnergy.isCurrentYear ? .bold : .semibold, design: .rounded))
                    .foregroundColor(yearEnergy.isCurrentYear ? .black : AppTheme.textPrimary)
            }

            Text("\(yearEnergy.year)")
                .font(.system(size: 11))
                .foregroundColor(AppTheme.textTertiary)
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.2), value: isSelected)
    }
}

#Preview {
    NavigationStack {
        CoupleMatrixResultView(
            matrix: CoupleMatrixCalculator.shared.calculate(
                birthDateA: Date(),
                birthDateB: Date()
            )
        )
        .environmentObject(AppViewModel())
    }
}
