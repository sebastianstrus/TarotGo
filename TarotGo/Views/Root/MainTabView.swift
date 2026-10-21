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
        // The system tab bar is hidden (each tab hides it inside its own navigation
        // stack); `MainTabBar` replaces it so the middle "Today" tab can be larger and
        // the bar can have a custom shape.
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
        .background {
            TabBarInsetAdjuster(
                inset: appViewModel.tabBarVisibility == .hidden ? 0 : TabBarMetrics.clearance
            )
            .frame(width: 0, height: 0)
        }
        .overlay(alignment: .bottom) {
            if appViewModel.tabBarVisibility != .hidden {
                MainTabBar(selection: $appViewModel.activeTab)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: appViewModel.tabBarVisibility)
        .accentColor(AppTheme.gold)
    }
}

// MARK: - Tab Bar Clearance
private enum TabBarMetrics {
    static let barHeight: CGFloat = 68
    static let bottomPadding: CGFloat = 6
    /// Extra breathing room so screen content never sits right against the bar.
    static let contentGap: CGFloat = 14
    static var clearance: CGFloat { barHeight + bottomPadding + contentGap }
}

/// Reserves space for the custom tab bar by adding a bottom safe-area inset on the
/// underlying `UITabBarController`, exactly where the system tab bar used to contribute
/// one. SwiftUI-level insets (`safeAreaInset` / `safeAreaPadding`) don't make it through
/// the tab pages' navigation stacks, but a UIKit inset reaches every screen, including
/// the ones pushed from a tab.
private struct TabBarInsetAdjuster: UIViewControllerRepresentable {
    let inset: CGFloat

    func makeUIViewController(context: Context) -> AdjusterController {
        let controller = AdjusterController()
        controller.inset = inset
        return controller
    }

    func updateUIViewController(_ controller: AdjusterController, context: Context) {
        controller.inset = inset
        controller.apply()
    }

    final class AdjusterController: UIViewController {
        var inset: CGFloat = 0

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            apply()
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            apply()
        }

        func apply() {
            guard let tabController = findTabBarController() else { return }
            guard tabController.additionalSafeAreaInsets.bottom != inset else { return }
            let target = inset
            UIView.animate(withDuration: 0.25) {
                tabController.additionalSafeAreaInsets.bottom = target
                tabController.view.layoutIfNeeded()
            }
        }

        private func findTabBarController() -> UITabBarController? {
            var current: UIViewController? = self
            while let controller = current {
                if let tab = controller as? UITabBarController { return tab }
                current = controller.parent
            }
            guard let root = view.window?.rootViewController else { return nil }
            return Self.search(root)
        }

        private static func search(_ controller: UIViewController) -> UITabBarController? {
            if let tab = controller as? UITabBarController { return tab }
            for child in controller.children {
                if let found = search(child) { return found }
            }
            if let presented = controller.presentedViewController {
                return search(presented)
            }
            return nil
        }
    }
}

// MARK: - Custom Tab Bar
private struct MainTabBar: View {
    @Binding var selection: TarotTab

    private let barHeight = TabBarMetrics.barHeight
    /// Diameter of the medallion button in the middle.
    private let buttonSize: CGFloat = 66
    /// Radius of the bump the bar makes around the medallion.
    private let bumpRadius: CGFloat = 43
    /// How far the bump's center sits below the top edge of the bar.
    private let bumpCenterOffset: CGFloat = 2
    /// Distance from the bottom of the bar to the bottom of the labels.
    private let labelBottomInset: CGFloat = 10

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

    private var isTodaySelected: Bool { selection == .today }

    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(leadingTabs, id: \.self) { tabItem($0) }

                // The middle slot belongs to the medallion and its label.
                todayItem

                ForEach(trailingTabs, id: \.self) { tabItem($0) }
            }
            .frame(height: barHeight)
            .padding(.horizontal, 8)
            .background {
                let shape = TabBarShape(
                    bumpRadius: bumpRadius,
                    bumpCenterOffset: bumpCenterOffset
                )
                ZStack {
                    shape.fill(.ultraThinMaterial)
                    shape.fill(Color.black.opacity(0.4))
                    shape.stroke(AppTheme.gold.opacity(0.45), style: StrokeStyle(lineWidth: 1, lineJoin: .round))
                }
                .shadow(color: .black.opacity(0.45), radius: 12, y: 4)
            }
        }
        .padding(.horizontal, 14)
        .padding(.bottom, TabBarMetrics.bottomPadding)
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
                    .frame(height: 26)
                    .symbolEffect(.bounce.byLayer, value: isSelected)
                Text(tab.title)
                    .font(.system(size: 10, weight: .medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .foregroundColor(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.5))
            .padding(.bottom, labelBottomInset)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: Center item

    private var todayItem: some View {
        Button {
            select(.today)
        } label: {
            ZStack(alignment: .bottom) {
                // Medallion, centered on the bump (so it rises above the bar).
                medallion
                    .frame(width: buttonSize, height: buttonSize)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .offset(y: bumpCenterOffset - buttonSize / 2)

                Text(TarotTab.today.title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(isTodaySelected ? AppTheme.lightGold : AppTheme.gold.opacity(0.85))
                    .padding(.bottom, labelBottomInset)
            }
            .frame(width: buttonSize + 26, height: barHeight)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(TarotTab.today.title)
        .accessibilityAddTraits(isTodaySelected ? .isSelected : [])
    }

    /// A gold-ringed dark medallion, in the same spirit as the round menu buttons elsewhere in the app.
    private var medallion: some View {
        ZStack {
            Circle()
                .fill(AppTheme.gold.opacity(isTodaySelected ? 0.5 : 0.18))
                .blur(radius: 14)
                .scaleEffect(1.15)

            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color(red: 0.32, green: 0.18, blue: 0.55), AppTheme.deepNavy],
                        center: .center,
                        startRadius: 2,
                        endRadius: buttonSize / 2
                    )
                )

            Circle()
                .strokeBorder(AppTheme.goldGradient, lineWidth: 3)

            Circle()
                .strokeBorder(AppTheme.gold.opacity(0.4), lineWidth: 0.8)
                .padding(6)

            Image(systemName: TarotTab.today.symbolImage)
                .font(.system(size: 32))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(isTodaySelected ? 0.9 : 0.5), radius: isTodaySelected ? 8 : 4)
                .symbolEffect(.bounce.byLayer, value: isTodaySelected)
        }
        .scaleEffect(isTodaySelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.35, dampingFraction: 0.6), value: isTodaySelected)
    }

    private func select(_ tab: TarotTab) {
        guard selection != tab else { return }
        HapticService.shared.impact(.light)
        selection = tab
    }
}

// MARK: - Bar Shape
/// A pill with a circular bump rising from the middle of its top edge, where the
/// Today medallion sits.
private struct TabBarShape: Shape {
    let bumpRadius: CGFloat
    let bumpCenterOffset: CGFloat

    func path(in rect: CGRect) -> Path {
        let pill = RoundedRectangle(cornerRadius: rect.height / 2, style: .continuous)
            .path(in: rect)
        let bump = Path(ellipseIn: CGRect(
            x: rect.midX - bumpRadius,
            y: rect.minY + bumpCenterOffset - bumpRadius,
            width: bumpRadius * 2,
            height: bumpRadius * 2
        ))
        return pill.union(bump)
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
        .environmentObject(SubscriptionService.shared)
}
