//
//  DestinyMatrixView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/15/26.
//

import SwiftUI

struct DestinyMatrixView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var navigateToDestinyMatrix: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Top spacing for safe area
                        Spacer()
                            .frame(height: 10)
                        
                        // Section title with gold styling
                        VStack(spacing: 10) {
                            Image(systemName: "star.circle.fill")
                                .font(.system(size: 50))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 10, x: 0, y: 5)
                            
                            Text(L10n.destinyMatrixViewTitle)
                                .font(AppTheme.serifFont(size: 36, weight: .regular))
                                .foregroundStyle(AppTheme.goldGradient)
                                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                            
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                                
                                Text(L10n.destinyMatrixViewSubtitle)
                                    .font(.system(size: 14, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                                
                                Image(systemName: "star.fill")
                                    .font(.system(size: 7))
                                    .foregroundColor(AppTheme.gold)
                            }
                        }
                        .padding(.bottom, 10)
                        
                        // Destiny Matrix options
                        VStack(spacing: 14) {
                            // Destiny Matrix
                            Button {
                                HapticService.shared.impact(.light)
                                navigateToDestinyMatrix = true
                            } label: {
                                NavigationButton(
                                    icon: "star.circle.fill",
                                    title: L10n.homeDestinyMatrix,
                                    subtitle: L10n.homeDestinyMatrixSubtitle
                                )
                            }
                            .buttonStyle(PlainButtonStyle())

                            // Saved Destiny Matrices
                            NavigationLink(destination: DestinyMatrixHistoryView()) {
                                NavigationButton(
                                    icon: "star.square.on.square.fill",
                                    title: L10n.homeMatrixHistory,
                                    subtitle: L10n.homeMatrixHistorySubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())

                            // Learn Destiny Matrix
                            NavigationLink(destination: LearnDestinyMatrixView()) {
                                NavigationButton(
                                    icon: "graduationcap.fill",
                                    title: L10n.homeLearnDestinyMatrix,
                                    subtitle: L10n.homeLearnDestinyMatrixSubtitle
                                )
                            }
                            .buttonStyle(NavigationButtonStyle())
                        }
                        .padding(.horizontal, 30)
                        
                        // Footer with golden accent
                        HStack(spacing: 10) {
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 35, height: 1)
                            
                            Text(L10n.destinyMatrixViewFooter)
                                .font(AppTheme.serifFont(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                            
                            Rectangle()
                                .fill(AppTheme.goldGradient)
                                .frame(width: 35, height: 1)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToDestinyMatrix) {
                DestinyMatrixInputView()
                    .toolbar(.hidden, for: .tabBar)
            }
            .onReceive(appViewModel.$shouldDismissToRoot) { shouldDismiss in
                if shouldDismiss {
                    navigateToDestinyMatrix = false
                }
            }
        }
    }
}

#Preview {
    DestinyMatrixView()
        .environmentObject(AppViewModel())
}
