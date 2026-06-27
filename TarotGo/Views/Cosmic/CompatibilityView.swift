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
    @State private var currentScore: Double = 0
    @State private var sharePDFURL: URL?

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
        .sheet(isPresented: .constant(sharePDFURL != nil), onDismiss: {
            sharePDFURL = nil
        }) {
            if let pdfURL = sharePDFURL {
                ShareSheet(items: [pdfURL])
            }
        }
        .onAppear {
            if let birthDate = AstrologyService.shared.userBirthDate {
                yourSign = AstrologyService.shared.zodiacSign(from: birthDate)
            }
            recomputeScoreIfNeeded()
        }
        .onChange(of: yourSign) { _, _ in recomputeScoreIfNeeded() }
        .onChange(of: partnerSign) { _, _ in recomputeScoreIfNeeded() }
    }

    private func recomputeScoreIfNeeded() {
        guard let your = yourSign, let partner = partnerSign else { return }
        currentScore = compatibilityScore(your: your, partner: partner)
    }

    private func sharePDF(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) {
        HapticService.shared.impact(.light)
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        sharePDFURL = PDFGenerationService.shared.generateCompatibilityPDF(
            yourSign: yourSign,
            partnerSign: partnerSign,
            score: currentScore,
            rating: compatibilityRating(currentScore),
            yourElement: yourElement,
            partnerElement: partnerElement,
            elementDescription: elementDescription(your: yourElement, partner: partnerElement),
            overall: overallCompatibility(your: yourSign, partner: partnerSign),
            strengths: strengths(your: yourSign, partner: partnerSign),
            challenges: challenges(your: yourSign, partner: partnerSign),
            advice: advice(your: yourSign, partner: partnerSign),
            date: Date(),
            mercury: mercuryPDFContext(your: yourSign, partner: partnerSign)
        )
    }

    private func mercuryPDFContext(
        your yourSign: ZodiacSign,
        partner partnerSign: ZodiacSign
    ) -> PDFGenerationService.MercuryRetrogradePDFContext? {
        let service = MercuryRetrogradeService.shared
        let now = Date()
        guard let period = service.activePeriod(for: now) else { return nil }
        let phase = period.phase(for: now)
        return PDFGenerationService.MercuryRetrogradePDFContext(
            phaseTitle: phase.title,
            signSymbol: period.zodiacSign.symbol,
            signName: period.zodiacSign.name,
            yourImpact: service.impactDescription(userSign: yourSign, retrogradeSign: period.zodiacSign),
            partnerImpact: service.impactDescription(userSign: partnerSign, retrogradeSign: period.zodiacSign),
            coupleGuidance: service.coupleGuidance(your: yourSign, partner: partnerSign)
        )
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
        let score = currentScore

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

            // Mercury Retrograde × Couple (only during active shadow/retrograde window)
            mercuryRetrogradeCard(your: yourSign, partner: partnerSign)

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

            // Share PDF button
            Button {
                sharePDF(your: yourSign, partner: partnerSign)
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 16))
                    Text(L10n.sharePDF)
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(AppTheme.deepNavy)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(AppTheme.goldGradient)
                .cornerRadius(12)
                .shadow(color: AppTheme.gold.opacity(0.4), radius: 8)
            }
            .padding(.top, 8)
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
        let (a, b) = yourSign.rawValue <= partnerSign.rawValue ? (yourSign, partnerSign) : (partnerSign, yourSign)
        let key = "compatibility.overall.\(a.key).\(b.key)"
        return NSLocalizedString(key, comment: "Overall compatibility for sign pair")
    }
    
    private func strengths(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let (a, b) = yourSign.rawValue <= partnerSign.rawValue ? (yourSign, partnerSign) : (partnerSign, yourSign)
        let key = "compatibility.strengths.\(a.key).\(b.key)"
        return NSLocalizedString(key, comment: "Strengths for sign pair")
    }

    private func challenges(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let (a, b) = yourSign.rawValue <= partnerSign.rawValue ? (yourSign, partnerSign) : (partnerSign, yourSign)
        let key = "compatibility.challenges.\(a.key).\(b.key)"
        return NSLocalizedString(key, comment: "Challenges for sign pair")
    }

    private func advice(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let (a, b) = yourSign.rawValue <= partnerSign.rawValue ? (yourSign, partnerSign) : (partnerSign, yourSign)
        let key = "compatibility.advice.\(a.key).\(b.key)"
        return NSLocalizedString(key, comment: "Advice for sign pair")
    }

    // MARK: - Mercury Retrograde × Couple

    @ViewBuilder
    private func mercuryRetrogradeCard(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> some View {
        let service = MercuryRetrogradeService.shared
        let now = Date()
        if let period = service.activePeriod(for: now) {
            let phase = period.phase(for: now)
            let yourImpact = service.impactDescription(userSign: yourSign, retrogradeSign: period.zodiacSign)
            let partnerImpact = service.impactDescription(userSign: partnerSign, retrogradeSign: period.zodiacSign)
            let coupleGuidance = service.coupleGuidance(your: yourSign, partner: partnerSign)

            VStack(alignment: .leading, spacing: 14) {
                // Header
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "arrow.triangle.2.circlepath")
                        .foregroundStyle(AppTheme.goldGradient)
                        .font(.system(size: 18))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(L10n.mercuryCoupleTitle)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppTheme.goldGradient)
                        Text(L10n.mercuryCoupleSubtitle)
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }

                // Phase badge with Mercury sign
                HStack(spacing: 8) {
                    Image(systemName: phase.iconName)
                        .font(.system(size: 12))
                        .foregroundColor(AppTheme.gold)
                    Text(phase.title)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(AppTheme.gold)
                    Spacer()
                    HStack(spacing: 4) {
                        Text(period.zodiacSign.symbol)
                            .font(.system(size: 14))
                        Text(period.zodiacSign.name)
                            .font(.system(size: 12, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(AppTheme.gold.opacity(0.12))
                        .overlay(Capsule().stroke(AppTheme.gold.opacity(0.35), lineWidth: 1))
                )

                // Side-by-side impact
                HStack(alignment: .top, spacing: 10) {
                    partnerImpactColumn(
                        label: L10n.mercuryCoupleImpactYou,
                        sign: yourSign,
                        impact: yourImpact
                    )
                    partnerImpactColumn(
                        label: L10n.mercuryCoupleImpactPartner,
                        sign: partnerSign,
                        impact: partnerImpact
                    )
                }
                .fixedSize(horizontal: false, vertical: true)

                // Couple guidance (pair-specific)
                Rectangle()
                    .fill(AppTheme.gold.opacity(0.2))
                    .frame(height: 1)
                    .padding(.vertical, 2)

                HStack(spacing: 8) {
                    Image(systemName: "heart.text.square.fill")
                        .foregroundColor(AppTheme.gold)
                    Text(L10n.mercuryCoupleAdvice)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                }

                Text(coupleGuidance)
                    .font(.system(size: 13, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                    )
            )
        }
    }

    private func partnerImpactColumn(label: String, sign: ZodiacSign, impact: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .tracking(1)
                .foregroundColor(AppTheme.gold.opacity(0.7))
                .frame(height: 28, alignment: .top)
                .textCase(.uppercase)
            
            HStack(spacing: 6) {
                Text(sign.symbol)
                    .font(.system(size: 22))
                Text(sign.name)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppTheme.gold)
            }
            
            Text(impact)
                .font(.system(size: 12, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(AppTheme.darkNavy.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        CompatibilityView()
    }
}
