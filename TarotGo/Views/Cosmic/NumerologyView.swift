//
//  NumerologyView.swift
//  TarotGo
//
//  Numerology feature - life path numbers and meanings
//

import SwiftUI

struct NumerologyView: View {
    @State private var showBirthDateInput: Bool = false
    @State private var birthDate: Date?
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image("ic_cosmic_numerology")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 64, height: 64)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.numerologyTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(L10n.numerologySubtitle)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    if let birthDate = birthDate {
                        numerologyContent(for: birthDate)
                    } else {
                        birthDatePrompt
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.numerologyTitle)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showBirthDateInput) {
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
            
            Text(L10n.enterYourBirthDate)
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(L10n.discoverNumerologyProfile)
                .font(.system(size: 15))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
            
            Button {
                showBirthDateInput = true
            } label: {
                Text(L10n.addBirthDate)
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
    
    private func numerologyContent(for date: Date) -> some View {
        let lifePathNumber = AstrologyService.shared.lifePathNumber(from: date)
        let zodiacSign = AstrologyService.shared.zodiacSign(from: date)
        
        return VStack(spacing: 24) {
            // Life Path Number Card
            VStack(spacing: 16) {
                Text(L10n.yourLifePathNumber)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text("\(lifePathNumber)")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(lifePathMeaning(for: lifePathNumber))
                    .font(.system(size: 15, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(6)
                    .padding(.horizontal)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                    )
            )
            
            // Personal Numbers Grid
            VStack(spacing: 16) {
                Text(L10n.yourPersonalNumbers)
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    personalNumberCard(
                        title: L10n.expression,
                        number: expressionNumber(from: date),
                        description: L10n.yourNaturalTalents
                    )
                    
                    personalNumberCard(
                        title: L10n.soulUrge,
                        number: soulUrgeNumber(from: date),
                        description: L10n.yourInnerDesires
                    )
                    
                    personalNumberCard(
                        title: L10n.birthday,
                        number: birthdayNumber(from: date),
                        description: L10n.yourSpecialGift
                    )
                    
                    personalNumberCard(
                        title: L10n.maturity,
                        number: maturityNumber(from: date, lifePath: lifePathNumber),
                        description: L10n.yourLaterLifeFocus
                    )
                }
            }
            
            // Zodiac Connection
            VStack(spacing: 12) {
                HStack {
                    Text(zodiacSign.symbol)
                        .font(.system(size: 30))
                    Text(zodiacSign.name)
                        .font(AppTheme.serifFont(size: 20, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                }
                
                Text(L10n.yourNumerologyComplements(zodiacSign.name))
                    .font(.system(size: 14, weight: .light))
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
    }
    
    private func personalNumberCard(title: String, number: Int, description: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppTheme.gold)
            
            Text("\(number)")
                .font(.system(size: 36, weight: .thin))
                .foregroundStyle(AppTheme.goldGradient)
            
            Text(description)
                .font(.system(size: 11, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
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
    
    // MARK: - Numerology Calculations
    
    private func lifePathMeaning(for number: Int) -> String {
        switch number {
        case 1:
            return L10n.lifePathMeaning1
        case 2:
            return L10n.lifePathMeaning2
        case 3:
            return L10n.lifePathMeaning3
        case 4:
            return L10n.lifePathMeaning4
        case 5:
            return L10n.lifePathMeaning5
        case 6:
            return L10n.lifePathMeaning6
        case 7:
            return L10n.lifePathMeaning7
        case 8:
            return L10n.lifePathMeaning8
        case 9:
            return L10n.lifePathMeaning9
        case 11:
            return L10n.lifePathMeaning11
        case 22:
            return L10n.lifePathMeaning22
        default:
            return L10n.lifePathMeaningDefault
        }
    }
    
    private func expressionNumber(from date: Date) -> Int {
        // Simplified: use month + day
        let components = Calendar.current.dateComponents([.month, .day], from: date)
        let sum = (components.month ?? 0) + (components.day ?? 0)
        return reduceToSingleDigit(sum)
    }
    
    private func soulUrgeNumber(from date: Date) -> Int {
        // Simplified: use day component
        let components = Calendar.current.dateComponents([.day], from: date)
        return reduceToSingleDigit(components.day ?? 1)
    }
    
    private func birthdayNumber(from date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: date)
        return reduceToSingleDigit(components.day ?? 1)
    }
    
    private func maturityNumber(from date: Date, lifePath: Int) -> Int {
        let components = Calendar.current.dateComponents([.year], from: date)
        let yearSum = reduceToSingleDigit(components.year ?? 2000)
        return reduceToSingleDigit(lifePath + yearSum)
    }
    
    private func reduceToSingleDigit(_ number: Int) -> Int {
        var result = number
        while result > 9 && result != 11 && result != 22 {
            result = sumDigits(result)
        }
        return result
    }
    
    private func sumDigits(_ number: Int) -> Int {
        var num = abs(number)
        var sum = 0
        while num > 0 {
            sum += num % 10
            num /= 10
        }
        return sum
    }
}

#Preview {
    NavigationStack {
        NumerologyView()
    }
}
