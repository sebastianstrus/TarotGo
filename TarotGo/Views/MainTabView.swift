//
//  MainTabView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TarotView()
                .tabItem {
                    Label {
                        Text(L10n.tabTarot)
                    } icon: {
                        Image(systemName: selectedTab == 0 ? "sparkles" : "sparkles")
                    }
                }
                .tag(0)
            
            PalmistryView()
                .tabItem {
                    Label {
                        Text(L10n.tabPalmistry)
                    } icon: {
                        Image(systemName: selectedTab == 1 ? "hand.raised.fill" : "hand.raised")
                    }
                }
                .tag(1)
            
            CosmicView()
                .tabItem {
                    Label {
                        Text(L10n.tabCosmic)
                    } icon: {
                        Image(systemName: selectedTab == 2 ? "moon.stars.fill" : "moon.stars")
                    }
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Label {
                        Text(L10n.tabSettings)
                    } icon: {
                        Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape")
                    }
                }
                .tag(3)
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

#Preview {
    MainTabView()
        .environmentObject(AppViewModel())
}
