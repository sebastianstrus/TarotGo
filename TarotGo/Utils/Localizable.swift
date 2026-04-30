//
//  Localizable.swift
//  TarotGo
//
//  Centralized localization strings
//

import Foundation

enum L10n {
    // MARK: - Common
    static let appName = NSLocalizedString("app.name", comment: "App name")
    static let cancel = NSLocalizedString("common.cancel", comment: "Cancel button")
    static let done = NSLocalizedString("common.done", comment: "Done button")
    static let save = NSLocalizedString("common.save", comment: "Save button")
    static let delete = NSLocalizedString("common.delete", comment: "Delete button")
    static let edit = NSLocalizedString("common.edit", comment: "Edit button")
    static let continue_ = NSLocalizedString("common.continue", comment: "Continue button")
    static let getStarted = NSLocalizedString("common.getStarted", comment: "Get started button")

    // MARK: - Home
    static let homeTitle = NSLocalizedString("home.title", comment: "TarotGo title")
    static let homeSubtitle = NSLocalizedString("home.subtitle", comment: "Your personal tarot companion")
    static let homeFooter = NSLocalizedString("home.footer", comment: "The cards are waiting for you")

    static let homeNewReading = NSLocalizedString("home.newReading", comment: "New Reading")
    static let homeNewReadingSubtitle = NSLocalizedString("home.newReading.subtitle", comment: "Discover what the cards reveal")

    static let homeCardOfDay = NSLocalizedString("home.cardOfDay", comment: "Card of the Day")
    static let homeCardOfDaySubtitle = NSLocalizedString("home.cardOfDay.subtitle", comment: "Today's guidance and insight")

    static let homeHistory = NSLocalizedString("home.history", comment: "Reading History")
    static let homeHistorySubtitle = NSLocalizedString("home.history.subtitle", comment: "Review your past readings")

    static let homeCardDictionary = NSLocalizedString("home.cardDictionary", comment: "Card Dictionary")
    static let homeCardDictionarySubtitle = NSLocalizedString("home.cardDictionary.subtitle", comment: "Explore all 78 tarot cards")
    
    static let homeSettings = NSLocalizedString("home.settings", comment: "Settings")
    static let homeSettingsSubtitle = NSLocalizedString("home.settings.subtitle", comment: "Configure notifications and preferences")

    // MARK: - Splash Screen
    static let splashJourneyBegins = NSLocalizedString("splash.journeyBegins", comment: "Your Journey Begins")
    
    // MARK: - Onboarding Flow
    static let onboardingWelcome = NSLocalizedString("onboarding.welcome", comment: "Welcome to TarotGo")
    static let onboardingWelcomeDesc = NSLocalizedString("onboarding.welcome.desc", comment: "Your journey into the wisdom of tarot begins here")

    static let onboardingShuffleTitle = NSLocalizedString("onboarding.shuffle.title", comment: "Shuffle with Intention")
    static let onboardingShuffleDesc = NSLocalizedString("onboarding.shuffle.desc", comment: "Hold the deck and focus on your question for a deeper connection")

    static let onboardingSelectTitle = NSLocalizedString("onboarding.select.title", comment: "Choose Your Cards")
    static let onboardingSelectDesc = NSLocalizedString("onboarding.select.desc", comment: "Trust your intuition when selecting cards from the spread")

    static let onboardingInterpretTitle = NSLocalizedString("onboarding.interpret.title", comment: "Receive Guidance")
    static let onboardingInterpretDesc = NSLocalizedString("onboarding.interpret.desc", comment: "Each card offers wisdom tailored to your question")

    // MARK: - Onboarding (Intention Selection)
    static let onboardingWelcomeText = NSLocalizedString("onboarding.welcomeText", comment: "Welcome")
    static let onboardingCenterYourself = NSLocalizedString("onboarding.centerYourself", comment: "Take a deep breath and center yourself")
    static let onboardingWhatBrings = NSLocalizedString("onboarding.whatBrings", comment: "What brings you here today?")
    static let onboardingOptionalQuestion = NSLocalizedString("onboarding.optionalQuestion", comment: "You may ask a specific question")
    static let onboardingQuestionPlaceholder = NSLocalizedString("onboarding.questionPlaceholder", comment: "What would you like to know?")
    static let onboardingBeginReading = NSLocalizedString("onboarding.beginReading", comment: "Begin Your Reading")
    static let onboardingGetStarted = NSLocalizedString("onboarding.getStarted", comment: "Get Started")
    static let onboardingNext = NSLocalizedString("onboarding.next", comment: "Next")
    static let onboardingSkip = NSLocalizedString("onboarding.skip", comment: "Skip")

