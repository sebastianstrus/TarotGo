//
//  OnboardingView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @State private var selectedCategory: IntentionCategory?
    @State private var customQuestion: String = ""
    @State private var showQuestionField: Bool = false
    @State private var navigateToReading: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            // Animated background
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 50)
                    
                    // Welcome text with gold styling
                    VStack(spacing: 15) {
                        Text(L10n.onboardingWelcomeText)
                            .font(AppTheme.serifFont(size: 42, weight: .medium))
                            .foregroundStyle(AppTheme.goldGradient)
                            .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)

                        HStack(spacing: 8) {
                            Rectangle()
                                .fill(AppTheme.gold.opacity(0.5))
                                .frame(width: 30, height: 1)

                            Text(L10n.onboardingCenterYourself)
                                .font(.system(size: 18, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Rectangle()
                                .fill(AppTheme.gold.opacity(0.5))
                                .frame(width: 30, height: 1)
                        }
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    }
                
                Spacer()
                
                // Category selection with gold accent
                VStack(spacing: 20) {
                    Text(L10n.onboardingWhatBrings)
                        .font(AppTheme.serifFont(size: 22, weight: .light))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    VStack(spacing: 15) {
                        ForEach(IntentionCategory.allCases, id: \.self) { category in
                            CategoryButton(
                                category: category,
                                isSelected: selectedCategory == category
                            ) {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedCategory = category
                                    showQuestionField = true
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }
                
                // Optional custom question
                if showQuestionField {
                    VStack(spacing: 15) {
                        HStack(spacing: 8) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundColor(AppTheme.gold.opacity(0.6))

                            Text(L10n.onboardingOptionalQuestion)
                                .font(.system(size: 16, weight: .light))
                                .foregroundColor(AppTheme.textSecondary)

                            Image(systemName: "star.fill")
                                .font(.system(size: 8))
                                .foregroundColor(AppTheme.gold.opacity(0.6))
                        }

                        TextField(L10n.onboardingQuestionPlaceholder, text: $customQuestion)
                            .textFieldStyle(MysticTextFieldStyle())
                            .padding(.horizontal, 30)
                            .focused($isTextFieldFocused)
                            .submitLabel(.done)
                            .onSubmit {
                                isTextFieldFocused = false
                            }
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                
                Spacer()
                
                // Continue button
                if selectedCategory != nil {
                    Button {
                        HapticService.shared.impact(.success)
                        SoundService.shared.play(.success, volume: 0.6)
                        navigateToReading = true
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 14))

                            Text(L10n.onboardingBeginReading)
                                .font(AppTheme.serifFont(size: 18, weight: .semibold))

                            Image(systemName: "star.fill")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(AppTheme.deepNavy)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.goldGradient)
                        .cornerRadius(15)
                        .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
                        .padding(.horizontal, 30)
                    }
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
                
                Spacer()
                    .frame(height: 50)
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isTextFieldFocused = false
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isTextFieldFocused = false
                }
                .foregroundColor(.white)
            }
        }
        .navigationDestination(isPresented: $navigateToReading) {
            if let category = selectedCategory {
                ShuffleRitualView(
                    category: category,
                    customQuestion: customQuestion.isEmpty ? nil : customQuestion
                )
            }
        }
        .onChange(of: appViewModel.shouldDismissToRoot) { _, shouldDismiss in
            if shouldDismiss {
                navigateToReading = false
            }
        }
    }
}

struct CategoryButton: View {
    let category: IntentionCategory
    let isSelected: Bool
    let action: () -> Void
    @State private var isPressed: Bool = false
    
    var body: some View {
        Button(action: {
            HapticService.shared.impact(.medium)
            SoundService.shared.play(.whoosh, volume: 0.4)
            action()
        }) {
            VStack(alignment: .leading, spacing: 5) {
                Text(category.displayName)
                    .font(AppTheme.serifFont(size: 20, weight: .medium))
                    .foregroundStyle(isSelected ? AppTheme.goldGradient : LinearGradient(colors: [.white], startPoint: .leading, endPoint: .trailing))
                
                Text(category.description)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(isSelected ? AppTheme.textSecondary : AppTheme.textSecondary.opacity(0.7))
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? AppTheme.cardGradient : LinearGradient(colors: [Color.white.opacity(0.08)], startPoint: .top, endPoint: .bottom))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
                    .shadow(color: isSelected ? AppTheme.gold.opacity(0.4) : .clear, radius: 8)
            )
        }
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
    }
}

struct MysticTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppTheme.darkNavy.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppTheme.gold.opacity(0.4), lineWidth: 1)
                    )
            )
            .foregroundColor(.white)
            .font(.system(size: 16))
            .tint(AppTheme.gold)
            .autocorrectionDisabled()
    }
}
