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
    @StateObject private var subscriptionService = SubscriptionService.shared

    @State private var selectedProductID: String = SubscriptionProduct.yearly.rawValue
    @State private var errorMessage: String?
    @State private var showError: Bool = false

    var body: some View {
        ZStack {
            Color.clear
                .background(AnimatedBackgroundView().ignoresSafeArea())

            ScrollView {
                VStack(spacing: 24) {
                    header
                    featuresSection
                    productsSection
                    ctaButton
                    footerLinks
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 32)
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
        VStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.2))
                    .frame(width: 110, height: 110)
                    .blur(radius: 18)

                Image(systemName: "crown.fill")
                    .font(.system(size: 56, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.7), radius: 12)
            }
            .padding(.top, 24)

            Text(L10n.paywallTitle)
                .font(AppTheme.serifFont(size: 32, weight: .regular))
                .foregroundStyle(AppTheme.goldGradient)
                .shadow(color: AppTheme.gold.opacity(0.5), radius: 8, x: 0, y: 4)

            Text(L10n.paywallSubtitle)
                .font(.system(size: 15, weight: .light))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Features

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            featureRow(icon: "rectangle.portrait.on.rectangle.portrait.angled.fill",
                       title: L10n.paywallFeatureTarotTitle,
                       subtitle: L10n.paywallFeatureTarotSubtitle)
            featureRow(icon: "star.circle.fill",
                       title: L10n.paywallFeatureMatrixTitle,
                       subtitle: L10n.paywallFeatureMatrixSubtitle)
            featureRow(icon: "hand.raised.palm.facing.fill",
                       title: L10n.paywallFeaturePalmTitle,
                       subtitle: L10n.paywallFeaturePalmSubtitle)
            featureRow(icon: "heart.circle.fill",
                       title: L10n.paywallFeatureCompatibilityTitle,
                       subtitle: L10n.paywallFeatureCompatibilitySubtitle)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(AppTheme.midNavy.opacity(0.45))
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(AppTheme.gold.opacity(0.35), lineWidth: 1)
                )
        )
    }

    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                Circle()
                    .fill(AppTheme.gold.opacity(0.15))
                    .frame(width: 42, height: 42)
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(AppTheme.goldGradient)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(AppTheme.serifFont(size: 16, weight: .semibold))
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
        VStack(spacing: 12) {
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
            HStack(spacing: 14) {
                ZStack {
                    Circle()
                        .stroke(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.4),
                                lineWidth: 1.5)
                        .frame(width: 22, height: 22)
                    if isSelected {
                        Circle()
                            .fill(AppTheme.goldGradient)
                            .frame(width: 12, height: 12)
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(isYearly ? L10n.paywallProductYearly : L10n.paywallProductMonthly)
                            .font(AppTheme.serifFont(size: 17, weight: .semibold))
                            .foregroundColor(AppTheme.textPrimary)

                        if let badge {
                            Text(badge)
                                .font(.system(size: 9, weight: .bold))
                                .tracking(0.8)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(
                                    Capsule().fill(AppTheme.goldGradient)
                                )
                                .foregroundColor(AppTheme.deepNavy)
                        }
                    }

                    if let trialText {
                        Text(trialText)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(AppTheme.lightGold)
                    }
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(product.displayPrice)
                        .font(AppTheme.serifFont(size: 18, weight: .semibold))
                        .foregroundStyle(AppTheme.goldGradient)
                    Text(periodText)
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(AppTheme.textTertiary)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(AppTheme.midNavy.opacity(isSelected ? 0.7 : 0.35))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? AppTheme.gold : AppTheme.gold.opacity(0.3),
                                    lineWidth: isSelected ? 1.8 : 1)
                    )
                    .shadow(color: isSelected ? AppTheme.gold.opacity(0.4) : .clear,
                            radius: 10)
            )
        }
        .buttonStyle(.plain)
    }

    private func trialDescription(for product: Product) -> String? {
        guard let intro = product.subscription?.introductoryOffer,
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
                        .font(AppTheme.serifFont(size: 17, weight: .semibold))
                        .foregroundColor(AppTheme.deepNavy)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 54)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(AppTheme.goldGradient)
                    .shadow(color: AppTheme.gold.opacity(0.6), radius: 14)
            )
        }
        .buttonStyle(.plain)
        .disabled(subscriptionService.isPurchasing || subscriptionService.products.isEmpty)
        .opacity(subscriptionService.products.isEmpty ? 0.5 : 1)
    }

    private var ctaTitle: String {
        if let product = subscriptionService.products.first(where: { $0.id == selectedProductID }),
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
                _ = try await subscriptionService.purchase(product)
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
        }
    }

    // MARK: - Footer

    private var footerLinks: some View {
        VStack(spacing: 12) {
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
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppTheme.textSecondary)
                    .underline()
            }
            .buttonStyle(.plain)

            Text(L10n.paywallDisclaimer)
                .font(.system(size: 11, weight: .light))
                .foregroundColor(AppTheme.textTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
        }
        .padding(.top, 4)
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
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(width: 32, height: 32)
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
