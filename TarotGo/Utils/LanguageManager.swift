//
//  LanguageManager.swift
//  TarotGo
//
//  In-app language selection
//

import Foundation
import Observation

// MARK: - App Language

nonisolated enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english
    case german
    case spanish
    case french
    case italian
    case japanese
    case norwegian
    case polish
    case portugueseBrazil
    case swedish
    case ukrainian

    var id: String { rawValue }

    /// Matches the `.lproj` / String Catalog locale identifier for this language.
    var code: String {
        switch self {
        case .english: return "en"
        case .german: return "de"
        case .spanish: return "es"
        case .french: return "fr"
        case .italian: return "it"
        case .japanese: return "ja"
        case .norwegian: return "nb"
        case .polish: return "pl"
        case .portugueseBrazil: return "pt-BR"
        case .swedish: return "sv"
        case .ukrainian: return "uk"
        }
    }

    var flag: String {
        switch self {
        case .english: return "🇬🇧"
        case .german: return "🇩🇪"
        case .spanish: return "🇪🇸"
        case .french: return "🇫🇷"
        case .italian: return "🇮🇹"
        case .japanese: return "🇯🇵"
        case .norwegian: return "🇳🇴"
        case .polish: return "🇵🇱"
        case .portugueseBrazil: return "🇧🇷"
        case .swedish: return "🇸🇪"
        case .ukrainian: return "🇺🇦"
        }
    }

    /// Native name, shown the same way regardless of the current interface language.
    var displayName: String {
        switch self {
        case .english: return "English"
        case .german: return "Deutsch"
        case .spanish: return "Español"
        case .french: return "Français"
        case .italian: return "Italiano"
        case .japanese: return "日本語"
        case .norwegian: return "Norsk"
        case .polish: return "Polski"
        case .portugueseBrazil: return "Português"
        case .swedish: return "Svenska"
        case .ukrainian: return "Українська"
        }
    }

    /// Bundle containing this language's compiled strings, falling back to the main bundle.
    var bundle: Bundle {
        Bundle.main.path(forResource: code, ofType: "lproj").flatMap(Bundle.init(path:)) ?? .main
    }
}

// MARK: - Selected Language (thread-safe snapshot)

/// `L10n` is nonisolated and can be read from any thread, so the active
/// language's bundle is kept in a lock-protected snapshot instead of on
/// the main-actor `LanguageManager`.
nonisolated enum SelectedLanguage {
    private static let lock = NSLock()
    nonisolated(unsafe) private static var _language: AppLanguage = LanguageManager.storedOrDetectedLanguage()
    nonisolated(unsafe) private static var _bundle: Bundle = _language.bundle

    static var language: AppLanguage {
        get { lock.withLock { _language } }
        set {
            lock.withLock {
                _language = newValue
                _bundle = newValue.bundle
            }
        }
    }

    static var bundle: Bundle { lock.withLock { _bundle } }

    /// Locale for the selected language, e.g. for language-name lookups.
    static var locale: Locale { Locale(identifier: language.code) }
}

// MARK: - Language Manager

/// Lets the user pick the app's interface language from within the app,
/// without relying on the system Settings app or a relaunch.
///
/// `NSLocalizedString` and `Text(_:)` resolve their locale once per process
/// and ignore later changes to `AppleLanguages`, so `L10n` looks strings up
/// in `SelectedLanguage.bundle` instead of the default bundle.
@Observable
@MainActor
final class LanguageManager {
    static let shared = LanguageManager()

    private nonisolated static let languageKey = "app.language"

    var language: AppLanguage {
        didSet {
            UserDefaults.standard.set(language.rawValue, forKey: Self.languageKey)
            SelectedLanguage.language = language
        }
    }

    /// Locale injected into the SwiftUI environment for date/number formatting
    /// and system control labels.
    var interfaceLocale: Locale {
        Locale(identifier: language.code)
    }

    init() {
        language = Self.storedOrDetectedLanguage()
        SelectedLanguage.language = language
    }

    nonisolated static func storedOrDetectedLanguage() -> AppLanguage {
        if let stored = UserDefaults.standard.string(forKey: languageKey),
           let language = AppLanguage(rawValue: stored) {
            return language
        }
        return detectedLanguage()
    }

    /// Picks the supported language that best matches the device's preferences.
    private nonisolated static func detectedLanguage() -> AppLanguage {
        let preferred = (Locale.preferredLanguages.first ?? "en").lowercased()
        if preferred.hasPrefix("pt") { return .portugueseBrazil }
        return AppLanguage.allCases.first { preferred.hasPrefix($0.code.lowercased()) } ?? .english
    }
}