    // MARK: - Intention Categories
    static let categoryLove = NSLocalizedString("category.love", comment: "Love")
    static let categoryLoveDesc = NSLocalizedString("category.love.desc", comment: "Relationships and romance")

    static let categoryCareer = NSLocalizedString("category.career", comment: "Career")
    static let categoryCareerDesc = NSLocalizedString("category.career.desc", comment: "Work and professional life")

    static let categoryFinance = NSLocalizedString("category.finance", comment: "Finance")
    static let categoryFinanceDesc = NSLocalizedString("category.finance.desc", comment: "Money and abundance")

    static let categoryHealth = NSLocalizedString("category.health", comment: "Health")
    static let categoryHealthDesc = NSLocalizedString("category.health.desc", comment: "Wellbeing and vitality")

    static let categoryGeneral = NSLocalizedString("category.general", comment: "General")
    static let categoryGeneralDesc = NSLocalizedString("category.general.desc", comment: "Life guidance and wisdom")

    // MARK: - Shuffle Ritual
    static let shuffleTakeBreath = NSLocalizedString("shuffle.takeBreath", comment: "Take a deep breath")
    static let shuffleInstruction = NSLocalizedString("shuffle.instruction", comment: "Place your finger on the deck and hold for 5 seconds while focusing on your question")
    static let shuffleFocusing = NSLocalizedString("shuffle.focusing", comment: "Focus on your intention...")
    static let shuffleShuffling = NSLocalizedString("shuffle.shuffling", comment: "The cards are being shuffled")
    static let shuffleReady = NSLocalizedString("shuffle.ready", comment: "Your deck is ready")

    // MARK: - Card Selection
    static let selectionChooseCard = NSLocalizedString("selection.chooseCard", comment: "Choose a card that calls to you")
    static let selectionCardOf = NSLocalizedString("selection.cardOf", comment: "Card %d of %d")

    // MARK: - Interpretation
    static let interpretationTapReveal = NSLocalizedString("interpretation.tapReveal", comment: "Tap to reveal when you're ready")
    static let interpretationReversed = NSLocalizedString("interpretation.reversed", comment: "(Reversed)")
    static let interpretationResonateQuestion = NSLocalizedString("interpretation.resonateQuestion", comment: "Does this resonate with you?")
    static let interpretationResonate = NSLocalizedString("interpretation.resonate", comment: "Does this resonate with you?")
    static let interpretationResonateYes = NSLocalizedString("interpretation.resonateYes", comment: "Yes, this speaks to me")
    static let interpretationResonateUnsure = NSLocalizedString("interpretation.resonateUnsure", comment: "I'm not sure")
    static let interpretationResonateNo = NSLocalizedString("interpretation.resonateNo", comment: "This doesn't fit")
    static let interpretationContinue = NSLocalizedString("interpretation.continue", comment: "Continue")
    static let interpretationSeeFullReading = NSLocalizedString("interpretation.seeFullReading", comment: "See Full Reading")

    // MARK: - Summary
    static let summaryYourReading = NSLocalizedString("summary.yourReading", comment: "Your Reading")
    static let summaryOverallInsight = NSLocalizedString("summary.overallInsight", comment: "Overall Insight")
    static let summaryReflections = NSLocalizedString("summary.reflections", comment: "Your Reflections")
    static let summarySaveReading = NSLocalizedString("summary.saveReading", comment: "Save Reading")
    static let summaryReadingSaved = NSLocalizedString("summary.readingSaved", comment: "Reading Saved")
    static let summaryShareReading = NSLocalizedString("summary.shareReading", comment: "Share Reading")
    static let summaryReturnToStart = NSLocalizedString("summary.returnToStart", comment: "Return to Start")
    
