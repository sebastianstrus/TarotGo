//
//  PalmBasicMeaningsView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/17/26.
//

import SwiftUI

struct PalmBasicMeaningsView: View {
    // Get current language code for localized palm image
    private var currentLanguageCode: String {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        // Handle special case for Brazilian Portuguese
        if languageCode == "pt", Locale.current.region?.identifier == "BR" {
            return "pt-BR"
        }
        return languageCode
    }
    
    // Get localized palm image name
    private var palmImageName: String {
        "palm_\(currentLanguageCode)"
    }
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Top spacing
                    Spacer()
                        .frame(height: 20)
                    
                    // Page title
                    VStack(alignment: .leading, spacing: 8) {
                        Text(L10n.palmBasicMeaningsTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)
                        
                        Text(L10n.palmBasicMeaningsSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Palm Diagram
                    ContentCard {
                        VStack(spacing: 12) {
                            Text(L10n.palmBasicMeaningsDiagramTitle)
                                .font(AppTheme.serifFont(size: 20, weight: .semibold))
                                .foregroundStyle(AppTheme.goldGradient)
                            
                            Image(palmImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(12)
                                .shadow(color: AppTheme.gold.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                    }
                    
                    // Major Lines Section
                    VStack(alignment: .leading, spacing: 24) {
                        SectionTitle(text: L10n.palmBasicMeaningsMajorLinesTitle)
                        
                        // Heart Line
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                PalmFeatureHeader(
                                    icon: "heart.fill",
                                    title: L10n.palmBasicMeaningsHeartLineTitle
                                )
                                
                                Text(L10n.palmBasicMeaningsHeartLineDescription)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                Text(L10n.palmBasicMeaningsHeartLineMeaning)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .lineSpacing(5)
                            }
                        }
                        
                        // Head Line
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                PalmFeatureHeader(
                                    icon: "brain.head.profile",
                                    title: L10n.palmBasicMeaningsHeadLineTitle
                                )
                                
                                Text(L10n.palmBasicMeaningsHeadLineDescription)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                Text(L10n.palmBasicMeaningsHeadLineMeaning)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .lineSpacing(5)
                            }
                        }
                        
                        // Life Line
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                PalmFeatureHeader(
                                    icon: "figure.walk",
                                    title: L10n.palmBasicMeaningsLifeLineTitle
                                )
                                
                                Text(L10n.palmBasicMeaningsLifeLineDescription)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                Text(L10n.palmBasicMeaningsLifeLineMeaning)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .lineSpacing(5)
                            }
                        }
                        
                        // Fate Line
                        ContentCard {
                            VStack(alignment: .leading, spacing: 12) {
                                PalmFeatureHeader(
                                    icon: "arrow.up.forward",
                                    title: L10n.palmBasicMeaningsFateLineTitle
                                )
                                
                                Text(L10n.palmBasicMeaningsFateLineDescription)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                Text(L10n.palmBasicMeaningsFateLineMeaning)
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(AppTheme.textSecondary)
                                    .lineSpacing(5)
                            }
                        }
                    }
                    
                    // Mounts Section
                    VStack(alignment: .leading, spacing: 24) {
                        SectionTitle(text: L10n.palmBasicMeaningsMountsTitle)
                        
                        ContentCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(L10n.palmBasicMeaningsMountsIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    MountItem(planet: L10n.palmBasicMeaningsVenusTitle, meaning: L10n.palmBasicMeaningsVenusMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsJupiterTitle, meaning: L10n.palmBasicMeaningsJupiterMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsSaturnTitle, meaning: L10n.palmBasicMeaningsSaturnMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsApolloTitle, meaning: L10n.palmBasicMeaningsApolloMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsMercuryTitle, meaning: L10n.palmBasicMeaningsMercuryMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsMarsTitle, meaning: L10n.palmBasicMeaningsMarsMeaning)
                                    MountItem(planet: L10n.palmBasicMeaningsMoonTitle, meaning: L10n.palmBasicMeaningsMoonMeaning)
                                }
                            }
                        }
                    }
                    
                    // Fingers Section
                    VStack(alignment: .leading, spacing: 24) {
                        SectionTitle(text: L10n.palmBasicMeaningsFingersTitle)
                        
                        ContentCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text(L10n.palmBasicMeaningsFingersIntro)
                                    .font(.system(size: 16, weight: .regular))
                                    .foregroundColor(AppTheme.textPrimary)
                                    .lineSpacing(6)
                                
                                VStack(alignment: .leading, spacing: 12) {
                                    FingerItem(name: L10n.palmBasicMeaningsThumbTitle, meaning: L10n.palmBasicMeaningsThumbMeaning)
                                    FingerItem(name: L10n.palmBasicMeaningsIndexTitle, meaning: L10n.palmBasicMeaningsIndexMeaning)
                                    FingerItem(name: L10n.palmBasicMeaningsMiddleTitle, meaning: L10n.palmBasicMeaningsMiddleMeaning)
                                    FingerItem(name: L10n.palmBasicMeaningsRingTitle, meaning: L10n.palmBasicMeaningsRingMeaning)
                                    FingerItem(name: L10n.palmBasicMeaningsPinkyTitle, meaning: L10n.palmBasicMeaningsPinkyMeaning)
                                }
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
}

struct PalmFeatureHeader: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(title)
                .font(AppTheme.serifFont(size: 20, weight: .semibold))
                .foregroundStyle(AppTheme.goldGradient)
        }
    }
}

struct MountItem: View {
    let planet: String
    let meaning: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundColor(AppTheme.gold)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(planet)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(meaning)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(4)
            }
        }
    }
}

struct FingerItem: View {
    let name: String
    let meaning: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "circle.fill")
                .font(.system(size: 6))
                .foregroundColor(AppTheme.gold)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(meaning)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PalmBasicMeaningsView()
    }
}
