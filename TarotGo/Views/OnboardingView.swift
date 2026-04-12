//
//  OnboardingView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedCategory: IntentionCategory?
    @State private var customQuestion: String = ""
    @State private var showQuestionField: Bool = false
    @State private var navigateToReading: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            // Animated background
            AnimatedBackgroundView()
            
            ScrollView {
                VStack(spacing: 30) {
                    Spacer()
                        .frame(height: 50)
                    
                    // Welcome text
                    VStack(spacing: 15) {
                        Text("Welcome")
                            .font(.system(size: 42, weight: .thin, design: .serif))
                            .foregroundColor(.white)
                        
                        Text("Take a deep breath and center yourself")
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                
                Spacer()
                
                // Category selection
                VStack(spacing: 20) {
                    Text("What brings you here today?")
                        .font(.system(size: 22, weight: .light, design: .serif))
                        .foregroundColor(.white)
                    
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
                        Text("You may ask a specific question")
                            .font(.system(size: 16, weight: .light))
                            .foregroundColor(.white.opacity(0.7))
                        
                        TextField("What would you like to know?", text: $customQuestion)
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
                        Text("Begin Your Reading")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.6)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(15)
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
                Text(category.rawValue)
                    .font(.system(size: 20, weight: .medium, design: .serif))
                    .foregroundColor(.white)
                
                Text(category.description)
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(.white.opacity(0.7))
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isSelected ? Color.white.opacity(0.6) : Color.white.opacity(0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
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
                    .fill(Color.white.opacity(0.15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
            )
            .foregroundColor(.white)
            .font(.system(size: 16))
            .tint(.white)
            .autocorrectionDisabled()
    }
}
