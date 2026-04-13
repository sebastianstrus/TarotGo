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

    // MARK: - History
    static let historyTitle = NSLocalizedString("history.title", comment: "Reading History")
    static let historyFilter = NSLocalizedString("history.filter", comment: "Filter:")
    static let historyAll = NSLocalizedString("history.all", comment: "All")
    static let historyNoReadings = NSLocalizedString("history.noReadings", comment: "No readings yet")
    static let historyNoReadingsDesc = NSLocalizedString("history.noReadings.desc", comment: "Your saved readings will appear here")
    static let historyReadingCount = NSLocalizedString("history.readingCount", comment: "%d reading(s)")
    static let historyDeleteAlert = NSLocalizedString("history.deleteAlert", comment: "Delete Reading")
    static let historyDeleteMessage = NSLocalizedString("history.deleteMessage", comment: "Are you sure you want to delete this reading? This action cannot be undone.")
    static let historyDeleteReading = NSLocalizedString("history.deleteReading", comment: "Delete Reading")
    static let historyNoReflections = NSLocalizedString("history.noReflections", comment: "No reflections added")

    // MARK: - Card of the Day
    static let cardOfDayTitle = NSLocalizedString("cardOfDay.title", comment: "Card of the Day")
    static let cardOfDayCenterYourself = NSLocalizedString("cardOfDay.centerYourself", comment: "Take a moment to center yourself")
    static let cardOfDayInstruction = NSLocalizedString("cardOfDay.instruction", comment: "Place your finger on the card and hold for 3 seconds")
    static let cardOfDayTodaysMessage = NSLocalizedString("cardOfDay.todaysMessage", comment: "Today's Message")
    static let cardOfDayReflect = NSLocalizedString("cardOfDay.reflect", comment: "Reflect")

    // MARK: - Settings
    static let settingsTitle = NSLocalizedString("settings.title", comment: "Settings")
    static let settingsNotifications = NSLocalizedString("settings.notifications", comment: "Notifications")
    static let settingsDailyReminder = NSLocalizedString("settings.dailyReminder", comment: "Daily Card Reminder")
    static let settingsDailyReminderDesc = NSLocalizedString("settings.dailyReminder.desc", comment: "Receive a daily reminder to draw your Card of the Day")
    static let settingsReminderTime = NSLocalizedString("settings.reminderTime", comment: "Reminder Time")
    static let settingsSetReminderTime = NSLocalizedString("settings.setReminderTime", comment: "Set Reminder Time")
    static let settingsAbout = NSLocalizedString("settings.about", comment: "About")
    static let settingsVersion = NSLocalizedString("settings.version", comment: "Version")

    // MARK: - Spread Types
    static let spreadSingleCard = NSLocalizedString("spread.singleCard", comment: "Single Card")
    static let spreadThreeCard = NSLocalizedString("spread.threeCard", comment: "Three Card Spread")
    static let spreadCelticCross = NSLocalizedString("spread.celticCross", comment: "Celtic Cross")
    static let spreadRelationship = NSLocalizedString("spread.relationship", comment: "Relationship Spread")

    // MARK: - Spread Positions
    static let positionPast = NSLocalizedString("position.past", comment: "Past")
    static let positionPastDesc = NSLocalizedString("position.past.desc", comment: "What has brought you to this moment")
    static let positionPresent = NSLocalizedString("position.present", comment: "Present")
    static let positionPresentDesc = NSLocalizedString("position.present.desc", comment: "Where you are right now")
    static let positionFuture = NSLocalizedString("position.future", comment: "Future")
    static let positionFutureDesc = NSLocalizedString("position.future.desc", comment: "What is unfolding ahead")
}