    // MARK: - PDF Export
    static let pdfTitle = NSLocalizedString("pdf.title", comment: "TarotGo Reading")
    static let pdfQuestion = NSLocalizedString("pdf.question", comment: "Question:")
    static let pdfCategory = NSLocalizedString("pdf.category", comment: "Category:")
    static let pdfSpread = NSLocalizedString("pdf.spread", comment: "Spread:")
    static let pdfOverallInsight = NSLocalizedString("pdf.overallInsight", comment: "Overall Insight")
    static let pdfCards = NSLocalizedString("pdf.cards", comment: "Cards")
    static let pdfPersonalReflections = NSLocalizedString("pdf.personalReflections", comment: "Personal Reflections")

    // MARK: - History
    static let historyTitle = NSLocalizedString("history.title", comment: "Reading History")
    static let historyFilter = NSLocalizedString("history.filter", comment: "Filter:")
    static let historyAll = NSLocalizedString("history.all", comment: "All")
    static let historyAllReadings = NSLocalizedString("history.allReadings", comment: "All Readings")
    static let historyNoReadings = NSLocalizedString("history.noReadings", comment: "No readings yet")
    static let historyNoReadingsDesc = NSLocalizedString("history.noReadings.desc", comment: "Your saved readings will appear here")
    static let historyDeleteAlert = NSLocalizedString("history.deleteAlert", comment: "Delete Reading")
    static let historyDeleteMessage = NSLocalizedString("history.deleteMessage", comment: "Are you sure you want to delete this reading? This action cannot be undone.")
    static let historyDeleteReading = NSLocalizedString("history.deleteReading", comment: "Delete Reading")
    static let historyNoReflections = NSLocalizedString("history.noReflections", comment: "No reflections added")

    // MARK: - Card of the Day
    static let cardOfDayTitle = NSLocalizedString("cardOfDay.title", comment: "Card of the Day")
    static let cardOfDayCenterYourself = NSLocalizedString("cardOfDay.centerYourself", comment: "Take a moment to center yourself")
    static let cardOfDayInstruction = NSLocalizedString("cardOfDay.instruction", comment: "Place your finger on the card and hold for 5 seconds")
    static let cardOfDayTodaysMessage = NSLocalizedString("cardOfDay.todaysMessage", comment: "Today's Message")
    static let cardOfDayReflect = NSLocalizedString("cardOfDay.reflect", comment: "Reflect")

    // MARK: - Settings
    static let settingsTitle = NSLocalizedString("settings.title", comment: "Settings")
    static let settingsNotifications = NSLocalizedString("settings.notifications", comment: "Notifications")
    static let settingsDailyReminder = NSLocalizedString("settings.dailyReminder", comment: "Daily Card Reminder")
    static let settingsDailyReminderDesc = NSLocalizedString("settings.dailyReminder.desc", comment: "Receive a daily reminder to draw your Card of the Day")
    static let settingsReminderTime = NSLocalizedString("settings.reminderTime", comment: "Reminder Time")
    static let settingsSetReminderTime = NSLocalizedString("settings.setReminderTime", comment: "Set Reminder Time")
    static let settingsAppearance = NSLocalizedString("settings.appearance", comment: "Appearance")
    static let settingsCardBack = NSLocalizedString("settings.cardBack", comment: "Card Back Design")
    static let settingsCardBackDesc = NSLocalizedString("settings.cardBack.desc", comment: "Choose the design for the back of your tarot cards")
    static let settingsCardBackModern = NSLocalizedString("settings.cardBack.modern", comment: "Modern")
    static let settingsCardBackOriginal = NSLocalizedString("settings.cardBack.original", comment: "Original")
    static let settingsCardBackStandard = NSLocalizedString("settings.cardBack.standard", comment: "Standard")
    static let settingsCardBackClassic = NSLocalizedString("settings.cardBack.classic", comment: "Classic")
    static let settingsCardBackModernSubtitle = NSLocalizedString("settings.cardBack.modern.subtitle", comment: "21st Century")
    static let settingsCardBackOriginalSubtitle = NSLocalizedString("settings.cardBack.original.subtitle", comment: "CRACKED ICE (1909)")
    static let settingsCardBackStandardSubtitle = NSLocalizedString("settings.cardBack.standard.subtitle", comment: "TUDOR ROSE")
    static let settingsCardBackClassicSubtitle = NSLocalizedString("settings.cardBack.classic.subtitle", comment: "PLAID")
    static let settingsInfo = NSLocalizedString("settings.info", comment: "Info")
    static let settingsIntroSlides = NSLocalizedString("settings.introSlides", comment: "Intro Slides")
    static let settingsAbout = NSLocalizedString("settings.about", comment: "About")
    static let settingsVersion = NSLocalizedString("settings.version", comment: "Version")
    static let settingsSave = NSLocalizedString("settings.save", comment: "Save")
    static let settingsLanguage = NSLocalizedString("settings.language", comment: "Language")
    static let settingsLanguageDesc = NSLocalizedString("settings.language.desc", comment: "Change the app language in your phone settings")
    
