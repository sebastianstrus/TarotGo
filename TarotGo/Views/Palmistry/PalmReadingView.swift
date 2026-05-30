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
                PalmReadingOverlay()
                    .transition(.opacity)
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
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 10)
                
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "hand.raised.palm.facing.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                    
                    Text(L10n.palmReadingTitle)
                        .font(AppTheme.serifFont(size: 36, weight: .medium))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(L10n.palmReadingSubtitle)
                        .font(.system(size: 16, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                }
                .padding(.bottom, 20)
                
                // Info cards
                VStack(spacing: 16) {
                    InfoCard(
                        icon: "eye.fill",
                        title: L10n.palmReadingOnDeviceTitle,
                        description: L10n.palmReadingOnDeviceDesc
                    )
                    
                    InfoCard(
                        icon: "line.3.horizontal.decrease.circle.fill",
                        title: L10n.palmReadingFourLinesTitle,
                        description: L10n.palmReadingFourLinesDesc
                    )
                    
                    InfoCard(
                        icon: "sparkles",
                        title: L10n.palmReadingAncientTitle,
                        description: L10n.palmReadingAncientDesc
                    )
                }
                .padding(.horizontal, 30)
                
                // Start button
                Button {
                    viewModel.startReading()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "camera.fill")
                        Text(L10n.palmReadingTakePhoto)
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

// MARK: - Mystical Palm Reading Overlay

private struct PalmReadingOverlay: View {
    @State private var outerRingRotation: Double = 0
    @State private var innerRingRotation: Double = 0
    @State private var pulse: CGFloat = 0.9
    @State private var glow: Double = 0.35
    @State private var appear: Bool = false
    @State private var lineProgress: CGFloat = 0
    @State private var scanLineOffset: CGFloat = -90
    @State private var rippleProgress: CGFloat = 0

    var body: some View {
        ZStack {
            // Dimmed mystical backdrop
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .background(.ultraThinMaterial.opacity(0.9))

            // Radiant glow behind the palm
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            AppTheme.gold.opacity(glow),
                            AppTheme.mysticalPurple.opacity(glow * 0.6),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 220
                    )
                )
                .frame(width: 440, height: 440)
                .blur(radius: 30)

            // Concentric energy ripples expanding outward
            ZStack {
                ForEach(0..<3, id: \.self) { i in
                    Circle()
                        .stroke(AppTheme.gold.opacity(0.5), lineWidth: 1.2)
                        .frame(width: 180, height: 180)
                        .scaleEffect(0.6 + rippleProgress + CGFloat(i) * 0.35)
                        .opacity(Double(1 - rippleProgress) * (1 - Double(i) * 0.25))
                }
            }

            // Main mystical geometry
            ZStack {
                // Outer rotating ring with orbiting golden dots
                ZStack {
                    Circle()
                        .stroke(AppTheme.gold.opacity(0.25), lineWidth: 1)
                        .frame(width: 280, height: 280)

                    ForEach(0..<8, id: \.self) { i in
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 6, height: 6)
                            .shadow(color: AppTheme.gold.opacity(0.8), radius: 6)
                            .offset(y: -140)
                            .rotationEffect(.degrees(Double(i) * 45))
                    }
                }
                .rotationEffect(.degrees(outerRingRotation))

                // Inner counter-rotating ring with smaller dots
                ZStack {
                    Circle()
                        .stroke(AppTheme.gold.opacity(0.2), lineWidth: 1)
                        .frame(width: 220, height: 220)

                    ForEach(0..<12, id: \.self) { i in
                        Circle()
                            .fill(AppTheme.lightGold)
                            .frame(width: 3, height: 3)
                            .shadow(color: AppTheme.gold.opacity(0.7), radius: 4)
                            .offset(y: -110)
                            .rotationEffect(.degrees(Double(i) * 30))
                    }
                }
                .rotationEffect(.degrees(innerRingRotation))

                // Palm lines being "read" (traced in with shimmer)
                ZStack {
                    ForEach(0..<4, id: \.self) { i in
                        PalmLineShape(lineIndex: i)
                            .trim(from: 0, to: lineProgress)
                            .stroke(
                                AppTheme.goldGradient,
                                style: StrokeStyle(lineWidth: 1.6, lineCap: .round)
                            )
                            .shadow(color: AppTheme.gold.opacity(0.8), radius: 4)
                            .frame(width: 150, height: 170)
                    }
                }

                // Central palm icon
                Image(systemName: "hand.raised.palm.facing.fill")
                    .font(.system(size: 96))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.9), radius: 18)
                    .scaleEffect(pulse)

                // Horizontal scanning line traveling over the palm
                ZStack {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.clear,
                                    AppTheme.lightGold.opacity(0.9),
                                    Color.clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 180, height: 3)
                        .shadow(color: AppTheme.gold.opacity(0.9), radius: 8)
                        .blur(radius: 1)
                        .offset(y: scanLineOffset)
                }
                .frame(width: 200, height: 200)
                .mask(Circle().frame(width: 200, height: 200))
            }
            .opacity(appear ? 1 : 0)
            .scaleEffect(appear ? 1 : 0.6)

            // Title beneath geometry
            VStack {
                Spacer()
                VStack(spacing: 10) {
                    Text(L10n.palmReadingAnalyzing)
                        .font(AppTheme.serifFont(size: 24, weight: .regular))
                        .foregroundStyle(AppTheme.goldGradient)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 8)

                    Text(L10n.palmReadingAnalyzingDesc)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .opacity(appear ? 1 : 0)
                .padding(.bottom, 100)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                appear = true
            }
            withAnimation(.linear(duration: 12).repeatForever(autoreverses: false)) {
                outerRingRotation = 360
            }
            withAnimation(.linear(duration: 9).repeatForever(autoreverses: false)) {
                innerRingRotation = -360
            }
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
                pulse = 1.08
                glow = 0.7
            }
            withAnimation(.easeInOut(duration: 2.2)) {
                lineProgress = 1.0
            }
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                scanLineOffset = 90
            }
            withAnimation(.easeOut(duration: 2.0).repeatForever(autoreverses: false)) {
                rippleProgress = 1.0
            }
        }
    }
}

