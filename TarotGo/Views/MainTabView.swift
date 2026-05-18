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
enum TarotTab: AnimatedTabSelectionProtocol {
    case tarot
    case palmistry
    case cosmic
    case settings
    
    var symbolImage: String {
        switch self {
        case .tarot: return "rectangle.portrait.on.rectangle.portrait.angled.fill"
        case .palmistry: return "hand.raised.palm.facing.fill"
        case .cosmic: return "moon.stars.fill"
        case .settings: return "gearshape.fill"
        }
    }
    
    var title: String {
        switch self {
        case .tarot: return L10n.tabTarot
        case .palmistry: return L10n.tabPalmistry
        case .cosmic: return L10n.tabCosmic
        case .settings: return L10n.tabSettings
        }
    }
}

// MARK: - Main Tab View
struct MainTabView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var activeTab: TarotTab = .tarot
    
    var body: some View {
        AnimatedTabView(selection: $activeTab) {
            Tab.init(TarotTab.tarot.title, systemImage: TarotTab.tarot.symbolImage, value: .tarot) {
                TarotView()
            }
            
            Tab.init(TarotTab.palmistry.title, systemImage: TarotTab.palmistry.symbolImage, value: .palmistry) {
                PalmistryView()
            }
            
            Tab.init(TarotTab.cosmic.title, systemImage: TarotTab.cosmic.symbolImage, value: .cosmic) {
                CosmicView()
            }
            
            Tab.init(TarotTab.settings.title, systemImage: TarotTab.settings.symbolImage, value: .settings) {
                NavigationStack {
                    SettingsView()
                }
            }
        } effects: { tab in
            switch tab {
            case .tarot: [.bounce.byLayer]
            case .palmistry: [.bounce.byLayer]
            case .cosmic: [.bounce.byLayer]
            case .settings: [.rotate]
            }
        }
        .accentColor(AppTheme.gold)
        .onAppear {
            configureTabBarAppearance()
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // Style for unselected items
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(AppTheme.gold.opacity(0.5))
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(AppTheme.gold.opacity(0.5))
        ]
        
        // Style for selected items
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(AppTheme.gold)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(AppTheme.gold)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Animated Tab View
struct AnimatedTabView<Selection: AnimatedTabSelectionProtocol, Content: TabContent<Selection>>: View {
    @Binding var selection: Selection
    
    @TabContentBuilder<Selection> var content: () -> Content
    
    var effects: (Selection) -> [any DiscreteSymbolEffect & SymbolEffect]
    
    @State private var imageViews: [Selection: UIImageView] = [:]
    
    var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(.tabBarOnly)
        .background(ExtractImageViewsFromTabView {
            imageViews = $0
        })
        .compositingGroup()
        .onChange(of: selection) { oldValue, newValue in
            let symbolEffects = effects(newValue)
            guard let imageView = imageViews[newValue] else { return }
            
            for effect in symbolEffects {
                imageView.addSymbolEffect(effect, options: .nonRepeating)
            }
        }
    }
}

// MARK: - Extract ImageViews Helper
fileprivate struct ExtractImageViewsFromTabView<Value: AnimatedTabSelectionProtocol>: UIViewRepresentable {
    var result: ([Value: UIImageView]) -> ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            if let compostingGroup = view.superview?.superview {
                guard let tabHostingController = compostingGroup.subviews.last else { return }
                guard let tabController = tabHostingController.subviews.first?.next as? UITabBarController else { return }
                
                extractImageViews(tabController.tabBar)
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func extractImageViews(_ tabBar: UITabBar) {
        let imageViews = tabBar.subviews(type: UIImageView.self)
            .filter({ $0.image?.isSymbolImage ?? false })
            .filter({ $0.tintColor == tabBar.tintColor })
        
        var dict: [Value: UIImageView] = [:]
        for tab in Value.allCases {
            if let imageView = imageViews.first(where: {
                $0.description.contains(tab.symbolImage)
            }) {
                dict[tab] = imageView
            }
        }
        result(dict)
    }
}

// MARK: - UIView Extension
fileprivate extension UIView {
    func subviews<T: UIView>(type: T.Type) -> [T] {
        subviews.compactMap { $0 as? T } +
        subviews.flatMap { $0.subviews(type: type) }
    }
}

// MARK: - Preview
#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