    static let settingsNotificationPermissionTitle = NSLocalizedString("settings.notificationPermission.title", comment: "Notification Permission Required")
    static let settingsNotificationPermissionMessage = NSLocalizedString("settings.notificationPermission.message", comment: "Please enable notifications in Settings to receive daily card reminders")
    static let settingsNotificationPermissionSettings = NSLocalizedString("settings.notificationPermission.settings", comment: "Open Settings")
    static let settingsNotificationPermissionCancel = NSLocalizedString("settings.notificationPermission.cancel", comment: "Cancel")
    
    static let settingsLegal = NSLocalizedString("settings.legal", comment: "Legal")
    static let settingsPrivacyPolicy = NSLocalizedString("settings.privacyPolicy", comment: "Privacy Policy")
    static let settingsTermsOfService = NSLocalizedString("settings.termsOfService", comment: "Terms of Service")

    // MARK: - Spread Types
    static let spreadSingleCard = NSLocalizedString("spread.singleCard", comment: "Single Card")
    static let spreadThreeCard = NSLocalizedString("spread.threeCard", comment: "Three Card Spread")
    static let spreadCelticCross = NSLocalizedString("spread.celticCross", comment: "Celtic Cross")
    static let spreadRelationship = NSLocalizedString("spread.relationship", comment: "Relationship Spread")
    static let spreadLoveTriangle = NSLocalizedString("spread.loveTriangle", comment: "Love Triangle")
    static let spreadCareerPath = NSLocalizedString("spread.careerPath", comment: "Career Path")

    // MARK: - Spread Positions
    static let positionPast = NSLocalizedString("position.past", comment: "Past")
    static let positionPastDesc = NSLocalizedString("position.past.desc", comment: "What has brought you to this moment")
    static let positionPresent = NSLocalizedString("position.present", comment: "Present")
    static let positionPresentDesc = NSLocalizedString("position.present.desc", comment: "Where you are right now")
    static let positionFuture = NSLocalizedString("position.future", comment: "Future")
    static let positionFutureDesc = NSLocalizedString("position.future.desc", comment: "What is unfolding ahead")

    // Three Card Spread
    static let positionPastShort = NSLocalizedString("position.past.short", comment: "Past")
    static let positionPastShortDesc = NSLocalizedString("position.past.short.desc", comment: "What brought you here")
    static let positionPresentShort = NSLocalizedString("position.present.short", comment: "Present")
    static let positionPresentShortDesc = NSLocalizedString("position.present.short.desc", comment: "Your current situation")
    static let positionFutureShort = NSLocalizedString("position.future.short", comment: "Future")
    static let positionFutureShortDesc = NSLocalizedString("position.future.short.desc", comment: "What's coming")

    // Celtic Cross
    static let positionChallenge = NSLocalizedString("position.challenge", comment: "Challenge")
    static let positionChallengeDesc = NSLocalizedString("position.challenge.desc", comment: "What crosses you")
    static let positionFoundation = NSLocalizedString("position.foundation", comment: "Past")
    static let positionFoundationDesc = NSLocalizedString("position.foundation.desc", comment: "Foundation of the situation")
    static let positionApproaching = NSLocalizedString("position.approaching", comment: "Future")
    static let positionApproachingDesc = NSLocalizedString("position.approaching.desc", comment: "What's approaching")
    static let positionAbove = NSLocalizedString("position.above", comment: "Above")
    static let positionAboveDesc = NSLocalizedString("position.above.desc", comment: "Your goal or aspiration")
    static let positionBelow = NSLocalizedString("position.below", comment: "Below")
    static let positionBelowDesc = NSLocalizedString("position.below.desc", comment: "Unconscious influences")
    static let positionAdvice = NSLocalizedString("position.advice", comment: "Advice")
    static let positionAdviceDesc = NSLocalizedString("position.advice.desc", comment: "Your best approach")
    static let positionExternal = NSLocalizedString("position.external", comment: "External")
    static let positionExternalDesc = NSLocalizedString("position.external.desc", comment: "Outside influences")
    static let positionHopes = NSLocalizedString("position.hopes", comment: "Hopes & Fears")
    static let positionHopesDesc = NSLocalizedString("position.hopes.desc", comment: "Your inner emotions")
    static let positionOutcome = NSLocalizedString("position.outcome", comment: "Outcome")
    static let positionOutcomeDesc = NSLocalizedString("position.outcome.desc", comment: "Final result")

