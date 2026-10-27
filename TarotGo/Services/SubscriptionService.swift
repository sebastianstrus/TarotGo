//
//  SubscriptionService.swift
//  TarotGo
//
//  StoreKit 2 subscription management.
//

import Foundation
import StoreKit
import Combine

enum SubscriptionProduct: String, CaseIterable {
    case monthly = "tarotgo.premium.month"
    case yearly = "tarotgo.premium.year"

    var id: String { rawValue }
}

enum SubscriptionError: LocalizedError {
    case failedVerification

    var errorDescription: String? {
        switch self {
        case .failedVerification:
            return L10n.subscriptionErrorVerification
        }
    }
}

@MainActor
final class SubscriptionService: ObservableObject {
    static let shared = SubscriptionService()

    @Published private(set) var products: [Product] = []
    @Published private(set) var purchasedProductIDs: Set<String> = []
    @Published private(set) var isLoadingProducts: Bool = false
    @Published private(set) var isPurchasing: Bool = false
    @Published private(set) var isEligibleForIntroOffer: Bool = false

    var isPremium: Bool {
        !purchasedProductIDs.isEmpty
    }

    var monthlyProduct: Product? {
        products.first(where: { $0.id == SubscriptionProduct.monthly.rawValue })
    }

    var yearlyProduct: Product? {
        products.first(where: { $0.id == SubscriptionProduct.yearly.rawValue })
    }

    private var updateListenerTask: Task<Void, Never>?

    private init() {
        updateListenerTask = listenForTransactions()
        Task {
            await loadProducts()
            await refreshPurchasedProducts()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    func loadProducts() async {
        isLoadingProducts = true
        defer { isLoadingProducts = false }

        do {
            let identifiers = SubscriptionProduct.allCases.map(\.rawValue)
            let storeProducts = try await Product.products(for: identifiers)
            products = storeProducts.sorted { $0.price < $1.price }
            await refreshIntroOfferEligibility()
        } catch {
            print("❌ Failed to load StoreKit products: \(error)")
        }
    }

    func refreshIntroOfferEligibility() async {
        guard let groupID = products.compactMap({ $0.subscription?.subscriptionGroupID }).first else {
            isEligibleForIntroOffer = false
            return
        }
        isEligibleForIntroOffer = await Product.SubscriptionInfo.isEligibleForIntroOffer(for: groupID)
    }

    @discardableResult
    func purchase(_ product: Product) async throws -> Transaction? {
        isPurchasing = true
        defer { isPurchasing = false }

        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            let verifiedID: String? = transaction.revocationDate == nil ? transaction.productID : nil
            if let verifiedID {
                purchasedProductIDs.insert(verifiedID)
            }
            await transaction.finish()
            // Entitlements may lag right after a purchase; keep the just-verified product
            // so the UI doesn't flip back to non-premium until the next app launch.
            await refreshPurchasedProducts(including: verifiedID)
            return transaction
        case .userCancelled, .pending:
            return nil
        @unknown default:
            return nil
        }
    }

    func restorePurchases() async throws {
        try await AppStore.sync()
        await refreshPurchasedProducts()
    }

    func refreshPurchasedProducts(including verifiedID: String? = nil) async {
        var purchased: Set<String> = []
        if let verifiedID { purchased.insert(verifiedID) }

        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if transaction.revocationDate == nil {
                purchased.insert(transaction.productID)
            }
        }

        var seenGroupIDs: Set<String> = []
        for product in products {
            guard let subscription = product.subscription else { continue }
            let groupID = subscription.subscriptionGroupID
            guard !seenGroupIDs.contains(groupID) else { continue }
            seenGroupIDs.insert(groupID)
            guard let statuses = try? await subscription.status else { continue }
            for status in statuses {
                guard status.state == .subscribed || status.state == .inGracePeriod,
                      case .verified(let transaction) = status.transaction else { continue }
                purchased.insert(transaction.productID)
            }
        }

        purchasedProductIDs = purchased
        await refreshIntroOfferEligibility()
    }

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                guard case .verified(let transaction) = result else { continue }
                await self.refreshPurchasedProducts()
                await transaction.finish()
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw SubscriptionError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}
