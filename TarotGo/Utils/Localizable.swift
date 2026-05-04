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

    static let homeDestinyMatrix = NSLocalizedString("home.destinyMatrix", comment: "Destiny Matrix")
    static let homeDestinyMatrixSubtitle = NSLocalizedString("home.destinyMatrix.subtitle", comment: "Discover your life's blueprint")
    
    static let homeCardDictionary = NSLocalizedString("home.cardDictionary", comment: "Card Dictionary")
    static let homeCardDictionarySubtitle = NSLocalizedString("home.cardDictionary.subtitle", comment: "Explore all 78 tarot cards")
    
    static let homeSettings = NSLocalizedString("home.settings", comment: "Settings")
    static let homeSettingsSubtitle = NSLocalizedString("home.settings.subtitle", comment: "Configure notifications and preferences")

    // MARK: - Destiny Matrix
    static let matrixTitle = NSLocalizedString("matrix.title", comment: "Destiny Matrix")
    static let matrixSubtitle = NSLocalizedString("matrix.subtitle", comment: "Your Personal Energy Map")
    static let matrixWhatIs = NSLocalizedString("matrix.whatIs", comment: "What is Destiny Matrix?")
    static let matrixDescription = NSLocalizedString("matrix.description", comment: "Destiny Matrix is a numerology system that maps the energies of your birth date to the 22 Major Arcana cards of the Tarot. Each position reveals different aspects of your life path, talents, and purpose.")
    static let matrixEnterBirthDate = NSLocalizedString("matrix.enterBirthDate", comment: "Enter Your Birth Date")
    static let matrixBirthDate = NSLocalizedString("matrix.birthDate", comment: "Birth Date")
    static let matrixCalculate = NSLocalizedString("matrix.calculate", comment: "Calculate My Matrix")
    
    static let matrixYourMatrix = NSLocalizedString("matrix.yourMatrix", comment: "Your Destiny Matrix")
    static let matrixTapCircle = NSLocalizedString("matrix.tapCircle", comment: "Tap any circle to see its meaning")
    static let matrixSelectedPosition = NSLocalizedString("matrix.selectedPosition", comment: "Selected Position")
    static let matrixNumber = NSLocalizedString("matrix.number", comment: "Number")
    static let matrixAssociatedCard = NSLocalizedString("matrix.associatedCard", comment: "Associated Tarot Card")
    
    static let matrixTabDiagram = NSLocalizedString("matrix.tab.diagram", comment: "Diagram")
    static let matrixTabPositions = NSLocalizedString("matrix.tab.positions", comment: "Positions")
    static let matrixTabCards = NSLocalizedString("matrix.tab.cards", comment: "Cards")
    
    static let matrixViewCardDetails = NSLocalizedString("matrix.viewCardDetails", comment: "View Card Details")
    static let matrixUniqueCards = NSLocalizedString("matrix.uniqueCards", comment: "Unique Cards in Your Matrix")
    static let matrixAllPositions = NSLocalizedString("matrix.allPositions", comment: "All 19 Positions")
    
    // Matrix Position Names
    static let matrixCenter = NSLocalizedString("matrix.position.center", comment: "Center")
    static let matrixCenterDesc = NSLocalizedString("matrix.position.center.desc", comment: "Your core essence and life purpose")
    
    static let matrixPersonalPower = NSLocalizedString("matrix.position.personalPower", comment: "Personal Power")
    static let matrixPersonalPowerDesc = NSLocalizedString("matrix.position.personalPower.desc", comment: "Your inner strength and personal authority")
    
    static let matrixSocialRealization = NSLocalizedString("matrix.position.socialRealization", comment: "Social Realization")
    static let matrixSocialRealizationDesc = NSLocalizedString("matrix.position.socialRealization.desc", comment: "How you express yourself in society")
    
    static let matrixSpiritualDevelopment = NSLocalizedString("matrix.position.spiritualDevelopment", comment: "Spiritual Development")
    static let matrixSpiritualDevelopmentDesc = NSLocalizedString("matrix.position.spiritualDevelopment.desc", comment: "Your spiritual path and growth")
    
    static let matrixPlanetaryInfluence = NSLocalizedString("matrix.position.planetaryInfluence", comment: "Planetary Influence")
    static let matrixPlanetaryInfluenceDesc = NSLocalizedString("matrix.position.planetaryInfluence.desc", comment: "External forces and cosmic energies affecting you")
    
    static let matrixMoney = NSLocalizedString("matrix.position.money", comment: "Money & Abundance")
    static let matrixMoneyDesc = NSLocalizedString("matrix.position.money.desc", comment: "Your relationship with material resources")
    
    static let matrixRelationships = NSLocalizedString("matrix.position.relationships", comment: "Relationships")
    static let matrixRelationshipsDesc = NSLocalizedString("matrix.position.relationships.desc", comment: "Your connection patterns with others")
    
    static let matrixTalents = NSLocalizedString("matrix.position.talents", comment: "Talents & Gifts")
    static let matrixTalentsDesc = NSLocalizedString("matrix.position.talents.desc", comment: "Your natural abilities and strengths")
    
    static let matrixPurpose = NSLocalizedString("matrix.position.purpose", comment: "Life Purpose")
    static let matrixPurposeDesc = NSLocalizedString("matrix.position.purpose.desc", comment: "Your mission and calling in life")
    
    static let matrixHealth = NSLocalizedString("matrix.position.health", comment: "Health & Vitality")
    static let matrixHealthDesc = NSLocalizedString("matrix.position.health.desc", comment: "Physical and energetic wellbeing")
    
    static let matrixKarma = NSLocalizedString("matrix.position.karma", comment: "Karmic Path")
    static let matrixKarmaDesc = NSLocalizedString("matrix.position.karma.desc", comment: "Lessons from past and what you're here to resolve")
    
    static let matrixMale = NSLocalizedString("matrix.position.male", comment: "Masculine Energy")
    static let matrixMaleDesc = NSLocalizedString("matrix.position.male.desc", comment: "Your active, yang, outward-directed energy")
    
    static let matrixFemale = NSLocalizedString("matrix.position.female", comment: "Feminine Energy")
    static let matrixFemaleDesc = NSLocalizedString("matrix.position.female.desc", comment: "Your receptive, yin, inward-directed energy")
    
    static let matrixSky = NSLocalizedString("matrix.position.sky", comment: "Sky Line")
    static let matrixSkyDesc = NSLocalizedString("matrix.position.sky.desc", comment: "Your higher aspirations and ideals")
    
    static let matrixEarth = NSLocalizedString("matrix.position.earth", comment: "Earth Line")
    static let matrixEarthDesc = NSLocalizedString("matrix.position.earth.desc", comment: "Your grounding and practical foundation")
    
    static let matrixComfort = NSLocalizedString("matrix.position.comfort", comment: "Comfort Zone")
    static let matrixComfortDesc = NSLocalizedString("matrix.position.comfort.desc", comment: "What feels natural and easy for you")
    
    static let matrixPast = NSLocalizedString("matrix.position.past", comment: "Past Influence")
    static let matrixPastDesc = NSLocalizedString("matrix.position.past.desc", comment: "Energies from your past shaping the present")
    
    static let matrixPresent = NSLocalizedString("matrix.position.present", comment: "Present Moment")
    static let matrixPresentDesc = NSLocalizedString("matrix.position.present.desc", comment: "Your current life situation and focus")
    
    static let matrixFuture = NSLocalizedString("matrix.position.future", comment: "Future Potential")
    static let matrixFutureDesc = NSLocalizedString("matrix.position.future.desc", comment: "Where your energy is headed")

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
    
    // MARK: - Learn Tarot
    // Main Learn View
    static let homeLearnTarot = NSLocalizedString("home.learnTarot", comment: "Learn Tarot")
    static let homeLearnTarotSubtitle = NSLocalizedString("home.learnTarot.subtitle", comment: "Understand cards, meanings and history")
    
    static let learnTarotTitle = NSLocalizedString("learn.title", comment: "Learn Tarot")
    static let learnTarotSubtitle = NSLocalizedString("learn.subtitle", comment: "Deepen your understanding")
    
    // Learn Options
    static let learnHistoryTitle = NSLocalizedString("learn.history.title", comment: "History of Tarot")
    static let learnHistorySubtitle = NSLocalizedString("learn.history.subtitle", comment: "Origins and evolution")
    
    static let learnBasicMeaningsTitle = NSLocalizedString("learn.basicMeanings.title", comment: "Card Basic Meanings")
    static let learnBasicMeaningsSubtitle = NSLocalizedString("learn.basicMeanings.subtitle", comment: "Understand the cards")
    
    static let learnHowToReadTitle = NSLocalizedString("learn.howToRead.title", comment: "How to Read")
    static let learnHowToReadSubtitle = NSLocalizedString("learn.howToRead.subtitle", comment: "Master the practice")
    
    static let learnTarotMindTitle = NSLocalizedString("learn.tarotMind.title", comment: "Tarot & Mind")
    static let learnTarotMindSubtitle = NSLocalizedString("learn.tarotMind.subtitle", comment: "Inner growth tool")
    
    static let learnFaqTitle = NSLocalizedString("learn.faq.title", comment: "FAQ")
    static let learnFaqSubtitle = NSLocalizedString("learn.faq.subtitle", comment: "Common questions")
    
    // History of Tarot View
    static let historyOfTarotTitle = NSLocalizedString("history.page.title", comment: "History of Tarot")
    static let historySubtitle = NSLocalizedString("history.page.subtitle", comment: "The Origins of Tarot: From Games to Symbolism")
    static let historyIntro = NSLocalizedString("history.intro", comment: "The history of Tarot is a fascinating journey that began not with mysticism, but with the simple joy of gameplay. While many associate the cards with ancient mystery, their documented roots lie in the courts of Renaissance Italy and the evolution of international card games.")
    
    static let historyEvolutionTitle = NSLocalizedString("history.evolution.title", comment: "The Evolution of Playing Cards")
    static let historyEvolutionIntro = NSLocalizedString("history.evolution.intro", comment: "Before the first 'Tarot' deck existed, standard playing cards had already taken Europe by storm.")
    
    static let historyMamlukTitle = NSLocalizedString("history.mamluk.title", comment: "The Mamluk Connection")
    static let historyMamlukText = NSLocalizedString("history.mamluk.text", comment: "Most scholars agree that European playing cards were adapted from the Egyptian Mamluk deck in the 14th century. These early decks arrived alongside the introduction of paper from Asia.")
    
    static let historySpreadTitle = NSLocalizedString("history.spread.title", comment: "Rapid Spread")
    static let historySpreadText = NSLocalizedString("history.spread.text", comment: "By the late 1300s, cards were so popular that records of them appear across Europe—often in the form of legal bans. In 1377, a monk named John of Rheinfelden described a basic pack of four suits with 13 cards each, very similar to the structure we use today.")
    
    static let historySuitsTitle = NSLocalizedString("history.suits.title", comment: "Original Suits")
    static let historySuitsText = NSLocalizedString("history.suits.text", comment: "The early 'Latin' suits consisted of Swords, Batons (Clubs), Cups, and Coins. While most modern playing cards use French suits (Spades, Hearts, etc.), Tarot has preserved these original symbols for over six centuries.")
    
    static let historyBirthTitle = NSLocalizedString("history.birth.title", comment: "The Birth of 'Tarocchi'")
    static let historyBirthIntro = NSLocalizedString("history.birth.intro", comment: "Tarot as we know it emerged in Northern Italy—specifically in Milan and Ferrara—during the early 15th century. At the time, these cards were called tarocchi or trionfi (triumphs).")
    
    static let historyTrumpsTitle = NSLocalizedString("history.trumps.title", comment: "The Addition of Trumps")
    static let historyTrumpsIntro = NSLocalizedString("history.trumps.intro", comment: "The revolutionary change was the addition of a Fool and 21 'trump' cards to the standard four-suit deck. These trumps were essentially a permanent suit of higher-ranking cards used for a game similar to modern Bridge.")
    
    static let historyViscontiTitle = NSLocalizedString("history.visconti.title", comment: "The Visconti-Sforza Legacy")
    static let historyViscontiText = NSLocalizedString("history.visconti.text", comment: "Some of the earliest and most beautiful examples come from the mid-1400s, commissioned by the Duke of Milan. These hand-painted decks often featured gold leaf and reflected the high fashion of the Italian nobility.")
    
    static let historyClassicalTitle = NSLocalizedString("history.classical.title", comment: "Classical Influence")
    static let historyClassicalText = NSLocalizedString("history.classical.text", comment: "Early decks weren't always standardized. For example, a deck commissioned by Duke Filippo Maria Visconti featured images of Roman gods and suits depicted as birds, showcasing the Renaissance obsession with classical motifs.")
    
    // Timeline Table
    static let historyTimelineTitle = NSLocalizedString("history.timeline.title", comment: "Timeline")
    static let historyTimelineEraHeader = NSLocalizedString("history.timeline.era", comment: "Era")
    static let historyTimelineMilestoneHeader = NSLocalizedString("history.timeline.milestone", comment: "Milestone")
    
    static let historyTimelineEra1 = NSLocalizedString("history.timeline.era1", comment: "Pre-14th Century")
    static let historyTimelineMilestone1 = NSLocalizedString("history.timeline.milestone1", comment: "Mamluk decks from Egypt introduce the four-suit system to Europe.")
    
    static let historyTimelineEra2 = NSLocalizedString("history.timeline.era2", comment: "1367–1377")
    static let historyTimelineMilestone2 = NSLocalizedString("history.timeline.milestone2", comment: "First European records of playing cards appear in Switzerland and Germany.")
    
    static let historyTimelineEra3 = NSLocalizedString("history.timeline.era3", comment: "1418–1450")
    static let historyTimelineMilestone3 = NSLocalizedString("history.timeline.milestone3", comment: "The first \"Triumph\" (Tarot) decks are created in Milan and Ferrara.")
    
    static let historyTimelineEra4 = NSLocalizedString("history.timeline.era4", comment: "Late 1400s")
    static let historyTimelineMilestone4 = NSLocalizedString("history.timeline.milestone4", comment: "Decks like the Sola Busca begin to incorporate intricate, classical illustrations for all cards.")
    
    static let historyTimelineEra5 = NSLocalizedString("history.timeline.era5", comment: "Late 18th Century")
    static let historyTimelineMilestone5 = NSLocalizedString("history.timeline.milestone5", comment: "Tarot begins its transition from a parlor game to a tool for divination and occult study.")
    
    // Card Basic Meanings View
    static let basicMeaningsTitle = NSLocalizedString("basicMeanings.title", comment: "Card Basic Meanings")
    static let basicMeaningsSubtitle = NSLocalizedString("basicMeanings.subtitle", comment: "Understanding the Tarot Deck")
    static let basicMeaningsIntro = NSLocalizedString("basicMeanings.intro", comment: "Each tarot card carries a unique message expressed through symbols and imagery.")
    
    static let basicMeaningsMajorTitle = NSLocalizedString("basicMeanings.major.title", comment: "Major Arcana (22 cards)")
    static let basicMeaningsMajorText = NSLocalizedString("basicMeanings.major.text", comment: "Represent major life events and deep transformations. They reflect important turning points and lessons.")
    
    static let basicMeaningsMinorTitle = NSLocalizedString("basicMeanings.minor.title", comment: "Minor Arcana (56 cards)")
    static let basicMeaningsMinorText = NSLocalizedString("basicMeanings.minor.text", comment: "Reflect everyday experiences and situations.")
    
    static let basicMeaningsCupsTitle = NSLocalizedString("basicMeanings.cups.title", comment: "Cups")
    static let basicMeaningsCupsSubtitle = NSLocalizedString("basicMeanings.cups.subtitle", comment: "Emotions & relationships")
    
    static let basicMeaningsPentaclesTitle = NSLocalizedString("basicMeanings.pentacles.title", comment: "Pentacles")
    static let basicMeaningsPentaclesSubtitle = NSLocalizedString("basicMeanings.pentacles.subtitle", comment: "Money & work")
    
    static let basicMeaningsSwordsTitle = NSLocalizedString("basicMeanings.swords.title", comment: "Swords")
    static let basicMeaningsSwordsSubtitle = NSLocalizedString("basicMeanings.swords.subtitle", comment: "Thoughts & challenges")
    
    static let basicMeaningsWandsTitle = NSLocalizedString("basicMeanings.wands.title", comment: "Wands")
    static let basicMeaningsWandsSubtitle = NSLocalizedString("basicMeanings.wands.subtitle", comment: "Energy & action")
    
    static let basicMeaningsConclusion = NSLocalizedString("basicMeanings.conclusion", comment: "There is no single correct interpretation. Meaning depends on context and intuition.")
    
    // How to Read View
    static let howToReadTitle = NSLocalizedString("howToRead.title", comment: "How to Read Tarot")
    
    static let howToReadStep1Title = NSLocalizedString("howToRead.step1.title", comment: "Focus on Your Question (Intention)")
    static let howToReadStep1Intro = NSLocalizedString("howToRead.step1.intro", comment: "Before you touch the cards, quiet your mind. Tarot works best with open-ended questions that give you room to take action.")
    static let howToReadStep1Example = NSLocalizedString("howToRead.step1.example", comment: "Instead of asking: 'Will I get this job?' (a closed yes/no question). Ask: 'What do I need to know about this career path?' or 'How can I best prepare for the interview?'.")
    static let howToReadStep1ProTip = NSLocalizedString("howToRead.step1.proTip", comment: "Frame your questions starting with 'How,' 'What,' or 'Why.'")
    
    static let howToReadStep2Title = NSLocalizedString("howToRead.step2.title", comment: "Draw Your Cards (Intuition in Action)")
    static let howToReadStep2Intro = NSLocalizedString("howToRead.step2.intro", comment: "Shuffle the deck in a way that feels natural to you. There is no 'wrong' method—you can cut the deck, spread them in a fan, or simply mix them on the table.")
    static let howToReadStep2Bullet1Title = NSLocalizedString("howToRead.step2.bullet1.title", comment: "Trust your impulse")
    static let howToReadStep2Bullet1Text = NSLocalizedString("howToRead.step2.bullet1.text", comment: "Choose the cards that 'catch your eye' or those where you feel a slight tingling in your hands.")
    static let howToReadStep2Bullet2Title = NSLocalizedString("howToRead.step2.bullet2.title", comment: "Simple spread")
    static let howToReadStep2Bullet2Text = NSLocalizedString("howToRead.step2.bullet2.text", comment: "To start, pull one card (as the energy of the day) or three (representing Past, Present, and Future).")
    
    static let howToReadStep3Title = NSLocalizedString("howToRead.step3.title", comment: "Interpret the Message (Connecting the Dots)")
    static let howToReadStep3Intro = NSLocalizedString("howToRead.step3.intro", comment: "This is the moment where images turn into a story. You don't have to rush to a guidebook right away.")
    static let howToReadStep3Bullet1Title = NSLocalizedString("howToRead.step3.bullet1.title", comment: "First impression")
    static let howToReadStep3Bullet1Text = NSLocalizedString("howToRead.step3.bullet1.text", comment: "What is happening in the picture? What emotions does this card evoke? Is the figure sad or victorious?")
    static let howToReadStep3Bullet2Title = NSLocalizedString("howToRead.step3.bullet2.title", comment: "Symbolism and context")
    static let howToReadStep3Bullet2Text = NSLocalizedString("howToRead.step3.bullet2.text", comment: "Check the traditional meaning, but also look at how the cards sit next to each other. Does the neighboring card strengthen the message or contradict it?")
    static let howToReadStep3ProTip = NSLocalizedString("howToRead.step3.proTip", comment: "Treat the cards like frames in a movie—what happened a moment ago, and what will happen next?")
    
    static let howToReadStep4Title = NSLocalizedString("howToRead.step4.title", comment: "Reflect (Your Personal Power)")
    static let howToReadStep4Intro = NSLocalizedString("howToRead.step4.intro", comment: "Tarot is not a sentence; it is a roadmap. The cards show the most likely scenario based on your current energy.")
    static let howToReadStep4Bullet1Title = NSLocalizedString("howToRead.step4.bullet1.title", comment: "No fixed answers")
    static let howToReadStep4Bullet1Text = NSLocalizedString("howToRead.step4.bullet1.text", comment: "If you don't like the outcome, treat it as a warning. You have the free will to change your approach.")
    static let howToReadStep4Bullet2Title = NSLocalizedString("howToRead.step4.bullet2.title", comment: "Life application")
    static let howToReadStep4Bullet2Text = NSLocalizedString("howToRead.step4.bullet2.text", comment: "Ask yourself: 'What is one small step I can take today based on this lesson?'.")
    
    static let howToReadRememberTitle = NSLocalizedString("howToRead.remember.title", comment: "Remember")
    static let howToReadRememberText = NSLocalizedString("howToRead.remember.text", comment: "Tarot is a mirror of your subconscious. The more often you work with it, the clearer the reflection becomes.")
    static let howToReadProTipLabel = NSLocalizedString("howToRead.proTip.label", comment: "Pro Tip:")
    
    // Tarot & Mind View
    static let tarotMindTitle = NSLocalizedString("tarotMind.title", comment: "Tarot & Mind")
    static let tarotMindSubtitle = NSLocalizedString("tarotMind.subtitle", comment: "A Tool for Inner Growth")
    
    static let tarotMindSection1Title = NSLocalizedString("tarotMind.section1.title", comment: "Tarot as a Mirror for Self-Reflection")
    static let tarotMindSection1Text = NSLocalizedString("tarotMind.section1.text", comment: "Tarot acts as a bridge between your conscious mind and your subconscious. When you look at a card, your brain naturally seeks patterns and meanings that resonate with your current life situation. It doesn't tell you what to do—it reflects what is already inside you, waiting to be acknowledged.")
    
    static let tarotMindSection2Title = NSLocalizedString("tarotMind.section2.title", comment: "Universal Archetypes and Emotions")
    static let tarotMindSection2Text = NSLocalizedString("tarotMind.section2.text", comment: "The images on the cards are not just random drawings; they represent archetypes—universal human experiences such as love, loss, conflict, victory, and transition.")
    static let tarotMindSection2Insight = NSLocalizedString("tarotMind.section2.insight", comment: "Whether it's the joy of the Sun or the heartbreak of the Three of Swords, these symbols tap into collective human emotions, helping you realize that your struggles and triumphs are part of a larger human story.")
    
    static let tarotMindSection3Title = NSLocalizedString("tarotMind.section3.title", comment: "Understanding Thoughts and Decisions")
    static let tarotMindSection3Intro = NSLocalizedString("tarotMind.section3.intro", comment: "Sometimes we feel stuck because of 'mental clutter.' Tarot helps you organize your internal world by:")
    static let tarotMindSection3Bullet1Title = NSLocalizedString("tarotMind.section3.bullet1.title", comment: "Externalizing Feelings")
    static let tarotMindSection3Bullet1Text = NSLocalizedString("tarotMind.section3.bullet1.text", comment: "Seeing a problem represented on a card makes it feel more manageable and less personal.")
    static let tarotMindSection3Bullet2Title = NSLocalizedString("tarotMind.section3.bullet2.title", comment: "Breaking Patterns")
    static let tarotMindSection3Bullet2Text = NSLocalizedString("tarotMind.section3.bullet2.text", comment: "It helps you identify recurring thoughts or behaviors that might be holding you back, allowing you to make more conscious, empowered decisions.")
    
    static let tarotMindSection4Title = NSLocalizedString("tarotMind.section4.title", comment: "Tarot as a Mindfulness Practice")
    static let tarotMindSection4Intro = NSLocalizedString("tarotMind.section4.intro", comment: "Integrating Tarot into your daily routine can be a grounding ritual in a fast-paced world.")
    static let tarotMindSection4Bullet1Title = NSLocalizedString("tarotMind.section4.bullet1.title", comment: "Card of the Day")
    static let tarotMindSection4Bullet1Text = NSLocalizedString("tarotMind.section4.bullet1.text", comment: "Drawing one card each morning isn't about predicting the future; it's about setting an intention. It asks: 'What energy should I be mindful of today?'")
    static let tarotMindSection4Bullet2Title = NSLocalizedString("tarotMind.section4.bullet2.title", comment: "Presence")
    static let tarotMindSection4Bullet2Text = NSLocalizedString("tarotMind.section4.bullet2.text", comment: "The act of shuffling and focusing on the imagery encourages you to stay in the moment, making it a perfect companion for meditation or journaling.")
    
    static let tarotMindConclusion = NSLocalizedString("tarotMind.conclusion", comment: "Think of Tarot not as a 'fortune teller,' but as a 'soul translator.' It gives a voice to your intuition when your logical mind is too loud.")
    static let tarotMindInsightLabel = NSLocalizedString("tarotMind.insight.label", comment: "Insight:")
    
    // FAQ View
    static let faqTitle = NSLocalizedString("faq.title", comment: "FAQ")
    static let faqSubtitle = NSLocalizedString("faq.subtitle", comment: "Frequently Asked Questions")
    
    static let faqQuestion1 = NSLocalizedString("faq.question1", comment: "Is tarot real?")
    static let faqAnswer1 = NSLocalizedString("faq.answer1", comment: "Tarot is not scientifically proven. It is best used as a tool for reflection and intuition.")
    
    static let faqQuestion2 = NSLocalizedString("faq.question2", comment: "Can tarot predict the future?")
    static let faqAnswer2 = NSLocalizedString("faq.answer2", comment: "Tarot shows possibilities, not fixed outcomes.")
    
    static let faqQuestion3 = NSLocalizedString("faq.question3", comment: "Do I need special abilities?")
    static let faqAnswer3 = NSLocalizedString("faq.answer3", comment: "No. Anyone can learn tarot with practice.")
    
    static let faqQuestion4 = NSLocalizedString("faq.question4", comment: "How often should I use tarot?")
    static let faqAnswer4 = NSLocalizedString("faq.answer4", comment: "As often as you like — daily or when you need guidance.")
    
    static let faqQuestion5 = NSLocalizedString("faq.question5", comment: "What if I don't understand a card?")
    static let faqAnswer5 = NSLocalizedString("faq.answer5", comment: "Start with basic meanings and trust your intuition over time.")
    
    static let faqQuestion6 = NSLocalizedString("faq.question6", comment: "Can I ask the same question multiple times?")
    static let faqAnswer6 = NSLocalizedString("faq.answer6", comment: "Yes, but it's recommended to give yourself time between readings. Repeating the same question too often may lead to confusion rather than clarity.")
    
    static let faqQuestion7 = NSLocalizedString("faq.question7", comment: "What is the best way to ask a question?")
    static let faqAnswer7 = NSLocalizedString("faq.answer7", comment: "Open-ended questions work best. Instead of 'yes or no', try asking 'What should I know about this situation?'")
    
    static let faqQuestion8 = NSLocalizedString("faq.question8", comment: "What does a reversed card mean?")
    static let faqAnswer8 = NSLocalizedString("faq.answer8", comment: "A reversed card can suggest blocked energy, delays, or an internal aspect of the situation. Its meaning depends on context.")
    
    static let faqQuestion9 = NSLocalizedString("faq.question9", comment: "Can tarot help with decisions?")
    static let faqAnswer9 = NSLocalizedString("faq.answer9", comment: "Yes. Tarot can help you see different perspectives and better understand your options, but the final decision is always yours.")
    
    static let faqQuestion10 = NSLocalizedString("faq.question10", comment: "Is tarot connected to religion?")
    static let faqAnswer10 = NSLocalizedString("faq.answer10", comment: "Tarot is not tied to any specific religion. It is a symbolic system that can be used by anyone, regardless of beliefs.")
    
    static let faqDisclaimerTitle = NSLocalizedString("faq.disclaimer.title", comment: "Important")
    static let faqDisclaimerText = NSLocalizedString("faq.disclaimer.text", comment: "Tarot is intended for entertainment and self-reflection purposes only.")
}
