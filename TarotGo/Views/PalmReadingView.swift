//
//  PalmReadingView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import SwiftUI

struct PalmReadingView: View {
    @StateObject private var viewModel = PalmReadingViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            switch viewModel.currentPhase {
            case .introduction:
                IntroductionView(viewModel: viewModel)
            case .cameraCapture:
                PalmCaptureView(viewModel: viewModel)
            case .analyzing:
                AnalyzingView()
            case .results:
                if let reading = viewModel.palmReading {
                    PalmResultView(reading: reading, viewModel: viewModel)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    HapticService.shared.impact(.light)
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(AppTheme.gold)
                }
            }
        }
        .alert("Error", isPresented: $viewModel.showError) {
            Button("Try Again", role: .cancel) {
                viewModel.takeNewPhoto()
            }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
    }
}

// MARK: - Introduction View

struct IntroductionView: View {
    @ObservedObject var viewModel: PalmReadingViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Spacer()
                    .frame(height: 40)
                
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                    
                    Text("Palm Reading")
                        .font(AppTheme.serifFont(size: 36, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text("Discover the secrets in your palm")
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                }
                .padding(.bottom, 20)
                
                // Info cards
                VStack(spacing: 16) {
                    InfoCard(
                        icon: "eye.fill",
                        title: "On-Device Analysis",
                        description: "Your palm image is processed locally and never leaves your device. Complete privacy guaranteed."
                    )
                    
                    InfoCard(
                        icon: "line.3.horizontal.decrease.circle.fill",
                        title: "Four Major Lines",
                        description: "We analyze your Heart, Head, Life, and Fate lines to reveal insights about your path."
                    )
                    
                    InfoCard(
                        icon: "sparkles",
                        title: "Ancient Wisdom",
                        description: "Palmistry has guided seekers for thousands of years. Let your palm tell its story."
                    )
                }
                .padding(.horizontal, 30)
                
                // Start button
                Button {
                    viewModel.startReading()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                        Text("Take Palm Photo")
                    }
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(AppTheme.goldGradient)
                    .cornerRadius(30)
                    .shadow(color: AppTheme.gold.opacity(0.4), radius: 15, x: 0, y: 8)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
                
                Spacer()
            }
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(AppTheme.goldGradient)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppTheme.textPrimary)
                
                Text(description)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

// MARK: - Analyzing View

struct AnalyzingView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "hand.raised.fill")
                .font(.system(size: 80))
                .foregroundStyle(AppTheme.goldGradient)
                .rotationEffect(.degrees(rotation))
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 20)
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        rotation = 360
                    }
                }
            
            VStack(spacing: 12) {
                Text("Reading Your Palm")
                    .font(AppTheme.serifFont(size: 28, weight: .medium))
                    .foregroundStyle(AppTheme.goldGradient)
                
                Text("Analyzing the lines of your destiny...")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
}

// MARK: - Result View

struct PalmResultView: View {
    let reading: PalmReading
    @ObservedObject var viewModel: PalmReadingViewModel
    @State private var selectedLine: PalmLine?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                Spacer()
                    .frame(height: 20)
                
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "hand.raised.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text("Your Palm Reading")
                        .font(AppTheme.serifFont(size: 32, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(reading.date, style: .date)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textTertiary)
                }
                .padding(.bottom, 10)
                
                // Overall interpretation
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "sparkles")
                            .foregroundStyle(AppTheme.goldGradient)
                        Text("Overall Reading")
                            .font(AppTheme.serifFont(size: 22, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    
                    Text(reading.overallInterpretation)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .lineSpacing(6)
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppTheme.cardGradient)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                        )
                )
                .padding(.horizontal, 20)
                
                // Individual lines
                VStack(spacing: 14) {
                    Text("Your Palm Lines")
                        .font(AppTheme.serifFont(size: 22, weight: .medium))
                        .foregroundColor(AppTheme.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    PalmLineCard(
                        line: .heart,
                        characteristics: reading.heartLine,
                        reading: reading
                    )
                    
                    PalmLineCard(
                        line: .head,
                        characteristics: reading.headLine,
                        reading: reading
                    )
                    
                    PalmLineCard(
                        line: .life,
                        characteristics: reading.lifeLine,
                        reading: reading
                    )
                    
                    if let fateLine = reading.fateLine {
                        PalmLineCard(
                            line: .fate,
                            characteristics: fateLine,
                            reading: reading
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                // Action buttons
                VStack(spacing: 12) {
                    Button {
                        viewModel.takeNewPhoto()
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Read Another Palm")
                        }
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppTheme.goldGradient)
                        .cornerRadius(30)
                    }
                    
                    Button {
                        viewModel.reset()
                    } label: {
                        Text("Done")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(AppTheme.gold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 10)
                .padding(.bottom, 30)
            }
        }
    }
}

struct PalmLineCard: View {
    let line: PalmLine
    let characteristics: PalmLineCharacteristics
    let reading: PalmReading
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button {
                withAnimation(.spring(response: 0.3)) {
                    isExpanded.toggle()
                }
                HapticService.shared.impact(.light)
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(line.localizedName)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text(PalmInterpretations.quickSummary(for: characteristics))
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(AppTheme.textTertiary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(AppTheme.gold)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
            }
            
            if isExpanded {
                Divider()
                    .background(AppTheme.gold.opacity(0.3))
                    .padding(.vertical, 4)
                
                Text(reading.interpretation(for: line))
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(5)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.cardGradient)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.3), lineWidth: 1)
                )
        )
    }
}

#Preview {
    NavigationStack {
        PalmReadingView()
    }
}
