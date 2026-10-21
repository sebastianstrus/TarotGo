//
//  MainTabView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

// MARK: - Tab Selection Protocol
protocol AnimatedTabSelectionProtocol: CaseIterable, Hashable {
    var title: String { get }
    var symbolImage: String { get }
}

// MARK: - TarotTab Enum
/// Declaration order is the visual order in the tab bar; `today` sits in the middle.
enum TarotTab: AnimatedTabSelectionProtocol {
    case tarot
    case destinyMatrix
    case today
    case palmistry
    case cosmic
    
    var symbolImage: String {
        switch self {
        case .today: return "sun.max.fill"
        case .tarot: return "rectangle.portrait.on.rectangle.portrait.angled.fill"
        case .destinyMatrix: return "star.circle.fill"
        case .palmistry: return "hand.raised.palm.facing.fill"
        case .cosmic: return "moon.stars.fill"
        }
    }
    
    var title: String {
        switch self {
        case .today: return L10n.tabToday
        case .tarot: return L10n.tabTarot
        case .destinyMatrix: return L10n.tabDestinyMatrix
        case .palmistry: return L10n.tabPalmistry
        case .cosmic: return L10n.tabCosmic
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    @EnvironmentObject var appViewModel: AppViewModel

    var body: some View {
        // The system tab bar is hidden; `MainTabBar` replaces it so the middle
        // "Today" tab can be larger and the bar can have a custom shape.
        TabView(selection: $appViewModel.activeTab) {
            TarotView()
                .tag(TarotTab.tarot)

            DestinyMatrixView()
                .tag(TarotTab.destinyMatrix)

            TodayView()
                .tag(TarotTab.today)

            PalmistryView()
                .tag(TarotTab.palmistry)

            CosmicView()
                .tag(TarotTab.cosmic)
        }
        .tabViewStyle(.tabBarOnly)
        .toolbarVisibility(.hidden, for: .tabBar)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            if appViewModel.tabBarVisibility != .hidden {
                MainTabBar(selection: $appViewModel.activeTab)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: appViewModel.tabBarVisibility)
        .accentColor(AppTheme.gold)
    }
}

// MARK: - Custom Tab Bar
private struct MainTabBar: View {
    @Binding var selection: TarotTab

    private let barHeight: CGFloat = 64
    private let centerSize: CGFloat = 74
    /// Gap between the raised button and the notch cut into the bar.
    private let notchGap: CGFloat = 7

    private var leadingTabs: [TarotTab] {
        let all = TarotTab.allCases
        guard let index = all.firstIndex(of: .today) else { return [] }
        return Array(all[..<index])
    }

    private var trailingTabs: [TarotTab] {
        let all = TarotTab.allCases
        guard let index = all.firstIndex(of: .today) else { return [] }
        return Array(all[all.index(after: index)...])
    }

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(leadingTabs, id: \.self) { tabItem($0) }

                // Room for the raised center button and its label.
                Color.clear
                    .frame(width: centerSize + 12)

                ForEach(trailingTabs, id: \.self) { tabItem($0) }
            }
            .frame(height: barHeight)
            .padding(.horizontal, 8)
            .background {
                let shape = TabBarShape(notchRadius: centerSize / 2 + notchGap)
                ZStack {
                    shape.fill(.ultraThinMaterial)
                    shape.fill(Color.black.opacity(0.35))
                    shape.stroke(AppTheme.gold.opacity(0.35), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.4), radius: 12, y: 4)
            }

            Text(TarotTab.today.title)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(selection == .today ? AppTheme.gold : AppTheme.gold.opacity(0.6))
                .frame(height: barHeight, alignment: .bottom)
                .padding(.bottom, 8)
                .allowsHitTesting(false)

            todayButton
                .offset(y: -centerSize / 2)
        }
        .padding(.horizontal, 14)
        .padding(.bottom, 6)
    }

    // MARK: Side items

    private func tabItem(_ tab: TarotTab) -> some View {
        let isSelected = selection == tab
        return Button {
            select(tab)
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.symbolImage)
                    .font(.system(size: 22))
                    .symbolEffect(.bounce.byLayer, value: isSelected)
                Text(tab.title)
                    .font(.system(size: 10, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundColor(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.5))
            .frame(maxWidth: .infinity)
            .frame(height: barHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: Center button

    private var todayButton: some View {
        let isSelected = selection == .today
        return Button {
            select(.today)
        } label: {
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(isSelected ? 0.45 : 0.2))
                    .frame(width: centerSize + 18, height: centerSize + 18)
                    .blur(radius: 14)

                Circle()
                    .fill(AppTheme.goldGradient)
                    .frame(width: centerSize, height: centerSize)
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white.opacity(0.45), lineWidth: 1.5)
                    )
                    .shadow(color: AppTheme.gold.opacity(isSelected ? 0.8 : 0.45), radius: isSelected ? 14 : 8)

                Image(systemName: TarotTab.today.symbolImage)
                    .font(.system(size: 38))
                    .foregroundColor(AppTheme.deepNavy)
                    .symbolEffect(.bounce.byLayer, value: isSelected)
            }
            .scaleEffect(isSelected ? 1.06 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.6), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(TarotTab.today.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func select(_ tab: TarotTab) {
        guard selection != tab else { return }
        HapticService.shared.impact(.light)
        selection = tab
    }
}

// MARK: - Bar Shape
/// A pill with a circular bite taken out of the top edge, centered, where the
/// raised Today button sits.
private struct TabBarShape: Shape {
    let notchRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        let pill = RoundedRectangle(cornerRadius: rect.height / 2, style: .continuous)
            .path(in: rect)
        let notch = Path(ellipseIn: CGRect(
            x: rect.midX - notchRadius,
            y: rect.minY - notchRadius,
            width: notchRadius * 2,
            height: notchRadius * 2
        ))
        return pill.subtracting(notch)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
        .environmentObject(SubscriptionService.shared)
}