    // Love Triangle
    static let positionYou = NSLocalizedString("position.you", comment: "You")
    static let positionYouDesc = NSLocalizedString("position.you.desc", comment: "Your emotional state")
    static let positionThem = NSLocalizedString("position.them", comment: "Them")
    static let positionThemDesc = NSLocalizedString("position.them.desc", comment: "Their emotional state")
    static let positionConnection = NSLocalizedString("position.connection", comment: "Connection")
    static let positionConnectionDesc = NSLocalizedString("position.connection.desc", comment: "The relationship dynamic")

    // Career Path
    static let positionCurrent = NSLocalizedString("position.current", comment: "Current Situation")
    static let positionCurrentDesc = NSLocalizedString("position.current.desc", comment: "Where you are now")
    static let positionObstacles = NSLocalizedString("position.obstacles", comment: "Obstacles")
    static let positionObstaclesDesc = NSLocalizedString("position.obstacles.desc", comment: "What's blocking you")
    static let positionStrengths = NSLocalizedString("position.strengths", comment: "Strengths")
    static let positionStrengthsDesc = NSLocalizedString("position.strengths.desc", comment: "Your assets")
    static let positionAction = NSLocalizedString("position.action", comment: "Action")
    static let positionActionDesc = NSLocalizedString("position.action.desc", comment: "What to do next")
    static let positionCareerOutcome = NSLocalizedString("position.careerOutcome", comment: "Outcome")
    static let positionCareerOutcomeDesc = NSLocalizedString("position.careerOutcome.desc", comment: "Potential result")

    // MARK: - Card Dictionary
    static let dictionaryTitle = NSLocalizedString("dictionary.title", comment: "Card Dictionary")
    static let dictionarySubtitle = NSLocalizedString("dictionary.subtitle", comment: "Explore all 78 tarot cards")
    static let dictionarySearchPlaceholder = NSLocalizedString("dictionary.searchPlaceholder", comment: "Search cards...")
    static let dictionaryAllCards = NSLocalizedString("dictionary.allCards", comment: "All Cards")
    static let dictionaryUpright = NSLocalizedString("dictionary.upright", comment: "Upright")
    static let dictionaryReversed = NSLocalizedString("dictionary.reversed", comment: "Reversed")
    static let dictionaryKeywords = NSLocalizedString("dictionary.keywords", comment: "Keywords")
    static let dictionaryMeanings = NSLocalizedString("dictionary.meanings", comment: "Meanings")
    static let dictionaryGeneral = NSLocalizedString("dictionary.general", comment: "General")

    // MARK: - Reading Count
    static func readingCount(_ count: Int) -> String {
        String(format: NSLocalizedString("history.readingCountFormat", comment: "reading count format"), count)
    }

    // MARK: - Card Position Format
    static func cardPosition(_ current: Int, _ total: Int) -> String {
        String(format: NSLocalizedString("selection.cardPositionFormat", comment: "Card X of Y"), current, total)
    }
    
    // MARK: - Tarot Card Interpretations
    /// Get a localized interpretation for a tarot card
    /// - Parameter key: The interpretation key (e.g., "the_fool_love_upright")
    /// - Returns: The localized interpretation text
    static func interpretation(_ key: String) -> String {
        NSLocalizedString("interpretation.\(key)", comment: "Interpretation for \(key)")
    }
    
    // MARK: - Spread Summary Components
    
    // Opening insights based on spread composition
    static func summaryMajorArcanaHigh(_ count: Int) -> String {
        String(format: NSLocalizedString("summary.majorArcana.high", comment: "Major Arcana cards appear"), count)
    }
    
