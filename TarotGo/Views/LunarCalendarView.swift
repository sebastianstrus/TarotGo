//
//  LunarCalendarView.swift
//  TarotGo
//
//  Lunar calendar with moon phases
//

import SwiftUI

struct LunarCalendarView: View {
    @State private var selectedDate = Date()
    @State private var currentPhase: MoonPhase = .newMoon
    @State private var illumination: Double = 0
    @State private var moonSign: ZodiacSign = .aries
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "moon.circle.fill")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.lunarCalendarTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(selectedDate.formatted(date: .long, time: .omitted))
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                    }
                    .padding(.top, 20)
                    
                    // Current Moon Phase
                    VStack(spacing: 20) {
                        Text(currentPhase.symbol)
                            .font(.system(size: 100))
                        
                        Text(currentPhase.rawValue)
                            .font(AppTheme.serifFont(size: 28, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 4) {
                                Text("\(Int(illumination))%")
                                    .font(.system(size: 24, weight: .light))
                                    .foregroundStyle(AppTheme.goldGradient)
                                Text(L10n.lunarCalendarIlluminated)
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                            
                            Divider()
                                .frame(height: 40)
                                .background(AppTheme.gold.opacity(0.3))
                            
                            VStack(spacing: 4) {
                                HStack(spacing: 4) {
                                    Text(moonSign.symbol)
                                        .font(.system(size: 20))
                                    Text(moonSign.name)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundStyle(AppTheme.goldGradient)
                                }
                                Text(L10n.lunarCalendarMoonIn)
                                    .font(.system(size: 12, weight: .light))
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
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
                    
                    // Phase Energy & Meaning
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(AppTheme.gold)
                            Text(currentPhase.energy)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(AppTheme.goldGradient)
                        }
                        
                        Text(currentPhase.description)
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
                    
                    // Upcoming Phases
                    VStack(spacing: 16) {
                        Text(L10n.lunarCalendarUpcomingPhases)
                            .font(AppTheme.serifFont(size: 18, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                        
                        VStack(spacing: 12) {
                            ForEach(upcomingPhases(), id: \.date) { item in
                                HStack {
                                    Text(item.phase.symbol)
                                        .font(.system(size: 30))
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.phase.rawValue)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(AppTheme.gold)
                                        
                                        Text(item.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.system(size: 12, weight: .light))
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                    
                                    Spacer()
                                    
                                    if Calendar.current.isDateInToday(item.date) {
                                        Text(L10n.lunarCalendarToday)
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(AppTheme.gold)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(
                                                Capsule()
                                                    .fill(AppTheme.gold.opacity(0.2))
                                            )
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(AppTheme.darkNavy.opacity(0.4))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                                        )
                                )
                            }
                        }
                    }
                    
                    // Ritual Suggestions
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "moon.stars.fill")
                                .foregroundColor(AppTheme.gold)
                            Text(L10n.lunarCalendarRitualSuggestions)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(AppTheme.goldGradient)
                        }
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(ritualSuggestions(for: currentPhase), id: \.self) { suggestion in
                                HStack(alignment: .top, spacing: 10) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 8))
                                        .foregroundColor(AppTheme.gold)
                                        .padding(.top, 6)
                                    
                                    Text(suggestion)
                                        .font(.system(size: 14, weight: .light))
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(AppTheme.darkNavy.opacity(0.4))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                            )
                    )
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.lunarCalendarTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            updateMoonInfo()
        }
    }
    
    private func updateMoonInfo() {
        currentPhase = LunarService.shared.moonPhase(for: selectedDate)
        illumination = LunarService.shared.illuminationPercentage(for: selectedDate)
        moonSign = LunarService.shared.moonZodiacSign(for: selectedDate)
    }
    
    private func upcomingPhases() -> [(date: Date, phase: MoonPhase)] {
        LunarService.shared.upcomingPhases(from: selectedDate, count: 7)
            .filter { !Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
            .prefix(5)
            .map { $0 }
    }
    
    private func ritualSuggestions(for phase: MoonPhase) -> [String] {
        switch phase {
        case .newMoon:
            return [
                L10n.ritualNewMoon1,
                L10n.ritualNewMoon2,
                L10n.ritualNewMoon3,
                L10n.ritualNewMoon4
            ]
        case .waxingCrescent:
            return [
                L10n.ritualWaxingCrescent1,
                L10n.ritualWaxingCrescent2,
                L10n.ritualWaxingCrescent3,
                L10n.ritualWaxingCrescent4
            ]
        case .firstQuarter:
            return [
                L10n.ritualFirstQuarter1,
                L10n.ritualFirstQuarter2,
                L10n.ritualFirstQuarter3,
                L10n.ritualFirstQuarter4
            ]
        case .waxingGibbous:
            return [
                L10n.ritualWaxingGibbous1,
                L10n.ritualWaxingGibbous2,
                L10n.ritualWaxingGibbous3,
                L10n.ritualWaxingGibbous4
            ]
        case .fullMoon:
            return [
                L10n.ritualFullMoon1,
                L10n.ritualFullMoon2,
                L10n.ritualFullMoon3,
                L10n.ritualFullMoon4
            ]
        case .waningGibbous:
            return [
                L10n.ritualWaningGibbous1,
                L10n.ritualWaningGibbous2,
                L10n.ritualWaningGibbous3,
                L10n.ritualWaningGibbous4
            ]
        case .lastQuarter:
            return [
                L10n.ritualLastQuarter1,
                L10n.ritualLastQuarter2,
                L10n.ritualLastQuarter3,
                L10n.ritualLastQuarter4
            ]
        case .waningCrescent:
            return [
                L10n.ritualWaningCrescent1,
                L10n.ritualWaningCrescent2,
                L10n.ritualWaningCrescent3,
                L10n.ritualWaningCrescent4
            ]
        }
    }
}

#Preview {
    NavigationStack {
        LunarCalendarView()
    }
}
