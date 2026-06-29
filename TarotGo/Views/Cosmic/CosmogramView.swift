//
//  CosmogramView.swift
//  TarotGo
//
//  Birth chart / cosmogram visualization
//

import SwiftUI

struct CosmogramView: View {
    @State private var showBirthDateInput = false
    @State private var birthDate: Date?
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image("ic_cosmic_cosmogram")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.cosmogramTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(L10n.cosmogramSubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    if let birthDate = birthDate {
                        cosmogramContent(for: birthDate)
                    } else {
                        birthDatePrompt
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.cosmogramTitle)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                birthDate = date
            }
        }
        .onAppear {
            birthDate = AstrologyService.shared.userBirthDate
            if birthDate == nil {
                showBirthDateInput = true
            }
        }
    }
    
    private var birthDatePrompt: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.gold.opacity(0.6))
            
            Text(L10n.enterYourBirthDateCosmogram)
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(L10n.generateBirthChartPrompt)
                .font(.system(size: 15))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
            
            Button {
                showBirthDateInput = true
            } label: {
                Text(L10n.addBirthDateButton)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.goldGradient)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 60)
    }
    
    private func cosmogramContent(for date: Date) -> some View {
        let sunSign = AstrologyService.shared.zodiacSign(from: date)
        let moonSign = LunarService.shared.moonZodiacSign(for: date)
        let risingSign = calculateRisingSign(from: date)
        
        return VStack(spacing: 30) {
            // Birth Chart Wheel
            chartWheel(sun: sunSign, moon: moonSign, rising: risingSign)
            
            // Big Three
            VStack(spacing: 16) {
                Text(L10n.bigThreeTitle)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                bigThreeCard(
                    title: L10n.sunSignTitle,
                    sign: sunSign,
                    description: L10n.sunSignDescription,
                    detail: sunSignDescription(sunSign)
                )
                
                bigThreeCard(
                    title: L10n.moonSignTitle,
                    sign: moonSign,
                    description: L10n.moonSignDescription,
                    detail: moonSignDescription(moonSign)
                )
                
                bigThreeCard(
                    title: L10n.risingSignTitle,
                    sign: risingSign,
                    description: L10n.risingSignDescription,
                    detail: risingSignDescription(risingSign)
                )
            }
            
            // Elements & Modalities
            elementModality(sun: sunSign, moon: moonSign, rising: risingSign)
            
            // Life Purpose
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(AppTheme.gold)
                    Text(L10n.yourCosmicBlueprint)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Text(L10n.yourChartReveals(sunSign.name, moonSign.name, risingSign.name))
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
    }
    
    private func chartWheel(sun: ZodiacSign, moon: ZodiacSign, rising: ZodiacSign) -> some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, 300)
            
            ZStack {
                // Outer circle
                Circle()
                    .stroke(AppTheme.gold.opacity(0.3), lineWidth: 2)
                    .frame(width: size, height: size)
                
                // Inner circles
                Circle()
                    .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                    .frame(width: size * 0.75, height: size * 0.75)
                
                Circle()
                    .stroke(AppTheme.gold.opacity(0.1), lineWidth: 1)
                    .frame(width: size * 0.5, height: size * 0.5)
                
                // Zodiac positions
                ForEach(Array(ZodiacSign.allCases.enumerated()), id: \.offset) { index, sign in
                    let angle = Double(index) * 30.0 - 90.0
                    let radius = size / 2
                    
                    Text(sign.symbol)
                        .font(.system(size: 20))
                        .foregroundColor(
                            sign == sun || sign == moon || sign == rising ?
                            AppTheme.gold : AppTheme.gold.opacity(0.4)
                        )
                        .position(
                            x: size/2 + cos(angle * .pi / 180) * (radius - 25),
                            y: size/2 + sin(angle * .pi / 180) * (radius - 25)
                        )
                }
                
                // Center - Sun
                VStack(spacing: 4) {
                    Text("☉")
                        .font(.system(size: 40))
                    Text(sun.name)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(AppTheme.gold)
                }
            }
            .frame(width: size, height: size)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 320)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    private func bigThreeCard(title: String, sign: ZodiacSign, description: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(sign.symbol)
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary)
                    
                    Text(sign.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Spacer()
            }
            
            Text(description)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppTheme.gold.opacity(0.8))
            
            Text(detail)
                .font(.system(size: 14, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .lineSpacing(4)
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
    
    private func elementModality(sun: ZodiacSign, moon: ZodiacSign, rising: ZodiacSign) -> some View {
        let sunElement = element(for: sun)
        let moonElement = element(for: moon)
        let risingElement = element(for: rising)
        
        return VStack(spacing: 16) {
            Text(L10n.elementalBalanceTitle)
                .font(AppTheme.serifFont(size: 18, weight: .medium))
                .foregroundStyle(AppTheme.goldGradient)
            
            HStack(spacing: 12) {
                elementPill(sunElement)
                elementPill(moonElement)
                elementPill(risingElement)
            }
            
            Text(elementBalanceDescription(sun: sunElement, moon: moonElement, rising: risingElement))
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
    
    private func elementPill(_ element: String) -> some View {
        HStack(spacing: 6) {
            Text(elementSymbol(element))
                .font(.system(size: 14))
            Text(element)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppTheme.gold)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(AppTheme.darkNavy.opacity(0.6))
                .overlay(
                    Capsule()
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
    
    // MARK: - Calculations
    
    private func calculateRisingSign(from date: Date) -> ZodiacSign {
        // Simplified: use hour of birth (approximation)
        let hour = Calendar.current.component(.hour, from: date)
        let signIndex = (hour / 2) % 12
        return ZodiacSign.allCases[signIndex]
    }
    
    private func element(for sign: ZodiacSign) -> String {
        switch sign {
        case .aries, .leo, .sagittarius: return L10n.elementFire
        case .taurus, .virgo, .capricorn: return L10n.elementEarth
        case .gemini, .libra, .aquarius: return L10n.elementAir
        case .cancer, .scorpio, .pisces: return L10n.elementWater
        }
    }
    
    private func elementSymbol(_ element: String) -> String {
        switch element {
        case L10n.elementFire: return "🔥"
        case L10n.elementEarth: return "🌍"
        case L10n.elementAir: return "💨"
        case L10n.elementWater: return "💧"
        default: return "✨"
        }
    }
    
    private func sunSignDescription(_ sign: ZodiacSign) -> String {
        return L10n.sunSignDetail(sign.name)
    }
    
    private func moonSignDescription(_ sign: ZodiacSign) -> String {
        return L10n.moonSignDetail(sign.name)
    }
    
    private func risingSignDescription(_ sign: ZodiacSign) -> String {
        return L10n.risingSignDetail(sign.name)
    }
    
    private func elementBalanceDescription(sun: String, moon: String, rising: String) -> String {
        let elements = [sun, moon, rising]
        let uniqueElements = Set(elements)
        
        if uniqueElements.count == 1 {
            return L10n.elementBalanceSame(sun)
        } else if uniqueElements.count == 2 {
            return L10n.elementBalanceTwoElements
        } else {
            return L10n.elementBalanceThreeElements
        }
    }
}

#Preview {
    NavigationStack {
        CosmogramView()
    }
}