// Hand-drawn palm line paths used for the tracing effect.
private struct PalmLineShape: Shape {
    let lineIndex: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        switch lineIndex {
        case 0: // Heart line — upper curve across the palm
            path.move(to: CGPoint(x: w * 0.08, y: h * 0.30))
            path.addCurve(
                to: CGPoint(x: w * 0.90, y: h * 0.24),
                control1: CGPoint(x: w * 0.35, y: h * 0.14),
                control2: CGPoint(x: w * 0.65, y: h * 0.18)
            )
        case 1: // Head line — middle, slightly descending
            path.move(to: CGPoint(x: w * 0.12, y: h * 0.46))
            path.addCurve(
                to: CGPoint(x: w * 0.86, y: h * 0.52),
                control1: CGPoint(x: w * 0.35, y: h * 0.42),
                control2: CGPoint(x: w * 0.62, y: h * 0.56)
            )
        case 2: // Life line — arcs from index toward wrist
            path.move(to: CGPoint(x: w * 0.30, y: h * 0.18))
            path.addCurve(
                to: CGPoint(x: w * 0.22, y: h * 0.92),
                control1: CGPoint(x: w * 0.08, y: h * 0.50),
                control2: CGPoint(x: w * 0.14, y: h * 0.78)
            )
        case 3: // Fate line — vertical from wrist toward middle finger
            path.move(to: CGPoint(x: w * 0.56, y: h * 0.94))
            path.addCurve(
                to: CGPoint(x: w * 0.50, y: h * 0.32),
                control1: CGPoint(x: w * 0.60, y: h * 0.70),
                control2: CGPoint(x: w * 0.46, y: h * 0.50)
            )
        default:
            break
        }
        return path
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
                    .frame(height: 10)
                
                // Header
                VStack(spacing: 12) {
                    Image(systemName: "hand.raised.palm.facing.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(AppTheme.goldGradient)
                    
                    Text(L10n.palmReadingYourReading)
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
                        Text(L10n.palmReadingOverall)
                            .font(AppTheme.serifFont(size: 22, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    
                    Text(reading.overallInterpretation)
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(AppTheme.textSecondary)
                        .lineSpacing(6)
                        .multilineTextAlignment(.leading)
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
                
                // Hand Shape Section
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "hand.raised.palm.facing.fill")
                            .foregroundStyle(AppTheme.goldGradient)
                        Text(NSLocalizedString("palm.handShape.title", comment: "Your Hand Shape"))
                            .font(AppTheme.serifFont(size: 22, weight: .medium))
                            .foregroundColor(AppTheme.textPrimary)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(reading.handShape.shapeType.description)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(AppTheme.gold)
                            
                            Spacer()
                            
                            Text("✦ \(reading.handShape.palmRatio.description) Palm")
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                        }
                        
                        Text(PalmInterpretations.handShapeInterpretation(for: reading.handShape))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .lineSpacing(5)
                            .multilineTextAlignment(.leading)
                    }
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
                    Text(L10n.palmReadingYourLines)
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
                    
                    PalmLineCard(
                        line: .fate,
                        characteristics: reading.fateLine,
                        reading: reading
                    )
                }
                .padding(.horizontal, 20)
                
                // Palm Mounts Section
                if !reading.mounts.isEmpty {
                    VStack(spacing: 14) {
                        HStack {
                            Image(systemName: "mountain.2.fill")
                                .foregroundStyle(AppTheme.goldGradient)
                            Text(NSLocalizedString("palm.mounts.title", comment: "Palm Mounts"))
                                .font(AppTheme.serifFont(size: 22, weight: .medium))
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                        
                        Text(NSLocalizedString("palm.mounts.description", comment: "The mounts are raised areas on your palm that reveal different aspects of your personality and life energy."))
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(AppTheme.textSecondary)
                            .padding(.horizontal, 20)
                        
                        ForEach(reading.mounts, id: \.mount) { mount in
                            PalmMountCard(mount: mount)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // Action buttons
                VStack(spacing: 12) {
                    Button {
                        viewModel.takeNewPhoto()
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text(L10n.palmReadingReadAnother)
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
                        Text(L10n.done)
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
    let characteristics: PalmLineCharacteristics?
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
                        
                        if let characteristics = characteristics {
                            Text(PalmInterpretations.quickSummary(for: characteristics))
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text("Not prominently visible")
                                .font(.system(size: 13, weight: .light))
                                .foregroundColor(AppTheme.textTertiary)
                                .multilineTextAlignment(.leading)
                        }
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
                    .multilineTextAlignment(.leading)
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

struct PalmMountCard: View {
    let mount: PalmMountCharacteristics
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
                        Text(mount.mount.localizedName)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)
                        
                        Text(PalmInterpretations.mountQuickSummary(for: mount))
                            .font(.system(size: 13, weight: .light))
                            .foregroundColor(AppTheme.textTertiary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
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
                
                Text(PalmInterpretations.mountInterpretation(for: mount))
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(AppTheme.textSecondary)
                    .lineSpacing(5)
                    .multilineTextAlignment(.leading)
                    .transition(.opacity.combined(with: .move(edge: .top)))
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

#Preview {
    NavigationStack {
        PalmReadingView()
    }
}
