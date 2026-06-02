//
//  DestinyMatrixBasicMeaningsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 6/2/26.
//

import SwiftUI

struct DestinyMatrixBasicMeaningsView: View {
    private struct Energy: Identifiable {
        let id: Int
        let name: String
        let light: String
        let shadow: String
    }
    
    private let energies: [Energy] = [
        .init(id: 1,  name: L10n.matrixEnergy1Name,  light: L10n.matrixEnergy1Light,  shadow: L10n.matrixEnergy1Shadow),
        .init(id: 2,  name: L10n.matrixEnergy2Name,  light: L10n.matrixEnergy2Light,  shadow: L10n.matrixEnergy2Shadow),
        .init(id: 3,  name: L10n.matrixEnergy3Name,  light: L10n.matrixEnergy3Light,  shadow: L10n.matrixEnergy3Shadow),
        .init(id: 4,  name: L10n.matrixEnergy4Name,  light: L10n.matrixEnergy4Light,  shadow: L10n.matrixEnergy4Shadow),
        .init(id: 5,  name: L10n.matrixEnergy5Name,  light: L10n.matrixEnergy5Light,  shadow: L10n.matrixEnergy5Shadow),
        .init(id: 6,  name: L10n.matrixEnergy6Name,  light: L10n.matrixEnergy6Light,  shadow: L10n.matrixEnergy6Shadow),
        .init(id: 7,  name: L10n.matrixEnergy7Name,  light: L10n.matrixEnergy7Light,  shadow: L10n.matrixEnergy7Shadow),
        .init(id: 8,  name: L10n.matrixEnergy8Name,  light: L10n.matrixEnergy8Light,  shadow: L10n.matrixEnergy8Shadow),
        .init(id: 9,  name: L10n.matrixEnergy9Name,  light: L10n.matrixEnergy9Light,  shadow: L10n.matrixEnergy9Shadow),
        .init(id: 10, name: L10n.matrixEnergy10Name, light: L10n.matrixEnergy10Light, shadow: L10n.matrixEnergy10Shadow),
        .init(id: 11, name: L10n.matrixEnergy11Name, light: L10n.matrixEnergy11Light, shadow: L10n.matrixEnergy11Shadow),
        .init(id: 12, name: L10n.matrixEnergy12Name, light: L10n.matrixEnergy12Light, shadow: L10n.matrixEnergy12Shadow),
        .init(id: 13, name: L10n.matrixEnergy13Name, light: L10n.matrixEnergy13Light, shadow: L10n.matrixEnergy13Shadow),
        .init(id: 14, name: L10n.matrixEnergy14Name, light: L10n.matrixEnergy14Light, shadow: L10n.matrixEnergy14Shadow),
        .init(id: 15, name: L10n.matrixEnergy15Name, light: L10n.matrixEnergy15Light, shadow: L10n.matrixEnergy15Shadow),
        .init(id: 16, name: L10n.matrixEnergy16Name, light: L10n.matrixEnergy16Light, shadow: L10n.matrixEnergy16Shadow),
        .init(id: 17, name: L10n.matrixEnergy17Name, light: L10n.matrixEnergy17Light, shadow: L10n.matrixEnergy17Shadow),
        .init(id: 18, name: L10n.matrixEnergy18Name, light: L10n.matrixEnergy18Light, shadow: L10n.matrixEnergy18Shadow),
        .init(id: 19, name: L10n.matrixEnergy19Name, light: L10n.matrixEnergy19Light, shadow: L10n.matrixEnergy19Shadow),
        .init(id: 20, name: L10n.matrixEnergy20Name, light: L10n.matrixEnergy20Light, shadow: L10n.matrixEnergy20Shadow),
        .init(id: 21, name: L10n.matrixEnergy21Name, light: L10n.matrixEnergy21Light, shadow: L10n.matrixEnergy21Shadow),
        .init(id: 22, name: L10n.matrixEnergy22Name, light: L10n.matrixEnergy22Light, shadow: L10n.matrixEnergy22Shadow)
    ]
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.matrixBasicMeaningsTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.matrixBasicMeaningsSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Intro
                    ContentCard {
                        Text(L10n.matrixBasicMeaningsIntro)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(AppTheme.textPrimary)
                            .lineSpacing(6)
                    }
                    
                    // 22 Energies
                    VStack(alignment: .leading, spacing: 24) {
                        SectionTitle(text: L10n.matrixBasicMeaningsListTitle)
                        
                        VStack(spacing: 14) {
                            ForEach(energies) { energy in
                                EnergyCard(energy: energy)
                            }
                        }
                    }
                    
                    Spacer()
                        .frame(height: 30)
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private struct EnergyCard: View {
        let energy: Energy
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                // Header with number badge and name
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.cardGradient)
                            .frame(width: 42, height: 42)
                            .overlay(
                                Circle()
                                    .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.5)
                            )
                        
                        Text("\(energy.id)")
                            .font(AppTheme.serifFont(size: 18, weight: .semibold))
                            .foregroundStyle(AppTheme.goldGradient)
                    }
                    
                    Text(energy.name)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Spacer()
                }
                
                // Light side
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(AppTheme.goldGradient)
                        .padding(.top, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(L10n.matrixBasicMeaningsLightLabel)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        Text(energy.light)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(AppTheme.textPrimary)
                            .lineSpacing(3)
                    }
                }
                
                // Shadow side
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "moon.fill")
                        .font(.system(size: 14))
                        .foregroundColor(AppTheme.textSecondary)
                        .padding(.top, 2)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(L10n.matrixBasicMeaningsShadowLabel)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(AppTheme.textSecondary)
                        
                        Text(energy.shadow)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineSpacing(3)
                    }
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppTheme.cardGradient)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: AppTheme.gold.opacity(0.1), radius: 10, x: 0, y: 5)
            )
        }
    }
}

#Preview {
    NavigationStack {
        DestinyMatrixBasicMeaningsView()
    }
}