    static let summaryMajorArcanaLow = NSLocalizedString("summary.majorArcana.low", comment: "The cards focus on everyday matters")
    
    static let summaryReversedMany = NSLocalizedString("summary.reversed.many", comment: "Many reversed cards suggest blocks")
    
    static let summaryReversedSome = NSLocalizedString("summary.reversed.some", comment: "Some reversed cards indicate areas needing attention")
    
    static let summaryReversedNone = NSLocalizedString("summary.reversed.none", comment: "All cards upright show clear forward energy")
    
    // Suit insights - Always shows dominant or balanced energy
    static let summarySuitCupsDominant = NSLocalizedString("summary.suit.cups.dominant", comment: "Cups dominate - emotions and relationships")
    
    static let summarySuitSwordsDominant = NSLocalizedString("summary.suit.swords.dominant", comment: "Swords dominate - mental energy and thoughts")
    
    static let summarySuitWandsDominant = NSLocalizedString("summary.suit.wands.dominant", comment: "Wands dominate - passion and creative energy")
    
    static let summarySuitPentaclesDominant = NSLocalizedString("summary.suit.pentacles.dominant", comment: "Pentacles dominate - material and practical matters")
    
    static let summarySuitMajorArcanaDominant = NSLocalizedString("summary.suit.majorArcana.dominant", comment: "Major Arcana dominates - soul journey")
    
    static let summarySuitBalanced = NSLocalizedString("summary.suit.balanced", comment: "Balanced mix of suits shows multi-faceted situation")
    
    // Category-specific insights - Richer context
    static let summaryInsightLove = NSLocalizedString("summary.insight.love", comment: "In matters of love and relationships")
    
    static let summaryInsightCareer = NSLocalizedString("summary.insight.career", comment: "Regarding your career and professional path")
    
    static let summaryInsightFinance = NSLocalizedString("summary.insight.finance", comment: "When it comes to finances and resources")
    
    static let summaryInsightHealth = NSLocalizedString("summary.insight.health", comment: "For your health and wellbeing")
    
    static let summaryInsightGeneral = NSLocalizedString("summary.insight.general", comment: "Looking at your life journey")
    
    // Closing statements - 10 variations for variety
    static let summaryClosing1 = NSLocalizedString("summary.closing.1", comment: "these cards are telling a story that requires your attention and honest reflection.")
    static let summaryClosing2 = NSLocalizedString("summary.closing.2", comment: "pay attention to how these energies are showing up in your life right now.")
    static let summaryClosing3 = NSLocalizedString("summary.closing.3", comment: "the cards invite you to sit with these insights and see what resonates.")
    static let summaryClosing4 = NSLocalizedString("summary.closing.4", comment: "trust your intuition as you interpret what the cards are revealing.")
    static let summaryClosing5 = NSLocalizedString("summary.closing.5", comment: "these messages are here to guide you forward with greater clarity.")
    static let summaryClosing6 = NSLocalizedString("summary.closing.6", comment: "reflect on how these themes are interwoven in your current situation.")
    static let summaryClosing7 = NSLocalizedString("summary.closing.7", comment: "the wisdom here asks you to look deeper and trust what you discover.")
    static let summaryClosing8 = NSLocalizedString("summary.closing.8", comment: "let these insights illuminate the path ahead as you move forward.")
    static let summaryClosing9 = NSLocalizedString("summary.closing.9", comment: "take time to absorb what the cards are showing you in this moment.")
    static let summaryClosing10 = NSLocalizedString("summary.closing.10", comment: "the cards have spoken—now it's time to listen with an open heart.")
    
    // Get a deterministic closing statement based on category and last card orientation
    static func closingForReading(category: IntentionCategory, lastCardReversed: Bool) -> String {
        // Map each category + reversed state to a specific closing (10 total combinations)
        switch (category, lastCardReversed) {
        case (.love, false):
            return summaryClosing1
        case (.love, true):
            return summaryClosing2
        case (.career, false):
            return summaryClosing3
        case (.career, true):
            return summaryClosing4
        case (.finance, false):
            return summaryClosing5
        case (.finance, true):
            return summaryClosing6
        case (.health, false):
            return summaryClosing7
        case (.health, true):
            return summaryClosing8
        case (.general, false):
            return summaryClosing9
        case (.general, true):
            return summaryClosing10
        }
    }
}
