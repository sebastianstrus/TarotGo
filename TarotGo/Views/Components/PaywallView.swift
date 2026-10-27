//
//  PaywallView.swift
//  TarotGo
//
//  Subscription paywall presented when a Premium feature is requested.
//

import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL
    @StateObject private var subscriptionService = SubscriptionService.shared

    private let privacyPolicyURL = URL(string: "https://tarot-go.com/privacy.html")!
    private let termsOfUseURL = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula")!

    @State private var selectedProductID: String = SubscriptionProduct.yearly.rawValue
    @State private var errorMessage: String?
    @State private var showError: Bool = false

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(spacing: 20) { // Reduced from 24 to compress general spacing
                    header
                    featuresSection
                    productsSection
                    ctaButton
                    footerLinks
                }
                .padding(.horizontal, 20) // Shrunk from 24 to gain a bit more width flexibility
                .padding(.top, 12)        // Shrunk from 16
                .padding(.bottom, 24)     // Shrunk from 32
            }

            closeButton
        }
        .preferredColorScheme(.dark)
        .alert(L10n.paywallErrorTitle, isPresented: $showError, presenting: errorMessage) { _ in
            Button(L10n.ok, role: .cancel) { }
        } message: { message in
            Text(message)
        }
        .onChange(of: subscriptionService.isPremium) { _, isPremium in
            if isPremium { dismiss() }
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 10) { // Tightened from 14
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.2))
                    .frame(width: 80, height: 80) // Scaled down from 110x110
                    .blur(radius: 14)

                Image(systemName: "crown.fill")
                    .font(.system(size: 40, weight: .semibold)) // Downsized from 56
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 10)
            }
            .padding(.top, 28) // Space below the close indicator zone

            Text(L10n.paywallTitle)
                .font(AppTheme.serifFont(size: 26, weight: .regular)) // Reduced size from 32
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 6, x: 0, y: 3)

            Text(L10n.paywallSubtitle)
                .font(.system(size: 14, weight: .light)) // Shrunk slightly from 15
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
    }

    // MARK: - Features

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 10) { // Shrunk from 14
            // Simplified version: only Destiny Matrix features for now.
            // Tarot Readings, Palm Reading and Cosmic Compatibility are hidden.
//            featureRow(icon: "rectangle.portrait.on.rectangle.portrait.angled.fill",
//                       title: L10n.paywallFeatureTarotTitle,
//                       subtitle: L10n.paywallFeatureTarotSubtitle)
            featureRow(icon: "star.circle.fill",
                       title: L10n.paywallFeatureMatrixTitle,
                       subtitle: L10n.paywallFeatureMatrixSubtitle)
            featureRow(icon: "bookmark.circle.fill",
                       title: L10n.paywallFeatureSaveTitle,
                       subtitle: L10n.paywallFeatureSaveSubtitle)
            featureRow(icon: "book.circle.fill",
                       title: L10n.paywallFeatureLearnTitle,
                       subtitle: L10n.paywallFeatureLearnSubtitle)
//            featureRow(icon: "hand.raised.palm.facing.fill",
//                       title: L10n.paywallFeaturePalmTitle,
//                       subtitle: L10n.paywallFeaturePalmSubtitle)
//            featureRow(icon: "heart.circle.fill",
//                       title: L10n.paywallFeatureCompatibilityTitle,
//                       subtitle: L10n.paywallFeatureCompatibilitySubtitle)
        }
        .padding(.vertical, 14) // Tighter edge parameters
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(AppTheme.midNavy.opacity(0.45))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(AppTheme.gold.opacity(0.35), lineWidth: 1)
                )
        )
    }

    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(alignment: .center, spacing: 12) { // Shrunk spacing from 14
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.15))
                    .frame(width: 34, height: 34) // Downsized container frame from 42
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold)) // Slightly down from 18
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(alignment: .leading, spacing: 1) { // Compact spacing
                Text(title)
                    .font(AppTheme.serifFont(size: 15, weight: .semibold)) // Downsized from 16
                    .foregroundColor(AppTheme.textPrimary)
                Text(subtitle)
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(AppTheme.textTertiary)
                    .lineLimit(2)
            }

            Spacer()
        }
    }

    // MARK: - Products

    private var productsSection: some View {
        VStack(spacing: 10) { // Shrunk element space from 12
            if subscriptionService.isLoadingProducts && subscriptionService.products.isEmpty {
                ProgressView()
                    .tint(AppTheme.gold)
                    .frame(maxWidth: .infinity, minHeight: 120)
            } else if subscriptionService.products.isEmpty {
                Text(L10n.paywallProductsLoading)
                    .font(.system(size: 13))
                    .foregroundColor(AppTheme.textTertiary)
                    .frame(maxWidth: .infinity, minHeight: 120)
            } else {
                if let yearly = subscriptionService.yearlyProduct {
                    productOption(for: yearly, badge: L10n.paywallBadgeBestValue, isYearly: true)
                }
                if let monthly = subscriptionService.monthlyProduct {
                    productOption(for: monthly, badge: nil, isYearly: false)
                }
            }
        }
    }

    private func productOption(for product: Product, badge: String?, isYearly: Bool) -> some View {
        let isSelected = selectedProductID == product.id
        let trialText = trialDescription(for: product)
        let periodText = isYearly ? L10n.paywallPeriodYearly : L10n.paywallPeriodMonthly

        return Button {
            HapticService.shared.impact(.soft)
            selectedProductID = product.id
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.4),
                                lineWidth: 1.5)
                        .frame(width: 20, height: 20) // Trimmed from 22
                    if isSelected {
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 10, height: 10) // Trimmed from 12
                    }
                }

                VStack(alignment: .leading, spacing: 2) { // Shrunk step size from 4
                    HStack(spacing: 6) {
                        Text(isYearly ? L10n.paywallProductYearly : L10n.paywallProductMonthly)
                            .font(AppTheme.serifFont(size: 16, weight: .semibold)) // Shrunk from 17

                        if let badge {
                            Text(badge)
                                .font(.system(size: 8, weight: .bold))
                                .tracking(0.8)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(
                                    Capsule().fill(AppTheme.goldGradient)
                                )
                                .foregroundColor(AppTheme.deepNavy)
                        }
                    }

                    if let trialText {
                        Text(trialText)
                            .font(.system(size: 11, weight: .medium)) // Down from 12
                            .foregroundColor(AppTheme.lightGold)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 1) {
                    Text(product.displayPrice)
                        .font(AppTheme.serifFont(size: 17, weight: .semibold)) // Shrunk from 18
                        .foregroundStyle(AppTheme.goldGradient)
                    Text(periodText)
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(AppTheme.textTertiary)
                }
            }
            .padding(12) // Compressed padding down from 16
            .background(
                RoundedRectangle(cornerRadius: 12) // Shrunk slightly from 14
                    .fill(AppTheme.midNavy.opacity(isSelected ? 0.7 : 0.35))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.3),
                                    lineWidth: isSelected ? 1.5 : 1)
                    )
                    .shadow(color: isSelected ? AppTheme.gold.opacity(0.35) : .clear,
                            radius: 8)
            )
        }
        .buttonStyle(.plain)
    }

    private func trialDescription(for product: Product) -> String? {
        guard subscriptionService.isEligibleForIntroOffer,
              let intro = product.subscription?.introductoryOffer,
              intro.paymentMode == .freeTrial else { return nil }
        let multiplier: Int
        switch intro.period.unit {
        case .day: multiplier = 1
        case .week: multiplier = 7
        case .month: multiplier = 30
        case .year: multiplier = 365
        @unknown default: multiplier = 1
        }
        let totalDays = intro.period.value * multiplier
        return L10n.paywallTrialDays(totalDays)
    }

    // MARK: - CTA

    private var ctaButton: some View {
        Button {
            startPurchase()
        } label: {
            HStack {
                if subscriptionService.isPurchasing {
                    ProgressView()
                        .tint(AppTheme.deepNavy)
                } else {
                    Text(ctaTitle)
                        .font(AppTheme.serifFont(size: 16, weight: .semibold)) // Down from 17
                        .foregroundColor(AppTheme.deepNavy)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 50) // Reduced baseline height footprint from 54
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.5), radius: 10)
            )
        }
        .buttonStyle(.plain)
        .disabled(subscriptionService.isPurchasing || subscriptionService.products.isEmpty)
        .opacity(subscriptionService.products.isEmpty ? 0.5 : 1)
    }

    private var ctaTitle: String {
        if subscriptionService.isEligibleForIntroOffer,
           let product = subscriptionService.products.first(where: { $0.id == selectedProductID }),
           product.subscription?.introductoryOffer?.paymentMode == .freeTrial {
            return L10n.paywallCtaStartTrial
        }
        return L10n.paywallCtaContinue
    }

    private func startPurchase() {
        guard let product = subscriptionService.products.first(where: { $0.id == selectedProductID }) else {
            return
        }
        HapticService.shared.impact(.medium)
        Task {
            do {
                if try await subscriptionService.purchase(product) != nil {
                    dismiss()
                }
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    // MARK: - Footer

    private var footerLinks: some View {
        VStack(spacing: 10) {
            Button {
                Task {
                    do {
                        try await subscriptionService.restorePurchases()
                    } catch {
                        errorMessage = error.localizedDescription
                        showError = true
                    }
                }
            } label: {
                Text(L10n.paywallRestore)
                    .font(.system(size: 12, weight: .medium)) // Shrunk from 13
                    .foregroundColor(AppTheme.textSecondary)
                    .underline()
            }
            .buttonStyle(.plain)

            Text(L10n.paywallDisclaimer)
                .font(.system(size: 10, weight: .light)) // Shrunk from 11
                .foregroundColor(AppTheme.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)

            HStack(spacing: 16) {
                Button {
                    HapticService.shared.impact(.light)
                    openURL(termsOfUseURL)
                } label: {
                    Text(L10n.settingsTermsOfService)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary)
                        .underline()
                }
                .buttonStyle(.plain)

                Text("•")
                    .font(.system(size: 11))
                    .foregroundColor(AppTheme.textTertiary)

                Button {
                    HapticService.shared.impact(.light)
                    openURL(privacyPolicyURL)
                } label: {
                    Text(L10n.settingsPrivacyPolicy)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(AppTheme.textSecondary)
                        .underline()
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 2)
    }

    // MARK: - Close button

    private var closeButton: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    HapticService.shared.impact(.light)
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle()
                                .fill(AppTheme.midNavy.opacity(0.6))
                                .overlay(Circle().stroke(AppTheme.gold.opacity(0.4), lineWidth: 1))
                        )
                }
                .buttonStyle(.plain)
            }
            .padding(.top, 12)
            .padding(.trailing, 16)
            Spacer()
        }
    }
}

#Preview {
    PaywallView()
}
