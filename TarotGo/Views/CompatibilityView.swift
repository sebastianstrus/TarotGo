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
                        Image(systemName: "heart.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
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
                            title: "Your Sign",
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
                            title: "Partner's Sign",
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
            
            Text("Select both zodiac signs to see compatibility")
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
                Text("Compatibility Score")
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
                title: "Overall Compatibility",
                icon: "heart.fill",
                content: overallCompatibility(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: "Strengths",
                icon: "star.fill",
                content: strengths(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: "Challenges",
                icon: "exclamationmark.triangle.fill",
                content: challenges(your: yourSign, partner: partnerSign)
            )
            
            analysisCard(
                title: "Advice",
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
            Text("Elemental Match")
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
        case .aries, .leo, .sagittarius: return "Fire"
        case .taurus, .virgo, .capricorn: return "Earth"
        case .gemini, .libra, .aquarius: return "Air"
        case .cancer, .scorpio, .pisces: return "Water"
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
        case 90...100: return "Excellent Match"
        case 80..<90: return "Very Compatible"
        case 70..<80: return "Good Match"
        case 60..<70: return "Moderate Compatibility"
        default: return "Challenging but Possible"
        }
    }
    
    private func elementDescription(your yourElement: String, partner partnerElement: String) -> String {
        if yourElement == partnerElement {
            return "Same element - natural understanding and shared values"
        }
        
        // Check compatible pairings
        if (yourElement == "Fire" && partnerElement == "Air") || (yourElement == "Air" && partnerElement == "Fire") {
            return "Fire and Air energize each other beautifully"
        } else if (yourElement == "Earth" && partnerElement == "Water") || (yourElement == "Water" && partnerElement == "Earth") {
            return "Earth and Water nurture and support one another"
        }
        
        return "Different elements bring unique dynamics"
    }
    
    private func overallCompatibility(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        return "This pairing brings together \(yourSign.name) and \(partnerSign.name), creating a dynamic relationship with unique strengths. While every relationship requires effort, understanding your astrological compatibility can help navigate challenges and celebrate your connection's natural flow."
    }
    
    private func strengths(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        if yourElement == partnerElement {
            return "Shared values and natural understanding create a strong foundation. You speak the same emotional language and intuitively grasp each other's needs and motivations."
        } else if ["Fire", "Air"].contains(yourElement) && ["Fire", "Air"].contains(partnerElement) {
            return "Your energies complement each other perfectly. Together you inspire growth, adventure, and intellectual stimulation. Communication flows easily and you motivate each other."
        } else if ["Earth", "Water"].contains(yourElement) && ["Earth", "Water"].contains(partnerElement) {
            return "You provide each other with security and emotional depth. This pairing excels at creating a nurturing, stable environment where both partners feel safe to be vulnerable."
        } else {
            return "Your differences create opportunities for growth and learning. Each partner brings unique perspectives that help broaden the other's worldview and capabilities."
        }
    }
    
    private func challenges(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        let yourElement = element(for: yourSign)
        let partnerElement = element(for: partnerSign)
        
        if yourElement == partnerElement {
            return "Too much similarity can lead to blind spots. Make sure to maintain individual identities and seek outside perspectives when needed."
        } else {
            return "Different elemental energies may require conscious effort to understand each other's needs and communication styles. Patience and open dialogue are essential."
        }
    }
    
    private func advice(your yourSign: ZodiacSign, partner partnerSign: ZodiacSign) -> String {
        return "Focus on appreciation rather than judgment. What seems like a difference can be a complementary strength. Practice active listening, celebrate your unique connection, and remember that all relationships thrive on mutual respect and effort."
    }
}

#Preview {
    NavigationStack {
        CompatibilityView()
    }
}
