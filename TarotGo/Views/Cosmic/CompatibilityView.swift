//
//  CompatibilityView.swift
//  TarotGo
//
//  Zodiac compatibility checker
//

import SwiftUI

struct CompatibilityView: View {
    @State private var yourSign: ZodiacSign?
    @State private var partnerSign: ZodiacSign?
    @State private var showYourSignPicker = false
    @State private var showPartnerSignPicker = false
    @State private var showBirthDateInput = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image("ic_cosmic_compatibility")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.compatibilityTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(L10n.compatibilitySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Sign Selection
                    HStack(spacing: 20) {
                        signButton(
                            title: L10n.compatibilityYourSign,
                            sign: yourSign,
                            action: {
                                if AstrologyService.shared.hasBirthDate {
                                    yourSign = AstrologyService.shared.zodiacSign(from: AstrologyService.shared.userBirthDate!)
                                } else {
                                    showYourSignPicker = true
                                }
                            }
                        )
                        
                        Image(systemName: "heart.fill")
                            .font(.system(size: 24))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        signButton(
                            title: L10n.compatibilityPartnerSign,
                            sign: partnerSign,
                            action: { showPartnerSignPicker = true }
                        )
                    }
                    
                    if let yourSign = yourSign, let partnerSign = partnerSign {
                        compatibilityContent(your: yourSign, partner: partnerSign)
                    } else {
                        selectionPrompt
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.compatibilityTitle)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showYourSignPicker) {
            SignPickerView(selectedSign: $yourSign, isPresented: $showYourSignPicker)
        }
        .sheet(isPresented: $showPartnerSignPicker) {
            SignPickerView(selectedSign: $partnerSign, isPresented: $showPartnerSignPicker)
        }
        .sheet(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                yourSign = AstrologyService.shared.zodiacSign(from: date)
            }
        }
        .onAppear {
            if let birthDate = AstrologyService.shared.userBirthDate {
                yourSign = AstrologyService.shared.zodiacSign(from: birthDate)
            }
        }
    }
    
    private func signButton(title: String, sign: ZodiacSign?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 12) {
                if let sign = sign {
                    Text(sign.symbol)
                        .font(.system(size: 50))
                    
                    Text(sign.name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppTheme.gold)
                } else {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(AppTheme.gold.opacity(0.6))
                    
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
            )
        }
    }
    
    private var selectionPrompt: some View {
        VStack(spacing: 16) {
            Image(systemName: "arrow.up.circle")
                .font(.system(size: 40))
                .foregroundColor(AppTheme.gold.opacity(0.6))
            
            Text(L10n.compatibilitySelectPrompt)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 40)
    }
    
    private func compatibilityContent(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> some View {
        let score = compatibilityScore(your: yourSign, partner: partnerSign)
        
        return VStack(spacing: 24) {
            // Compatibility Score
            VStack(spacing: 16) {
                Text(L10n.compatibilityScore)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                ZStack {
                    Circle()
                        .stroke(AppTheme.darkNavy.opacity(0.3), lineWidth: 15)
                        .frame(width: 120, height: 120)
                    
                    Circle()
                        .trim(from: 0, to: score / 100)
                        .stroke(AppTheme.goldGradient, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(score))%")
                        .font(.system(size: 36, weight: .thin))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Text(compatibilityRating(score))
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppTheme.gold)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Element Compatibility
            elementCompatibility(your: yourSign, partner: partnerSign)
            
            // Detailed Analysis
            analysisCard(
                title: L10n.compatibilityOverall,
                icon: "heart.fill",
                content: overallCompatibility(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: L10n.compatibilityStrengths,
                icon: "star.fill",
                content: strengths(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: L10n.compatibilityChallenges,
                icon: "exclamationmark.triangle.fill",
                content: challenges(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: L10n.compatibilityAdvice,
                icon: "lightbulb.fill",
                content: advice(your: yourSign, partner: partnerSign)
            )
        }
    }
    
    private func analysisCard(title: String, icon: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(AppTheme.gold)
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }
            
            Text(content)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .lineSpacing(6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private func elementCompatibility(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> some View {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        return VStack(spacing: 12) {
            Text(L10n.compatibilityElementalMatch)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            HStack(spacing: 20) {
                elementBadge(yourElement)
                Image(systemName: "arrow.left.arrow.right")
                    .foregroundColor(AppTheme.gold)
                elementBadge(partnerElement)
            }
            
            Text(elementDescription(your: yourElement, partner: partnerElement))
                .font(.system(size: 13, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(AppTheme.darkNavy.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                )
        )
    }
    
    private func elementBadge(_ element: String) -> some View {
        VStack(spacing: 6) {
            Text(elementSymbol(element))
                .font(.system(size: 24))
            Text(element)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppTheme.gold)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(AppTheme.darkNavy.opacity(0.6))
        )
    }
    
    // MARK: - Compatibility Logic
    
    private func element(for sign: ZodiacSign) -> String {
        switch sign {
        case .aries, .leo, .sagittarius: return L10n.compatibilityElementFire
        case .taurus, .virgo, .capricorn: return L10n.compatibilityElementEarth
        case .gemini, .libra, .aquarius: return L10n.compatibilityElementAir
        case .cancer, .scorpio, .pisces: return L10n.compatibilityElementWater
        }
    }
    
    private func elementSymbol(_ element: String) -> String {
        switch element {
        case "Fire": return "🔥"
        case "Earth": return "🌍"
        case "Air": return "💨"
        case "Water": return "💧"
        default: return "✨"
        }
    }
    
    private func compatibilityScore(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> Double {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        // Same element: 80-90%
        if yourElement == partnerElement {
            return Double.random(in: 80...90)
        }
        
        // Compatible elements: 70-85%
        let compatible = [
            ("Fire", "Air"), ("Air", "Fire"),
            ("Earth", "Water"), ("Water", "Earth")
        ]
        
        if compatible.contains(where: { $0 == (yourElement, partnerElement) }) {
            return Double.random(in: 70...85)
        }
        
        // Challenging elements: 50-70%
        return Double.random(in: 50...70)
    }
    
    private func compatibilityRating(_ score: Double) -> String {
        switch score {
        case 90...100: return L10n.compatibilityRatingExcellent
        case 80..<90: return L10n.compatibilityRatingVeryCompatible
        case 70..<80: return L10n.compatibilityRatingGood
        case 60..<70: return L10n.compatibilityRatingModerate
        default: return L10n.compatibilityRatingChallenging
        }
    }
    
    private func elementDescription(your yourElement: String, partner partnerElement: String) -> String {
        if yourElement == partnerElement {
            return L10n.compatibilityElementDescSame
        }
        
        // Check compatible pairings
        if (yourElement == L10n.compatibilityElementFire && partnerElement == L10n.compatibilityElementAir) || (yourElement == L10n.compatibilityElementAir && partnerElement == L10n.compatibilityElementFire) {
            return L10n.compatibilityElementDescFireAir
        } else if (yourElement == L10n.compatibilityElementEarth && partnerElement == L10n.compatibilityElementWater) || (yourElement == L10n.compatibilityElementWater && partnerElement == L10n.compatibilityElementEarth) {
            return L10n.compatibilityElementDescEarthWater
        }
        
        return L10n.compatibilityElementDescDifferent
    }
    
    private func overallCompatibility(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        return String(format: L10n.compatibilityOverallText, yourSign.name, partnerSign.name)
    }
    
    private func strengths(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        if yourElement == partnerElement {
            return L10n.compatibilityStrengthsSameElement
        } else if [L10n.compatibilityElementFire, L10n.compatibilityElementAir].contains(yourElement) && [L10n.compatibilityElementFire, L10n.compatibilityElementAir].contains(partnerElement) {
            return L10n.compatibilityStrengthsFireAir
        } else if [L10n.compatibilityElementEarth, L10n.compatibilityElementWater].contains(yourElement) && [L10n.compatibilityElementEarth, L10n.compatibilityElementWater].contains(partnerElement) {
            return L10n.compatibilityStrengthsEarthWater
        } else {
            return L10n.compatibilityStrengthsDifferent
        }
    }
    
    private func challenges(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        if yourElement == partnerElement {
            return L10n.compatibilityChallengesSameElement
        } else {
            return L10n.compatibilityChallengesDifferent
        }
    }
    
    private func advice(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        return L10n.compatibilityAdviceText
    }
}

#Preview {
    NavigationStack {
        CompatibilityView()
    }
}
