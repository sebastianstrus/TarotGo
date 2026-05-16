//
//  HoroscopeView.swift
//  TarotGo
//
//  Daily horoscope readings for zodiac signs
//

import SwiftUI

struct HoroscopeView: View {
    @State private var showBirthDateInput: Bool = false
    @State private var selectedSign: ZodiacSign?
    @State private var showSignPicker: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "sparkle.magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        
                        Text(L10n.horoscopeTitle)
                            .font(AppTheme.serifFont(size: 32, weight: .light))
                            .foregroundStyle(AppTheme.goldGradient)
                            .multilineTextAlignment(.center)
                        
                        Text(Date().formatted(date: .long, time: .omitted))
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(AppTheme.gold.opacity(0.8))
                    }
                    .padding(.top, 20)
                    
                    if let sign = selectedSign {
                        horoscopeContent(for: sign)
                    } else {
                        signSelectionPrompt
                    }
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(L10n.horoscopeTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if selectedSign != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSignPicker = true
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundStyle(AppTheme.goldGradient)
                    }
                }
            }
        }
        .sheet(isPresented: $showBirthDateInput) {
            BirthDateInputView(isPresented: $showBirthDateInput) { date in
                selectedSign = AstrologyService.shared.zodiacSign(from: date)
            }
        }
        .sheet(isPresented: $showSignPicker) {
            SignPickerView(selectedSign: $selectedSign, isPresented: $showSignPicker)
        }
        .onAppear {
            if let birthDate = AstrologyService.shared.userBirthDate {
                selectedSign = AstrologyService.shared.zodiacSign(from: birthDate)
            }
        }
    }
    
    private var signSelectionPrompt: some View {
        VStack(spacing: 24) {
            Image(systemName: "star.circle")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.gold.opacity(0.6))
            
            Text("Select Your Zodiac Sign")
                .font(AppTheme.serifFont(size: 24, weight: .light))
                .foregroundStyle(AppTheme.goldGradient)
            
            VStack(spacing: 16) {
                Button {
                    if AstrologyService.shared.hasBirthDate {
                        selectedSign = AstrologyService.shared.zodiacSign(from: AstrologyService.shared.userBirthDate!)
                    } else {
                        showBirthDateInput = true
                    }
                } label: {
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                        Text("Use My Birth Date")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.goldGradient)
                    .cornerRadius(12)
                }
                
                Button {
                    showSignPicker = true
                } label: {
                    HStack {
                        Image(systemName: "list.bullet.circle")
                        Text("Choose Manually")
                    }
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppTheme.gold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                    )
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.top, 60)
    }
    
    private func horoscopeContent(for sign: ZodiacSign) -> some View {
        VStack(spacing: 24) {
            // Sign Header
            VStack(spacing: 12) {
                Text(sign.symbol)
                    .font(.system(size: 60))
                
                Text(sign.name)
                    .font(AppTheme.serifFont(size: 28, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text(signDateRange(for: sign))
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
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
            
            // Today's Reading
            horoscopeCard(
                title: "Today's Overview",
                icon: "sun.max.fill",
                content: dailyReading(for: sign)
            )
            
            // Love & Relationships
            horoscopeCard(
                title: "Love & Relationships",
                icon: "heart.fill",
                content: loveReading(for: sign)
            )
            
            // Career & Finance
            horoscopeCard(
                title: "Career & Finance",
                icon: "briefcase.fill",
                content: careerReading(for: sign)
            )
            
            // Lucky Elements
            VStack(spacing: 16) {
                Text("Today's Lucky Elements")
                    .font(AppTheme.serifFont(size: 18, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                HStack(spacing: 20) {
                    luckyElement(icon: "paintpalette.fill", label: "Color", value: luckyColor(for: sign))
                    luckyElement(icon: "number.circle.fill", label: "Number", value: "\(luckyNumber(for: sign))")
                    luckyElement(icon: "clock.fill", label: "Time", value: luckyTime(for: sign))
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(AppTheme.darkNavy.opacity(0.4))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
    
    private func horoscopeCard(title: String, icon: String, content: String) -> some View {
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
    
    private func luckyElement(icon: String, label: String, value: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(AppTheme.gold)
            Text(label)
                .font(.system(size: 11, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppTheme.gold)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Horoscope Content Generation
    
    private func dailyReading(for sign: ZodiacSign) -> String {
        let seed = getDailySeed(for: sign)
        let readings = getDailyReadings(for: sign)
        return readings[seed % readings.count]
    }
    
    private func loveReading(for sign: ZodiacSign) -> String {
        let seed = getDailySeed(for: sign) + 1
        let readings = getLoveReadings(for: sign)
        return readings[seed % readings.count]
    }
    
    private func careerReading(for sign: ZodiacSign) -> String {
        let seed = getDailySeed(for: sign) + 2
        let readings = getCareerReadings(for: sign)
        return readings[seed % readings.count]
    }
    
    private func getDailySeed(for sign: ZodiacSign) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        return (components.year ?? 0) * 372 + (components.month ?? 0) * 31 + (components.day ?? 0) + sign.rawValue
    }
    
    private func luckyColor(for sign: ZodiacSign) -> String {
        let colors = ["Gold", "Silver", "Blue", "Green", "Red", "Purple", "Orange"]
        return colors[getDailySeed(for: sign) % colors.count]
    }
    
    private func luckyNumber(for sign: ZodiacSign) -> Int {
        return (getDailySeed(for: sign) % 9) + 1
    }
    
    private func luckyTime(for sign: ZodiacSign) -> String {
        let times = ["Morning", "Noon", "Afternoon", "Evening", "Night"]
        return times[getDailySeed(for: sign) % times.count]
    }
    
    private func signDateRange(for sign: ZodiacSign) -> String {
        switch sign {
        case .aries: return "Mar 21 - Apr 19"
        case .taurus: return "Apr 20 - May 20"
        case .gemini: return "May 21 - Jun 20"
        case .cancer: return "Jun 21 - Jul 22"
        case .leo: return "Jul 23 - Aug 22"
        case .virgo: return "Aug 23 - Sep 22"
        case .libra: return "Sep 23 - Oct 22"
        case .scorpio: return "Oct 23 - Nov 21"
        case .sagittarius: return "Nov 22 - Dec 21"
        case .capricorn: return "Dec 22 - Jan 19"
        case .aquarius: return "Jan 20 - Feb 18"
        case .pisces: return "Feb 19 - Mar 20"
        }
    }
    
    // Daily reading variations for each sign
    private func getDailyReadings(for sign: ZodiacSign) -> [String] {
        return [
            "Today brings fresh opportunities for growth. Trust your instincts and embrace new experiences with an open heart.",
            "The cosmic energy today favors reflection and planning. Take time to consider your next steps carefully.",
            "Your natural strengths shine brightly today. Don't hesitate to showcase your talents and unique perspective.",
            "A day of unexpected connections and meaningful conversations. Stay open to wisdom from unlikely sources.",
            "Today's energy supports transformation. Let go of what no longer serves you and welcome positive change."
        ]
    }
    
    private func getLoveReadings(for sign: ZodiacSign) -> [String] {
        return [
            "Communication flows easily in your relationships today. Express your feelings with honesty and compassion.",
            "A romantic opportunity may present itself unexpectedly. Stay present and authentic in your interactions.",
            "Focus on deepening existing bonds rather than seeking new connections. Quality over quantity brings fulfillment.",
            "Your emotional intuition is heightened. Trust your heart's wisdom in matters of love and connection.",
            "Independence and partnership find beautiful balance today. Honor both your needs and those of loved ones."
        ]
    }
    
    private func getCareerReadings(for sign: ZodiacSign) -> [String] {
        return [
            "Professional recognition is on the horizon. Your hard work and dedication are being noticed by those who matter.",
            "Collaboration brings success today. Seek input from colleagues and build on collective wisdom.",
            "Financial decisions require careful consideration. Trust your analytical mind and avoid impulsive choices.",
            "Your creative solutions impress others. Don't be afraid to think outside the box and propose innovative ideas.",
            "A good day for planning long-term goals. Set clear intentions and take practical steps toward your aspirations."
        ]
    }
}

// MARK: - Sign Picker Sheet

struct SignPickerView: View {
    @Binding var selectedSign: ZodiacSign?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .background(AnimatedBackgroundView().ignoresSafeArea())
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(ZodiacSign.allCases, id: \.self) { sign in
                            Button {
                                selectedSign = sign
                                isPresented = false
                                HapticService.shared.impact(.light)
                                SoundService.shared.play(.click)
                            } label: {
                                VStack(spacing: 12) {
                                    Text(sign.symbol)
                                        .font(.system(size: 40))
                                    
                                    Text(sign.name)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(AppTheme.gold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(AppTheme.darkNavy.opacity(0.6))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    selectedSign == sign ? AppTheme.gold : AppTheme.gold.opacity(0.2),
                                                    lineWidth: selectedSign == sign ? 2 : 1
                                                )
                                        )
                                )
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Select Your Sign")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundStyle(AppTheme.goldGradient)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HoroscopeView()
    }
}
