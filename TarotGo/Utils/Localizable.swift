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
    static let comingSoon = NSLocalizedString("common.comingSoon", comment: "Coming Soon label")
    
    // MARK: - Tab Bar
    static let tabTarot = NSLocalizedString("tab.tarot", comment: "Tarot tab")
    static let tabDestinyMatrix = NSLocalizedString("tab.destinyMatrix", comment: "Destiny Matrix tab")
    static let tabPalmistry = NSLocalizedString("tab.palmistry", comment: "Palmistry tab")
    static let tabCosmic = NSLocalizedString("tab.cosmic", comment: "Cosmic tab")
    static let tabSettings = NSLocalizedString("tab.settings", comment: "Settings tab")
    
    // MARK: - Tarot View
    static let tarotViewTitle = NSLocalizedString("tarotView.title", comment: "Tarot")
    static let tarotViewSubtitle = NSLocalizedString("tarotView.subtitle", comment: "Divine wisdom through the cards")
    
    // MARK: - Palmistry View
    static let palmistryViewTitle = NSLocalizedString("palmistryView.title", comment: "Palmistry")
    static let palmistryViewSubtitle = NSLocalizedString("palmistryView.subtitle", comment: "Secrets written in your hands")
    static let palmistryViewFooter = NSLocalizedString("palmistryView.footer", comment: "Your destiny lies in your hands")
    
    // MARK: - Destiny Matrix View
    static let destinyMatrixViewTitle = NSLocalizedString("destinyMatrixView.title", comment: "Destiny Matrix")
    static let destinyMatrixViewSubtitle = NSLocalizedString("destinyMatrixView.subtitle", comment: "Your personal energy map")
    static let destinyMatrixViewFooter = NSLocalizedString("destinyMatrixView.footer", comment: "Discover the blueprint of your soul")
    
    // MARK: - Cosmic View
    static let cosmicViewTitle = NSLocalizedString("cosmicView.title", comment: "Cosmic")
    static let cosmicViewSubtitle = NSLocalizedString("cosmicView.subtitle", comment: "Explore celestial influences")
    static let cosmicViewFooter = NSLocalizedString("cosmicView.footer", comment: "The stars illuminate your path")
    
    // MARK: - Learn Palmistry
    static let learnPalmistryTitle = NSLocalizedString("learnPalmistry.title", comment: "Learn Palmistry")
    static let learnPalmistrySubtitle = NSLocalizedString("learnPalmistry.subtitle", comment: "Master the art of palm reading")
    static let learnPalmistryComingSoon = NSLocalizedString("learnPalmistry.comingSoon", comment: "Content coming soon")
    static let learnPalmistryDescription = NSLocalizedString("learnPalmistry.description", comment: "Discover the ancient art of palmistry. Learn to read the lines, mounts, and shapes that reveal your destiny.")
    
    // MARK: - Cosmic Features
    static let horoscopeTitle = NSLocalizedString("horoscope.title", comment: "Horoscope")
    static let horoscopeSubtitle = NSLocalizedString("horoscope.subtitle", comment: "Your daily celestial guidance")
    
    static let cosmogramTitle = NSLocalizedString("cosmogram.title", comment: "Cosmogram")
    static let cosmogramSubtitle = NSLocalizedString("cosmogram.subtitle", comment: "Your personal star chart")
    
    static let numerologyTitle = NSLocalizedString("numerology.title", comment: "Numerology")
    static let numerologySubtitle = NSLocalizedString("numerology.subtitle", comment: "The power of numbers")
    
    static let lunarCalendarTitle = NSLocalizedString("lunarCalendar.title", comment: "Lunar Calendar")
    static let lunarCalendarSubtitle = NSLocalizedString("lunarCalendar.subtitle", comment: "Follow the moon's phases")
    static let lunarCalendarIlluminated = NSLocalizedString("lunarCalendar.illuminated", comment: "Illuminated")
    static let lunarCalendarMoonIn = NSLocalizedString("lunarCalendar.moonIn", comment: "Moon in")
    static let lunarCalendarUpcomingPhases = NSLocalizedString("lunarCalendar.upcomingPhases", comment: "Upcoming Moon Phases")
    static let lunarCalendarToday = NSLocalizedString("lunarCalendar.today", comment: "Today")
    static let lunarCalendarRitualSuggestions = NSLocalizedString("lunarCalendar.ritualSuggestions", comment: "Ritual Suggestions")
    
    // Moon Phase Names
    static let moonPhaseNewMoon = NSLocalizedString("moonPhase.newMoon", comment: "New Moon")
    static let moonPhaseWaxingCrescent = NSLocalizedString("moonPhase.waxingCrescent", comment: "Waxing Crescent")
    static let moonPhaseFirstQuarter = NSLocalizedString("moonPhase.firstQuarter", comment: "First Quarter")
    static let moonPhaseWaxingGibbous = NSLocalizedString("moonPhase.waxingGibbous", comment: "Waxing Gibbous")
    static let moonPhaseFullMoon = NSLocalizedString("moonPhase.fullMoon", comment: "Full Moon")
    static let moonPhaseWaningGibbous = NSLocalizedString("moonPhase.waningGibbous", comment: "Waning Gibbous")
    static let moonPhaseLastQuarter = NSLocalizedString("moonPhase.lastQuarter", comment: "Last Quarter")
    static let moonPhaseWaningCrescent = NSLocalizedString("moonPhase.waningCrescent", comment: "Waning Crescent")
    
    // Moon Phase Descriptions
    static let moonPhaseNewMoonDesc = NSLocalizedString("moonPhase.newMoon.desc", comment: "A time for new beginnings, setting intentions, and planting seeds for the future.")
    static let moonPhaseWaxingCrescentDesc = NSLocalizedString("moonPhase.waxingCrescent.desc", comment: "Energy is building. Take initial action on your goals and remain flexible.")
    static let moonPhaseFirstQuarterDesc = NSLocalizedString("moonPhase.firstQuarter.desc", comment: "Time for decision and commitment. Push through obstacles with determination.")
    static let moonPhaseWaxingGibbousDesc = NSLocalizedString("moonPhase.waxingGibbous.desc", comment: "Refine your plans and adjust your approach. Success is within reach.")
    static let moonPhaseFullMoonDesc = NSLocalizedString("moonPhase.fullMoon.desc", comment: "Peak energy for manifestation, celebration, and emotional release. Harvest what you've sown.")
    static let moonPhaseWaningGibbousDesc = NSLocalizedString("moonPhase.waningGibbous.desc", comment: "Share your wisdom and gratitude. Reflect on lessons learned.")
    static let moonPhaseLastQuarterDesc = NSLocalizedString("moonPhase.lastQuarter.desc", comment: "Release what no longer serves you. Let go and create space for renewal.")
    static let moonPhaseWaningCrescentDesc = NSLocalizedString("moonPhase.waningCrescent.desc", comment: "Rest, restore, and prepare for the next cycle. Surrender and trust.")
    
    // Moon Phase Energy Titles
    static let moonPhaseNewMoonEnergy = NSLocalizedString("moonPhase.newMoon.energy", comment: "Intention & New Beginnings")
    static let moonPhaseWaxingCrescentEnergy = NSLocalizedString("moonPhase.waxingCrescent.energy", comment: "Growth & Expansion")
    static let moonPhaseFirstQuarterEnergy = NSLocalizedString("moonPhase.firstQuarter.energy", comment: "Action & Determination")
    static let moonPhaseWaxingGibbousEnergy = NSLocalizedString("moonPhase.waxingGibbous.energy", comment: "Refinement & Adjustment")
    static let moonPhaseFullMoonEnergy = NSLocalizedString("moonPhase.fullMoon.energy", comment: "Manifestation & Release")
    static let moonPhaseWaningGibbousEnergy = NSLocalizedString("moonPhase.waningGibbous.energy", comment: "Gratitude & Sharing")
    static let moonPhaseLastQuarterEnergy = NSLocalizedString("moonPhase.lastQuarter.energy", comment: "Letting Go & Forgiveness")
    static let moonPhaseWaningCrescentEnergy = NSLocalizedString("moonPhase.waningCrescent.energy", comment: "Rest & Surrender")
    
    // Ritual Suggestions - New Moon
    static let ritualNewMoon1 = NSLocalizedString("ritual.newMoon.1", comment: "Set intentions for the upcoming lunar cycle")
    static let ritualNewMoon2 = NSLocalizedString("ritual.newMoon.2", comment: "Journal about new beginnings you wish to invite")
    static let ritualNewMoon3 = NSLocalizedString("ritual.newMoon.3", comment: "Create a vision board for your goals")
    static let ritualNewMoon4 = NSLocalizedString("ritual.newMoon.4", comment: "Light a candle and meditate on fresh starts")
    
    // Ritual Suggestions - Waxing Crescent
    static let ritualWaxingCrescent1 = NSLocalizedString("ritual.waxingCrescent.1", comment: "Take the first concrete steps toward your goals")
    static let ritualWaxingCrescent2 = NSLocalizedString("ritual.waxingCrescent.2", comment: "Research and gather resources you'll need")
    static let ritualWaxingCrescent3 = NSLocalizedString("ritual.waxingCrescent.3", comment: "Connect with others who support your vision")
    static let ritualWaxingCrescent4 = NSLocalizedString("ritual.waxingCrescent.4", comment: "Practice affirmations for growth and expansion")
    
    // Ritual Suggestions - First Quarter
    static let ritualFirstQuarter1 = NSLocalizedString("ritual.firstQuarter.1", comment: "Make important decisions with confidence")
    static let ritualFirstQuarter2 = NSLocalizedString("ritual.firstQuarter.2", comment: "Address and work through any obstacles")
    static let ritualFirstQuarter3 = NSLocalizedString("ritual.firstQuarter.3", comment: "Take bold action on your plans")
    static let ritualFirstQuarter4 = NSLocalizedString("ritual.firstQuarter.4", comment: "Review progress and adjust your approach")
    
    // Ritual Suggestions - Waxing Gibbous
    static let ritualWaxingGibbous1 = NSLocalizedString("ritual.waxingGibbous.1", comment: "Refine and polish your projects")
    static let ritualWaxingGibbous2 = NSLocalizedString("ritual.waxingGibbous.2", comment: "Seek feedback and make improvements")
    static let ritualWaxingGibbous3 = NSLocalizedString("ritual.waxingGibbous.3", comment: "Practice patience as success approaches")
    static let ritualWaxingGibbous4 = NSLocalizedString("ritual.waxingGibbous.4", comment: "Prepare for upcoming manifestations")
    
    // Ritual Suggestions - Full Moon
    static let ritualFullMoon1 = NSLocalizedString("ritual.fullMoon.1", comment: "Celebrate achievements and express gratitude")
    static let ritualFullMoon2 = NSLocalizedString("ritual.fullMoon.2", comment: "Release what no longer serves your growth")
    static let ritualFullMoon3 = NSLocalizedString("ritual.fullMoon.3", comment: "Charge crystals and tools under moonlight")
    static let ritualFullMoon4 = NSLocalizedString("ritual.fullMoon.4", comment: "Perform a releasing ritual or ceremony")
    
    // Ritual Suggestions - Waning Gibbous
    static let ritualWaningGibbous1 = NSLocalizedString("ritual.waningGibbous.1", comment: "Share your knowledge and experiences")
    static let ritualWaningGibbous2 = NSLocalizedString("ritual.waningGibbous.2", comment: "Express gratitude for lessons learned")
    static let ritualWaningGibbous3 = NSLocalizedString("ritual.waningGibbous.3", comment: "Help others with your newfound wisdom")
    static let ritualWaningGibbous4 = NSLocalizedString("ritual.waningGibbous.4", comment: "Reflect on the cycle's teachings")
    
    // Ritual Suggestions - Last Quarter
    static let ritualLastQuarter1 = NSLocalizedString("ritual.lastQuarter.1", comment: "Let go of limiting beliefs and patterns")
    static let ritualLastQuarter2 = NSLocalizedString("ritual.lastQuarter.2", comment: "Forgive yourself and others")
    static let ritualLastQuarter3 = NSLocalizedString("ritual.lastQuarter.3", comment: "Clear physical and energetic clutter")
    static let ritualLastQuarter4 = NSLocalizedString("ritual.lastQuarter.4", comment: "Journal about what you're ready to release")
    
    // Ritual Suggestions - Waning Crescent
    static let ritualWaningCrescent1 = NSLocalizedString("ritual.waningCrescent.1", comment: "Rest and restore your energy")
    static let ritualWaningCrescent2 = NSLocalizedString("ritual.waningCrescent.2", comment: "Practice deep meditation or contemplation")
    static let ritualWaningCrescent3 = NSLocalizedString("ritual.waningCrescent.3", comment: "Trust in the natural cycles of life")
    static let ritualWaningCrescent4 = NSLocalizedString("ritual.waningCrescent.4", comment: "Prepare for the new moon's fresh start")
    
    static let compatibilityTitle = NSLocalizedString("compatibility.title", comment: "Compatibility")
    static let compatibilitySubtitle = NSLocalizedString("compatibility.subtitle", comment: "Discover your cosmic connections")
    static let compatibilityYourSign = NSLocalizedString("compatibility.yourSign", comment: "Your Sign")
    static let compatibilityPartnerSign = NSLocalizedString("compatibility.partnerSign", comment: "Partner's Sign")
    static let compatibilitySelectPrompt = NSLocalizedString("compatibility.selectPrompt", comment: "Select both zodiac signs to see compatibility")
    static let compatibilityScore = NSLocalizedString("compatibility.score", comment: "Compatibility Score")
    static let compatibilityElementalMatch = NSLocalizedString("compatibility.elementalMatch", comment: "Elemental Match")
    static let compatibilityOverall = NSLocalizedString("compatibility.overall", comment: "Overall Compatibility")
    static let compatibilityStrengths = NSLocalizedString("compatibility.strengths", comment: "Strengths")
    static let compatibilityChallenges = NSLocalizedString("compatibility.challenges", comment: "Challenges")
    static let compatibilityAdvice = NSLocalizedString("compatibility.advice", comment: "Advice")
    
    // Rating levels
    static let compatibilityRatingExcellent = NSLocalizedString("compatibility.rating.excellent", comment: "Excellent Match")
    static let compatibilityRatingVeryCompatible = NSLocalizedString("compatibility.rating.veryCompatible", comment: "Very Compatible")
    static let compatibilityRatingGood = NSLocalizedString("compatibility.rating.good", comment: "Good Match")
    static let compatibilityRatingModerate = NSLocalizedString("compatibility.rating.moderate", comment: "Moderate Compatibility")
    static let compatibilityRatingChallenging = NSLocalizedString("compatibility.rating.challenging", comment: "Challenging but Possible")
    
    // Elements
    static let compatibilityElementFire = NSLocalizedString("compatibility.element.fire", comment: "Fire")
    static let compatibilityElementEarth = NSLocalizedString("compatibility.element.earth", comment: "Earth")
    static let compatibilityElementAir = NSLocalizedString("compatibility.element.air", comment: "Air")
    static let compatibilityElementWater = NSLocalizedString("compatibility.element.water", comment: "Water")
    
    // Element descriptions
    static let compatibilityElementDescSame = NSLocalizedString("compatibility.elementDesc.same", comment: "Same element description")
    static let compatibilityElementDescFireAir = NSLocalizedString("compatibility.elementDesc.fireAir", comment: "Fire and Air description")
    static let compatibilityElementDescEarthWater = NSLocalizedString("compatibility.elementDesc.earthWater", comment: "Earth and Water description")
    static let compatibilityElementDescDifferent = NSLocalizedString("compatibility.elementDesc.different", comment: "Different elements description")
    
    // Detailed texts
    static let compatibilityOverallText = NSLocalizedString("compatibility.overallText", comment: "Overall compatibility text")
    static let compatibilityStrengthsSameElement = NSLocalizedString("compatibility.strengthsSameElement", comment: "Strengths for same element")
    static let compatibilityStrengthsFireAir = NSLocalizedString("compatibility.strengthsFireAir", comment: "Strengths for Fire/Air")
    static let compatibilityStrengthsEarthWater = NSLocalizedString("compatibility.strengthsEarthWater", comment: "Strengths for Earth/Water")
    static let compatibilityStrengthsDifferent = NSLocalizedString("compatibility.strengthsDifferent", comment: "Strengths for different elements")
    static let compatibilityChallengesSameElement = NSLocalizedString("compatibility.challengesSameElement", comment: "Challenges for same element")
    static let compatibilityChallengesDifferent = NSLocalizedString("compatibility.challengesDifferent", comment: "Challenges for different elements")
    static let compatibilityAdviceText = NSLocalizedString("compatibility.adviceText", comment: "General advice text")

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

    static let homeCoupleDestiny = NSLocalizedString("home.coupleDestiny", comment: "Couple Destiny")
    static let homeCoupleDestinySubtitle = NSLocalizedString("home.coupleDestiny.subtitle", comment: "Explore shared energy")
    
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
    static let matrixCalculate = NSLocalizedString("matrix.calculate", comment: "Calculate Matrix")
    static let matrixCalculateForOther = NSLocalizedString("matrix.calculateForOther", comment: "Calculate for someone else")
    static let matrixYourBirthDate = NSLocalizedString("matrix.yourBirthDate", comment: "Your Birth Date")
    
    static let matrixYourMatrix = NSLocalizedString("matrix.yourMatrix", comment: "Your Destiny Matrix")
    static let matrixTapCircle = NSLocalizedString("matrix.tapCircle", comment: "Tap any circle to see its meaning")
    static let matrixSelectedPosition = NSLocalizedString("matrix.selectedPosition", comment: "Selected Position")
    static let matrixNumber = NSLocalizedString("matrix.number", comment: "Number")
    static let matrixAssociatedCard = NSLocalizedString("matrix.associatedCard", comment: "Associated Tarot Card")
    
    static let matrixTabDiagram = NSLocalizedString("matrix.tab.diagram", comment: "Diagram")
    static let matrixTabPositions = NSLocalizedString("matrix.tab.positions", comment: "Positions")
    static let matrixTabCards = NSLocalizedString("matrix.tab.cards", comment: "Cards")
    static let matrixTabYearAnalysis = NSLocalizedString("matrix.tab.yearAnalysis", comment: "Year Analysis")
    
    static let matrixViewCardDetails = NSLocalizedString("matrix.viewCardDetails", comment: "View Card Details")
    static let matrixUniqueCards = NSLocalizedString("matrix.uniqueCards", comment: "Unique Cards in Your Matrix")
    static let matrixAllPositions = NSLocalizedString("matrix.allPositions", comment: "All 19 Positions")
    static let matrixShareMatrix = NSLocalizedString("matrix.shareMatrix", comment: "Share Destiny Matrix")
    static let coupleMatrixShareMatrix = NSLocalizedString("coupleMatrix.shareMatrix", comment: "Share Couple Matrix")
    
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

    // MARK: - Couple Matrix
    static let coupleMatrixTitle = NSLocalizedString("coupleMatrix.title", comment: "Couple Matrix")
    static let coupleMatrixSubtitle = NSLocalizedString("coupleMatrix.subtitle", comment: "Map the shared energies of two souls")
    static let coupleMatrixWhatIs = NSLocalizedString("coupleMatrix.whatIs", comment: "What is the Couple Matrix?")
    static let coupleMatrixDescription = NSLocalizedString("coupleMatrix.description", comment: "The Couple Matrix combines the birth energies of two partners using the 22 Major Arcana to reveal the heart, karma, and purpose of your union.")
    static let coupleMatrixYourBirthDate = NSLocalizedString("coupleMatrix.yourBirthDate", comment: "Your Birth Date")
    static let coupleMatrixUseMyBirthDate = NSLocalizedString("coupleMatrix.useMyBirthDate", comment: "Use my saved birth date")
    static let coupleMatrixEnterPartnerABirthDate = NSLocalizedString("coupleMatrix.enterPartnerABirthDate", comment: "Enter Partner A's Birth Date")
    static let coupleMatrixEnterPartnerBBirthDate = NSLocalizedString("coupleMatrix.enterPartnerBBirthDate", comment: "Enter Partner B's Birth Date")
    static let coupleMatrixCalculate = NSLocalizedString("coupleMatrix.calculate", comment: "Calculate Couple Matrix")
    static let coupleMatrixYourMatrix = NSLocalizedString("coupleMatrix.yourMatrix", comment: "Your Couple Matrix")

    // Couple Matrix Position Names
    static let coupleMatrixPartnerA = NSLocalizedString("coupleMatrix.position.partnerA", comment: "Partner A")
    static let coupleMatrixPartnerADesc = NSLocalizedString("coupleMatrix.position.partnerA.desc", comment: "The core energy of the first partner")

    static let coupleMatrixPartnerB = NSLocalizedString("coupleMatrix.position.partnerB", comment: "Partner B")
    static let coupleMatrixPartnerBDesc = NSLocalizedString("coupleMatrix.position.partnerB.desc", comment: "The core energy of the second partner")

    static let coupleMatrixUnion = NSLocalizedString("coupleMatrix.position.union", comment: "Union")
    static let coupleMatrixUnionDesc = NSLocalizedString("coupleMatrix.position.union.desc", comment: "The combined essence at the heart of your relationship")

    static let coupleMatrixLove = NSLocalizedString("coupleMatrix.position.love", comment: "Love Line")
    static let coupleMatrixLoveDesc = NSLocalizedString("coupleMatrix.position.love.desc", comment: "How affection flows between the two of you")

    static let coupleMatrixKarma = NSLocalizedString("coupleMatrix.position.karma", comment: "Shared Karma")
    static let coupleMatrixKarmaDesc = NSLocalizedString("coupleMatrix.position.karma.desc", comment: "Lessons your souls have come together to resolve")

    static let coupleMatrixMoney = NSLocalizedString("coupleMatrix.position.money", comment: "Shared Abundance")
    static let coupleMatrixMoneyDesc = NSLocalizedString("coupleMatrix.position.money.desc", comment: "Material harmony you create together")

    static let coupleMatrixSexuality = NSLocalizedString("coupleMatrix.position.sexuality", comment: "Passion")
    static let coupleMatrixSexualityDesc = NSLocalizedString("coupleMatrix.position.sexuality.desc", comment: "The intimate energy and chemistry you share")

    static let coupleMatrixChildren = NSLocalizedString("coupleMatrix.position.children", comment: "Creative Legacy")
    static let coupleMatrixChildrenDesc = NSLocalizedString("coupleMatrix.position.children.desc", comment: "Children, projects, and the legacy you build together")

    static let coupleMatrixPurpose = NSLocalizedString("coupleMatrix.position.purpose", comment: "Purpose of the Union")
    static let coupleMatrixPurposeDesc = NSLocalizedString("coupleMatrix.position.purpose.desc", comment: "What this relationship is here to fulfill")

    static let coupleMatrixHealth = NSLocalizedString("coupleMatrix.position.health", comment: "Vitality")
    static let coupleMatrixHealthDesc = NSLocalizedString("coupleMatrix.position.health.desc", comment: "The living energy that sustains your bond")

    static let coupleMatrixYearsTogether = NSLocalizedString("coupleMatrix.yearsTogether", comment: "Years Together")
    static let coupleMatrixCurrentYearEnergy = NSLocalizedString("coupleMatrix.currentYearEnergy", comment: "Current Year Energy")
    static let coupleMatrixYearEnergy = NSLocalizedString("coupleMatrix.yearEnergy", comment: "Year Energy")
    static let coupleMatrixEnergyForYear = NSLocalizedString("coupleMatrix.energyForYear", comment: "Energy for this year")

    // MARK: - Destiny Matrix History
    static let matrixHistoryTitle = NSLocalizedString("matrixHistory.title", comment: "Saved Matrices")
    static let matrixHistoryEmpty = NSLocalizedString("matrixHistory.empty", comment: "No saved matrices yet")
    static let matrixHistoryEmptyDesc = NSLocalizedString("matrixHistory.empty.desc", comment: "Your saved Destiny Matrices will appear here")
    static let matrixHistoryDeleteAlert = NSLocalizedString("matrixHistory.deleteAlert", comment: "Delete Matrix")
    static let matrixHistoryDeleteMessage = NSLocalizedString("matrixHistory.deleteMessage", comment: "Are you sure you want to delete this saved matrix? This action cannot be undone.")
    static let matrixHistoryDelete = NSLocalizedString("matrixHistory.delete", comment: "Delete Matrix")
    static let matrixHistorySavedOn = NSLocalizedString("matrixHistory.savedOn", comment: "Saved on")
    static let matrixHistoryFilterAll = NSLocalizedString("matrixHistory.filter.all", comment: "All")
    static let matrixHistoryFilterSingle = NSLocalizedString("matrixHistory.filter.single", comment: "Single")
    static let matrixHistoryFilterCouple = NSLocalizedString("matrixHistory.filter.couple", comment: "Couple")
    static let homeMatrixHistory = NSLocalizedString("home.matrixHistory", comment: "Saved Matrices")
    static let homeMatrixHistorySubtitle = NSLocalizedString("home.matrixHistory.subtitle", comment: "Review your saved Destiny Matrices")

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

    // MARK: - Exit Reading Confirmation
    static let exitReadingTitle = NSLocalizedString("exitReading.title", comment: "End Reading?")
    static let exitReadingMessage = NSLocalizedString("exitReading.message", comment: "Your progress will be lost if you exit now.")
    static let exitReadingConfirm = NSLocalizedString("exitReading.confirm", comment: "End Reading")
    static let exitReadingCancel = NSLocalizedString("exitReading.cancel", comment: "Continue Reading")

    // MARK: - Summary
    static let summaryYourReading = NSLocalizedString("summary.yourReading", comment: "Your Reading")
    static let summaryYourTarotGoReading = NSLocalizedString("summary.yourTarotGoReading", comment: "Your TarotGo Reading")
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

    // MARK: - PDF Export - Destiny Matrix
    static let pdfMatrixTitle = NSLocalizedString("pdf.matrix.title", comment: "Your Destiny Matrix")
    static let pdfMatrixBirthDate = NSLocalizedString("pdf.matrix.birthDate", comment: "Birth Date:")
    static let pdfMatrixSavedOn = NSLocalizedString("pdf.matrix.savedOn", comment: "Saved on:")
    static let pdfMatrixCoreEssence = NSLocalizedString("pdf.matrix.coreEssence", comment: "Core Essence")
    static let pdfMatrixKeyPositions = NSLocalizedString("pdf.matrix.keyPositions", comment: "Key Positions")
    static let pdfMatrixCurrentYear = NSLocalizedString("pdf.matrix.currentYear", comment: "Current Year Energy")
    static let pdfMatrixEnergy = NSLocalizedString("pdf.matrix.energy", comment: "Energy:")
    static let pdfMatrixYear = NSLocalizedString("pdf.matrix.year", comment: "Year")
    static let pdfMatrixAge = NSLocalizedString("pdf.matrix.age", comment: "Age")
    static let pdfMatrixLifeTimeline = NSLocalizedString("pdf.matrix.lifeTimeline", comment: "Life Timeline")
    static let pdfMatrixYears = NSLocalizedString("pdf.matrix.years", comment: "years")
    static let pdfMatrixCurrentYearDesc = NSLocalizedString("pdf.matrix.currentYearDesc", comment: "Your guiding energy this year, shaping the themes, lessons and opportunities woven into your path.")
    static let pdfMatrixEnergyLegend = NSLocalizedString("pdf.matrix.energyLegend", comment: "Energy Legend")
    static let pdfMatrixEnergyLegendIntro = NSLocalizedString("pdf.matrix.energyLegendIntro", comment: "Every circle in your timeline carries a number from 1 to 22 — each tied to a Major Arcana card. Use this legend as a quick guide to the essence each number holds.")

    // MARK: - PDF Export - Couple Matrix
    static let pdfCoupleMatrixTitle = NSLocalizedString("pdf.coupleMatrix.title", comment: "Your Couple Matrix")
    static let pdfCoupleMatrixHeartOfUnion = NSLocalizedString("pdf.coupleMatrix.heartOfUnion", comment: "Heart of Union")
    static let pdfCoupleMatrixPartnerEnergies = NSLocalizedString("pdf.coupleMatrix.partnerEnergies", comment: "Partner Energies")
    static let pdfCoupleMatrixSharedAspects = NSLocalizedString("pdf.coupleMatrix.sharedAspects", comment: "Shared Aspects")
    static let pdfCoupleMatrixYearsTimeline = NSLocalizedString("pdf.coupleMatrix.yearsTimeline", comment: "Years Together Timeline")
    static let pdfCoupleMatrixCurrentYearDesc = NSLocalizedString("pdf.coupleMatrix.currentYearDesc", comment: "The guiding energy of your union this year, shaping the lessons and opportunities woven into your shared path.")

    // MARK: - PDF Export - Palm Reading
    static let pdfPalmTitle = NSLocalizedString("pdf.palm.title", comment: "Your Palm Reading")
    static let pdfPalmSavedOn = NSLocalizedString("pdf.palm.savedOn", comment: "Saved on:")
    static let pdfPalmCapturedImage = NSLocalizedString("pdf.palm.capturedImage", comment: "Captured Palm")
    static let pdfPalmHandShape = NSLocalizedString("pdf.palm.handShape", comment: "Hand Shape")
    static let pdfPalmFingerLength = NSLocalizedString("pdf.palm.fingerLength", comment: "Finger Length:")
    static let pdfPalmShape = NSLocalizedString("pdf.palm.shape", comment: "Palm Shape:")
    static let pdfPalmLines = NSLocalizedString("pdf.palm.lines", comment: "Palm Lines")
    static let pdfPalmMounts = NSLocalizedString("pdf.palm.mounts", comment: "Palm Mounts")
    static let pdfPalmLength = NSLocalizedString("pdf.palm.length", comment: "Length:")
    static let pdfPalmDepth = NSLocalizedString("pdf.palm.depth", comment: "Depth:")
    static let pdfPalmContinuity = NSLocalizedString("pdf.palm.continuity", comment: "Continuity:")
    static let pdfPalmProminence = NSLocalizedString("pdf.palm.prominence", comment: "Prominence:")

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
    static let settingsSound = NSLocalizedString("settings.sound", comment: "Sound")
    static let settingsSoundEnabled = NSLocalizedString("settings.soundEnabled", comment: "Sound Effects")
    static let settingsSoundEnabledDesc = NSLocalizedString("settings.soundEnabled.desc", comment: "Play sound effects throughout the app")
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
    static let settingsLanguageSelection = NSLocalizedString("settings.languageSelection", comment: "Language Selection")
    static let settingsLanguageDesc = NSLocalizedString("settings.language.desc", comment: "Change the app language in your phone settings")
    
    static let settingsNotificationPermissionTitle = NSLocalizedString("settings.notificationPermission.title", comment: "Notification Permission Required")
    static let settingsNotificationPermissionMessage = NSLocalizedString("settings.notificationPermission.message", comment: "Please enable notifications in Settings to receive daily card reminders")
    static let settingsNotificationPermissionSettings = NSLocalizedString("settings.notificationPermission.settings", comment: "Open Settings")
    static let settingsNotificationPermissionCancel = NSLocalizedString("settings.notificationPermission.cancel", comment: "Cancel")
    
    static let settingsLegal = NSLocalizedString("settings.legal", comment: "Legal")
    static let settingsPrivacyPolicy = NSLocalizedString("settings.privacyPolicy", comment: "Privacy Policy")
    static let settingsTermsOfService = NSLocalizedString("settings.termsOfService", comment: "Terms of Service")
    
    // Birth Date Settings
    static let settingsPersonalization = NSLocalizedString("settings.personalization", comment: "Personalization")
    static let settingsBirthDate = NSLocalizedString("settings.birthDate", comment: "Birth Date")
    static let settingsChange = NSLocalizedString("settings.change", comment: "Change")
    static let settingsAddBirthDate = NSLocalizedString("settings.addBirthDate", comment: "Add Birth Date")
    static let settingsAddBirthDateDesc = NSLocalizedString("settings.addBirthDate.desc", comment: "Personalize your readings with astrology")
    static let settingsBirthDateFooter = NSLocalizedString("settings.birthDate.footer", comment: "Your birth date enables a personalized card of the day, the Destiny Matrix, and astrological insights. It's stored locally and never shared.")
    
    static let skip = NSLocalizedString("common.skip", comment: "Skip")
    
    // Birth Date Input
    static let birthDateInputTitle = NSLocalizedString("birthDateInput.title", comment: "Your Birth Date")
    static let birthDateInputDescription = NSLocalizedString("birthDateInput.description", comment: "Enter your birth date to unlock personalized daily cards, Destiny Matrix, and astrological insights")
    static let birthDateInputSelectDate = NSLocalizedString("birthDateInput.selectDate", comment: "Select Your Birth Date")
    static let birthDateInputZodiacSign = NSLocalizedString("birthDateInput.zodiacSign", comment: "Zodiac Sign")
    static let birthDateInputLifePath = NSLocalizedString("birthDateInput.lifePath", comment: "Life Path")
    static let birthDateInputNumerology = NSLocalizedString("birthDateInput.numerology", comment: "Numerology")
    static let birthDateInputPrivacy = NSLocalizedString("birthDateInput.privacy", comment: "Your birth date is stored securely on your device and never shared")

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
    
    // MARK: - Palm Reading
    static let palmReadingTitle = NSLocalizedString("palmReading.title", comment: "Palm Reading")
    static let palmReadingSubtitle = NSLocalizedString("palmReading.subtitle", comment: "Discover the secrets in your palm")
    
    // Palm Line Names
    static let palmLineHeart = NSLocalizedString("palm.line.heart", comment: "Heart Line")
    static let palmLineHead = NSLocalizedString("palm.line.head", comment: "Head Line")
    static let palmLineLife = NSLocalizedString("palm.line.life", comment: "Life Line")
    static let palmLineFate = NSLocalizedString("palm.line.fate", comment: "Fate Line")
    
    // Palm Line Characteristics
    static let palmLineLengthShort = NSLocalizedString("palm.lineLength.short", comment: "Short")
    static let palmLineLengthMedium = NSLocalizedString("palm.lineLength.medium", comment: "Medium")
    static let palmLineLengthLong = NSLocalizedString("palm.lineLength.long", comment: "Long")
    
    static let palmLineDepthFaint = NSLocalizedString("palm.lineDepth.faint", comment: "Faint")
    static let palmLineDepthModerate = NSLocalizedString("palm.lineDepth.moderate", comment: "Moderate")
    static let palmLineDepthDeep = NSLocalizedString("palm.lineDepth.deep", comment: "Deep")
    
    static let palmLineContinuityContinuous = NSLocalizedString("palm.lineContinuity.continuous", comment: "Continuous")
    static let palmLineContinuityBroken = NSLocalizedString("palm.lineContinuity.broken", comment: "Broken")
    static let palmLineContinuityChained = NSLocalizedString("palm.lineContinuity.chained", comment: "Chained")
    
    static let palmFateLineNotVisible = NSLocalizedString("palm.fateLine.notVisible", comment: "The Fate Line is not prominently visible in your palm, which suggests a life path shaped by personal choices rather than external destiny. You have the freedom to create your own direction.")
    static let palmReadingIntroTitle = NSLocalizedString("palmReading.intro.title", comment: "Discover the secrets in your palm")
    static let palmReadingOnDeviceTitle = NSLocalizedString("palmReading.onDevice.title", comment: "On-Device Analysis")
    static let palmReadingOnDeviceDesc = NSLocalizedString("palmReading.onDevice.desc", comment: "Your palm image is processed locally and never leaves your device. Complete privacy guaranteed.")
    static let palmReadingFourLinesTitle = NSLocalizedString("palmReading.fourLines.title", comment: "Four Major Lines")
    static let palmReadingFourLinesDesc = NSLocalizedString("palmReading.fourLines.desc", comment: "We analyze your Heart, Head, Life, and Fate lines to reveal insights about your path.")
    static let palmReadingAncientTitle = NSLocalizedString("palmReading.ancient.title", comment: "Ancient Wisdom")
    static let palmReadingAncientDesc = NSLocalizedString("palmReading.ancient.desc", comment: "Palmistry has guided seekers for thousands of years. Let your palm tell its story.")
    static let palmReadingTakePhoto = NSLocalizedString("palmReading.takePhoto", comment: "Take Palm Photo")
    static let palmReadingAnalyzing = NSLocalizedString("palmReading.analyzing", comment: "Reading Your Palm")
    static let palmReadingAnalyzingDesc = NSLocalizedString("palmReading.analyzing.desc", comment: "Analyzing the lines of your destiny...")
    static let palmReadingYourReading = NSLocalizedString("palmReading.yourReading", comment: "Your Palm Reading")
    static let palmReadingOverall = NSLocalizedString("palmReading.overall", comment: "Overall Reading")
    static let palmReadingYourLines = NSLocalizedString("palmReading.yourLines", comment: "Your Palm Lines")
    static let palmReadingReadAnother = NSLocalizedString("palmReading.readAnother", comment: "Read Another Palm")
    static let palmReadingCameraAccess = NSLocalizedString("palmReading.cameraAccess", comment: "Camera Access Required")
    static let palmReadingCameraDesc = NSLocalizedString("palmReading.camera.desc", comment: "To read your palm, we need access to your camera. Your palm image is processed locally and never leaves your device.")
    static let palmReadingOpenSettings = NSLocalizedString("palmReading.openSettings", comment: "Open Settings")
    static let palmReadingPlaceHand = NSLocalizedString("palmReading.placeHand", comment: "Place your palm within the guide")

    // MARK: - Palm Reading History
    static let palmHistoryTitle = NSLocalizedString("palmHistory.title", comment: "Saved Readings")
    static let palmHistoryButtonTitle = NSLocalizedString("palmHistory.button.title", comment: "Saved Readings")
    static let palmHistoryButtonSubtitle = NSLocalizedString("palmHistory.button.subtitle", comment: "Review your saved palm readings")
    static let palmHistoryEmpty = NSLocalizedString("palmHistory.empty", comment: "No saved palm readings yet")
    static let palmHistoryEmptyDesc = NSLocalizedString("palmHistory.empty.desc", comment: "Your saved palm readings will appear here")
    static let palmHistorySavedOn = NSLocalizedString("palmHistory.savedOn", comment: "Saved on")
    static let palmHistoryDeleteAlert = NSLocalizedString("palmHistory.deleteAlert", comment: "Delete Reading")
    static let palmHistoryDeleteMessage = NSLocalizedString("palmHistory.deleteMessage", comment: "Are you sure you want to delete this saved palm reading? This action cannot be undone.")
    static let palmHistoryDelete = NSLocalizedString("palmHistory.delete", comment: "Delete Reading")
    static let palmHistoryCapturedImage = NSLocalizedString("palmHistory.capturedImage", comment: "Captured Image")

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
    
    // MARK: - Palm Reading Interpretations
    
    // Overall reading - Emotional-Mental Balance
    static let palmInterpretationBalanceDeepBoth = NSLocalizedString("palm.interpretation.balance.deepBoth", value: "Your palm reveals a powerful balance between heart and mind. You possess both emotional depth and intellectual clarity, allowing you to navigate life with wisdom and compassion. ", comment: "Palm interpretation for deep heart and head lines")
    
    static let palmInterpretationBalanceDeepHeartFaintHead = NSLocalizedString("palm.interpretation.balance.deepHeartFaintHead", value: "Your heart leads the way in your life's journey. You feel deeply and passionately, though you may benefit from bringing more analytical thinking into your decision-making process. ", comment: "Palm interpretation for deep heart, faint head")
    
    static let palmInterpretationBalanceFaintHeartDeepHead = NSLocalizedString("palm.interpretation.balance.faintHeartDeepHead", value: "You approach life through the lens of logic and reason. Your sharp intellect serves you well, though opening yourself to emotional experiences could bring greater fulfillment. ", comment: "Palm interpretation for faint heart, deep head")
    
    static let palmInterpretationBalanceGentle = NSLocalizedString("palm.interpretation.balance.gentle", value: "Your palm shows a gentle, balanced approach to life. You navigate between heart and mind with flexibility, adapting to what each situation requires. ", comment: "Palm interpretation for balanced approach")
    
    // Overall reading - Life Force
    static let palmInterpretationLifeDeepContinuous = NSLocalizedString("palm.interpretation.life.deepContinuous", value: "Your Life Line indicates strong vitality and resilience. You have the energy and determination to overcome challenges and pursue your goals with vigor. ", comment: "Palm interpretation for deep continuous life line")
    
    static let palmInterpretationLifeBroken = NSLocalizedString("palm.interpretation.life.broken", value: "The breaks in your Life Line suggest significant transitions or transformative periods in your journey. These are opportunities for renewal and reinvention. ", comment: "Palm interpretation for broken life line")
    
    // Overall reading - Fate Line
    static let palmInterpretationFateDeep = NSLocalizedString("palm.interpretation.fate.deep", value: "A prominent Fate Line indicates that external forces and opportunities play a significant role in your path. You are someone whose life may be shaped by destiny and synchronicity. ", comment: "Palm interpretation for deep fate line")
    
    static let palmInterpretationFateSubtle = NSLocalizedString("palm.interpretation.fate.subtle", value: "Your subtle Fate Line suggests you have great freedom in crafting your own destiny. You are the architect of your own path. ", comment: "Palm interpretation for subtle fate line")
    
    static let palmInterpretationFateAbsent = NSLocalizedString("palm.interpretation.fate.absent", value: "The absence of a prominent Fate Line reveals that you are a true free spirit, unbound by predetermined paths. Your life is yours to create. ", comment: "Palm interpretation for absent fate line")
    
    // Overall reading - Summary
    static let palmInterpretationSummaryIntro = NSLocalizedString("palm.interpretation.summary.intro", value: "\n\nOverall, your palm tells the story of ", comment: "Summary introduction")
    
    static let palmInterpretationSummaryHeartLong = NSLocalizedString("palm.interpretation.summary.heartLong", value: "a compassionate soul who forms deep connections, ", comment: "Summary for long heart line")
    
    static let palmInterpretationSummaryHeadLong = NSLocalizedString("palm.interpretation.summary.headLong", value: "a thoughtful mind that considers many perspectives, ", comment: "Summary for long head line")
    
    static let palmInterpretationSummaryLifeLong = NSLocalizedString("palm.interpretation.summary.lifeLong", value: "and a vibrant life force that will carry you through many years and experiences. ", comment: "Summary for long life line")
    
    static let palmInterpretationClosing = NSLocalizedString("palm.interpretation.closing", value: "Remember, your palm is a map of potentials, not fixed destinies. The lines you see today may evolve as you do.", comment: "Closing statement")
    
    // Individual Line Interpretations - Heart Line
    static let palmLineHeartTitle = NSLocalizedString("palm.line.heart.title", value: "**Heart Line - Emotions & Relationships**\n\n", comment: "Heart line title")
    
    static let palmLineHeartLengthShort = NSLocalizedString("palm.line.heart.length.short", value: "Your Heart Line is relatively short, suggesting you may be selective in your emotional expressions. You value quality over quantity in relationships and may prefer a small circle of deep connections.\n\n", comment: "Heart line short length interpretation")
    
    static let palmLineHeartLengthMedium = NSLocalizedString("palm.line.heart.length.medium", value: "Your Heart Line shows a balanced approach to emotions. You can connect deeply with others while maintaining healthy boundaries.\n\n", comment: "Heart line medium length interpretation")
    
    static let palmLineHeartLengthLong = NSLocalizedString("palm.line.heart.length.long", value: "Your long Heart Line reveals a generous, loving nature. You have much love to give and form deep, lasting emotional bonds with others.\n\n", comment: "Heart line long length interpretation")
    
    static let palmLineHeartDepthDeep = NSLocalizedString("palm.line.heart.depth.deep", value: "The depth of your Heart Line indicates intense emotional experiences. You feel things profoundly and are capable of great passion and empathy.", comment: "Heart line deep depth interpretation")
    
    static let palmLineHeartDepthModerate = NSLocalizedString("palm.line.heart.depth.moderate", value: "Your Heart Line's moderate depth suggests emotional stability and resilience. You can feel deeply without being overwhelmed.", comment: "Heart line moderate depth interpretation")
    
    static let palmLineHeartDepthFaint = NSLocalizedString("palm.line.heart.depth.faint", value: "A subtle Heart Line can indicate a more reserved emotional nature, or someone who expresses feelings through actions rather than words.", comment: "Heart line faint depth interpretation")
    
    // Individual Line Interpretations - Head Line
    static let palmLineHeadTitle = NSLocalizedString("palm.line.head.title", value: "**Head Line - Intellect & Mental Approach**\n\n", comment: "Head line title")
    
    static let palmLineHeadLengthShort = NSLocalizedString("palm.line.head.length.short", value: "Your shorter Head Line suggests you're decisive and direct in your thinking. You focus on practical matters and get to the point quickly.\n\n", comment: "Head line short length interpretation")
    
    static let palmLineHeadLengthMedium = NSLocalizedString("palm.line.head.length.medium", value: "Your Head Line indicates balanced mental abilities. You can think both practically and creatively as situations require.\n\n", comment: "Head line medium length interpretation")
    
    static let palmLineHeadLengthLong = NSLocalizedString("palm.line.head.length.long", value: "Your long Head Line reveals a complex, analytical mind. You consider many angles and enjoy deep thinking and planning.\n\n", comment: "Head line long length interpretation")
    
    static let palmLineHeadDepthDeep = NSLocalizedString("palm.line.head.depth.deep", value: "The deep imprint of your Head Line shows strong mental focus and concentration. You have the ability to deeply analyze and solve complex problems.", comment: "Head line deep depth interpretation")
    
    static let palmLineHeadDepthModerate = NSLocalizedString("palm.line.head.depth.moderate", value: "Your Head Line's clarity suggests reliable mental processes and good judgment. You think things through without overthinking.", comment: "Head line moderate depth interpretation")
    
    static let palmLineHeadDepthFaint = NSLocalizedString("palm.line.head.depth.faint", value: "A lighter Head Line can indicate flexibility in thinking, or someone who trusts intuition as much as logic.", comment: "Head line faint depth interpretation")
    
    // Individual Line Interpretations - Life Line
    static let palmLineLifeTitle = NSLocalizedString("palm.line.life.title", value: "**Life Line - Vitality & Life Path**\n\n", comment: "Life line title")
    
    static let palmLineLifeLengthShort = NSLocalizedString("palm.line.life.length.short", value: "The length of your Life Line speaks to the intensity rather than duration of your vitality. You live fully in each moment.\n\n", comment: "Life line short length interpretation")
    
    static let palmLineLifeLengthMedium = NSLocalizedString("palm.line.life.length.medium", value: "Your Life Line indicates steady, reliable energy throughout your journey. You have the stamina for what life brings.\n\n", comment: "Life line medium length interpretation")
    
    static let palmLineLifeLengthLong = NSLocalizedString("palm.line.life.length.long", value: "Your long Life Line suggests robust vitality and endurance. You have the energy and resilience for a full, dynamic life.\n\n", comment: "Life line long length interpretation")
    
    static let palmLineLifeContinuityContinuous = NSLocalizedString("palm.line.life.continuity.continuous", value: "The continuous flow of your Life Line indicates a steady life path with smooth transitions. You adapt well to life's changes.", comment: "Life line continuous continuity interpretation")
    
    static let palmLineLifeContinuityBroken = NSLocalizedString("palm.line.life.continuity.broken", value: "Breaks in your Life Line suggest major life changes or transformative periods. These are opportunities for reinvention and growth.", comment: "Life line broken continuity interpretation")
    
    static let palmLineLifeContinuityChained = NSLocalizedString("palm.line.life.continuity.chained", value: "A chained pattern in your Life Line can indicate fluctuating energy levels or a path marked by various challenges that ultimately strengthen you.", comment: "Life line chained continuity interpretation")
    
    // Individual Line Interpretations - Fate Line
    static let palmLineFateTitle = NSLocalizedString("palm.line.fate.title", value: "**Fate Line - Destiny & External Influences**\n\n", comment: "Fate line title")
    
    static let palmLineFateDepthDeep = NSLocalizedString("palm.line.fate.depth.deep", value: "Your prominent Fate Line indicates a life strongly influenced by external forces, opportunities, and synchronicities. Events and people may play significant roles in shaping your path.\n\n", comment: "Fate line deep depth interpretation")
    
    static let palmLineFateDepthModerate = NSLocalizedString("palm.line.fate.depth.moderate", value: "Your Fate Line suggests a balance between predetermined circumstances and personal choice. You work with what life brings while steering your own course.\n\n", comment: "Fate line moderate depth interpretation")
    
    static let palmLineFateDepthFaint = NSLocalizedString("palm.line.fate.depth.faint", value: "A subtle Fate Line reveals that you have great freedom in creating your destiny. You are less bound by external circumstances and more empowered to forge your own path.\n\n", comment: "Fate line faint depth interpretation")
    
    static let palmLineFateClosing = NSLocalizedString("palm.line.fate.closing", value: "The Fate Line reminds us that while certain opportunities and challenges come our way, how we respond to them is always within our control.", comment: "Fate line closing statement")
    
    // Quick Summary - Formatted strings with parameters
    static func palmQuickSummaryHeart(_ depth: String, _ length: String) -> String {
        String(format: NSLocalizedString("palm.quickSummary.heart", value: "%@ and %@ - reflects your emotional depth and capacity for connection", comment: "Quick summary for heart line"), depth, length)
    }
    
    static func palmQuickSummaryHead(_ depth: String, _ length: String) -> String {
        String(format: NSLocalizedString("palm.quickSummary.head", value: "%@ and %@ - indicates your mental approach and decision-making style", comment: "Quick summary for head line"), depth, length)
    }
    
    static func palmQuickSummaryLife(_ depth: String, _ continuity: String) -> String {
        String(format: NSLocalizedString("palm.quickSummary.life", value: "%@ and %@ - represents your vitality and life journey", comment: "Quick summary for life line"), depth, continuity)
    }
    
    static func palmQuickSummaryFate(_ depth: String) -> String {
        String(format: NSLocalizedString("palm.quickSummary.fate", value: "%@ - shows the role of destiny and external influences in your path", comment: "Quick summary for fate line"), depth)
    }
    
    // MARK: - Learn Palmistry
    // Main Learn Palmistry View
    static let learnPalmistryHistoryTitle = NSLocalizedString("learnPalmistry.history.title", comment: "History of Palmistry")
    static let learnPalmistryHistorySubtitle = NSLocalizedString("learnPalmistry.history.subtitle", comment: "Origins and evolution")
    
    static let learnPalmistryBasicMeaningsTitle = NSLocalizedString("learnPalmistry.basicMeanings.title", comment: "Palm Basic Meanings")
    static let learnPalmistryBasicMeaningsSubtitle = NSLocalizedString("learnPalmistry.basicMeanings.subtitle", comment: "Lines, mounts and fingers")
    
    static let learnPalmistryHowToReadTitle = NSLocalizedString("learnPalmistry.howToRead.title", comment: "How to Read")
    static let learnPalmistryHowToReadSubtitle = NSLocalizedString("learnPalmistry.howToRead.subtitle", comment: "Master palm reading")
    
    static let learnPalmistryMindTitle = NSLocalizedString("learnPalmistry.mind.title", comment: "Palmistry & Mind")
    static let learnPalmistryMindSubtitle = NSLocalizedString("learnPalmistry.mind.subtitle", comment: "Self-discovery tool")
    
    static let learnPalmistryFaqTitle = NSLocalizedString("learnPalmistry.faq.title", comment: "FAQ")
    static let learnPalmistryFaqSubtitle = NSLocalizedString("learnPalmistry.faq.subtitle", comment: "Common questions")
    
    // History of Palmistry View
    static let historyOfPalmistryTitle = NSLocalizedString("historyOfPalmistry.title", comment: "History of Palmistry")
    static let historyOfPalmistrySubtitle = NSLocalizedString("historyOfPalmistry.subtitle", comment: "Ancient Art of Hand Reading")
    static let historyOfPalmistryIntro = NSLocalizedString("historyOfPalmistry.intro", comment: "Palmistry, also known as chiromancy, is one of humanity's oldest methods of divination and self-discovery. For thousands of years, people across cultures have looked to their hands for insights into character, destiny, and life's path.")
    
    static let historyOfPalmistryAncientTitle = NSLocalizedString("historyOfPalmistry.ancient.title", comment: "Ancient Origins")
    static let historyOfPalmistryAncientIntro = NSLocalizedString("historyOfPalmistry.ancient.intro", comment: "The practice of palm reading has roots in multiple ancient civilizations, each contributing unique perspectives to this sacred art.")
    
    static let historyOfPalmistryIndiaTitle = NSLocalizedString("historyOfPalmistry.india.title", comment: "India and Vedic Tradition")
    static let historyOfPalmistryIndiaText = NSLocalizedString("historyOfPalmistry.india.text", comment: "Ancient Hindu texts dating back 5,000 years contain detailed references to palm reading. The Vedic scriptures describe how the lines of the hand reflect one's karma and spiritual journey.")
    
    static let historyOfPalmistryChinaTitle = NSLocalizedString("historyOfPalmistry.china.title", comment: "China and I Ching")
    static let historyOfPalmistryChinaText = NSLocalizedString("historyOfPalmistry.china.text", comment: "In ancient China, palm reading was integrated with traditional medicine and philosophy. Practitioners believed the hand revealed the balance of yin and yang energies within the body.")
    
    static let historyOfPalmistryEgyptTitle = NSLocalizedString("historyOfPalmistry.egypt.title", comment: "Egypt and the Mysteries")
    static let historyOfPalmistryEgyptText = NSLocalizedString("historyOfPalmistry.egypt.text", comment: "Ancient Egyptians studied hands as a way to understand divine will. Hieroglyphics show priests examining palms during religious ceremonies and healing rituals.")
    
    static let historyOfPalmistryWesternTitle = NSLocalizedString("historyOfPalmistry.western.title", comment: "Western Development")
    static let historyOfPalmistryWesternIntro = NSLocalizedString("historyOfPalmistry.western.intro", comment: "Palmistry traveled westward along trade routes, evolving as it encountered Greek philosophy and European mysticism.")
    
    static let historyOfPalmistryGreeceTitle = NSLocalizedString("historyOfPalmistry.greece.title", comment: "Ancient Greece")
    static let historyOfPalmistryGreeceText = NSLocalizedString("historyOfPalmistry.greece.text", comment: "Aristotle and other Greek philosophers studied palmistry as a science. They associated different parts of the hand with planets and elements, creating systematic methods still used today.")
    
    static let historyOfPalmistryRenaissanceTitle = NSLocalizedString("historyOfPalmistry.renaissance.title", comment: "Renaissance Revival")
    static let historyOfPalmistryRenaissanceText = NSLocalizedString("historyOfPalmistry.renaissance.text", comment: "During the Renaissance, palmistry experienced a revival among European scholars who sought to merge ancient wisdom with emerging scientific methods.")
    
    static let historyOfPalmistryModernTitle = NSLocalizedString("historyOfPalmistry.modern.title", comment: "Modern Era")
    static let historyOfPalmistryModernText = NSLocalizedString("historyOfPalmistry.modern.text", comment: "In the 19th and 20th centuries, palmistry became popular in Western society. Notable practitioners like Cheiro brought palm reading to royal courts and wrote influential texts that standardized interpretations.")
    
    // History Timeline
    static let historyOfPalmistryTimelineTitle = NSLocalizedString("historyOfPalmistry.timeline.title", comment: "Timeline")
    static let historyOfPalmistryTimelineEraHeader = NSLocalizedString("historyOfPalmistry.timeline.era", comment: "Era")
    static let historyOfPalmistryTimelineMilestoneHeader = NSLocalizedString("historyOfPalmistry.timeline.milestone", comment: "Milestone")
    
    static let historyOfPalmistryTimelineEra1 = NSLocalizedString("historyOfPalmistry.timeline.era1", comment: "3000 BCE")
    static let historyOfPalmistryTimelineMilestone1 = NSLocalizedString("historyOfPalmistry.timeline.milestone1", comment: "Earliest references to palm reading appear in Vedic texts in India.")
    
    static let historyOfPalmistryTimelineEra2 = NSLocalizedString("historyOfPalmistry.timeline.era2", comment: "384–322 BCE")
    static let historyOfPalmistryTimelineMilestone2 = NSLocalizedString("historyOfPalmistry.timeline.milestone2", comment: "Aristotle writes about palmistry, establishing philosophical foundations.")
    
    static let historyOfPalmistryTimelineEra3 = NSLocalizedString("historyOfPalmistry.timeline.era3", comment: "Middle Ages")
    static let historyOfPalmistryTimelineMilestone3 = NSLocalizedString("historyOfPalmistry.timeline.milestone3", comment: "Palmistry spreads through Europe via Romani culture and scholarly texts.")
    
    static let historyOfPalmistryTimelineEra4 = NSLocalizedString("historyOfPalmistry.timeline.era4", comment: "Renaissance")
    static let historyOfPalmistryTimelineMilestone4 = NSLocalizedString("historyOfPalmistry.timeline.milestone4", comment: "European scholars revive interest in palmistry as both art and proto-science.")
    
    static let historyOfPalmistryTimelineEra5 = NSLocalizedString("historyOfPalmistry.timeline.era5", comment: "19th–20th Century")
    static let historyOfPalmistryTimelineMilestone5 = NSLocalizedString("historyOfPalmistry.timeline.milestone5", comment: "Palmistry gains popularity in Western society; standardized systems emerge.")
    
    // Palm Basic Meanings View
    static let palmBasicMeaningsTitle = NSLocalizedString("palmBasicMeanings.title", comment: "Palm Basic Meanings")
    static let palmBasicMeaningsSubtitle = NSLocalizedString("palmBasicMeanings.subtitle", comment: "Understanding Your Hand")
    static let palmBasicMeaningsDiagramTitle = NSLocalizedString("palmBasicMeanings.diagram.title", comment: "Palm Reading Map")
    
    static let palmBasicMeaningsMajorLinesTitle = NSLocalizedString("palmBasicMeanings.majorLines.title", comment: "The Major Lines")
    
    static let palmBasicMeaningsHeartLineTitle = NSLocalizedString("palmBasicMeanings.heartLine.title", comment: "Heart Line")
    static let palmBasicMeaningsHeartLineDescription = NSLocalizedString("palmBasicMeanings.heartLine.description", comment: "The uppermost horizontal line running across your palm.")
    static let palmBasicMeaningsHeartLineMeaning = NSLocalizedString("palmBasicMeanings.heartLine.meaning", comment: "Represents emotions, relationships, and how you give and receive love. A deep, clear line suggests strong emotional connections, while a faint line may indicate emotional reserve.")
    
    static let palmBasicMeaningsHeadLineTitle = NSLocalizedString("palmBasicMeanings.headLine.title", comment: "Head Line")
    static let palmBasicMeaningsHeadLineDescription = NSLocalizedString("palmBasicMeanings.headLine.description", comment: "The horizontal line below the Heart Line.")
    static let palmBasicMeaningsHeadLineMeaning = NSLocalizedString("palmBasicMeanings.headLine.meaning", comment: "Reveals your thinking style, intellect, and decision-making approach. A long line indicates analytical thinking, while a shorter line suggests more direct, practical reasoning.")
    
    static let palmBasicMeaningsLifeLineTitle = NSLocalizedString("palmBasicMeanings.lifeLine.title", comment: "Life Line")
    static let palmBasicMeaningsLifeLineDescription = NSLocalizedString("palmBasicMeanings.lifeLine.description", comment: "The curved line that wraps around the base of your thumb.")
    static let palmBasicMeaningsLifeLineMeaning = NSLocalizedString("palmBasicMeanings.lifeLine.meaning", comment: "Indicates vitality, physical health, and major life changes. Contrary to myth, it doesn't predict lifespan but shows the quality and intensity of your life energy.")
    
    static let palmBasicMeaningsFateLineTitle = NSLocalizedString("palmBasicMeanings.fateLine.title", comment: "Fate Line")
    static let palmBasicMeaningsFateLineDescription = NSLocalizedString("palmBasicMeanings.fateLine.description", comment: "A vertical line running up the center of the palm (not everyone has this line).")
    static let palmBasicMeaningsFateLineMeaning = NSLocalizedString("palmBasicMeanings.fateLine.meaning", comment: "Represents career, life direction, and the influence of external forces. A strong Fate Line suggests a clear path, while its absence indicates freedom to create your own destiny.")
    
    static let palmBasicMeaningsMountsTitle = NSLocalizedString("palmBasicMeanings.mounts.title", comment: "The Mounts")
    static let palmBasicMeaningsMountsIntro = NSLocalizedString("palmBasicMeanings.mounts.intro", comment: "Mounts are the fleshy pads on your palm, each associated with planetary energies and personality traits:")
    
    static let palmBasicMeaningsVenusTitle = NSLocalizedString("palmBasicMeanings.venus.title", comment: "Mount of Venus")
    static let palmBasicMeaningsVenusMeaning = NSLocalizedString("palmBasicMeanings.venus.meaning", comment: "Located at the base of the thumb. Represents love, passion, and vitality.")
    
    static let palmBasicMeaningsJupiterTitle = NSLocalizedString("palmBasicMeanings.jupiter.title", comment: "Mount of Jupiter")
    static let palmBasicMeaningsJupiterMeaning = NSLocalizedString("palmBasicMeanings.jupiter.meaning", comment: "Below the index finger. Associated with ambition, leadership, and confidence.")
    
    static let palmBasicMeaningsSaturnTitle = NSLocalizedString("palmBasicMeanings.saturn.title", comment: "Mount of Saturn")
    static let palmBasicMeaningsSaturnMeaning = NSLocalizedString("palmBasicMeanings.saturn.meaning", comment: "Below the middle finger. Relates to responsibility, wisdom, and discipline.")
    
    static let palmBasicMeaningsApolloTitle = NSLocalizedString("palmBasicMeanings.apollo.title", comment: "Mount of Apollo (Sun)")
    static let palmBasicMeaningsApolloMeaning = NSLocalizedString("palmBasicMeanings.apollo.meaning", comment: "Below the ring finger. Represents creativity, happiness, and success.")
    
    static let palmBasicMeaningsMercuryTitle = NSLocalizedString("palmBasicMeanings.mercury.title", comment: "Mount of Mercury")
    static let palmBasicMeaningsMercuryMeaning = NSLocalizedString("palmBasicMeanings.mercury.meaning", comment: "Below the pinky finger. Associated with communication, wit, and business acumen.")
    
    static let palmBasicMeaningsMarsTitle = NSLocalizedString("palmBasicMeanings.mars.title", comment: "Mounts of Mars")
    static let palmBasicMeaningsMarsMeaning = NSLocalizedString("palmBasicMeanings.mars.meaning", comment: "Two areas between thumb and fingers. Represent courage, aggression, and determination.")
    
    static let palmBasicMeaningsMoonTitle = NSLocalizedString("palmBasicMeanings.moon.title", comment: "Mount of the Moon")
    static let palmBasicMeaningsMoonMeaning = NSLocalizedString("palmBasicMeanings.moon.meaning", comment: "On the outer edge of palm. Relates to imagination, intuition, and emotions.")
    
    static let palmBasicMeaningsFingersTitle = NSLocalizedString("palmBasicMeanings.fingers.title", comment: "The Fingers")
    static let palmBasicMeaningsFingersIntro = NSLocalizedString("palmBasicMeanings.fingers.intro", comment: "Each finger carries its own significance:")
    
    static let palmBasicMeaningsThumbTitle = NSLocalizedString("palmBasicMeanings.thumb.title", comment: "Thumb")
    static let palmBasicMeaningsThumbMeaning = NSLocalizedString("palmBasicMeanings.thumb.meaning", comment: "Willpower, logic, and self-control.")
    
    static let palmBasicMeaningsIndexTitle = NSLocalizedString("palmBasicMeanings.index.title", comment: "Index Finger (Jupiter)")
    static let palmBasicMeaningsIndexMeaning = NSLocalizedString("palmBasicMeanings.index.meaning", comment: "Leadership, ambition, and authority.")
    
    static let palmBasicMeaningsMiddleTitle = NSLocalizedString("palmBasicMeanings.middle.title", comment: "Middle Finger (Saturn)")
    static let palmBasicMeaningsMiddleMeaning = NSLocalizedString("palmBasicMeanings.middle.meaning", comment: "Responsibility, balance, and introspection.")
    
    static let palmBasicMeaningsRingTitle = NSLocalizedString("palmBasicMeanings.ring.title", comment: "Ring Finger (Apollo)")
    static let palmBasicMeaningsRingMeaning = NSLocalizedString("palmBasicMeanings.ring.meaning", comment: "Creativity, expression, and happiness.")
    
    static let palmBasicMeaningsPinkyTitle = NSLocalizedString("palmBasicMeanings.pinky.title", comment: "Pinky Finger (Mercury)")
    static let palmBasicMeaningsPinkyMeaning = NSLocalizedString("palmBasicMeanings.pinky.meaning", comment: "Communication, intelligence, and persuasion.")
    
    // How to Read Palm View
    static let howToReadPalmTitle = NSLocalizedString("howToReadPalm.title", comment: "How to Read a Palm")
    
    static let howToReadPalmStep1Title = NSLocalizedString("howToReadPalm.step1.title", comment: "Choose the Hand")
    static let howToReadPalmStep1Intro = NSLocalizedString("howToReadPalm.step1.intro", comment: "The first step in palm reading is deciding which hand to read.")
    static let howToReadPalmStep1Bullet1Title = NSLocalizedString("howToReadPalm.step1.bullet1.title", comment: "Dominant Hand")
    static let howToReadPalmStep1Bullet1Text = NSLocalizedString("howToReadPalm.step1.bullet1.text", comment: "Your dominant hand (the one you write with) shows your present and future—how you're actively shaping your life through choices and actions.")
    static let howToReadPalmStep1Bullet2Title = NSLocalizedString("howToReadPalm.step1.bullet2.title", comment: "Non-Dominant Hand")
    static let howToReadPalmStep1Bullet2Text = NSLocalizedString("howToReadPalm.step1.bullet2.text", comment: "Your non-dominant hand represents your potential, inherited traits, and past influences—the foundation you were born with.")
    static let howToReadPalmStep1ProTip = NSLocalizedString("howToReadPalm.step1.proTip", comment: "For a complete reading, examine both hands and note the differences between them.")
    
    static let howToReadPalmStep2Title = NSLocalizedString("howToReadPalm.step2.title", comment: "Examine the Hand Shape")
    static let howToReadPalmStep2Intro = NSLocalizedString("howToReadPalm.step2.intro", comment: "The overall shape of the hand reveals personality traits, similar to the elements in astrology:")
    static let howToReadPalmStep2Bullet1Title = NSLocalizedString("howToReadPalm.step2.bullet1.title", comment: "Earth Hands (square palm, short fingers)")
    static let howToReadPalmStep2Bullet1Text = NSLocalizedString("howToReadPalm.step2.bullet1.text", comment: "Practical, grounded, reliable. Value stability and hard work.")
    static let howToReadPalmStep2Bullet2Title = NSLocalizedString("howToReadPalm.step2.bullet2.title", comment: "Air Hands (square palm, long fingers)")
    static let howToReadPalmStep2Bullet2Text = NSLocalizedString("howToReadPalm.step2.bullet2.text", comment: "Intellectual, communicative, social. Love ideas and mental stimulation.")
    static let howToReadPalmStep2Bullet3Title = NSLocalizedString("howToReadPalm.step2.bullet3.title", comment: "Water Hands (rectangular palm, long fingers)")
    static let howToReadPalmStep2Bullet3Text = NSLocalizedString("howToReadPalm.step2.bullet3.text", comment: "Emotional, intuitive, creative. Deeply sensitive to feelings.")
    static let howToReadPalmStep2Bullet4Title = NSLocalizedString("howToReadPalm.step2.bullet4.title", comment: "Fire Hands (rectangular palm, short fingers)")
    static let howToReadPalmStep2Bullet4Text = NSLocalizedString("howToReadPalm.step2.bullet4.text", comment: "Passionate, energetic, spontaneous. Driven by enthusiasm.")
    
    static let howToReadPalmStep3Title = NSLocalizedString("howToReadPalm.step3.title", comment: "Read the Major Lines")
    static let howToReadPalmStep3Intro = NSLocalizedString("howToReadPalm.step3.intro", comment: "Focus on the four main lines, paying attention to their depth, length, and any breaks or branches:")
    static let howToReadPalmStep3Bullet1Title = NSLocalizedString("howToReadPalm.step3.bullet1.title", comment: "Deep, clear lines")
    static let howToReadPalmStep3Bullet1Text = NSLocalizedString("howToReadPalm.step3.bullet1.text", comment: "Indicate strong energy in that area of life.")
    static let howToReadPalmStep3Bullet2Title = NSLocalizedString("howToReadPalm.step3.bullet2.title", comment: "Faint or broken lines")
    static let howToReadPalmStep3Bullet2Text = NSLocalizedString("howToReadPalm.step3.bullet2.text", comment: "Suggest challenges, transitions, or areas needing attention.")
    static let howToReadPalmStep3Bullet3Title = NSLocalizedString("howToReadPalm.step3.bullet3.title", comment: "Branches")
    static let howToReadPalmStep3Bullet3Text = NSLocalizedString("howToReadPalm.step3.bullet3.text", comment: "Usually positive, indicating opportunities or multiple paths.")
    static let howToReadPalmStep3ProTip = NSLocalizedString("howToReadPalm.step3.proTip", comment: "Lines can change over time! Your palm is not fixed—it evolves with you.")
    
    static let howToReadPalmStep4Title = NSLocalizedString("howToReadPalm.step4.title", comment: "Study the Mounts")
    static let howToReadPalmStep4Intro = NSLocalizedString("howToReadPalm.step4.intro", comment: "Feel the mounts (the fleshy pads) on your palm. Prominent mounts indicate strong traits:")
    static let howToReadPalmStep4Bullet1Title = NSLocalizedString("howToReadPalm.step4.bullet1.title", comment: "Well-developed mounts")
    static let howToReadPalmStep4Bullet1Text = NSLocalizedString("howToReadPalm.step4.bullet1.text", comment: "Show active qualities (e.g., prominent Venus mount = passionate nature).")
    static let howToReadPalmStep4Bullet2Title = NSLocalizedString("howToReadPalm.step4.bullet2.title", comment: "Flat mounts")
    static let howToReadPalmStep4Bullet2Text = NSLocalizedString("howToReadPalm.step4.bullet2.text", comment: "Suggest those qualities are less emphasized in your personality.")
    
    static let howToReadPalmStep5Title = NSLocalizedString("howToReadPalm.step5.title", comment: "Interpret Everything Together")
    static let howToReadPalmStep5Intro = NSLocalizedString("howToReadPalm.step5.intro", comment: "Palm reading is holistic—no single feature tells the whole story. Combine all elements:")
    static let howToReadPalmStep5Bullet1Title = NSLocalizedString("howToReadPalm.step5.bullet1.title", comment: "Look for patterns")
    static let howToReadPalmStep5Bullet1Text = NSLocalizedString("howToReadPalm.step5.bullet1.text", comment: "Do the hand shape and lines tell a consistent story?")
    static let howToReadPalmStep5Bullet2Title = NSLocalizedString("howToReadPalm.step5.bullet2.title", comment: "Trust intuition")
    static let howToReadPalmStep5Bullet2Text = NSLocalizedString("howToReadPalm.step5.bullet2.text", comment: "What stands out to you most? That's often where the important message lies.")
    
    static let howToReadPalmRememberTitle = NSLocalizedString("howToReadPalm.remember.title", comment: "Remember")
    static let howToReadPalmRememberText = NSLocalizedString("howToReadPalm.remember.text", comment: "Your palm is a map of tendencies, not a fixed fate. Use palmistry as a tool for self-understanding and growth, not prediction.")
    
    // Palmistry & Mind View
    static let palmistryMindTitle = NSLocalizedString("palmistryMind.title", comment: "Palmistry & Mind")
    static let palmistryMindSubtitle = NSLocalizedString("palmistryMind.subtitle", comment: "A Tool for Self-Discovery")
    
    static let palmistryMindSection1Title = NSLocalizedString("palmistryMind.section1.title", comment: "Palmistry as a Self-Discovery Tool")
    static let palmistryMindSection1Text = NSLocalizedString("palmistryMind.section1.text", comment: "Palmistry offers a unique mirror for self-reflection. By examining the lines and shapes of your hands, you engage in an ancient practice of introspection that can reveal patterns in your thinking, feeling, and behaving.")
    
    static let palmistryMindSection2Title = NSLocalizedString("palmistryMind.section2.title", comment: "The Mind-Body Connection")
    static let palmistryMindSection2Text = NSLocalizedString("palmistryMind.section2.text", comment: "Your hands are directly connected to your brain through more nerve endings than almost any other part of your body. Some practitioners believe that repeated thoughts and behaviors can actually shape the lines on your palms over time, creating a physical map of your mental and emotional patterns.")
    static let palmistryMindSection2Insight = NSLocalizedString("palmistryMind.section2.insight", comment: "This is why palmistry encourages you to see yourself not as fixed, but as constantly evolving. The person you become shapes the very lines you read.")
    
    static let palmistryMindSection3Title = NSLocalizedString("palmistryMind.section3.title", comment: "Understanding Personality Through Your Palm")
    static let palmistryMindSection3Intro = NSLocalizedString("palmistryMind.section3.intro", comment: "Palm reading can illuminate aspects of your personality you might not have fully recognized:")
    static let palmistryMindSection3Bullet1Title = NSLocalizedString("palmistryMind.section3.bullet1.title", comment: "Emotional Patterns")
    static let palmistryMindSection3Bullet1Text = NSLocalizedString("palmistryMind.section3.bullet1.text", comment: "The Heart Line reveals how you process emotions and form connections, helping you understand relationship patterns.")
    static let palmistryMindSection3Bullet2Title = NSLocalizedString("palmistryMind.section3.bullet2.title", comment: "Mental Approach")
    static let palmistryMindSection3Bullet2Text = NSLocalizedString("palmistryMind.section3.bullet2.text", comment: "The Head Line shows your thinking style—are you more analytical or intuitive? Practical or imaginative?")
    static let palmistryMindSection3Bullet3Title = NSLocalizedString("palmistryMind.section3.bullet3.title", comment: "Life Energy")
    static let palmistryMindSection3Bullet3Text = NSLocalizedString("palmistryMind.section3.bullet3.text", comment: "The Life Line indicates your vitality and how you approach challenges, revealing your core resilience.")
    
    static let palmistryMindSection4Title = NSLocalizedString("palmistryMind.section4.title", comment: "Palmistry for Awareness and Growth")
    static let palmistryMindSection4Intro = NSLocalizedString("palmistryMind.section4.intro", comment: "Using palmistry as a mindfulness practice can help you:")
    static let palmistryMindSection4Bullet1Title = NSLocalizedString("palmistryMind.section4.bullet1.title", comment: "Recognize Strengths")
    static let palmistryMindSection4Bullet1Text = NSLocalizedString("palmistryMind.section4.bullet1.text", comment: "Identify your natural talents and gifts that you can develop further.")
    static let palmistryMindSection4Bullet2Title = NSLocalizedString("palmistryMind.section4.bullet2.title", comment: "Acknowledge Challenges")
    static let palmistryMindSection4Bullet2Text = NSLocalizedString("palmistryMind.section4.bullet2.text", comment: "See where you might face obstacles, allowing you to prepare and adapt.")
    
    static let palmistryMindSection5Title = NSLocalizedString("palmistryMind.section5.title", comment: "The Power of Observation")
    static let palmistryMindSection5Text = NSLocalizedString("palmistryMind.section5.text", comment: "The simple act of studying your palm—really looking at it—creates a moment of presence and connection with yourself. In our busy lives, palmistry offers a reason to pause, reflect, and ask: 'Who am I? What am I becoming?'")
    
    static let palmistryMindConclusion = NSLocalizedString("palmistryMind.conclusion", comment: "Like tarot, palmistry doesn't dictate your fate—it illuminates possibilities. Your hands hold stories, but you're the author writing them.")
    static let palmistryMindInsightLabel = NSLocalizedString("palmistryMind.insight.label", comment: "Insight:")
    
    // Palmistry FAQ View
    static let palmistryFaqTitle = NSLocalizedString("palmistryFaq.title", comment: "Palmistry FAQ")
    static let palmistryFaqSubtitle = NSLocalizedString("palmistryFaq.subtitle", comment: "Frequently Asked Questions")
    
    static let palmistryFaqQuestion1 = NSLocalizedString("palmistryFaq.question1", comment: "Is palmistry scientifically proven?")
    static let palmistryFaqAnswer1 = NSLocalizedString("palmistryFaq.answer1", comment: "Palmistry is not scientifically validated. It's best understood as a tool for self-reflection and personal insight rather than empirical prediction.")
    
    static let palmistryFaqQuestion2 = NSLocalizedString("palmistryFaq.question2", comment: "Can palmistry predict my future?")
    static let palmistryFaqAnswer2 = NSLocalizedString("palmistryFaq.answer2", comment: "Palmistry doesn't predict fixed outcomes. It reveals tendencies, patterns, and potentials based on your current state. Your choices shape your future.")
    
    static let palmistryFaqQuestion3 = NSLocalizedString("palmistryFaq.question3", comment: "Which hand should I read?")
    static let palmistryFaqAnswer3 = NSLocalizedString("palmistryFaq.answer3", comment: "Your dominant hand shows your present and conscious choices. Your non-dominant hand reveals inherited traits and potential. Read both for a complete picture.")
    
    static let palmistryFaqQuestion4 = NSLocalizedString("palmistryFaq.question4", comment: "Do my palm lines change over time?")
    static let palmistryFaqAnswer4 = NSLocalizedString("palmistryFaq.answer4", comment: "Yes! Palm lines can and do change as you grow and your circumstances shift. They reflect your current life path, not a permanent fate.")
    
    static let palmistryFaqQuestion5 = NSLocalizedString("palmistryFaq.question5", comment: "Does the Life Line show how long I'll live?")
    static let palmistryFaqAnswer5 = NSLocalizedString("palmistryFaq.answer5", comment: "No. This is a common myth. The Life Line indicates vitality and life quality, not lifespan.")
    
    static let palmistryFaqQuestion6 = NSLocalizedString("palmistryFaq.question6", comment: "What if I don't have a Fate Line?")
    static let palmistryFaqAnswer6 = NSLocalizedString("palmistryFaq.answer6", comment: "Not everyone has a visible Fate Line. Its absence suggests freedom to create your own path without strong external influences.")
    
    static let palmistryFaqQuestion7 = NSLocalizedString("palmistryFaq.question7", comment: "What do breaks in my lines mean?")
    static let palmistryFaqAnswer7 = NSLocalizedString("palmistryFaq.answer7", comment: "Breaks can indicate transitions, challenges, or significant changes in that area of life. They're not necessarily negative—often they represent growth through transformation.")
    
    static let palmistryFaqQuestion8 = NSLocalizedString("palmistryFaq.question8", comment: "Can palmistry help with decisions?")
    static let palmistryFaqAnswer8 = NSLocalizedString("palmistryFaq.answer8", comment: "Palmistry can illuminate your natural tendencies and strengths, helping you make more informed choices. However, trust your judgment and intuition above all.")
    
    static let palmistryFaqQuestion9 = NSLocalizedString("palmistryFaq.question9", comment: "Do men and women's palms differ?")
    static let palmistryFaqAnswer9 = NSLocalizedString("palmistryFaq.answer9", comment: "The same principles apply to all palms regardless of gender. Individual variation matters more than gender-based differences.")
    
    static let palmistryFaqQuestion10 = NSLocalizedString("palmistryFaq.question10", comment: "Is palmistry connected to any religion?")
    static let palmistryFaqAnswer10 = NSLocalizedString("palmistryFaq.answer10", comment: "Palmistry has been practiced across many cultures and spiritual traditions, but it's not inherently religious. It's a tool anyone can use for self-understanding.")
    
    static let palmistryFaqDisclaimerTitle = NSLocalizedString("palmistryFaq.disclaimer.title", comment: "Important")
    static let palmistryFaqDisclaimerText = NSLocalizedString("palmistryFaq.disclaimer.text", comment: "Palmistry is intended for entertainment and self-reflection purposes only. It should not replace professional advice for health, legal, or financial matters.")
    
    // MARK: - Horoscope & Cosmogram
    static let time = NSLocalizedString("Time", comment: "A label for the time picker.")
    static let palmReadingCameraDescription = NSLocalizedString("To read your palm, we need access to your camera. Your palm image is processed locally and never leaves your device.", comment: "A description of the camera access required to read your palm.")
    static let todaysLuckyElements = NSLocalizedString("Today's Lucky Elements", comment: "A heading for the lucky elements of the day.")
    static let tryAgain = NSLocalizedString("Try Again", comment: "A button that triggers a new photo capture when pressed.")
    static let useMyBirthDate = NSLocalizedString("Use My Birth Date", comment: "A button that allows users to use their birth date to select their zodiac sign.")
    static let viewCardDetails = NSLocalizedString("View card details", comment: "A label describing a button that will open a new screen.")
    static let viewCardDetailsCapitalized = NSLocalizedString("View Card Details", comment: "A label describing a button that will open a new screen.")
    static let yearEnergy = NSLocalizedString("Year Energy", comment: "A label displayed in the year energy detail card.")
    static let yourBigThree = NSLocalizedString("Your Big Three", comment: "A heading for the user's Big Three zodiac signs.")
    
    // Format strings
    static func yourChartReveals(_ sun: String, _ moon: String, _ rising: String) -> String {
        String(format: NSLocalizedString("Your chart reveals a unique combination of energies. The %1$@ Sun gives you core vitality, while your %2$@ Moon shapes your emotional landscape. With %3$@ rising, you present yourself to the world with distinct grace. Together, these create your cosmic fingerprint.", comment: "A paragraph describing the user's cosmic blueprint, highlighting their Sun sign, Moon sign, and rising sign."), sun, moon, rising)
    }
    
    static let yourCosmicBlueprint = NSLocalizedString("Your Cosmic Blueprint", comment: "A title for the user's cosmic blueprint.")
    static let yourLifePathNumber = NSLocalizedString("Your Life Path Number", comment: "A label displayed above the user's life path number.")
    
    static func yourNumerologyComplements(_ sign: String) -> String {
        String(format: NSLocalizedString("Your numerology complements your %@ energy", comment: "A description of how the user's numerology relates to their zodiac sign."), sign)
    }
    
    static let yourPersonalNumbers = NSLocalizedString("Your Personal Numbers", comment: "A label displayed above the user's numerology numbers.")
    
    // MARK: - Cosmogram View
    static let enterYourBirthDateCosmogram = NSLocalizedString("cosmogram.enterBirthDate", comment: "Enter Your Birth Date")
    static let generateBirthChartPrompt = NSLocalizedString("cosmogram.generatePrompt", comment: "Generate your personal birth chart based on your birth date")
    static let addBirthDateButton = NSLocalizedString("cosmogram.addBirthDate", comment: "Add Birth Date")
    static let bigThreeTitle = NSLocalizedString("cosmogram.bigThree", comment: "Your Big Three")
    static let sunSignTitle = NSLocalizedString("cosmogram.sunSign", comment: "Sun Sign")
    static let sunSignDescription = NSLocalizedString("cosmogram.sunSign.desc", comment: "Your core identity and life force")
    static let moonSignTitle = NSLocalizedString("cosmogram.moonSign", comment: "Moon Sign")
    static let moonSignDescription = NSLocalizedString("cosmogram.moonSign.desc", comment: "Your emotional nature and inner world")
    static let risingSignTitle = NSLocalizedString("cosmogram.risingSign", comment: "Rising Sign")
    static let risingSignDescription = NSLocalizedString("cosmogram.risingSign.desc", comment: "Your outward personality and first impression")
    static let elementalBalanceTitle = NSLocalizedString("cosmogram.elementalBalance", comment: "Elemental Balance")
    static let elementFire = NSLocalizedString("cosmogram.element.fire", comment: "Fire")
    static let elementEarth = NSLocalizedString("cosmogram.element.earth", comment: "Earth")
    static let elementAir = NSLocalizedString("cosmogram.element.air", comment: "Air")
    static let elementWater = NSLocalizedString("cosmogram.element.water", comment: "Water")
    
    // Cosmogram element balance descriptions
    static func elementBalanceSame(_ element: String) -> String {
        String(format: NSLocalizedString("cosmogram.elementBalance.same", comment: "All three placements share the %@ element, creating powerful focus and intensity in this energy."), element)
    }
    static let elementBalanceTwoElements = NSLocalizedString("cosmogram.elementBalance.two", comment: "Your chart balances two elemental energies, creating dynamic interplay between different life approaches.")
    static let elementBalanceThreeElements = NSLocalizedString("cosmogram.elementBalance.three", comment: "Three different elements create a well-rounded, multifaceted personality with diverse strengths and perspectives.")
    
    // Cosmogram sign descriptions
    static func sunSignDetail(_ sign: String) -> String {
        String(format: NSLocalizedString("cosmogram.sunSign.detail", comment: "Your Sun in %@ illuminates your path with unique qualities. This is your essential self, your vitality, and the core of your being."), sign)
    }
    static func moonSignDetail(_ sign: String) -> String {
        String(format: NSLocalizedString("cosmogram.moonSign.detail", comment: "With the Moon in %@, your emotional world is colored by distinct sensibilities. This placement reveals how you process feelings and seek comfort."), sign)
    }
    static func risingSignDetail(_ sign: String) -> String {
        String(format: NSLocalizedString("cosmogram.risingSign.detail", comment: "%@ rising shapes how others perceive you and how you approach new situations. This is your mask and your authentic first impression."), sign)
    }
    
    // MARK: - Horoscope View
    static let selectYourZodiacSign = NSLocalizedString("Select Your Zodiac Sign", comment: "Prompt for selecting zodiac sign")
    static let chooseManually = NSLocalizedString("Choose Manually", comment: "Button to manually choose zodiac sign")
    static let todaysOverview = NSLocalizedString("Today's Overview", comment: "Horoscope section title")
    static let loveAndRelationships = NSLocalizedString("Love & Relationships", comment: "Horoscope section title")
    static let careerAndFinance = NSLocalizedString("Career & Finance", comment: "Horoscope section title")
    
    // Lucky Elements
    static let color = NSLocalizedString("Color", comment: "Lucky color label")
    static let number = NSLocalizedString("Number", comment: "Lucky number label")
    
    // Lucky Colors
    static let luckyColorGold = NSLocalizedString("Gold", comment: "Lucky color: Gold")
    static let luckyColorSilver = NSLocalizedString("Silver", comment: "Lucky color: Silver")
    static let luckyColorBlue = NSLocalizedString("Blue", comment: "Lucky color: Blue")
    static let luckyColorGreen = NSLocalizedString("Green", comment: "Lucky color: Green")
    static let luckyColorRed = NSLocalizedString("Red", comment: "Lucky color: Red")
    static let luckyColorPurple = NSLocalizedString("Purple", comment: "Lucky color: Purple")
    static let luckyColorOrange = NSLocalizedString("Orange", comment: "Lucky color: Orange")
    
    // Lucky Times
    static let luckyTimeMorning = NSLocalizedString("Morning", comment: "Lucky time: Morning")
    static let luckyTimeNoon = NSLocalizedString("Noon", comment: "Lucky time: Noon")
    static let luckyTimeAfternoon = NSLocalizedString("Afternoon", comment: "Lucky time: Afternoon")
    static let luckyTimeEvening = NSLocalizedString("Evening", comment: "Lucky time: Evening")
    static let luckyTimeNight = NSLocalizedString("Night", comment: "Lucky time: Night")
    
    // Sign Picker
    static let selectYourSign = NSLocalizedString("Select Your Sign", comment: "Sign picker title")
    
    // Zodiac Date Ranges
    static let ariesDateRange = NSLocalizedString("Mar 21 - Apr 19", comment: "Aries date range")
    static let taurusDateRange = NSLocalizedString("Apr 20 - May 20", comment: "Taurus date range")
    static let geminiDateRange = NSLocalizedString("May 21 - Jun 20", comment: "Gemini date range")
    static let cancerDateRange = NSLocalizedString("Jun 21 - Jul 22", comment: "Cancer date range")
    static let leoDateRange = NSLocalizedString("Jul 23 - Aug 22", comment: "Leo date range")
    static let virgoDateRange = NSLocalizedString("Aug 23 - Sep 22", comment: "Virgo date range")
    static let libraDateRange = NSLocalizedString("Sep 23 - Oct 22", comment: "Libra date range")
    static let scorpioDateRange = NSLocalizedString("Oct 23 - Nov 21", comment: "Scorpio date range")
    static let sagittariusDateRange = NSLocalizedString("Nov 22 - Dec 21", comment: "Sagittarius date range")
    static let capricornDateRange = NSLocalizedString("Dec 22 - Jan 19", comment: "Capricorn date range")
    static let aquariusDateRange = NSLocalizedString("Jan 20 - Feb 18", comment: "Aquarius date range")
    static let piscesDateRange = NSLocalizedString("Feb 19 - Mar 20", comment: "Pisces date range")
    
    // Daily Readings (5 variations)
    static let dailyReading1 = NSLocalizedString("Today brings fresh opportunities for growth. Trust your instincts and embrace new experiences with an open heart.", comment: "Daily horoscope reading variation 1")
    static let dailyReading2 = NSLocalizedString("The cosmic energy today favors reflection and planning. Take time to consider your next steps carefully.", comment: "Daily horoscope reading variation 2")
    static let dailyReading3 = NSLocalizedString("Your natural strengths shine brightly today. Don't hesitate to showcase your talents and unique perspective.", comment: "Daily horoscope reading variation 3")
    static let dailyReading4 = NSLocalizedString("A day of unexpected connections and meaningful conversations. Stay open to wisdom from unlikely sources.", comment: "Daily horoscope reading variation 4")
    static let dailyReading5 = NSLocalizedString("Today's energy supports transformation. Let go of what no longer serves you and welcome positive change.", comment: "Daily horoscope reading variation 5")
    
    // Love Readings (5 variations)
    static let loveReading1 = NSLocalizedString("Communication flows easily in your relationships today. Express your feelings with honesty and compassion.", comment: "Love horoscope reading variation 1")
    static let loveReading2 = NSLocalizedString("A romantic opportunity may present itself unexpectedly. Stay present and authentic in your interactions.", comment: "Love horoscope reading variation 2")
    static let loveReading3 = NSLocalizedString("Focus on deepening existing bonds rather than seeking new connections. Quality over quantity brings fulfillment.", comment: "Love horoscope reading variation 3")
    static let loveReading4 = NSLocalizedString("Your emotional intuition is heightened. Trust your heart's wisdom in matters of love and connection.", comment: "Love horoscope reading variation 4")
    static let loveReading5 = NSLocalizedString("Independence and partnership find beautiful balance today. Honor both your needs and those of loved ones.", comment: "Love horoscope reading variation 5")
    
    // Career Readings (5 variations)
    static let careerReading1 = NSLocalizedString("Professional recognition is on the horizon. Your hard work and dedication are being noticed by those who matter.", comment: "Career horoscope reading variation 1")
    static let careerReading2 = NSLocalizedString("Collaboration brings success today. Seek input from colleagues and build on collective wisdom.", comment: "Career horoscope reading variation 2")
    static let careerReading3 = NSLocalizedString("Financial decisions require careful consideration. Trust your analytical mind and avoid impulsive choices.", comment: "Career horoscope reading variation 3")
    static let careerReading4 = NSLocalizedString("Your creative solutions impress others. Don't be afraid to think outside the box and propose innovative ideas.", comment: "Career horoscope reading variation 4")
    static let careerReading5 = NSLocalizedString("A good day for planning long-term goals. Set clear intentions and take practical steps toward your aspirations.", comment: "Career horoscope reading variation 5")
    
    // MARK: - Numerology View
    static let enterYourBirthDate = NSLocalizedString("Enter Your Birth Date", comment: "Prompt to enter birth date for numerology")
    static let discoverNumerologyProfile = NSLocalizedString("Discover your numerology profile based on your birth date", comment: "Description of numerology feature")
    static let addBirthDate = NSLocalizedString("Add Birth Date", comment: "Button to add birth date")
    
    // Personal Numbers
    static let expression = NSLocalizedString("Expression", comment: "Expression number label")
    static let soulUrge = NSLocalizedString("Soul Urge", comment: "Soul urge number label")
    static let birthday = NSLocalizedString("Birthday", comment: "Birthday number label")
    static let maturity = NSLocalizedString("Maturity", comment: "Maturity number label")
    
    // Personal Number Descriptions
    static let yourNaturalTalents = NSLocalizedString("Your natural talents", comment: "Expression number description")
    static let yourInnerDesires = NSLocalizedString("Your inner desires", comment: "Soul urge number description")
    static let yourSpecialGift = NSLocalizedString("Your special gift", comment: "Birthday number description")
    static let yourLaterLifeFocus = NSLocalizedString("Your later life focus", comment: "Maturity number description")
    
    // Life Path Meanings
    static let lifePathMeaning1 = NSLocalizedString("The Leader - Independent, ambitious, and pioneering. You are here to forge new paths and inspire others with your courage.", comment: "Life path 1 meaning")
    static let lifePathMeaning2 = NSLocalizedString("The Peacemaker - Diplomatic, sensitive, and cooperative. You bring harmony and balance to relationships and situations.", comment: "Life path 2 meaning")
    static let lifePathMeaning3 = NSLocalizedString("The Creative - Expressive, optimistic, and social. You inspire joy and creativity in everything you touch.", comment: "Life path 3 meaning")
    static let lifePathMeaning4 = NSLocalizedString("The Builder - Practical, disciplined, and hardworking. You create solid foundations and lasting structures.", comment: "Life path 4 meaning")
    static let lifePathMeaning5 = NSLocalizedString("The Freedom Seeker - Adventurous, versatile, and dynamic. You embrace change and seek diverse experiences.", comment: "Life path 5 meaning")
    static let lifePathMeaning6 = NSLocalizedString("The Nurturer - Responsible, caring, and protective. You create harmony in home and community.", comment: "Life path 6 meaning")
    static let lifePathMeaning7 = NSLocalizedString("The Seeker - Analytical, introspective, and spiritual. You search for deeper truths and wisdom.", comment: "Life path 7 meaning")
    static let lifePathMeaning8 = NSLocalizedString("The Powerhouse - Ambitious, authoritative, and material. You master the material world with confidence.", comment: "Life path 8 meaning")
    static let lifePathMeaning9 = NSLocalizedString("The Humanitarian - Compassionate, wise, and selfless. You serve the greater good with understanding.", comment: "Life path 9 meaning")
    static let lifePathMeaning11 = NSLocalizedString("The Illuminator - Intuitive, inspirational, and enlightened. You bring spiritual insights to the world.", comment: "Life path 11 meaning")
    static let lifePathMeaning22 = NSLocalizedString("The Master Builder - Visionary, practical, and transformative. You manifest grand visions into reality.", comment: "Life path 22 meaning")
    static let lifePathMeaningDefault = NSLocalizedString("Your unique number holds special meaning in your life journey.", comment: "Default life path meaning")
    
    // MARK: - Learn Destiny Matrix
    // Main Learn Destiny Matrix View
    static let homeLearnDestinyMatrix = NSLocalizedString("home.learnDestinyMatrix", comment: "Learn Matrix")
    static let homeLearnDestinyMatrixSubtitle = NSLocalizedString("home.learnDestinyMatrix.subtitle", comment: "Understand the 22 energies and your chart")

    static let learnDestinyMatrixTitle = NSLocalizedString("learnDestinyMatrix.title", comment: "Learn Destiny Matrix")
    static let learnDestinyMatrixSubtitle = NSLocalizedString("learnDestinyMatrix.subtitle", comment: "Decode the blueprint of your soul")

    // Learn Options
    static let learnDestinyMatrixHistoryTitle = NSLocalizedString("learnDestinyMatrix.history.title", comment: "History of the Matrix")
    static let learnDestinyMatrixHistorySubtitle = NSLocalizedString("learnDestinyMatrix.history.subtitle", comment: "Origins and evolution")

    static let learnDestinyMatrixBasicMeaningsTitle = NSLocalizedString("learnDestinyMatrix.basicMeanings.title", comment: "The 22 Energies")
    static let learnDestinyMatrixBasicMeaningsSubtitle = NSLocalizedString("learnDestinyMatrix.basicMeanings.subtitle", comment: "Archetypes and meanings")

    static let learnDestinyMatrixHowToReadTitle = NSLocalizedString("learnDestinyMatrix.howToRead.title", comment: "How to Read Your Matrix")
    static let learnDestinyMatrixHowToReadSubtitle = NSLocalizedString("learnDestinyMatrix.howToRead.subtitle", comment: "Map your personal chart")

    static let learnDestinyMatrixMindTitle = NSLocalizedString("learnDestinyMatrix.mind.title", comment: "Matrix & Mind")
    static let learnDestinyMatrixMindSubtitle = NSLocalizedString("learnDestinyMatrix.mind.subtitle", comment: "Self-reflection tool")

    static let learnDestinyMatrixFaqTitle = NSLocalizedString("learnDestinyMatrix.faq.title", comment: "FAQ")
    static let learnDestinyMatrixFaqSubtitle = NSLocalizedString("learnDestinyMatrix.faq.subtitle", comment: "Common questions")

    // History of Destiny Matrix View
    static let historyOfMatrixTitle = NSLocalizedString("historyOfMatrix.title", comment: "History of the Destiny Matrix")
    static let historyOfMatrixSubtitle = NSLocalizedString("historyOfMatrix.subtitle", comment: "Ancient Wisdom, Modern System")
    static let historyOfMatrixIntro = NSLocalizedString("historyOfMatrix.intro", comment: "The Destiny Matrix is a contemporary spiritual system that blends ancient wisdom traditions—numerology, the Major Arcana of the Tarot, and Eastern energy practices—into a single personal chart calculated from your date of birth.")

    static let historyOfMatrixRootsTitle = NSLocalizedString("historyOfMatrix.roots.title", comment: "Ancient Roots")
    static let historyOfMatrixRootsIntro = NSLocalizedString("historyOfMatrix.roots.intro", comment: "Though the Matrix itself is a modern system, every part of it draws from traditions that span thousands of years.")

    static let historyOfMatrixNumerologyTitle = NSLocalizedString("historyOfMatrix.numerology.title", comment: "Pythagorean Numerology")
    static let historyOfMatrixNumerologyText = NSLocalizedString("historyOfMatrix.numerology.text", comment: "The mathematical backbone of the Matrix comes from Pythagorean numerology (6th century BCE), which taught that numbers carry archetypal vibrations and that a birth date reveals a soul's blueprint.")

    static let historyOfMatrixTarotTitle = NSLocalizedString("historyOfMatrix.tarot.title", comment: "Tarot's Major Arcana")
    static let historyOfMatrixTarotText = NSLocalizedString("historyOfMatrix.tarot.text", comment: "The 22 energies of the Matrix correspond directly to the 22 Major Arcana of the Tarot—archetypes refined in Renaissance Europe to describe every stage of the human journey from The Fool to The World.")

    static let historyOfMatrixChakraTitle = NSLocalizedString("historyOfMatrix.chakra.title", comment: "Vedic Chakra System")
    static let historyOfMatrixChakraText = NSLocalizedString("historyOfMatrix.chakra.text", comment: "From the Indian Vedic tradition, the Matrix borrows the seven-chakra model used to describe how life energy flows through key centers in the human body, from material survival to higher spiritual awareness.")

    static let historyOfMatrixModernTitle = NSLocalizedString("historyOfMatrix.modern.title", comment: "Modern Formulation")
    static let historyOfMatrixModernIntro = NSLocalizedString("historyOfMatrix.modern.intro", comment: "The system as practiced today took shape in the early 21st century, drawing the older traditions together into one diagram.")

    static let historyOfMatrixLadiniTitle = NSLocalizedString("historyOfMatrix.ladini.title", comment: "Natalia Ladini")
    static let historyOfMatrixLadiniText = NSLocalizedString("historyOfMatrix.ladini.text", comment: "Russian researcher Natalia Ladini is credited with systematizing the modern Destiny Matrix in the 2000s, mapping the 22 archetypes onto a precise octagonal diagram derived from the birth date.")

    static let historyOfMatrixGlobalTitle = NSLocalizedString("historyOfMatrix.global.title", comment: "Global Spread")
    static let historyOfMatrixGlobalText = NSLocalizedString("historyOfMatrix.global.text", comment: "From Eastern Europe, the Matrix has spread worldwide, embraced by coaches, healers, and self-development practitioners as a practical tool for archetypal self-discovery.")

    // History Timeline
    static let historyOfMatrixTimelineTitle = NSLocalizedString("historyOfMatrix.timeline.title", comment: "Timeline")
    static let historyOfMatrixTimelineEraHeader = NSLocalizedString("historyOfMatrix.timeline.era", comment: "Era")
    static let historyOfMatrixTimelineMilestoneHeader = NSLocalizedString("historyOfMatrix.timeline.milestone", comment: "Milestone")

    static let historyOfMatrixTimelineEra1 = NSLocalizedString("historyOfMatrix.timeline.era1", comment: "6th c. BCE")
    static let historyOfMatrixTimelineMilestone1 = NSLocalizedString("historyOfMatrix.timeline.milestone1", comment: "Pythagoras teaches that numbers express the divine order of the cosmos.")

    static let historyOfMatrixTimelineEra2 = NSLocalizedString("historyOfMatrix.timeline.era2", comment: "Ancient India")
    static let historyOfMatrixTimelineMilestone2 = NSLocalizedString("historyOfMatrix.timeline.milestone2", comment: "Vedic texts describe the seven chakras as centers of life energy.")

    static let historyOfMatrixTimelineEra3 = NSLocalizedString("historyOfMatrix.timeline.era3", comment: "15th century")
    static let historyOfMatrixTimelineMilestone3 = NSLocalizedString("historyOfMatrix.timeline.milestone3", comment: "The Major Arcana of the Tarot is shaped in Renaissance Italy.")

    static let historyOfMatrixTimelineEra4 = NSLocalizedString("historyOfMatrix.timeline.era4", comment: "20th century")
    static let historyOfMatrixTimelineMilestone4 = NSLocalizedString("historyOfMatrix.timeline.milestone4", comment: "Jungian archetype theory revives interest in symbolic self-knowledge.")

    static let historyOfMatrixTimelineEra5 = NSLocalizedString("historyOfMatrix.timeline.era5", comment: "2000s")
    static let historyOfMatrixTimelineMilestone5 = NSLocalizedString("historyOfMatrix.timeline.milestone5", comment: "Natalia Ladini systematizes the modern Destiny Matrix.")

    // Matrix Basic Meanings View
    static let matrixBasicMeaningsTitle = NSLocalizedString("matrixBasicMeanings.title", comment: "The 22 Energies")
    static let matrixBasicMeaningsSubtitle = NSLocalizedString("matrixBasicMeanings.subtitle", comment: "Archetypes of the Matrix")
    static let matrixBasicMeaningsIntro = NSLocalizedString("matrixBasicMeanings.intro", comment: "Every position in the Destiny Matrix is filled by one of 22 universal energies. Each energy carries a gift to develop and a shadow to integrate. These archetypes correspond to the 22 Major Arcana of the Tarot.")
    static let matrixBasicMeaningsListTitle = NSLocalizedString("matrixBasicMeanings.list.title", comment: "The 22 Archetypes")
    static let matrixBasicMeaningsLightLabel = NSLocalizedString("matrixBasicMeanings.light.label", comment: "Light")
    static let matrixBasicMeaningsShadowLabel = NSLocalizedString("matrixBasicMeanings.shadow.label", comment: "Shadow")

    // 22 Energies — name, light, shadow
    static let matrixEnergy1Name = NSLocalizedString("matrixEnergy.1.name", comment: "1 — The Magician")
    static let matrixEnergy1Light = NSLocalizedString("matrixEnergy.1.light", comment: "Initiative, willpower, focused action, mastery of skills.")
    static let matrixEnergy1Shadow = NSLocalizedString("matrixEnergy.1.shadow", comment: "Manipulation, scattered energy, ego-driven choices.")

    static let matrixEnergy2Name = NSLocalizedString("matrixEnergy.2.name", comment: "2 — The High Priestess")
    static let matrixEnergy2Light = NSLocalizedString("matrixEnergy.2.light", comment: "Intuition, inner wisdom, calm depth, sacred knowledge.")
    static let matrixEnergy2Shadow = NSLocalizedString("matrixEnergy.2.shadow", comment: "Coldness, secrecy, withdrawal from life.")

    static let matrixEnergy3Name = NSLocalizedString("matrixEnergy.3.name", comment: "3 — The Empress")
    static let matrixEnergy3Light = NSLocalizedString("matrixEnergy.3.light", comment: "Creativity, abundance, nurturing love, sensual joy.")
    static let matrixEnergy3Shadow = NSLocalizedString("matrixEnergy.3.shadow", comment: "Possessiveness, dependency, smothering care.")

    static let matrixEnergy4Name = NSLocalizedString("matrixEnergy.4.name", comment: "4 — The Emperor")
    static let matrixEnergy4Light = NSLocalizedString("matrixEnergy.4.light", comment: "Leadership, structure, stability, mastery of resources.")
    static let matrixEnergy4Shadow = NSLocalizedString("matrixEnergy.4.shadow", comment: "Tyranny, rigidity, need to control everything.")

    static let matrixEnergy5Name = NSLocalizedString("matrixEnergy.5.name", comment: "5 — The Hierophant")
    static let matrixEnergy5Light = NSLocalizedString("matrixEnergy.5.light", comment: "Teaching, tradition, wisdom transmitted to others.")
    static let matrixEnergy5Shadow = NSLocalizedString("matrixEnergy.5.shadow", comment: "Dogmatism, conformity, fear of new ideas.")

    static let matrixEnergy6Name = NSLocalizedString("matrixEnergy.6.name", comment: "6 — The Lovers")
    static let matrixEnergy6Light = NSLocalizedString("matrixEnergy.6.light", comment: "Conscious choice, alignment of values, soulful partnership.")
    static let matrixEnergy6Shadow = NSLocalizedString("matrixEnergy.6.shadow", comment: "Indecision, codependency, divided heart.")

    static let matrixEnergy7Name = NSLocalizedString("matrixEnergy.7.name", comment: "7 — The Chariot")
    static let matrixEnergy7Light = NSLocalizedString("matrixEnergy.7.light", comment: "Willpower, discipline, victory through focused effort.")
    static let matrixEnergy7Shadow = NSLocalizedString("matrixEnergy.7.shadow", comment: "Aggression, ego conflict, overdrive.")

    static let matrixEnergy8Name = NSLocalizedString("matrixEnergy.8.name", comment: "8 — Justice")
    static let matrixEnergy8Light = NSLocalizedString("matrixEnergy.8.light", comment: "Fairness, balance, honest decisions, karmic harmony.")
    static let matrixEnergy8Shadow = NSLocalizedString("matrixEnergy.8.shadow", comment: "Harsh judgment, score-keeping, cold detachment.")

    static let matrixEnergy9Name = NSLocalizedString("matrixEnergy.9.name", comment: "9 — The Hermit")
    static let matrixEnergy9Light = NSLocalizedString("matrixEnergy.9.light", comment: "Inner search, solitude as gift, mentorship, deep wisdom.")
    static let matrixEnergy9Shadow = NSLocalizedString("matrixEnergy.9.shadow", comment: "Isolation, avoidance of intimacy, loneliness.")

    static let matrixEnergy10Name = NSLocalizedString("matrixEnergy.10.name", comment: "10 — Wheel of Fortune")
    static let matrixEnergy10Light = NSLocalizedString("matrixEnergy.10.light", comment: "Trust in cycles, lucky timing, faith in the flow of life.")
    static let matrixEnergy10Shadow = NSLocalizedString("matrixEnergy.10.shadow", comment: "Passivity, gambling on chance, blaming fate.")

    static let matrixEnergy11Name = NSLocalizedString("matrixEnergy.11.name", comment: "11 — Strength")
    static let matrixEnergy11Light = NSLocalizedString("matrixEnergy.11.light", comment: "Courage, gentle power, mastery of impulses, inner calm.")
    static let matrixEnergy11Shadow = NSLocalizedString("matrixEnergy.11.shadow", comment: "Brutality, suppressed anger, raw force.")

    static let matrixEnergy12Name = NSLocalizedString("matrixEnergy.12.name", comment: "12 — The Hanged Man")
    static let matrixEnergy12Light = NSLocalizedString("matrixEnergy.12.light", comment: "Sacrifice for growth, surrender, fresh perspective.")
    static let matrixEnergy12Shadow = NSLocalizedString("matrixEnergy.12.shadow", comment: "Victimhood, stagnation, martyr complex.")

    static let matrixEnergy13Name = NSLocalizedString("matrixEnergy.13.name", comment: "13 — Death (Transformation)")
    static let matrixEnergy13Light = NSLocalizedString("matrixEnergy.13.light", comment: "Endings that bring renewal, deep transformation, rebirth.")
    static let matrixEnergy13Shadow = NSLocalizedString("matrixEnergy.13.shadow", comment: "Clinging to the past, fear of letting go.")

    static let matrixEnergy14Name = NSLocalizedString("matrixEnergy.14.name", comment: "14 — Temperance")
    static let matrixEnergy14Light = NSLocalizedString("matrixEnergy.14.light", comment: "Integration, healing, balance of opposites, harmony.")
    static let matrixEnergy14Shadow = NSLocalizedString("matrixEnergy.14.shadow", comment: "Extremes, imbalance, impatience with process.")

    static let matrixEnergy15Name = NSLocalizedString("matrixEnergy.15.name", comment: "15 — The Devil")
    static let matrixEnergy15Light = NSLocalizedString("matrixEnergy.15.light", comment: "Magnetism, sensual aliveness, healthy material drive.")
    static let matrixEnergy15Shadow = NSLocalizedString("matrixEnergy.15.shadow", comment: "Addiction, attachment, shadow appetites, manipulation.")

    static let matrixEnergy16Name = NSLocalizedString("matrixEnergy.16.name", comment: "16 — The Tower")
    static let matrixEnergy16Light = NSLocalizedString("matrixEnergy.16.light", comment: "Sudden breakthroughs, liberation from false structures.")
    static let matrixEnergy16Shadow = NSLocalizedString("matrixEnergy.16.shadow", comment: "Crisis, destruction, ego collapse, abrupt loss.")

    static let matrixEnergy17Name = NSLocalizedString("matrixEnergy.17.name", comment: "17 — The Star")
    static let matrixEnergy17Light = NSLocalizedString("matrixEnergy.17.light", comment: "Hope, inspiration, talent, healing radiance.")
    static let matrixEnergy17Shadow = NSLocalizedString("matrixEnergy.17.shadow", comment: "Idealization, escapism, disconnect from reality.")

    static let matrixEnergy18Name = NSLocalizedString("matrixEnergy.18.name", comment: "18 — The Moon")
    static let matrixEnergy18Light = NSLocalizedString("matrixEnergy.18.light", comment: "Dreams, deep intuition, contact with the subconscious.")
    static let matrixEnergy18Shadow = NSLocalizedString("matrixEnergy.18.shadow", comment: "Illusion, fear, anxiety, hidden enemies of the mind.")

    static let matrixEnergy19Name = NSLocalizedString("matrixEnergy.19.name", comment: "19 — The Sun")
    static let matrixEnergy19Light = NSLocalizedString("matrixEnergy.19.light", comment: "Joy, vitality, success, radiant self-expression.")
    static let matrixEnergy19Shadow = NSLocalizedString("matrixEnergy.19.shadow", comment: "Ego inflation, burnout, demand for constant praise.")

    static let matrixEnergy20Name = NSLocalizedString("matrixEnergy.20.name", comment: "20 — Judgment")
    static let matrixEnergy20Light = NSLocalizedString("matrixEnergy.20.light", comment: "Calling, awakening, hearing your life's purpose.")
    static let matrixEnergy20Shadow = NSLocalizedString("matrixEnergy.20.shadow", comment: "Self-judgment, guilt, fear of being seen.")

    static let matrixEnergy21Name = NSLocalizedString("matrixEnergy.21.name", comment: "21 — The World")
    static let matrixEnergy21Light = NSLocalizedString("matrixEnergy.21.light", comment: "Completion, integration, wholeness, mastery of a cycle.")
    static let matrixEnergy21Shadow = NSLocalizedString("matrixEnergy.21.shadow", comment: "Stagnation in comfort, fear of the next chapter.")

    static let matrixEnergy22Name = NSLocalizedString("matrixEnergy.22.name", comment: "22 — The Fool")
    static let matrixEnergy22Light = NSLocalizedString("matrixEnergy.22.light", comment: "Freedom, openness, fearless new beginnings, trust.")
    static let matrixEnergy22Shadow = NSLocalizedString("matrixEnergy.22.shadow", comment: "Irresponsibility, naivety, scattered direction.")

    // How To Read Matrix View
    static let howToReadMatrixTitle = NSLocalizedString("howToReadMatrix.title", comment: "How to Read Your Matrix")

    static let howToReadMatrixStep1Title = NSLocalizedString("howToReadMatrix.step1.title", comment: "Calculate Your Chart")
    static let howToReadMatrixStep1Intro = NSLocalizedString("howToReadMatrix.step1.intro", comment: "Your Matrix is built from your date of birth—day, month, and year. Each part is reduced to a single energy between 1 and 22, then combined to fill every position on the diagram.")
    static let howToReadMatrixStep1Bullet1Title = NSLocalizedString("howToReadMatrix.step1.bullet1.title", comment: "Enter Birth Date")
    static let howToReadMatrixStep1Bullet1Text = NSLocalizedString("howToReadMatrix.step1.bullet1.text", comment: "Use your exact birth date. The system handles the math for you.")
    static let howToReadMatrixStep1Bullet2Title = NSLocalizedString("howToReadMatrix.step1.bullet2.title", comment: "Trust the Numbers")
    static let howToReadMatrixStep1Bullet2Text = NSLocalizedString("howToReadMatrix.step1.bullet2.text", comment: "Don't worry about manual calculation—what matters is the meaning behind each energy.")
    static let howToReadMatrixStep1ProTip = NSLocalizedString("howToReadMatrix.step1.proTip", comment: "If you're unsure of an exact time zone, the day, month, and year are what shape the Matrix.")

    static let howToReadMatrixStep2Title = NSLocalizedString("howToReadMatrix.step2.title", comment: "Find the Central Square")
    static let howToReadMatrixStep2Intro = NSLocalizedString("howToReadMatrix.step2.intro", comment: "At the heart of your Matrix is a square with four corner energies and a central one. Together they describe who you are and how you move through life.")
    static let howToReadMatrixStep2Bullet1Title = NSLocalizedString("howToReadMatrix.step2.bullet1.title", comment: "Character (Sky)")
    static let howToReadMatrixStep2Bullet1Text = NSLocalizedString("howToReadMatrix.step2.bullet1.text", comment: "Your conscious personality and the qualities you naturally express.")
    static let howToReadMatrixStep2Bullet2Title = NSLocalizedString("howToReadMatrix.step2.bullet2.title", comment: "Karma (Earth)")
    static let howToReadMatrixStep2Bullet2Text = NSLocalizedString("howToReadMatrix.step2.bullet2.text", comment: "Patterns carried from the past that ask to be transformed in this lifetime.")
    static let howToReadMatrixStep2Bullet3Title = NSLocalizedString("howToReadMatrix.step2.bullet3.title", comment: "Talents & Comfort Zone")
    static let howToReadMatrixStep2Bullet3Text = NSLocalizedString("howToReadMatrix.step2.bullet3.text", comment: "The gifts you bring forward and the comfortable habits you tend to repeat.")
    static let howToReadMatrixStep2Bullet4Title = NSLocalizedString("howToReadMatrix.step2.bullet4.title", comment: "Heart / Mission Core")
    static let howToReadMatrixStep2Bullet4Text = NSLocalizedString("howToReadMatrix.step2.bullet4.text", comment: "The integrating energy at the center—your essence and the gateway to your purpose.")

    static let howToReadMatrixStep3Title = NSLocalizedString("howToReadMatrix.step3.title", comment: "Read the Life Lines")
    static let howToReadMatrixStep3Intro = NSLocalizedString("howToReadMatrix.step3.intro", comment: "Around the central square are lines that describe your main areas of life. Each line is built from several energies that work together.")
    static let howToReadMatrixStep3Bullet1Title = NSLocalizedString("howToReadMatrix.step3.bullet1.title", comment: "Money & Finance Line")
    static let howToReadMatrixStep3Bullet1Text = NSLocalizedString("howToReadMatrix.step3.bullet1.text", comment: "How you attract resources, your relationship to abundance, and where money flows freely or gets blocked.")
    static let howToReadMatrixStep3Bullet2Title = NSLocalizedString("howToReadMatrix.step3.bullet2.title", comment: "Relationship Line")
    static let howToReadMatrixStep3Bullet2Text = NSLocalizedString("howToReadMatrix.step3.bullet2.text", comment: "How you bond with partners, the lessons love brings, and what kind of relationships nourish you.")
    static let howToReadMatrixStep3Bullet3Title = NSLocalizedString("howToReadMatrix.step3.bullet3.title", comment: "Family & Ancestral Line")
    static let howToReadMatrixStep3Bullet3Text = NSLocalizedString("howToReadMatrix.step3.bullet3.text", comment: "Patterns inherited from your family system that influence your roots and sense of belonging.")
    static let howToReadMatrixStep3ProTip = NSLocalizedString("howToReadMatrix.step3.proTip", comment: "Read each line as a story: light versions describe what flows naturally, shadow versions show what's ready to be healed.")

    static let howToReadMatrixStep4Title = NSLocalizedString("howToReadMatrix.step4.title", comment: "Look at Your Mission")
    static let howToReadMatrixStep4Intro = NSLocalizedString("howToReadMatrix.step4.intro", comment: "The mission points reveal your purpose—why your soul chose this lifetime and the contribution you're invited to make.")
    static let howToReadMatrixStep4Bullet1Title = NSLocalizedString("howToReadMatrix.step4.bullet1.title", comment: "Personal Mission")
    static let howToReadMatrixStep4Bullet1Text = NSLocalizedString("howToReadMatrix.step4.bullet1.text", comment: "The growth your soul came here to experience for itself.")
    static let howToReadMatrixStep4Bullet2Title = NSLocalizedString("howToReadMatrix.step4.bullet2.title", comment: "Social Mission")
    static let howToReadMatrixStep4Bullet2Text = NSLocalizedString("howToReadMatrix.step4.bullet2.text", comment: "How you're meant to serve and what gift you offer to the world.")

    static let howToReadMatrixStep5Title = NSLocalizedString("howToReadMatrix.step5.title", comment: "Bring It All Together")
    static let howToReadMatrixStep5Intro = NSLocalizedString("howToReadMatrix.step5.intro", comment: "Once you understand the parts, read the whole Matrix as a conversation between archetypes. Notice repeated energies and how the light and shadow sides relate.")
    static let howToReadMatrixStep5Bullet1Title = NSLocalizedString("howToReadMatrix.step5.bullet1.title", comment: "Look for Repetitions")
    static let howToReadMatrixStep5Bullet1Text = NSLocalizedString("howToReadMatrix.step5.bullet1.text", comment: "Energies that appear in multiple positions carry a strong theme in your life.")
    static let howToReadMatrixStep5Bullet2Title = NSLocalizedString("howToReadMatrix.step5.bullet2.title", comment: "Hold Light & Shadow Together")
    static let howToReadMatrixStep5Bullet2Text = NSLocalizedString("howToReadMatrix.step5.bullet2.text", comment: "Each energy has both gifts and challenges. Working consciously with the shadow side is where real growth happens.")

    static let howToReadMatrixRememberTitle = NSLocalizedString("howToReadMatrix.remember.title", comment: "Remember")
    static let howToReadMatrixRememberText = NSLocalizedString("howToReadMatrix.remember.text", comment: "Your Matrix is a map, not a verdict. It points to potentials and patterns—your free will and conscious choices write the actual story of your life.")

    // Matrix & Mind View
    static let matrixMindTitle = NSLocalizedString("matrixMind.title", comment: "Matrix & Mind")
    static let matrixMindSubtitle = NSLocalizedString("matrixMind.subtitle", comment: "A Tool for Self-Reflection")

    static let matrixMindSection1Title = NSLocalizedString("matrixMind.section1.title", comment: "A Map of Inner Archetypes")
    static let matrixMindSection1Text = NSLocalizedString("matrixMind.section1.text", comment: "The Destiny Matrix can be understood as a map of inner archetypes—universal patterns that live inside every person. Reading your chart isn't about predicting fate; it's about meeting the parts of yourself that shape how you think, feel, and choose.")

    static let matrixMindSection2Title = NSLocalizedString("matrixMind.section2.title", comment: "Working with the Shadow")
    static let matrixMindSection2Text = NSLocalizedString("matrixMind.section2.text", comment: "Each of the 22 energies carries both a light expression and a shadow expression. The shadow is not bad—it's the part of an archetype that runs unconsciously when ignored. Naming it gently is the first step toward integration.")
    static let matrixMindSection2Insight = NSLocalizedString("matrixMind.section2.insight", comment: "What you can name, you can work with. What stays unconscious, controls you.")

    static let matrixMindSection3Title = NSLocalizedString("matrixMind.section3.title", comment: "Patterns of Behavior")
    static let matrixMindSection3Intro = NSLocalizedString("matrixMind.section3.intro", comment: "When you look at the lines and positions of your Matrix, you start to see how certain patterns repeat across areas of life:")
    static let matrixMindSection3Bullet1Title = NSLocalizedString("matrixMind.section3.bullet1.title", comment: "Comfort Zone")
    static let matrixMindSection3Bullet1Text = NSLocalizedString("matrixMind.section3.bullet1.text", comment: "Habits and identities you cling to because they feel safe—even when they no longer serve growth.")
    static let matrixMindSection3Bullet2Title = NSLocalizedString("matrixMind.section3.bullet2.title", comment: "Karmic Loops")
    static let matrixMindSection3Bullet2Text = NSLocalizedString("matrixMind.section3.bullet2.text", comment: "Situations that keep reappearing in slightly different costumes until the lesson is consciously met.")
    static let matrixMindSection3Bullet3Title = NSLocalizedString("matrixMind.section3.bullet3.title", comment: "Ancestral Patterns")
    static let matrixMindSection3Bullet3Text = NSLocalizedString("matrixMind.section3.bullet3.text", comment: "Family inheritances—beliefs, fears, and gifts—visible in the family/karmic positions of your chart.")

    static let matrixMindSection4Title = NSLocalizedString("matrixMind.section4.title", comment: "Mindful Practice")
    static let matrixMindSection4Intro = NSLocalizedString("matrixMind.section4.intro", comment: "The Matrix becomes most powerful when used as a mirror for daily reflection rather than as a forecast.")
    static let matrixMindSection4Bullet1Title = NSLocalizedString("matrixMind.section4.bullet1.title", comment: "Journaling")
    static let matrixMindSection4Bullet1Text = NSLocalizedString("matrixMind.section4.bullet1.text", comment: "Pick one energy from your chart and journal on its light and shadow as you noticed them this week.")
    static let matrixMindSection4Bullet2Title = NSLocalizedString("matrixMind.section4.bullet2.title", comment: "Conscious Choice")
    static let matrixMindSection4Bullet2Text = NSLocalizedString("matrixMind.section4.bullet2.text", comment: "When you recognize a pattern playing out, pause and ask: which side of this energy do I want to express right now?")

    static let matrixMindSection5Title = NSLocalizedString("matrixMind.section5.title", comment: "From Insight to Choice")
    static let matrixMindSection5Text = NSLocalizedString("matrixMind.section5.text", comment: "Reading your Matrix is not the end—it's the start of a conscious dialogue with yourself. The chart describes the landscape; you choose the path. Used gently, it can support therapy, coaching, and any path of self-understanding.")

    static let matrixMindConclusion = NSLocalizedString("matrixMind.conclusion", comment: "The Matrix doesn't decide who you are. It invites you to remember who you came here to be.")
    static let matrixMindInsightLabel = NSLocalizedString("matrixMind.insight.label", comment: "Insight")

    // Destiny Matrix FAQ View
    static let matrixFaqTitle = NSLocalizedString("matrixFaq.title", comment: "Frequently Asked Questions")
    static let matrixFaqSubtitle = NSLocalizedString("matrixFaq.subtitle", comment: "Common questions about the Destiny Matrix")

    static let matrixFaqQuestion1 = NSLocalizedString("matrixFaq.question1", comment: "What is the Destiny Matrix?")
    static let matrixFaqAnswer1 = NSLocalizedString("matrixFaq.answer1", comment: "The Destiny Matrix is a personal chart built from your date of birth that maps 22 universal energies onto key positions of your life: your personality, relationships, money, family, and mission. It combines numerology, Tarot archetypes, and the Eastern chakra system into one diagram.")

    static let matrixFaqQuestion2 = NSLocalizedString("matrixFaq.question2", comment: "Is the Matrix the same as numerology?")
    static let matrixFaqAnswer2 = NSLocalizedString("matrixFaq.answer2", comment: "Numerology is one of its ingredients but not the whole system. The Matrix uses numerological calculation to place 22 archetypal energies—rooted in the Major Arcana of the Tarot—onto a specific diagram, giving a more layered picture than numbers alone.")

    static let matrixFaqQuestion3 = NSLocalizedString("matrixFaq.question3", comment: "Why are there exactly 22 energies?")
    static let matrixFaqAnswer3 = NSLocalizedString("matrixFaq.answer3", comment: "The 22 energies correspond to the 22 Major Arcana of the Tarot—a complete cycle of archetypes describing the human journey from beginning (The Fool) to wholeness (The World).")

    static let matrixFaqQuestion4 = NSLocalizedString("matrixFaq.question4", comment: "Can my Matrix change over time?")
    static let matrixFaqAnswer4 = NSLocalizedString("matrixFaq.answer4", comment: "The chart itself is fixed because it's calculated from your birth date. What changes is your relationship to it—how consciously you express the light or shadow side of each energy as you grow.")

    static let matrixFaqQuestion5 = NSLocalizedString("matrixFaq.question5", comment: "How is it different from Tarot or astrology?")
    static let matrixFaqAnswer5 = NSLocalizedString("matrixFaq.answer5", comment: "Tarot is a divination tool that responds to a specific question in the moment. Astrology maps planetary positions at your birth. The Matrix is a fixed birth-chart of archetypes, focused on identity, purpose, and personal patterns rather than transits or one-off questions.")

    static let matrixFaqQuestion6 = NSLocalizedString("matrixFaq.question6", comment: "Can it predict the future?")
    static let matrixFaqAnswer6 = NSLocalizedString("matrixFaq.answer6", comment: "The Matrix doesn't predict events. It describes potentials, patterns, and lessons. Your choices, awareness, and effort decide which version of each energy actually shows up in your life.")

    static let matrixFaqQuestion7 = NSLocalizedString("matrixFaq.question7", comment: "Do I need a birth time or place?")
    static let matrixFaqAnswer7 = NSLocalizedString("matrixFaq.answer7", comment: "No. Unlike a natal astrology chart, the Destiny Matrix only needs your day, month, and year of birth.")

    static let matrixFaqQuestion8 = NSLocalizedString("matrixFaq.question8", comment: "Can I read someone else's Matrix?")
    static let matrixFaqAnswer8 = NSLocalizedString("matrixFaq.answer8", comment: "Yes—if they share their birth date with you. Many people use it to better understand their partner, family member, or child. Always read with respect and ask before sharing interpretations.")

    static let matrixFaqQuestion9 = NSLocalizedString("matrixFaq.question9", comment: "Is the Destiny Matrix a religion?")
    static let matrixFaqAnswer9 = NSLocalizedString("matrixFaq.answer9", comment: "No. The Matrix is a symbolic self-development tool. It can sit alongside any faith—or none—and works as a mirror for reflection rather than as a belief system.")

    static let matrixFaqQuestion10 = NSLocalizedString("matrixFaq.question10", comment: "How should I start working with my chart?")
    static let matrixFaqAnswer10 = NSLocalizedString("matrixFaq.answer10", comment: "Begin with the central square—your personality, karma, talents, and core energy. Read both the light and shadow sides. Then explore one life line at a time (money, relationships, family) over several weeks rather than all at once.")

    static let matrixFaqDisclaimerTitle = NSLocalizedString("matrixFaq.disclaimer.title", comment: "Important Note")
    static let matrixFaqDisclaimerText = NSLocalizedString("matrixFaq.disclaimer.text", comment: "The Destiny Matrix is offered as a tool for reflection and self-discovery. It is not a substitute for medical, psychological, legal, or financial advice. Trust your own judgment and seek qualified professionals when you need real-world support.")

    // MARK: - Astrology / Zodiac Signs
    // These are used by AstrologyService for zodiac sign names
}
