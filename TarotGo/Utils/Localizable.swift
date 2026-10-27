//
//  Localizable.swift
//  TarotGo
//
//  Centralized localization strings
//

import Foundation

nonisolated enum L10n {
    // Shadows the global `NSLocalizedString` for everything in this enum so
    // lookups use the language picked in-app rather than the system language.
    // Strings are computed (not cached) so a language switch applies immediately.
    private static func NSLocalizedString(_ key: String, value: String = "", comment: String) -> String {
        Foundation.NSLocalizedString(key, bundle: SelectedLanguage.bundle, value: value, comment: comment)
    }

    // MARK: - Common
    static var appName: String { NSLocalizedString("app.name", comment: "App name") }
    static var cancel: String { NSLocalizedString("common.cancel", comment: "Cancel button") }
    static var done: String { NSLocalizedString("common.done", comment: "Done button") }
    static var save: String { NSLocalizedString("common.save", comment: "Save button") }
    static var delete: String { NSLocalizedString("common.delete", comment: "Delete button") }
    static var edit: String { NSLocalizedString("common.edit", comment: "Edit button") }
    static var continue_: String { NSLocalizedString("common.continue", comment: "Continue button") }
    static var getStarted: String { NSLocalizedString("common.getStarted", comment: "Get started button") }
    static var comingSoon: String { NSLocalizedString("common.comingSoon", comment: "Coming Soon label") }
    static var ok: String { NSLocalizedString("common.ok", comment: "OK button") }
    static var sharePDF: String { NSLocalizedString("common.sharePDF", value: "Share PDF", comment: "Share PDF button") }

    // MARK: - Tab Bar
    static var tabTarot: String { NSLocalizedString("tab.tarot", comment: "Tarot tab") }
    static var tabDestinyMatrix: String { NSLocalizedString("tab.destinyMatrix", comment: "Destiny Matrix tab") }
    static var tabPalmistry: String { NSLocalizedString("tab.palmistry", comment: "Palmistry tab") }
    static var tabCosmic: String { NSLocalizedString("tab.cosmic", comment: "Cosmic tab") }
    static var tabSettings: String { NSLocalizedString("tab.settings", comment: "Settings tab") }
    
    // MARK: - Tarot View
    static var tarotViewTitle: String { NSLocalizedString("tarotView.title", comment: "Tarot") }
    static var tarotViewSubtitle: String { NSLocalizedString("tarotView.subtitle", comment: "Divine wisdom through the cards") }
    
    // MARK: - Palmistry View
    static var palmistryViewTitle: String { NSLocalizedString("palmistryView.title", comment: "Palmistry") }
    static var palmistryViewSubtitle: String { NSLocalizedString("palmistryView.subtitle", comment: "Secrets written in your hands") }
    static var palmistryViewFooter: String { NSLocalizedString("palmistryView.footer", comment: "Your destiny lies in your hands") }
    
    // MARK: - Destiny Matrix View
    static var destinyMatrixViewTitle: String { NSLocalizedString("destinyMatrixView.title", comment: "Destiny Matrix") }
    static var destinyMatrixViewSubtitle: String { NSLocalizedString("destinyMatrixView.subtitle", comment: "Your personal energy map") }
    static var destinyMatrixViewFooter: String { NSLocalizedString("destinyMatrixView.footer", comment: "Discover the blueprint of your soul") }
    
    // MARK: - Cosmic View
    static var cosmicViewTitle: String { NSLocalizedString("cosmicView.title", comment: "Cosmic") }
    static var cosmicViewSubtitle: String { NSLocalizedString("cosmicView.subtitle", comment: "Explore celestial influences") }
    static var cosmicViewFooter: String { NSLocalizedString("cosmicView.footer", comment: "The stars illuminate your path") }
    
    // MARK: - Learn Palmistry
    static var learnPalmistryTitle: String { NSLocalizedString("learnPalmistry.title", comment: "Learn Palmistry") }
    static var learnPalmistrySubtitle: String { NSLocalizedString("learnPalmistry.subtitle", comment: "Master the art of palm reading") }
    static var learnPalmistryComingSoon: String { NSLocalizedString("learnPalmistry.comingSoon", comment: "Content coming soon") }
    static var learnPalmistryDescription: String { NSLocalizedString("learnPalmistry.description", comment: "Discover the ancient art of palmistry. Learn to read the lines, mounts, and shapes that reveal your destiny.") }
    
    // MARK: - Cosmic Features
    static var horoscopeTitle: String { NSLocalizedString("horoscope.title", comment: "Horoscope") }
    static var horoscopeSubtitle: String { NSLocalizedString("horoscope.subtitle", comment: "Your daily celestial guidance") }
    
    static var cosmogramTitle: String { NSLocalizedString("cosmogram.title", comment: "Cosmogram") }
    static var cosmogramSubtitle: String { NSLocalizedString("cosmogram.subtitle", comment: "Your personal star chart") }
    
    static var numerologyTitle: String { NSLocalizedString("numerology.title", comment: "Numerology") }
    static var numerologySubtitle: String { NSLocalizedString("numerology.subtitle", comment: "The power of numbers") }
    
    static var lunarCalendarTitle: String { NSLocalizedString("lunarCalendar.title", comment: "Lunar Calendar") }
    static var lunarCalendarSubtitle: String { NSLocalizedString("lunarCalendar.subtitle", comment: "Follow the moon's phases") }
    static var lunarCalendarIlluminated: String { NSLocalizedString("lunarCalendar.illuminated", comment: "Illuminated") }
    static var lunarCalendarMoonIn: String { NSLocalizedString("lunarCalendar.moonIn", comment: "Moon in") }
    static var lunarCalendarUpcomingPhases: String { NSLocalizedString("lunarCalendar.upcomingPhases", comment: "Upcoming Moon Phases") }
    static var lunarCalendarToday: String { NSLocalizedString("lunarCalendar.today", comment: "Today") }
    static var lunarCalendarRitualSuggestions: String { NSLocalizedString("lunarCalendar.ritualSuggestions", comment: "Ritual Suggestions") }
    
    // Moon Phase Names
    static var moonPhaseNewMoon: String { NSLocalizedString("moonPhase.newMoon", comment: "New Moon") }
    static var moonPhaseWaxingCrescent: String { NSLocalizedString("moonPhase.waxingCrescent", comment: "Waxing Crescent") }
    static var moonPhaseFirstQuarter: String { NSLocalizedString("moonPhase.firstQuarter", comment: "First Quarter") }
    static var moonPhaseWaxingGibbous: String { NSLocalizedString("moonPhase.waxingGibbous", comment: "Waxing Gibbous") }
    static var moonPhaseFullMoon: String { NSLocalizedString("moonPhase.fullMoon", comment: "Full Moon") }
    static var moonPhaseWaningGibbous: String { NSLocalizedString("moonPhase.waningGibbous", comment: "Waning Gibbous") }
    static var moonPhaseLastQuarter: String { NSLocalizedString("moonPhase.lastQuarter", comment: "Last Quarter") }
    static var moonPhaseWaningCrescent: String { NSLocalizedString("moonPhase.waningCrescent", comment: "Waning Crescent") }
    
    // Moon Phase Descriptions
    static var moonPhaseNewMoonDesc: String { NSLocalizedString("moonPhase.newMoon.desc", comment: "A time for new beginnings, setting intentions, and planting seeds for the future.") }
    static var moonPhaseWaxingCrescentDesc: String { NSLocalizedString("moonPhase.waxingCrescent.desc", comment: "Energy is building. Take initial action on your goals and remain flexible.") }
    static var moonPhaseFirstQuarterDesc: String { NSLocalizedString("moonPhase.firstQuarter.desc", comment: "Time for decision and commitment. Push through obstacles with determination.") }
    static var moonPhaseWaxingGibbousDesc: String { NSLocalizedString("moonPhase.waxingGibbous.desc", comment: "Refine your plans and adjust your approach. Success is within reach.") }
    static var moonPhaseFullMoonDesc: String { NSLocalizedString("moonPhase.fullMoon.desc", comment: "Peak energy for manifestation, celebration, and emotional release. Harvest what you've sown.") }
    static var moonPhaseWaningGibbousDesc: String { NSLocalizedString("moonPhase.waningGibbous.desc", comment: "Share your wisdom and gratitude. Reflect on lessons learned.") }
    static var moonPhaseLastQuarterDesc: String { NSLocalizedString("moonPhase.lastQuarter.desc", comment: "Release what no longer serves you. Let go and create space for renewal.") }
    static var moonPhaseWaningCrescentDesc: String { NSLocalizedString("moonPhase.waningCrescent.desc", comment: "Rest, restore, and prepare for the next cycle. Surrender and trust.") }
    
    // Moon Phase Energy Titles
    static var moonPhaseNewMoonEnergy: String { NSLocalizedString("moonPhase.newMoon.energy", comment: "Intention & New Beginnings") }
    static var moonPhaseWaxingCrescentEnergy: String { NSLocalizedString("moonPhase.waxingCrescent.energy", comment: "Growth & Expansion") }
    static var moonPhaseFirstQuarterEnergy: String { NSLocalizedString("moonPhase.firstQuarter.energy", comment: "Action & Determination") }
    static var moonPhaseWaxingGibbousEnergy: String { NSLocalizedString("moonPhase.waxingGibbous.energy", comment: "Refinement & Adjustment") }
    static var moonPhaseFullMoonEnergy: String { NSLocalizedString("moonPhase.fullMoon.energy", comment: "Manifestation & Release") }
    static var moonPhaseWaningGibbousEnergy: String { NSLocalizedString("moonPhase.waningGibbous.energy", comment: "Gratitude & Sharing") }
    static var moonPhaseLastQuarterEnergy: String { NSLocalizedString("moonPhase.lastQuarter.energy", comment: "Letting Go & Forgiveness") }
    static var moonPhaseWaningCrescentEnergy: String { NSLocalizedString("moonPhase.waningCrescent.energy", comment: "Rest & Surrender") }
    
    // Ritual Suggestions - New Moon
    static var ritualNewMoon1: String { NSLocalizedString("ritual.newMoon.1", comment: "Set intentions for the upcoming lunar cycle") }
    static var ritualNewMoon2: String { NSLocalizedString("ritual.newMoon.2", comment: "Journal about new beginnings you wish to invite") }
    static var ritualNewMoon3: String { NSLocalizedString("ritual.newMoon.3", comment: "Create a vision board for your goals") }
    static var ritualNewMoon4: String { NSLocalizedString("ritual.newMoon.4", comment: "Light a candle and meditate on fresh starts") }
    
    // Ritual Suggestions - Waxing Crescent
    static var ritualWaxingCrescent1: String { NSLocalizedString("ritual.waxingCrescent.1", comment: "Take the first concrete steps toward your goals") }
    static var ritualWaxingCrescent2: String { NSLocalizedString("ritual.waxingCrescent.2", comment: "Research and gather resources you'll need") }
    static var ritualWaxingCrescent3: String { NSLocalizedString("ritual.waxingCrescent.3", comment: "Connect with others who support your vision") }
    static var ritualWaxingCrescent4: String { NSLocalizedString("ritual.waxingCrescent.4", comment: "Practice affirmations for growth and expansion") }
    
    // Ritual Suggestions - First Quarter
    static var ritualFirstQuarter1: String { NSLocalizedString("ritual.firstQuarter.1", comment: "Make important decisions with confidence") }
    static var ritualFirstQuarter2: String { NSLocalizedString("ritual.firstQuarter.2", comment: "Address and work through any obstacles") }
    static var ritualFirstQuarter3: String { NSLocalizedString("ritual.firstQuarter.3", comment: "Take bold action on your plans") }
    static var ritualFirstQuarter4: String { NSLocalizedString("ritual.firstQuarter.4", comment: "Review progress and adjust your approach") }
    
    // Ritual Suggestions - Waxing Gibbous
    static var ritualWaxingGibbous1: String { NSLocalizedString("ritual.waxingGibbous.1", comment: "Refine and polish your projects") }
    static var ritualWaxingGibbous2: String { NSLocalizedString("ritual.waxingGibbous.2", comment: "Seek feedback and make improvements") }
    static var ritualWaxingGibbous3: String { NSLocalizedString("ritual.waxingGibbous.3", comment: "Practice patience as success approaches") }
    static var ritualWaxingGibbous4: String { NSLocalizedString("ritual.waxingGibbous.4", comment: "Prepare for upcoming manifestations") }
    
    // Ritual Suggestions - Full Moon
    static var ritualFullMoon1: String { NSLocalizedString("ritual.fullMoon.1", comment: "Celebrate achievements and express gratitude") }
    static var ritualFullMoon2: String { NSLocalizedString("ritual.fullMoon.2", comment: "Release what no longer serves your growth") }
    static var ritualFullMoon3: String { NSLocalizedString("ritual.fullMoon.3", comment: "Charge crystals and tools under moonlight") }
    static var ritualFullMoon4: String { NSLocalizedString("ritual.fullMoon.4", comment: "Perform a releasing ritual or ceremony") }
    
    // Ritual Suggestions - Waning Gibbous
    static var ritualWaningGibbous1: String { NSLocalizedString("ritual.waningGibbous.1", comment: "Share your knowledge and experiences") }
    static var ritualWaningGibbous2: String { NSLocalizedString("ritual.waningGibbous.2", comment: "Express gratitude for lessons learned") }
    static var ritualWaningGibbous3: String { NSLocalizedString("ritual.waningGibbous.3", comment: "Help others with your newfound wisdom") }
    static var ritualWaningGibbous4: String { NSLocalizedString("ritual.waningGibbous.4", comment: "Reflect on the cycle's teachings") }
    
    // Ritual Suggestions - Last Quarter
    static var ritualLastQuarter1: String { NSLocalizedString("ritual.lastQuarter.1", comment: "Let go of limiting beliefs and patterns") }
    static var ritualLastQuarter2: String { NSLocalizedString("ritual.lastQuarter.2", comment: "Forgive yourself and others") }
    static var ritualLastQuarter3: String { NSLocalizedString("ritual.lastQuarter.3", comment: "Clear physical and energetic clutter") }
    static var ritualLastQuarter4: String { NSLocalizedString("ritual.lastQuarter.4", comment: "Journal about what you're ready to release") }
    
    // Ritual Suggestions - Waning Crescent
    static var ritualWaningCrescent1: String { NSLocalizedString("ritual.waningCrescent.1", comment: "Rest and restore your energy") }
    static var ritualWaningCrescent2: String { NSLocalizedString("ritual.waningCrescent.2", comment: "Practice deep meditation or contemplation") }
    static var ritualWaningCrescent3: String { NSLocalizedString("ritual.waningCrescent.3", comment: "Trust in the natural cycles of life") }
    static var ritualWaningCrescent4: String { NSLocalizedString("ritual.waningCrescent.4", comment: "Prepare for the new moon's fresh start") }
    
    static var compatibilityTitle: String { NSLocalizedString("compatibility.title", comment: "Compatibility") }
    static var compatibilitySubtitle: String { NSLocalizedString("compatibility.subtitle", comment: "Discover your cosmic connections") }
    static var compatibilityYourSign: String { NSLocalizedString("compatibility.yourSign", comment: "Your Sign") }
    static var compatibilityPartnerSign: String { NSLocalizedString("compatibility.partnerSign", comment: "Partner's Sign") }
    static var compatibilitySelectPrompt: String { NSLocalizedString("compatibility.selectPrompt", comment: "Select both zodiac signs to see compatibility") }
    static var compatibilityScore: String { NSLocalizedString("compatibility.score", comment: "Compatibility Score") }
    static var compatibilityElementalMatch: String { NSLocalizedString("compatibility.elementalMatch", comment: "Elemental Match") }
    static var compatibilityOverall: String { NSLocalizedString("compatibility.overall", comment: "Overall Compatibility") }
    static var compatibilityStrengths: String { NSLocalizedString("compatibility.strengths", comment: "Strengths") }
    static var compatibilityChallenges: String { NSLocalizedString("compatibility.challenges", comment: "Challenges") }
    static var compatibilityAdvice: String { NSLocalizedString("compatibility.advice", comment: "Advice") }
    
    // Rating levels
    static var compatibilityRatingExcellent: String { NSLocalizedString("compatibility.rating.excellent", comment: "Excellent Match") }
    static var compatibilityRatingVeryCompatible: String { NSLocalizedString("compatibility.rating.veryCompatible", comment: "Very Compatible") }
    static var compatibilityRatingGood: String { NSLocalizedString("compatibility.rating.good", comment: "Good Match") }
    static var compatibilityRatingModerate: String { NSLocalizedString("compatibility.rating.moderate", comment: "Moderate Compatibility") }
    static var compatibilityRatingChallenging: String { NSLocalizedString("compatibility.rating.challenging", comment: "Challenging but Possible") }
    
    // Elements
    static var compatibilityElementFire: String { NSLocalizedString("compatibility.element.fire", comment: "Fire") }
    static var compatibilityElementEarth: String { NSLocalizedString("compatibility.element.earth", comment: "Earth") }
    static var compatibilityElementAir: String { NSLocalizedString("compatibility.element.air", comment: "Air") }
    static var compatibilityElementWater: String { NSLocalizedString("compatibility.element.water", comment: "Water") }
    
    // Element descriptions
    static var compatibilityElementDescSame: String { NSLocalizedString("compatibility.elementDesc.same", comment: "Same element description") }
    static var compatibilityElementDescFireAir: String { NSLocalizedString("compatibility.elementDesc.fireAir", comment: "Fire and Air description") }
    static var compatibilityElementDescEarthWater: String { NSLocalizedString("compatibility.elementDesc.earthWater", comment: "Earth and Water description") }
    static var compatibilityElementDescDifferent: String { NSLocalizedString("compatibility.elementDesc.different", comment: "Different elements description") }
    
    // Detailed texts
    static var compatibilityOverallText: String { NSLocalizedString("compatibility.overallText", comment: "Overall compatibility text") }
    static var compatibilityStrengthsSameElement: String { NSLocalizedString("compatibility.strengthsSameElement", comment: "Strengths for same element") }
    static var compatibilityStrengthsFireAir: String { NSLocalizedString("compatibility.strengthsFireAir", comment: "Strengths for Fire/Air") }
    static var compatibilityStrengthsEarthWater: String { NSLocalizedString("compatibility.strengthsEarthWater", comment: "Strengths for Earth/Water") }
    static var compatibilityStrengthsDifferent: String { NSLocalizedString("compatibility.strengthsDifferent", comment: "Strengths for different elements") }
    static var compatibilityChallengesSameElement: String { NSLocalizedString("compatibility.challengesSameElement", comment: "Challenges for same element") }
    static var compatibilityChallengesDifferent: String { NSLocalizedString("compatibility.challengesDifferent", comment: "Challenges for different elements") }
    static var compatibilityAdviceText: String { NSLocalizedString("compatibility.adviceText", comment: "General advice text") }

    // MARK: - Home
    static var homeTitle: String { NSLocalizedString("home.title", comment: "TarotGo title") }
    static var homeSubtitle: String { NSLocalizedString("home.subtitle", comment: "Your personal tarot companion") }
    static var homeFooter: String { NSLocalizedString("home.footer", comment: "The cards are waiting for you") }

    static var homeNewReading: String { NSLocalizedString("home.newReading", comment: "New Reading") }
    static var homeNewReadingSubtitle: String { NSLocalizedString("home.newReading.subtitle", comment: "Discover what the cards reveal") }

    static var homeCardOfDay: String { NSLocalizedString("home.cardOfDay", comment: "Card of the Day") }
    static var homeCardOfDaySubtitle: String { NSLocalizedString("home.cardOfDay.subtitle", comment: "Today's guidance and insight") }

    static var homeHistory: String { NSLocalizedString("home.history", comment: "Reading History") }
    static var homeHistorySubtitle: String { NSLocalizedString("home.history.subtitle", comment: "Review your past readings") }

    static var homeDestinyMatrix: String { NSLocalizedString("home.destinyMatrix", comment: "Destiny Matrix") }
    static var homeDestinyMatrixSubtitle: String { NSLocalizedString("home.destinyMatrix.subtitle", comment: "Discover your life's blueprint") }

    static var homeCoupleDestiny: String { NSLocalizedString("home.coupleDestiny", comment: "Couple Destiny") }
    static var homeCoupleDestinySubtitle: String { NSLocalizedString("home.coupleDestiny.subtitle", comment: "Explore shared energy") }
    
    static var homeCardDictionary: String { NSLocalizedString("home.cardDictionary", comment: "Card Dictionary") }
    static var homeCardDictionarySubtitle: String { NSLocalizedString("home.cardDictionary.subtitle", comment: "Explore all 78 tarot cards") }
    
    static var homeSettings: String { NSLocalizedString("home.settings", comment: "Settings") }
    static var homeSettingsSubtitle: String { NSLocalizedString("home.settings.subtitle", comment: "Configure notifications and preferences") }

    // MARK: - Destiny Matrix
    static var matrixTitle: String { NSLocalizedString("matrix.title", comment: "Destiny Matrix") }
    static var matrixSubtitle: String { NSLocalizedString("matrix.subtitle", comment: "Your Personal Energy Map") }
    static var matrixWhatIs: String { NSLocalizedString("matrix.whatIs", comment: "What is Destiny Matrix?") }
    static var matrixDescription: String { NSLocalizedString("matrix.description", comment: "Destiny Matrix is a numerology system that maps the energies of your birth date to the 22 Major Arcana cards of the Tarot. Each position reveals different aspects of your life path, talents, and purpose.") }
    static var matrixEnterBirthDate: String { NSLocalizedString("matrix.enterBirthDate", comment: "Enter Your Birth Date") }
    static var matrixBirthDate: String { NSLocalizedString("matrix.birthDate", comment: "Birth Date") }
    static var matrixCalculate: String { NSLocalizedString("matrix.calculate", comment: "Calculate Matrix") }
    static var matrixCalculateForOther: String { NSLocalizedString("matrix.calculateForOther", comment: "Calculate for someone else") }
    static var matrixYourBirthDate: String { NSLocalizedString("matrix.yourBirthDate", comment: "Your Birth Date") }
    
    static var matrixYourMatrix: String { NSLocalizedString("matrix.yourMatrix", comment: "Your Destiny Matrix") }
    static var matrixTapCircle: String { NSLocalizedString("matrix.tapCircle", comment: "Tap any circle to see its meaning") }
    static var matrixSelectedPosition: String { NSLocalizedString("matrix.selectedPosition", comment: "Selected Position") }
    static var matrixNumber: String { NSLocalizedString("matrix.number", comment: "Number") }
    static var matrixAssociatedCard: String { NSLocalizedString("matrix.associatedCard", comment: "Associated Tarot Card") }
    
    static var matrixTabDiagram: String { NSLocalizedString("matrix.tab.diagram", comment: "Diagram") }
    static var matrixTabPositions: String { NSLocalizedString("matrix.tab.positions", comment: "Positions") }
    static var matrixTabCards: String { NSLocalizedString("matrix.tab.cards", comment: "Cards") }
    static var matrixTabYearAnalysis: String { NSLocalizedString("matrix.tab.yearAnalysis", comment: "Year Analysis") }
    
    static var matrixViewCardDetails: String { NSLocalizedString("matrix.viewCardDetails", comment: "View Card Details") }
    static var matrixUniqueCards: String { NSLocalizedString("matrix.uniqueCards", comment: "Unique Cards in Your Matrix") }
    static var matrixAllPositions: String { NSLocalizedString("matrix.allPositions", comment: "All 19 Positions") }
    static var matrixShareMatrix: String { NSLocalizedString("matrix.shareMatrix", comment: "Share Destiny Matrix") }
    static var coupleMatrixShareMatrix: String { NSLocalizedString("coupleMatrix.shareMatrix", comment: "Share Couple Matrix") }
    
    // Matrix Position Names
    static var matrixCenter: String { NSLocalizedString("matrix.position.center", comment: "Center") }
    static var matrixCenterDesc: String { NSLocalizedString("matrix.position.center.desc", comment: "Your core essence and life purpose") }
    
    static var matrixPersonalPower: String { NSLocalizedString("matrix.position.personalPower", comment: "Personal Power") }
    static var matrixPersonalPowerDesc: String { NSLocalizedString("matrix.position.personalPower.desc", comment: "Your inner strength and personal authority") }
    
    static var matrixSocialRealization: String { NSLocalizedString("matrix.position.socialRealization", comment: "Social Realization") }
    static var matrixSocialRealizationDesc: String { NSLocalizedString("matrix.position.socialRealization.desc", comment: "How you express yourself in society") }
    
    static var matrixSpiritualDevelopment: String { NSLocalizedString("matrix.position.spiritualDevelopment", comment: "Spiritual Development") }
    static var matrixSpiritualDevelopmentDesc: String { NSLocalizedString("matrix.position.spiritualDevelopment.desc", comment: "Your spiritual path and growth") }
    
    static var matrixPlanetaryInfluence: String { NSLocalizedString("matrix.position.planetaryInfluence", comment: "Planetary Influence") }
    static var matrixPlanetaryInfluenceDesc: String { NSLocalizedString("matrix.position.planetaryInfluence.desc", comment: "External forces and cosmic energies affecting you") }
    
    static var matrixMoney: String { NSLocalizedString("matrix.position.money", comment: "Money & Abundance") }
    static var matrixMoneyDesc: String { NSLocalizedString("matrix.position.money.desc", comment: "Your relationship with material resources") }
    
    static var matrixRelationships: String { NSLocalizedString("matrix.position.relationships", comment: "Relationships") }
    static var matrixRelationshipsDesc: String { NSLocalizedString("matrix.position.relationships.desc", comment: "Your connection patterns with others") }
    
    static var matrixTalents: String { NSLocalizedString("matrix.position.talents", comment: "Talents & Gifts") }
    static var matrixTalentsDesc: String { NSLocalizedString("matrix.position.talents.desc", comment: "Your natural abilities and strengths") }
    
    static var matrixPurpose: String { NSLocalizedString("matrix.position.purpose", comment: "Life Purpose") }
    static var matrixPurposeDesc: String { NSLocalizedString("matrix.position.purpose.desc", comment: "Your mission and calling in life") }
    
    static var matrixHealth: String { NSLocalizedString("matrix.position.health", comment: "Health & Vitality") }
    static var matrixHealthDesc: String { NSLocalizedString("matrix.position.health.desc", comment: "Physical and energetic wellbeing") }
    
    static var matrixKarma: String { NSLocalizedString("matrix.position.karma", comment: "Karmic Path") }
    static var matrixKarmaDesc: String { NSLocalizedString("matrix.position.karma.desc", comment: "Lessons from past and what you're here to resolve") }
    
    static var matrixMale: String { NSLocalizedString("matrix.position.male", comment: "Masculine Energy") }
    static var matrixMaleDesc: String { NSLocalizedString("matrix.position.male.desc", comment: "Your active, yang, outward-directed energy") }
    
    static var matrixFemale: String { NSLocalizedString("matrix.position.female", comment: "Feminine Energy") }
    static var matrixFemaleDesc: String { NSLocalizedString("matrix.position.female.desc", comment: "Your receptive, yin, inward-directed energy") }
    
    static var matrixSky: String { NSLocalizedString("matrix.position.sky", comment: "Sky Line") }
    static var matrixSkyDesc: String { NSLocalizedString("matrix.position.sky.desc", comment: "Your higher aspirations and ideals") }
    
    static var matrixEarth: String { NSLocalizedString("matrix.position.earth", comment: "Earth Line") }
    static var matrixEarthDesc: String { NSLocalizedString("matrix.position.earth.desc", comment: "Your grounding and practical foundation") }
    
    static var matrixComfort: String { NSLocalizedString("matrix.position.comfort", comment: "Comfort Zone") }
    static var matrixComfortDesc: String { NSLocalizedString("matrix.position.comfort.desc", comment: "What feels natural and easy for you") }
    
    static var matrixPast: String { NSLocalizedString("matrix.position.past", comment: "Past Influence") }
    static var matrixPastDesc: String { NSLocalizedString("matrix.position.past.desc", comment: "Energies from your past shaping the present") }
    
    static var matrixPresent: String { NSLocalizedString("matrix.position.present", comment: "Present Moment") }
    static var matrixPresentDesc: String { NSLocalizedString("matrix.position.present.desc", comment: "Your current life situation and focus") }
    
    static var matrixFuture: String { NSLocalizedString("matrix.position.future", comment: "Future Potential") }
    static var matrixFutureDesc: String { NSLocalizedString("matrix.position.future.desc", comment: "Where your energy is headed") }

    // MARK: - Couple Matrix
    static var coupleMatrixTitle: String { NSLocalizedString("coupleMatrix.title", comment: "Couple Matrix") }
    static var coupleMatrixSubtitle: String { NSLocalizedString("coupleMatrix.subtitle", comment: "Map the shared energies of two souls") }
    static var coupleMatrixWhatIs: String { NSLocalizedString("coupleMatrix.whatIs", comment: "What is the Couple Matrix?") }
    static var coupleMatrixDescription: String { NSLocalizedString("coupleMatrix.description", comment: "The Couple Matrix combines the birth energies of two partners using the 22 Major Arcana to reveal the heart, karma, and purpose of your union.") }
    static var coupleMatrixYourBirthDate: String { NSLocalizedString("coupleMatrix.yourBirthDate", comment: "Your Birth Date") }
    static var coupleMatrixUseMyBirthDate: String { NSLocalizedString("coupleMatrix.useMyBirthDate", comment: "Use my saved birth date") }
    static var coupleMatrixEnterPartnerABirthDate: String { NSLocalizedString("coupleMatrix.enterPartnerABirthDate", comment: "Enter Partner A's Birth Date") }
    static var coupleMatrixEnterPartnerBBirthDate: String { NSLocalizedString("coupleMatrix.enterPartnerBBirthDate", comment: "Enter Partner B's Birth Date") }
    static var coupleMatrixCalculate: String { NSLocalizedString("coupleMatrix.calculate", comment: "Calculate Couple Matrix") }
    static var coupleMatrixYourMatrix: String { NSLocalizedString("coupleMatrix.yourMatrix", comment: "Your Couple Matrix") }

    // Couple Matrix Position Names
    static var coupleMatrixPartnerA: String { NSLocalizedString("coupleMatrix.position.partnerA", comment: "Partner A") }
    static var coupleMatrixPartnerADesc: String { NSLocalizedString("coupleMatrix.position.partnerA.desc", comment: "The core energy of the first partner") }

    static var coupleMatrixPartnerB: String { NSLocalizedString("coupleMatrix.position.partnerB", comment: "Partner B") }
    static var coupleMatrixPartnerBDesc: String { NSLocalizedString("coupleMatrix.position.partnerB.desc", comment: "The core energy of the second partner") }

    static var coupleMatrixUnion: String { NSLocalizedString("coupleMatrix.position.union", comment: "Union") }
    static var coupleMatrixUnionDesc: String { NSLocalizedString("coupleMatrix.position.union.desc", comment: "The combined essence at the heart of your relationship") }

    static var coupleMatrixLove: String { NSLocalizedString("coupleMatrix.position.love", comment: "Love Line") }
    static var coupleMatrixLoveDesc: String { NSLocalizedString("coupleMatrix.position.love.desc", comment: "How affection flows between the two of you") }

    static var coupleMatrixKarma: String { NSLocalizedString("coupleMatrix.position.karma", comment: "Shared Karma") }
    static var coupleMatrixKarmaDesc: String { NSLocalizedString("coupleMatrix.position.karma.desc", comment: "Lessons your souls have come together to resolve") }

    static var coupleMatrixMoney: String { NSLocalizedString("coupleMatrix.position.money", comment: "Shared Abundance") }
    static var coupleMatrixMoneyDesc: String { NSLocalizedString("coupleMatrix.position.money.desc", comment: "Material harmony you create together") }

    static var coupleMatrixSexuality: String { NSLocalizedString("coupleMatrix.position.sexuality", comment: "Passion") }
    static var coupleMatrixSexualityDesc: String { NSLocalizedString("coupleMatrix.position.sexuality.desc", comment: "The intimate energy and chemistry you share") }

    static var coupleMatrixChildren: String { NSLocalizedString("coupleMatrix.position.children", comment: "Creative Legacy") }
    static var coupleMatrixChildrenDesc: String { NSLocalizedString("coupleMatrix.position.children.desc", comment: "Children, projects, and the legacy you build together") }

    static var coupleMatrixPurpose: String { NSLocalizedString("coupleMatrix.position.purpose", comment: "Purpose of the Union") }
    static var coupleMatrixPurposeDesc: String { NSLocalizedString("coupleMatrix.position.purpose.desc", comment: "What this relationship is here to fulfill") }

    static var coupleMatrixHealth: String { NSLocalizedString("coupleMatrix.position.health", comment: "Vitality") }
    static var coupleMatrixHealthDesc: String { NSLocalizedString("coupleMatrix.position.health.desc", comment: "The living energy that sustains your bond") }

    static var coupleMatrixYearsTogether: String { NSLocalizedString("coupleMatrix.yearsTogether", comment: "Years Together") }
    static var coupleMatrixCurrentYearEnergy: String { NSLocalizedString("coupleMatrix.currentYearEnergy", comment: "Current Year Energy") }
    static var coupleMatrixYearEnergy: String { NSLocalizedString("coupleMatrix.yearEnergy", comment: "Year Energy") }
    static var coupleMatrixEnergyForYear: String { NSLocalizedString("coupleMatrix.energyForYear", comment: "Energy for this year") }

    // MARK: - Destiny Matrix History
    static var matrixHistoryTitle: String { NSLocalizedString("matrixHistory.title", comment: "Saved Matrices") }
    static var matrixHistoryEmpty: String { NSLocalizedString("matrixHistory.empty", comment: "No saved matrices yet") }
    static var matrixHistoryEmptyDesc: String { NSLocalizedString("matrixHistory.empty.desc", comment: "Your saved Destiny Matrices will appear here") }
    static var matrixHistoryDeleteAlert: String { NSLocalizedString("matrixHistory.deleteAlert", comment: "Delete Matrix") }
    static var matrixHistoryDeleteMessage: String { NSLocalizedString("matrixHistory.deleteMessage", comment: "Are you sure you want to delete this saved matrix? This action cannot be undone.") }
    static var matrixHistoryDelete: String { NSLocalizedString("matrixHistory.delete", comment: "Delete Matrix") }
    static var matrixHistorySavedOn: String { NSLocalizedString("matrixHistory.savedOn", comment: "Saved on") }
    static var matrixHistoryFilterAll: String { NSLocalizedString("matrixHistory.filter.all", comment: "All") }
    static var matrixHistoryFilterSingle: String { NSLocalizedString("matrixHistory.filter.single", comment: "Single") }
    static var matrixHistoryFilterCouple: String { NSLocalizedString("matrixHistory.filter.couple", comment: "Couple") }
    static var homeMatrixHistory: String { NSLocalizedString("home.matrixHistory", comment: "Saved Matrices") }
    static var homeMatrixHistorySubtitle: String { NSLocalizedString("home.matrixHistory.subtitle", comment: "Review your saved Destiny Matrices") }

    // MARK: - Splash Screen
    static var splashJourneyBegins: String { NSLocalizedString("splash.journeyBegins", comment: "Your Journey Begins") }
    
    // MARK: - Onboarding Flow
    static var onboardingWelcome: String { NSLocalizedString("onboarding.welcome", comment: "Welcome to TarotGo") }
    static var onboardingWelcomeDesc: String { NSLocalizedString("onboarding.welcome.desc", comment: "Your journey into the wisdom of tarot begins here") }

    static var onboardingShuffleTitle: String { NSLocalizedString("onboarding.shuffle.title", comment: "Shuffle with Intention") }
    static var onboardingShuffleDesc: String { NSLocalizedString("onboarding.shuffle.desc", comment: "Hold the deck and focus on your question for a deeper connection") }

    static var onboardingSelectTitle: String { NSLocalizedString("onboarding.select.title", comment: "Choose Your Cards") }
    static var onboardingSelectDesc: String { NSLocalizedString("onboarding.select.desc", comment: "Trust your intuition when selecting cards from the spread") }

    static var onboardingInterpretTitle: String { NSLocalizedString("onboarding.interpret.title", comment: "Receive Guidance") }
    static var onboardingInterpretDesc: String { NSLocalizedString("onboarding.interpret.desc", comment: "Each card offers wisdom tailored to your question") }

    static var onboardingWelcomeSubtitle: String { NSLocalizedString("onboarding.welcome.subtitle", comment: "Your all-in-one mystical companion for tarot, destiny, palmistry and cosmic wisdom") }

    static var onboardingTarotTitle: String { NSLocalizedString("onboarding.tarot.title", comment: "Draw Your Cards") }
    static var onboardingTarotDesc: String { NSLocalizedString("onboarding.tarot.desc", comment: "Shuffle the deck, choose a spread, and uncover insights — even in AR") }

    static var onboardingDestinyMatrixTitle: String { NSLocalizedString("onboarding.destinyMatrix.title", comment: "Decode Your Destiny") }
    static var onboardingDestinyMatrixDesc: String { NSLocalizedString("onboarding.destinyMatrix.desc", comment: "Discover your life purpose, karma and relationships through the 22 arcana matrix") }

    static var onboardingPalmistryTitle: String { NSLocalizedString("onboarding.palmistry.title", comment: "Read Your Palm") }
    static var onboardingPalmistryDesc: String { NSLocalizedString("onboarding.palmistry.desc", comment: "Snap a photo of your hand and reveal what your lines say about you") }

    static var onboardingCosmicTitle: String { NSLocalizedString("onboarding.cosmic.title", comment: "Explore the Cosmos") }
    static var onboardingCosmicDesc: String { NSLocalizedString("onboarding.cosmic.desc", comment: "Daily horoscope, lunar calendar, numerology, cosmogram and compatibility") }

    static var onboardingReadyTitle: String { NSLocalizedString("onboarding.ready.title", comment: "Your Journey Begins") }
    static var onboardingReadyDesc: String { NSLocalizedString("onboarding.ready.desc", comment: "Personalize your experience and let the universe guide you") }

    // MARK: - Onboarding (Intention Selection)
    static var onboardingWelcomeText: String { NSLocalizedString("onboarding.welcomeText", comment: "Welcome") }
    static var onboardingCenterYourself: String { NSLocalizedString("onboarding.centerYourself", comment: "Take a deep breath and center yourself") }
    static var onboardingWhatBrings: String { NSLocalizedString("onboarding.whatBrings", comment: "What brings you here today?") }
    static var onboardingOptionalQuestion: String { NSLocalizedString("onboarding.optionalQuestion", comment: "You may ask a specific question") }
    static var onboardingQuestionPlaceholder: String { NSLocalizedString("onboarding.questionPlaceholder", comment: "What would you like to know?") }
    static var onboardingBeginReading: String { NSLocalizedString("onboarding.beginReading", comment: "Begin Your Reading") }
    static var onboardingGetStarted: String { NSLocalizedString("onboarding.getStarted", comment: "Get Started") }
    static var onboardingNext: String { NSLocalizedString("onboarding.next", comment: "Next") }
    static var onboardingSkip: String { NSLocalizedString("onboarding.skip", comment: "Skip") }

    // MARK: - Intention Categories
    static var categoryLove: String { NSLocalizedString("category.love", comment: "Love") }
    static var categoryLoveDesc: String { NSLocalizedString("category.love.desc", comment: "Relationships and romance") }

    static var categoryCareer: String { NSLocalizedString("category.career", comment: "Career") }
    static var categoryCareerDesc: String { NSLocalizedString("category.career.desc", comment: "Work and professional life") }

    static var categoryFinance: String { NSLocalizedString("category.finance", comment: "Finance") }
    static var categoryFinanceDesc: String { NSLocalizedString("category.finance.desc", comment: "Money and abundance") }

    static var categoryHealth: String { NSLocalizedString("category.health", comment: "Health") }
    static var categoryHealthDesc: String { NSLocalizedString("category.health.desc", comment: "Wellbeing and vitality") }

    static var categoryGeneral: String { NSLocalizedString("category.general", comment: "General") }
    static var categoryGeneralDesc: String { NSLocalizedString("category.general.desc", comment: "Life guidance and wisdom") }

    // MARK: - Shuffle Ritual
    static var shuffleTakeBreath: String { NSLocalizedString("shuffle.takeBreath", comment: "Take a deep breath") }
    static var shuffleInstruction: String { NSLocalizedString("shuffle.instruction", comment: "Place your finger on the deck and hold for 5 seconds while focusing on your question") }
    static var shuffleFocusing: String { NSLocalizedString("shuffle.focusing", comment: "Focus on your intention...") }
    static var shuffleShuffling: String { NSLocalizedString("shuffle.shuffling", comment: "The cards are being shuffled") }
    static var shuffleReady: String { NSLocalizedString("shuffle.ready", comment: "Your deck is ready") }

    // MARK: - Card Selection
    static var selectionChooseCard: String { NSLocalizedString("selection.chooseCard", comment: "Choose a card that calls to you") }
    static var selectionCardOf: String { NSLocalizedString("selection.cardOf", comment: "Card %d of %d") }

    // MARK: - Interpretation
    static var interpretationTapReveal: String { NSLocalizedString("interpretation.tapReveal", comment: "Tap to reveal when you're ready") }
    static var interpretationReversed: String { NSLocalizedString("interpretation.reversed", comment: "(Reversed)") }
    static var interpretationResonateQuestion: String { NSLocalizedString("interpretation.resonateQuestion", comment: "Does this resonate with you?") }
    static var interpretationResonateYes: String { NSLocalizedString("interpretation.resonateYes", comment: "Yes, this speaks to me") }
    static var interpretationResonateUnsure: String { NSLocalizedString("interpretation.resonateUnsure", comment: "I'm not sure") }
    static var interpretationResonateNo: String { NSLocalizedString("interpretation.resonateNo", comment: "This doesn't fit") }
    static var interpretationContinue: String { NSLocalizedString("interpretation.continue", comment: "Continue") }
    static var interpretationSeeFullReading: String { NSLocalizedString("interpretation.seeFullReading", comment: "See Full Reading") }

    // MARK: - Exit Reading Confirmation
    static var exitReadingTitle: String { NSLocalizedString("exitReading.title", comment: "End Reading?") }
    static var exitReadingMessage: String { NSLocalizedString("exitReading.message", comment: "Your progress will be lost if you exit now.") }
    static var exitReadingConfirm: String { NSLocalizedString("exitReading.confirm", comment: "End Reading") }
    static var exitReadingCancel: String { NSLocalizedString("exitReading.cancel", comment: "Continue Reading") }

    // MARK: - Summary
    static var summaryYourReading: String { NSLocalizedString("summary.yourReading", comment: "Your Reading") }
    static var summaryYourTarotGoReading: String { NSLocalizedString("summary.yourTarotGoReading", comment: "Your TarotGo Reading") }
    static var summaryOverallInsight: String { NSLocalizedString("summary.overallInsight", comment: "Overall Insight") }
    static var summaryReflections: String { NSLocalizedString("summary.reflections", comment: "Your Reflections") }
    static var summarySaveReading: String { NSLocalizedString("summary.saveReading", comment: "Save Reading") }
    static var summaryReadingSaved: String { NSLocalizedString("summary.readingSaved", comment: "Reading Saved") }
    static var summaryShareReading: String { NSLocalizedString("summary.shareReading", comment: "Share Reading") }
    static var summaryReturnToStart: String { NSLocalizedString("summary.returnToStart", comment: "Return to Start") }
    
    // MARK: - PDF Export
    static var pdfTitle: String { NSLocalizedString("pdf.title", comment: "TarotGo Reading") }
    static var pdfQuestion: String { NSLocalizedString("pdf.question", comment: "Question:") }
    static var pdfCategory: String { NSLocalizedString("pdf.category", comment: "Category:") }
    static var pdfSpread: String { NSLocalizedString("pdf.spread", comment: "Spread:") }
    static var pdfOverallInsight: String { NSLocalizedString("pdf.overallInsight", comment: "Overall Insight") }
    static var pdfCards: String { NSLocalizedString("pdf.cards", comment: "Cards") }
    static var pdfPersonalReflections: String { NSLocalizedString("pdf.personalReflections", comment: "Personal Reflections") }
    static var pdfDownloadOnAppStore: String { NSLocalizedString("pdf.downloadOnAppStore", comment: "Download TarotGo on the App Store:") }

    // MARK: - PDF Export - Destiny Matrix
    static var pdfMatrixTitle: String { NSLocalizedString("pdf.matrix.title", comment: "Your Destiny Matrix") }
    static var pdfMatrixBirthDate: String { NSLocalizedString("pdf.matrix.birthDate", comment: "Birth Date:") }
    static var pdfMatrixSavedOn: String { NSLocalizedString("pdf.matrix.savedOn", comment: "Saved on:") }
    static var pdfMatrixCoreEssence: String { NSLocalizedString("pdf.matrix.coreEssence", comment: "Core Essence") }
    static var pdfMatrixKeyPositions: String { NSLocalizedString("pdf.matrix.keyPositions", comment: "Key Positions") }
    static var pdfMatrixCurrentYear: String { NSLocalizedString("pdf.matrix.currentYear", comment: "Current Year Energy") }
    static var pdfMatrixEnergy: String { NSLocalizedString("pdf.matrix.energy", comment: "Energy:") }
    static var pdfMatrixYear: String { NSLocalizedString("pdf.matrix.year", comment: "Year") }
    static var pdfMatrixAge: String { NSLocalizedString("pdf.matrix.age", comment: "Age") }
    static var pdfMatrixLifeTimeline: String { NSLocalizedString("pdf.matrix.lifeTimeline", comment: "Life Timeline") }
    static var pdfMatrixYears: String { NSLocalizedString("pdf.matrix.years", comment: "years") }
    static var pdfMatrixCurrentYearDesc: String { NSLocalizedString("pdf.matrix.currentYearDesc", comment: "Your guiding energy this year, shaping the themes, lessons and opportunities woven into your path.") }
    static var pdfMatrixEnergyLegend: String { NSLocalizedString("pdf.matrix.energyLegend", comment: "Energy Legend") }
    static var pdfMatrixEnergyLegendIntro: String { NSLocalizedString("pdf.matrix.energyLegendIntro", comment: "Every circle in your timeline carries a number from 1 to 22 — each tied to a Major Arcana card. Use this legend as a quick guide to the essence each number holds.") }

    // MARK: - PDF Export - Couple Matrix
    static var pdfCoupleMatrixTitle: String { NSLocalizedString("pdf.coupleMatrix.title", comment: "Your Couple Matrix") }
    static var pdfCoupleMatrixHeartOfUnion: String { NSLocalizedString("pdf.coupleMatrix.heartOfUnion", comment: "Heart of Union") }
    static var pdfCoupleMatrixPartnerEnergies: String { NSLocalizedString("pdf.coupleMatrix.partnerEnergies", comment: "Partner Energies") }
    static var pdfCoupleMatrixSharedAspects: String { NSLocalizedString("pdf.coupleMatrix.sharedAspects", comment: "Shared Aspects") }
    static var pdfCoupleMatrixYearsTimeline: String { NSLocalizedString("pdf.coupleMatrix.yearsTimeline", comment: "Years Together Timeline") }
    static var pdfCoupleMatrixCurrentYearDesc: String { NSLocalizedString("pdf.coupleMatrix.currentYearDesc", comment: "The guiding energy of your union this year, shaping the lessons and opportunities woven into your shared path.") }

    // MARK: - PDF Export - Palm Reading
    static var pdfPalmTitle: String { NSLocalizedString("pdf.palm.title", comment: "Your Palm Reading") }
    static var pdfPalmSavedOn: String { NSLocalizedString("pdf.palm.savedOn", comment: "Saved on:") }
    static var pdfPalmHand: String { NSLocalizedString("pdf.palm.hand", comment: "Hand:") }
    static var pdfPalmCapturedImage: String { NSLocalizedString("pdf.palm.capturedImage", comment: "Captured Palm") }
    static var pdfPalmHandShape: String { NSLocalizedString("pdf.palm.handShape", comment: "Hand Shape") }
    static var pdfPalmFingerLength: String { NSLocalizedString("pdf.palm.fingerLength", comment: "Finger Length:") }
    static var pdfPalmShape: String { NSLocalizedString("pdf.palm.shape", comment: "Palm Shape:") }
    static var pdfPalmLines: String { NSLocalizedString("pdf.palm.lines", comment: "Palm Lines") }
    static var pdfPalmMounts: String { NSLocalizedString("pdf.palm.mounts", comment: "Palm Mounts") }
    static var pdfPalmLength: String { NSLocalizedString("pdf.palm.length", comment: "Length:") }
    static var pdfPalmDepth: String { NSLocalizedString("pdf.palm.depth", comment: "Depth:") }
    static var pdfPalmContinuity: String { NSLocalizedString("pdf.palm.continuity", comment: "Continuity:") }
    static var pdfPalmProminence: String { NSLocalizedString("pdf.palm.prominence", comment: "Prominence:") }

    // MARK: - History
    static var historyTitle: String { NSLocalizedString("history.title", comment: "Reading History") }
    static var historyFilter: String { NSLocalizedString("history.filter", comment: "Filter:") }
    static var historyAll: String { NSLocalizedString("history.all", comment: "All") }
    static var historyAllReadings: String { NSLocalizedString("history.allReadings", comment: "All Readings") }
    static var historyNoReadings: String { NSLocalizedString("history.noReadings", comment: "No readings yet") }
    static var historyNoReadingsDesc: String { NSLocalizedString("history.noReadings.desc", comment: "Your saved readings will appear here") }
    static var historyDeleteAlert: String { NSLocalizedString("history.deleteAlert", comment: "Delete Reading") }
    static var historyDeleteMessage: String { NSLocalizedString("history.deleteMessage", comment: "Are you sure you want to delete this reading? This action cannot be undone.") }
    static var historyDeleteReading: String { NSLocalizedString("history.deleteReading", comment: "Delete Reading") }
    static var historyNoReflections: String { NSLocalizedString("history.noReflections", comment: "No reflections added") }

    // MARK: - Card of the Day
    static var cardOfDayTitle: String { NSLocalizedString("cardOfDay.title", comment: "Card of the Day") }
    static var cardOfDayCenterYourself: String { NSLocalizedString("cardOfDay.centerYourself", comment: "Take a moment to center yourself") }
    static var cardOfDayInstruction: String { NSLocalizedString("cardOfDay.instruction", comment: "Place your finger on the card and hold for 5 seconds") }
    static var cardOfDayTodaysMessage: String { NSLocalizedString("cardOfDay.todaysMessage", comment: "Today's Message") }
    static var cardOfDayReflect: String { NSLocalizedString("cardOfDay.reflect", comment: "Reflect") }

    // MARK: - Settings
    static var settingsTitle: String { NSLocalizedString("settings.title", comment: "Settings") }
    static var settingsNotifications: String { NSLocalizedString("settings.notifications", comment: "Notifications") }
    static var settingsDailyReminder: String { NSLocalizedString("settings.dailyReminder", comment: "Daily Card Reminder") }
    static var settingsDailyReminderDesc: String { NSLocalizedString("settings.dailyReminder.desc", comment: "Receive a daily reminder to draw your Card of the Day") }
    static var settingsReminderTime: String { NSLocalizedString("settings.reminderTime", comment: "Reminder Time") }
    static var settingsSetReminderTime: String { NSLocalizedString("settings.setReminderTime", comment: "Set Reminder Time") }
    static var settingsSound: String { NSLocalizedString("settings.sound", comment: "Sound") }
    static var settingsSoundEnabled: String { NSLocalizedString("settings.soundEnabled", comment: "Sound Effects") }
    static var settingsSoundEnabledDesc: String { NSLocalizedString("settings.soundEnabled.desc", comment: "Play sound effects throughout the app") }
    static var settingsAppearance: String { NSLocalizedString("settings.appearance", comment: "Appearance") }
    static var settingsCardBack: String { NSLocalizedString("settings.cardBack", comment: "Card Back Design") }
    static var settingsCardBackDesc: String { NSLocalizedString("settings.cardBack.desc", comment: "Choose the design for the back of your tarot cards") }
    static var settingsCardBackModern: String { NSLocalizedString("settings.cardBack.modern", comment: "Modern") }
    static var settingsCardBackOriginal: String { NSLocalizedString("settings.cardBack.original", comment: "Original") }
    static var settingsCardBackStandard: String { NSLocalizedString("settings.cardBack.standard", comment: "Standard") }
    static var settingsCardBackClassic: String { NSLocalizedString("settings.cardBack.classic", comment: "Classic") }
    static var settingsCardBackModernSubtitle: String { NSLocalizedString("settings.cardBack.modern.subtitle", comment: "21st Century") }
    static var settingsCardBackOriginalSubtitle: String { NSLocalizedString("settings.cardBack.original.subtitle", comment: "CRACKED ICE (1909)") }
    static var settingsCardBackStandardSubtitle: String { NSLocalizedString("settings.cardBack.standard.subtitle", comment: "TUDOR ROSE") }
    static var settingsCardBackClassicSubtitle: String { NSLocalizedString("settings.cardBack.classic.subtitle", comment: "PLAID") }
    static var settingsInfo: String { NSLocalizedString("settings.info", comment: "Info") }
    static var settingsIntroSlides: String { NSLocalizedString("settings.introSlides", comment: "Intro Slides") }
    static var settingsAbout: String { NSLocalizedString("settings.about", comment: "About") }
    static var settingsVersion: String { NSLocalizedString("settings.version", comment: "Version") }
    static var settingsSave: String { NSLocalizedString("settings.save", comment: "Save") }
    static var settingsLanguage: String { NSLocalizedString("settings.language", comment: "Language") }
    static var settingsLanguageSelection: String { NSLocalizedString("settings.languageSelection", comment: "Language Selection") }
    static var settingsLanguageDesc: String { NSLocalizedString("settings.language.desc", comment: "Change the app language in your phone settings") }
    
    static var settingsNotificationPermissionTitle: String { NSLocalizedString("settings.notificationPermission.title", comment: "Notification Permission Required") }
    static var settingsNotificationPermissionMessage: String { NSLocalizedString("settings.notificationPermission.message", comment: "Please enable notifications in Settings to receive daily card reminders") }
    static var settingsNotificationPermissionSettings: String { NSLocalizedString("settings.notificationPermission.settings", comment: "Open Settings") }
    static var settingsNotificationPermissionCancel: String { NSLocalizedString("settings.notificationPermission.cancel", comment: "Cancel") }
    
    static var settingsRateApp: String { NSLocalizedString("settings.rateApp", comment: "Rate TarotGo") }
    static var settingsRateAppDesc: String { NSLocalizedString("settings.rateAppDesc", comment: "Loving TarotGo? Leave a review on the App Store - it helps other seekers find us.") }
    static var settingsRateAppHeader: String { NSLocalizedString("settings.rateAppHeader", comment: "Support") }
    static var settingsLegal: String { NSLocalizedString("settings.legal", comment: "Legal") }
    static var settingsPrivacyPolicy: String { NSLocalizedString("settings.privacyPolicy", comment: "Privacy Policy") }
    static var settingsTermsOfService: String { NSLocalizedString("settings.termsOfService", comment: "Terms of Service") }

    // Premium subscription status
    static var settingsPremiumHeader: String { NSLocalizedString("settings.premium.header", comment: "Premium section header in settings") }
    static var settingsPremiumActive: String { NSLocalizedString("settings.premium.active", comment: "Premium Active status text") }
    static var settingsPremiumManage: String { NSLocalizedString("settings.premium.manage", comment: "Manage Subscription row") }
    static var settingsPremiumPlanYearly: String { NSLocalizedString("settings.premium.plan.yearly", comment: "Yearly plan label") }
    static var settingsPremiumPlanMonthly: String { NSLocalizedString("settings.premium.plan.monthly", comment: "Monthly plan label") }
    
    // Birth Date Settings
    static var settingsPersonalization: String { NSLocalizedString("settings.personalization", comment: "Personalization") }
    static var settingsBirthDate: String { NSLocalizedString("settings.birthDate", comment: "Birth Date") }
    static var settingsChange: String { NSLocalizedString("settings.change", comment: "Change") }
    static var settingsAddBirthDate: String { NSLocalizedString("settings.addBirthDate", comment: "Add Birth Date") }
    static var settingsAddBirthDateDesc: String { NSLocalizedString("settings.addBirthDate.desc", comment: "Personalize your readings with astrology") }
    static var settingsBirthDateFooter: String { NSLocalizedString("settings.birthDate.footer", comment: "Your birth date enables a personalized card of the day, the Destiny Matrix, and astrological insights. It's stored locally and never shared.") }
    
    static var skip: String { NSLocalizedString("common.skip", comment: "Skip") }
    
    // Birth Date Input
    static var birthDateInputTitle: String { NSLocalizedString("birthDateInput.title", comment: "Your Birth Date") }
    static var birthDateInputDescription: String { NSLocalizedString("birthDateInput.description", comment: "Enter your birth date to unlock personalized daily cards, Destiny Matrix, and astrological insights") }
    static var birthDateInputSelectDate: String { NSLocalizedString("birthDateInput.selectDate", comment: "Select Your Birth Date") }
    static var birthDateInputZodiacSign: String { NSLocalizedString("birthDateInput.zodiacSign", comment: "Zodiac Sign") }
    static var birthDateInputLifePath: String { NSLocalizedString("birthDateInput.lifePath", comment: "Life Path") }
    static var birthDateInputNumerology: String { NSLocalizedString("birthDateInput.numerology", comment: "Numerology") }
    static var birthDateInputPrivacy: String { NSLocalizedString("birthDateInput.privacy", comment: "Your birth date is stored securely on your device and never shared") }

    // MARK: - Spread Types
    static var spreadSingleCard: String { NSLocalizedString("spread.singleCard", comment: "Single Card") }
    static var spreadThreeCard: String { NSLocalizedString("spread.threeCard", comment: "Three Card Spread") }
    static var spreadCelticCross: String { NSLocalizedString("spread.celticCross", comment: "Celtic Cross") }
    static var spreadRelationship: String { NSLocalizedString("spread.relationship", comment: "Relationship Spread") }
    static var spreadLoveTriangle: String { NSLocalizedString("spread.loveTriangle", comment: "Love Triangle") }
    static var spreadCareerPath: String { NSLocalizedString("spread.careerPath", comment: "Career Path") }

    // MARK: - Spread Positions
    static var positionPast: String { NSLocalizedString("position.past", comment: "Past") }
    static var positionPastDesc: String { NSLocalizedString("position.past.desc", comment: "What has brought you to this moment") }
    static var positionPresent: String { NSLocalizedString("position.present", comment: "Present") }
    static var positionPresentDesc: String { NSLocalizedString("position.present.desc", comment: "Where you are right now") }
    static var positionFuture: String { NSLocalizedString("position.future", comment: "Future") }
    static var positionFutureDesc: String { NSLocalizedString("position.future.desc", comment: "What is unfolding ahead") }

    // Three Card Spread
    static var positionPastShort: String { NSLocalizedString("position.past.short", comment: "Past") }
    static var positionPastShortDesc: String { NSLocalizedString("position.past.short.desc", comment: "What brought you here") }
    static var positionPresentShort: String { NSLocalizedString("position.present.short", comment: "Present") }
    static var positionPresentShortDesc: String { NSLocalizedString("position.present.short.desc", comment: "Your current situation") }
    static var positionFutureShort: String { NSLocalizedString("position.future.short", comment: "Future") }
    static var positionFutureShortDesc: String { NSLocalizedString("position.future.short.desc", comment: "What's coming") }

    // Celtic Cross
    static var positionChallenge: String { NSLocalizedString("position.challenge", comment: "Challenge") }
    static var positionChallengeDesc: String { NSLocalizedString("position.challenge.desc", comment: "What crosses you") }
    static var positionFoundation: String { NSLocalizedString("position.foundation", comment: "Past") }
    static var positionFoundationDesc: String { NSLocalizedString("position.foundation.desc", comment: "Foundation of the situation") }
    static var positionApproaching: String { NSLocalizedString("position.approaching", comment: "Future") }
    static var positionApproachingDesc: String { NSLocalizedString("position.approaching.desc", comment: "What's approaching") }
    static var positionAbove: String { NSLocalizedString("position.above", comment: "Above") }
    static var positionAboveDesc: String { NSLocalizedString("position.above.desc", comment: "Your goal or aspiration") }
    static var positionBelow: String { NSLocalizedString("position.below", comment: "Below") }
    static var positionBelowDesc: String { NSLocalizedString("position.below.desc", comment: "Unconscious influences") }
    static var positionAdvice: String { NSLocalizedString("position.advice", comment: "Advice") }
    static var positionAdviceDesc: String { NSLocalizedString("position.advice.desc", comment: "Your best approach") }
    static var positionExternal: String { NSLocalizedString("position.external", comment: "External") }
    static var positionExternalDesc: String { NSLocalizedString("position.external.desc", comment: "Outside influences") }
    static var positionHopes: String { NSLocalizedString("position.hopes", comment: "Hopes & Fears") }
    static var positionHopesDesc: String { NSLocalizedString("position.hopes.desc", comment: "Your inner emotions") }
    static var positionOutcome: String { NSLocalizedString("position.outcome", comment: "Outcome") }
    static var positionOutcomeDesc: String { NSLocalizedString("position.outcome.desc", comment: "Final result") }

    // Love Triangle
    static var positionYou: String { NSLocalizedString("position.you", comment: "You") }
    static var positionYouDesc: String { NSLocalizedString("position.you.desc", comment: "Your emotional state") }
    static var positionThem: String { NSLocalizedString("position.them", comment: "Them") }
    static var positionThemDesc: String { NSLocalizedString("position.them.desc", comment: "Their emotional state") }
    static var positionConnection: String { NSLocalizedString("position.connection", comment: "Connection") }
    static var positionConnectionDesc: String { NSLocalizedString("position.connection.desc", comment: "The relationship dynamic") }

    // Career Path
    static var positionCurrent: String { NSLocalizedString("position.current", comment: "Current Situation") }
    static var positionCurrentDesc: String { NSLocalizedString("position.current.desc", comment: "Where you are now") }
    static var positionObstacles: String { NSLocalizedString("position.obstacles", comment: "Obstacles") }
    static var positionObstaclesDesc: String { NSLocalizedString("position.obstacles.desc", comment: "What's blocking you") }
    static var positionStrengths: String { NSLocalizedString("position.strengths", comment: "Strengths") }
    static var positionStrengthsDesc: String { NSLocalizedString("position.strengths.desc", comment: "Your assets") }
    static var positionAction: String { NSLocalizedString("position.action", comment: "Action") }
    static var positionActionDesc: String { NSLocalizedString("position.action.desc", comment: "What to do next") }
    static var positionCareerOutcome: String { NSLocalizedString("position.careerOutcome", comment: "Outcome") }
    static var positionCareerOutcomeDesc: String { NSLocalizedString("position.careerOutcome.desc", comment: "Potential result") }

    // MARK: - Card Dictionary
    static var dictionaryTitle: String { NSLocalizedString("dictionary.title", comment: "Card Dictionary") }
    static var dictionarySubtitle: String { NSLocalizedString("dictionary.subtitle", comment: "Explore all 78 tarot cards") }
    static var dictionarySearchPlaceholder: String { NSLocalizedString("dictionary.searchPlaceholder", comment: "Search cards...") }
    static var dictionaryAllCards: String { NSLocalizedString("dictionary.allCards", comment: "All Cards") }
    static var dictionaryUpright: String { NSLocalizedString("dictionary.upright", comment: "Upright") }
    static var dictionaryReversed: String { NSLocalizedString("dictionary.reversed", comment: "Reversed") }
    static var dictionaryKeywords: String { NSLocalizedString("dictionary.keywords", comment: "Keywords") }
    static var dictionaryMeanings: String { NSLocalizedString("dictionary.meanings", comment: "Meanings") }
    static var dictionaryGeneral: String { NSLocalizedString("dictionary.general", comment: "General") }

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
    
    static var summaryMajorArcanaLow: String { NSLocalizedString("summary.majorArcana.low", comment: "The cards focus on everyday matters") }
    
    static var summaryReversedMany: String { NSLocalizedString("summary.reversed.many", comment: "Many reversed cards suggest blocks") }
    
    static var summaryReversedSome: String { NSLocalizedString("summary.reversed.some", comment: "Some reversed cards indicate areas needing attention") }
    
    static var summaryReversedNone: String { NSLocalizedString("summary.reversed.none", comment: "All cards upright show clear forward energy") }
    
    // Suit insights - Always shows dominant or balanced energy
    static var summarySuitCupsDominant: String { NSLocalizedString("summary.suit.cups.dominant", comment: "Cups dominate - emotions and relationships") }
    
    static var summarySuitSwordsDominant: String { NSLocalizedString("summary.suit.swords.dominant", comment: "Swords dominate - mental energy and thoughts") }
    
    static var summarySuitWandsDominant: String { NSLocalizedString("summary.suit.wands.dominant", comment: "Wands dominate - passion and creative energy") }
    
    static var summarySuitPentaclesDominant: String { NSLocalizedString("summary.suit.pentacles.dominant", comment: "Pentacles dominate - material and practical matters") }
    
    static var summarySuitMajorArcanaDominant: String { NSLocalizedString("summary.suit.majorArcana.dominant", comment: "Major Arcana dominates - soul journey") }
    
    static var summarySuitBalanced: String { NSLocalizedString("summary.suit.balanced", comment: "Balanced mix of suits shows multi-faceted situation") }
    
    // Category-specific insights - Richer context
    static var summaryInsightLove: String { NSLocalizedString("summary.insight.love", comment: "In matters of love and relationships") }
    
    static var summaryInsightCareer: String { NSLocalizedString("summary.insight.career", comment: "Regarding your career and professional path") }
    
    static var summaryInsightFinance: String { NSLocalizedString("summary.insight.finance", comment: "When it comes to finances and resources") }
    
    static var summaryInsightHealth: String { NSLocalizedString("summary.insight.health", comment: "For your health and wellbeing") }
    
    static var summaryInsightGeneral: String { NSLocalizedString("summary.insight.general", comment: "Looking at your life journey") }
    
    // Closing statements - 10 variations for variety
    static var summaryClosing1: String { NSLocalizedString("summary.closing.1", comment: "these cards are telling a story that requires your attention and honest reflection.") }
    static var summaryClosing2: String { NSLocalizedString("summary.closing.2", comment: "pay attention to how these energies are showing up in your life right now.") }
    static var summaryClosing3: String { NSLocalizedString("summary.closing.3", comment: "the cards invite you to sit with these insights and see what resonates.") }
    static var summaryClosing4: String { NSLocalizedString("summary.closing.4", comment: "trust your intuition as you interpret what the cards are revealing.") }
    static var summaryClosing5: String { NSLocalizedString("summary.closing.5", comment: "these messages are here to guide you forward with greater clarity.") }
    static var summaryClosing6: String { NSLocalizedString("summary.closing.6", comment: "reflect on how these themes are interwoven in your current situation.") }
    static var summaryClosing7: String { NSLocalizedString("summary.closing.7", comment: "the wisdom here asks you to look deeper and trust what you discover.") }
    static var summaryClosing8: String { NSLocalizedString("summary.closing.8", comment: "let these insights illuminate the path ahead as you move forward.") }
    static var summaryClosing9: String { NSLocalizedString("summary.closing.9", comment: "take time to absorb what the cards are showing you in this moment.") }
    static var summaryClosing10: String { NSLocalizedString("summary.closing.10", comment: "the cards have spoken—now it's time to listen with an open heart.") }
    
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
    static var palmReadingTitle: String { NSLocalizedString("palmReading.title", comment: "Palm Reading") }
    static var palmReadingSubtitle: String { NSLocalizedString("palmReading.subtitle", comment: "Discover the secrets in your palm") }
    
    // Palm Line Names
    static var palmLineHeart: String { NSLocalizedString("palm.line.heart", comment: "Heart Line") }
    static var palmLineHead: String { NSLocalizedString("palm.line.head", comment: "Head Line") }
    static var palmLineLife: String { NSLocalizedString("palm.line.life", comment: "Life Line") }
    static var palmLineFate: String { NSLocalizedString("palm.line.fate", comment: "Fate Line") }
    
    // Palm Line Characteristics
    static var palmLineLengthShort: String { NSLocalizedString("palm.lineLength.short", comment: "Short") }
    static var palmLineLengthMedium: String { NSLocalizedString("palm.lineLength.medium", comment: "Medium") }
    static var palmLineLengthLong: String { NSLocalizedString("palm.lineLength.long", comment: "Long") }
    
    static var palmLineDepthFaint: String { NSLocalizedString("palm.lineDepth.faint", comment: "Faint") }
    static var palmLineDepthModerate: String { NSLocalizedString("palm.lineDepth.moderate", comment: "Moderate") }
    static var palmLineDepthDeep: String { NSLocalizedString("palm.lineDepth.deep", comment: "Deep") }
    
    static var palmLineContinuityContinuous: String { NSLocalizedString("palm.lineContinuity.continuous", comment: "Continuous") }
    static var palmLineContinuityBroken: String { NSLocalizedString("palm.lineContinuity.broken", comment: "Broken") }
    static var palmLineContinuityChained: String { NSLocalizedString("palm.lineContinuity.chained", comment: "Chained") }
    
    static var palmFateLineNotVisible: String { NSLocalizedString("palm.fateLine.notVisible", comment: "The Fate Line is not prominently visible in your palm, which suggests a life path shaped by personal choices rather than external destiny. You have the freedom to create your own direction.") }
    static var palmReadingIntroTitle: String { NSLocalizedString("palmReading.intro.title", comment: "Discover the secrets in your palm") }
    static var palmReadingOnDeviceTitle: String { NSLocalizedString("palmReading.onDevice.title", comment: "On-Device Analysis") }
    static var palmReadingOnDeviceDesc: String { NSLocalizedString("palmReading.onDevice.desc", comment: "Your palm image is processed locally and never leaves your device. Complete privacy guaranteed.") }
    static var palmReadingFourLinesTitle: String { NSLocalizedString("palmReading.fourLines.title", comment: "Four Major Lines") }
    static var palmReadingFourLinesDesc: String { NSLocalizedString("palmReading.fourLines.desc", comment: "We analyze your Heart, Head, Life, and Fate lines to reveal insights about your path.") }
    static var palmReadingAncientTitle: String { NSLocalizedString("palmReading.ancient.title", comment: "Ancient Wisdom") }
    static var palmReadingAncientDesc: String { NSLocalizedString("palmReading.ancient.desc", comment: "Palmistry has guided seekers for thousands of years. Let your palm tell its story.") }
    static var palmReadingTakePhoto: String { NSLocalizedString("palmReading.takePhoto", comment: "Take Palm Photo") }
    static var palmReadingAnalyzing: String { NSLocalizedString("palmReading.analyzing", comment: "Reading Your Palm") }
    static var palmReadingAnalyzingDesc: String { NSLocalizedString("palmReading.analyzing.desc", comment: "Analyzing the lines of your destiny...") }
    static var palmReadingYourReading: String { NSLocalizedString("palmReading.yourReading", comment: "Your Palm Reading") }
    static var palmReadingOverall: String { NSLocalizedString("palmReading.overall", comment: "Overall Reading") }
    static var palmReadingYourLines: String { NSLocalizedString("palmReading.yourLines", comment: "Your Palm Lines") }
    static var palmReadingReadAnother: String { NSLocalizedString("palmReading.readAnother", comment: "Read Another Palm") }
    static var palmReadingCameraAccess: String { NSLocalizedString("palmReading.cameraAccess", comment: "Camera Access Required") }
    static var palmReadingCameraDesc: String { NSLocalizedString("palmReading.camera.desc", comment: "To read your palm, we need access to your camera. Your palm image is processed locally and never leaves your device.") }
    static var palmReadingOpenSettings: String { NSLocalizedString("palmReading.openSettings", comment: "Open Settings") }
    static var palmReadingPlaceHand: String { NSLocalizedString("palmReading.placeHand", comment: "Place your palm within the guide") }

    // MARK: - Palm Analysis Errors
    static var palmAnalysisErrorInvalidImage: String { NSLocalizedString("palmAnalysis.error.invalidImage", comment: "The image could not be processed. Please try taking another photo.") }
    static var palmAnalysisErrorNoHandDetected: String { NSLocalizedString("palmAnalysis.error.noHandDetected", comment: "No hand detected in the image. Please ensure your palm is clearly visible and well-lit.") }
    static var palmAnalysisErrorFingersNotExtended: String { NSLocalizedString("palmAnalysis.error.fingersNotExtended", comment: "Please open your hand and extend all your fingers. A closed fist or curled fingers cannot be read.") }
    static var palmAnalysisErrorLowConfidence: String { NSLocalizedString("palmAnalysis.error.lowConfidence", comment: "Your palm couldn't be clearly identified. Show the inside of your hand to the camera with good lighting and try again.") }
    static var palmAnalysisErrorProcessingFailed: String { NSLocalizedString("palmAnalysis.error.processingFailed", comment: "Failed to analyze the palm lines. Please try again with better lighting.") }
    static var palmAnalysisErrorWrongHandSide: String { NSLocalizedString("palmAnalysis.error.wrongHandSide", comment: "Please show the inside of your hand to the camera, not the back. Palm reading requires the palm side facing the lens.") }
    static var palmAnalysisErrorPoorLighting: String { NSLocalizedString("palmAnalysis.error.poorLighting", value: "The palm lines aren't clearly visible in this photo. Please try again in brighter, more even light — avoid strong shadows or backlight.", comment: "Palm image lacks enough crease detail to analyze — usually caused by dim light, shadows, or backlight.") }

    // MARK: - Palm Handedness
    static var palmHandednessLeft: String { NSLocalizedString("palm.handedness.left", comment: "Left Hand") }
    static var palmHandednessRight: String { NSLocalizedString("palm.handedness.right", comment: "Right Hand") }

    // MARK: - Palm Reading History
    static var palmHistoryTitle: String { NSLocalizedString("palmHistory.title", comment: "Saved Readings") }
    static var palmHistoryButtonTitle: String { NSLocalizedString("palmHistory.button.title", comment: "Saved Readings") }
    static var palmHistoryButtonSubtitle: String { NSLocalizedString("palmHistory.button.subtitle", comment: "Review your saved palm readings") }
    static var palmHistoryEmpty: String { NSLocalizedString("palmHistory.empty", comment: "No saved palm readings yet") }
    static var palmHistoryEmptyDesc: String { NSLocalizedString("palmHistory.empty.desc", comment: "Your saved palm readings will appear here") }
    static var palmHistorySavedOn: String { NSLocalizedString("palmHistory.savedOn", comment: "Saved on") }
    static var palmHistoryDeleteAlert: String { NSLocalizedString("palmHistory.deleteAlert", comment: "Delete Reading") }
    static var palmHistoryDeleteMessage: String { NSLocalizedString("palmHistory.deleteMessage", comment: "Are you sure you want to delete this saved palm reading? This action cannot be undone.") }
    static var palmHistoryDelete: String { NSLocalizedString("palmHistory.delete", comment: "Delete Reading") }
    static var palmHistoryCapturedImage: String { NSLocalizedString("palmHistory.capturedImage", comment: "Captured Image") }

    // MARK: - Learn Tarot
    // Main Learn View
    static var homeLearnTarot: String { NSLocalizedString("home.learnTarot", comment: "Learn Tarot") }
    static var homeLearnTarotSubtitle: String { NSLocalizedString("home.learnTarot.subtitle", comment: "Understand cards, meanings and history") }
    
    static var learnTarotTitle: String { NSLocalizedString("learn.title", comment: "Learn Tarot") }
    static var learnTarotSubtitle: String { NSLocalizedString("learn.subtitle", comment: "Deepen your understanding") }
    
    // Learn Options
    static var learnHistoryTitle: String { NSLocalizedString("learn.history.title", comment: "History of Tarot") }
    static var learnHistorySubtitle: String { NSLocalizedString("learn.history.subtitle", comment: "Origins and evolution") }
    
    static var learnBasicMeaningsTitle: String { NSLocalizedString("learn.basicMeanings.title", comment: "Card Basic Meanings") }
    static var learnBasicMeaningsSubtitle: String { NSLocalizedString("learn.basicMeanings.subtitle", comment: "Understand the cards") }
    
    static var learnHowToReadTitle: String { NSLocalizedString("learn.howToRead.title", comment: "How to Read") }
    static var learnHowToReadSubtitle: String { NSLocalizedString("learn.howToRead.subtitle", comment: "Master the practice") }
    
    static var learnTarotMindTitle: String { NSLocalizedString("learn.tarotMind.title", comment: "Tarot & Mind") }
    static var learnTarotMindSubtitle: String { NSLocalizedString("learn.tarotMind.subtitle", comment: "Inner growth tool") }
    
    static var learnFaqTitle: String { NSLocalizedString("learn.faq.title", comment: "FAQ") }
    static var learnFaqSubtitle: String { NSLocalizedString("learn.faq.subtitle", comment: "Common questions") }
    
    // History of Tarot View
    static var historyOfTarotTitle: String { NSLocalizedString("history.page.title", comment: "History of Tarot") }
    static var historySubtitle: String { NSLocalizedString("history.page.subtitle", comment: "The Origins of Tarot: From Games to Symbolism") }
    static var historyIntro: String { NSLocalizedString("history.intro", comment: "The history of Tarot is a fascinating journey that began not with mysticism, but with the simple joy of gameplay. While many associate the cards with ancient mystery, their documented roots lie in the courts of Renaissance Italy and the evolution of international card games.") }
    
    static var historyEvolutionTitle: String { NSLocalizedString("history.evolution.title", comment: "The Evolution of Playing Cards") }
    static var historyEvolutionIntro: String { NSLocalizedString("history.evolution.intro", comment: "Before the first 'Tarot' deck existed, standard playing cards had already taken Europe by storm.") }
    
    static var historyMamlukTitle: String { NSLocalizedString("history.mamluk.title", comment: "The Mamluk Connection") }
    static var historyMamlukText: String { NSLocalizedString("history.mamluk.text", comment: "Most scholars agree that European playing cards were adapted from the Egyptian Mamluk deck in the 14th century. These early decks arrived alongside the introduction of paper from Asia.") }
    
    static var historySpreadTitle: String { NSLocalizedString("history.spread.title", comment: "Rapid Spread") }
    static var historySpreadText: String { NSLocalizedString("history.spread.text", comment: "By the late 1300s, cards were so popular that records of them appear across Europe—often in the form of legal bans. In 1377, a monk named John of Rheinfelden described a basic pack of four suits with 13 cards each, very similar to the structure we use today.") }
    
    static var historySuitsTitle: String { NSLocalizedString("history.suits.title", comment: "Original Suits") }
    static var historySuitsText: String { NSLocalizedString("history.suits.text", comment: "The early 'Latin' suits consisted of Swords, Batons (Clubs), Cups, and Coins. While most modern playing cards use French suits (Spades, Hearts, etc.), Tarot has preserved these original symbols for over six centuries.") }
    
    static var historyBirthTitle: String { NSLocalizedString("history.birth.title", comment: "The Birth of 'Tarocchi'") }
    static var historyBirthIntro: String { NSLocalizedString("history.birth.intro", comment: "Tarot as we know it emerged in Northern Italy—specifically in Milan and Ferrara—during the early 15th century. At the time, these cards were called tarocchi or trionfi (triumphs).") }
    
    static var historyTrumpsTitle: String { NSLocalizedString("history.trumps.title", comment: "The Addition of Trumps") }
    static var historyTrumpsIntro: String { NSLocalizedString("history.trumps.intro", comment: "The revolutionary change was the addition of a Fool and 21 'trump' cards to the standard four-suit deck. These trumps were essentially a permanent suit of higher-ranking cards used for a game similar to modern Bridge.") }
    
    static var historyViscontiTitle: String { NSLocalizedString("history.visconti.title", comment: "The Visconti-Sforza Legacy") }
    static var historyViscontiText: String { NSLocalizedString("history.visconti.text", comment: "Some of the earliest and most beautiful examples come from the mid-1400s, commissioned by the Duke of Milan. These hand-painted decks often featured gold leaf and reflected the high fashion of the Italian nobility.") }
    
    static var historyClassicalTitle: String { NSLocalizedString("history.classical.title", comment: "Classical Influence") }
    static var historyClassicalText: String { NSLocalizedString("history.classical.text", comment: "Early decks weren't always standardized. For example, a deck commissioned by Duke Filippo Maria Visconti featured images of Roman gods and suits depicted as birds, showcasing the Renaissance obsession with classical motifs.") }
    
    // Timeline Table
    static var historyTimelineTitle: String { NSLocalizedString("history.timeline.title", comment: "Timeline") }
    static var historyTimelineEraHeader: String { NSLocalizedString("history.timeline.era", comment: "Era") }
    static var historyTimelineMilestoneHeader: String { NSLocalizedString("history.timeline.milestone", comment: "Milestone") }
    
    static var historyTimelineEra1: String { NSLocalizedString("history.timeline.era1", comment: "Pre-14th Century") }
    static var historyTimelineMilestone1: String { NSLocalizedString("history.timeline.milestone1", comment: "Mamluk decks from Egypt introduce the four-suit system to Europe.") }
    
    static var historyTimelineEra2: String { NSLocalizedString("history.timeline.era2", comment: "1367–1377") }
    static var historyTimelineMilestone2: String { NSLocalizedString("history.timeline.milestone2", comment: "First European records of playing cards appear in Switzerland and Germany.") }
    
    static var historyTimelineEra3: String { NSLocalizedString("history.timeline.era3", comment: "1418–1450") }
    static var historyTimelineMilestone3: String { NSLocalizedString("history.timeline.milestone3", comment: "The first \"Triumph\" (Tarot) decks are created in Milan and Ferrara.") }
    
    static var historyTimelineEra4: String { NSLocalizedString("history.timeline.era4", comment: "Late 1400s") }
    static var historyTimelineMilestone4: String { NSLocalizedString("history.timeline.milestone4", comment: "Decks like the Sola Busca begin to incorporate intricate, classical illustrations for all cards.") }
    
    static var historyTimelineEra5: String { NSLocalizedString("history.timeline.era5", comment: "Late 18th Century") }
    static var historyTimelineMilestone5: String { NSLocalizedString("history.timeline.milestone5", comment: "Tarot begins its transition from a parlor game to a tool for divination and occult study.") }
    
    // Card Basic Meanings View
    static var basicMeaningsTitle: String { NSLocalizedString("basicMeanings.title", comment: "Card Basic Meanings") }
    static var basicMeaningsSubtitle: String { NSLocalizedString("basicMeanings.subtitle", comment: "Understanding the Tarot Deck") }
    static var basicMeaningsIntro: String { NSLocalizedString("basicMeanings.intro", comment: "Each tarot card carries a unique message expressed through symbols and imagery.") }
    
    static var basicMeaningsMajorTitle: String { NSLocalizedString("basicMeanings.major.title", comment: "Major Arcana (22 cards)") }
    static var basicMeaningsMajorText: String { NSLocalizedString("basicMeanings.major.text", comment: "Represent major life events and deep transformations. They reflect important turning points and lessons.") }
    
    static var basicMeaningsMinorTitle: String { NSLocalizedString("basicMeanings.minor.title", comment: "Minor Arcana (56 cards)") }
    static var basicMeaningsMinorText: String { NSLocalizedString("basicMeanings.minor.text", comment: "Reflect everyday experiences and situations.") }
    
    static var basicMeaningsCupsTitle: String { NSLocalizedString("basicMeanings.cups.title", comment: "Cups") }
    static var basicMeaningsCupsSubtitle: String { NSLocalizedString("basicMeanings.cups.subtitle", comment: "Emotions & relationships") }
    
    static var basicMeaningsPentaclesTitle: String { NSLocalizedString("basicMeanings.pentacles.title", comment: "Pentacles") }
    static var basicMeaningsPentaclesSubtitle: String { NSLocalizedString("basicMeanings.pentacles.subtitle", comment: "Money & work") }
    
    static var basicMeaningsSwordsTitle: String { NSLocalizedString("basicMeanings.swords.title", comment: "Swords") }
    static var basicMeaningsSwordsSubtitle: String { NSLocalizedString("basicMeanings.swords.subtitle", comment: "Thoughts & challenges") }
    
    static var basicMeaningsWandsTitle: String { NSLocalizedString("basicMeanings.wands.title", comment: "Wands") }
    static var basicMeaningsWandsSubtitle: String { NSLocalizedString("basicMeanings.wands.subtitle", comment: "Energy & action") }
    
    static var basicMeaningsConclusion: String { NSLocalizedString("basicMeanings.conclusion", comment: "There is no single correct interpretation. Meaning depends on context and intuition.") }
    
    // How to Read View
    static var howToReadTitle: String { NSLocalizedString("howToRead.title", comment: "How to Read Tarot") }
    
    static var howToReadStep1Title: String { NSLocalizedString("howToRead.step1.title", comment: "Focus on Your Question (Intention)") }
    static var howToReadStep1Intro: String { NSLocalizedString("howToRead.step1.intro", comment: "Before you touch the cards, quiet your mind. Tarot works best with open-ended questions that give you room to take action.") }
    static var howToReadStep1Example: String { NSLocalizedString("howToRead.step1.example", comment: "Instead of asking: 'Will I get this job?' (a closed yes/no question). Ask: 'What do I need to know about this career path?' or 'How can I best prepare for the interview?'.") }
    static var howToReadStep1ProTip: String { NSLocalizedString("howToRead.step1.proTip", comment: "Frame your questions starting with 'How,' 'What,' or 'Why.'") }
    
    static var howToReadStep2Title: String { NSLocalizedString("howToRead.step2.title", comment: "Draw Your Cards (Intuition in Action)") }
    static var howToReadStep2Intro: String { NSLocalizedString("howToRead.step2.intro", comment: "Shuffle the deck in a way that feels natural to you. There is no 'wrong' method—you can cut the deck, spread them in a fan, or simply mix them on the table.") }
    static var howToReadStep2Bullet1Title: String { NSLocalizedString("howToRead.step2.bullet1.title", comment: "Trust your impulse") }
    static var howToReadStep2Bullet1Text: String { NSLocalizedString("howToRead.step2.bullet1.text", comment: "Choose the cards that 'catch your eye' or those where you feel a slight tingling in your hands.") }
    static var howToReadStep2Bullet2Title: String { NSLocalizedString("howToRead.step2.bullet2.title", comment: "Simple spread") }
    static var howToReadStep2Bullet2Text: String { NSLocalizedString("howToRead.step2.bullet2.text", comment: "To start, pull one card (as the energy of the day) or three (representing Past, Present, and Future).") }
    
    static var howToReadStep3Title: String { NSLocalizedString("howToRead.step3.title", comment: "Interpret the Message (Connecting the Dots)") }
    static var howToReadStep3Intro: String { NSLocalizedString("howToRead.step3.intro", comment: "This is the moment where images turn into a story. You don't have to rush to a guidebook right away.") }
    static var howToReadStep3Bullet1Title: String { NSLocalizedString("howToRead.step3.bullet1.title", comment: "First impression") }
    static var howToReadStep3Bullet1Text: String { NSLocalizedString("howToRead.step3.bullet1.text", comment: "What is happening in the picture? What emotions does this card evoke? Is the figure sad or victorious?") }
    static var howToReadStep3Bullet2Title: String { NSLocalizedString("howToRead.step3.bullet2.title", comment: "Symbolism and context") }
    static var howToReadStep3Bullet2Text: String { NSLocalizedString("howToRead.step3.bullet2.text", comment: "Check the traditional meaning, but also look at how the cards sit next to each other. Does the neighboring card strengthen the message or contradict it?") }
    static var howToReadStep3ProTip: String { NSLocalizedString("howToRead.step3.proTip", comment: "Treat the cards like frames in a movie—what happened a moment ago, and what will happen next?") }
    
    static var howToReadStep4Title: String { NSLocalizedString("howToRead.step4.title", comment: "Reflect (Your Personal Power)") }
    static var howToReadStep4Intro: String { NSLocalizedString("howToRead.step4.intro", comment: "Tarot is not a sentence; it is a roadmap. The cards show the most likely scenario based on your current energy.") }
    static var howToReadStep4Bullet1Title: String { NSLocalizedString("howToRead.step4.bullet1.title", comment: "No fixed answers") }
    static var howToReadStep4Bullet1Text: String { NSLocalizedString("howToRead.step4.bullet1.text", comment: "If you don't like the outcome, treat it as a warning. You have the free will to change your approach.") }
    static var howToReadStep4Bullet2Title: String { NSLocalizedString("howToRead.step4.bullet2.title", comment: "Life application") }
    static var howToReadStep4Bullet2Text: String { NSLocalizedString("howToRead.step4.bullet2.text", comment: "Ask yourself: 'What is one small step I can take today based on this lesson?'.") }
    
    static var howToReadRememberTitle: String { NSLocalizedString("howToRead.remember.title", comment: "Remember") }
    static var howToReadRememberText: String { NSLocalizedString("howToRead.remember.text", comment: "Tarot is a mirror of your subconscious. The more often you work with it, the clearer the reflection becomes.") }
    static var howToReadProTipLabel: String { NSLocalizedString("howToRead.proTip.label", comment: "Pro Tip:") }
    
    // Tarot & Mind View
    static var tarotMindTitle: String { NSLocalizedString("tarotMind.title", comment: "Tarot & Mind") }
    static var tarotMindSubtitle: String { NSLocalizedString("tarotMind.subtitle", comment: "A Tool for Inner Growth") }
    
    static var tarotMindSection1Title: String { NSLocalizedString("tarotMind.section1.title", comment: "Tarot as a Mirror for Self-Reflection") }
    static var tarotMindSection1Text: String { NSLocalizedString("tarotMind.section1.text", comment: "Tarot acts as a bridge between your conscious mind and your subconscious. When you look at a card, your brain naturally seeks patterns and meanings that resonate with your current life situation. It doesn't tell you what to do—it reflects what is already inside you, waiting to be acknowledged.") }
    
    static var tarotMindSection2Title: String { NSLocalizedString("tarotMind.section2.title", comment: "Universal Archetypes and Emotions") }
    static var tarotMindSection2Text: String { NSLocalizedString("tarotMind.section2.text", comment: "The images on the cards are not just random drawings; they represent archetypes—universal human experiences such as love, loss, conflict, victory, and transition.") }
    static var tarotMindSection2Insight: String { NSLocalizedString("tarotMind.section2.insight", comment: "Whether it's the joy of the Sun or the heartbreak of the Three of Swords, these symbols tap into collective human emotions, helping you realize that your struggles and triumphs are part of a larger human story.") }
    
    static var tarotMindSection3Title: String { NSLocalizedString("tarotMind.section3.title", comment: "Understanding Thoughts and Decisions") }
    static var tarotMindSection3Intro: String { NSLocalizedString("tarotMind.section3.intro", comment: "Sometimes we feel stuck because of 'mental clutter.' Tarot helps you organize your internal world by:") }
    static var tarotMindSection3Bullet1Title: String { NSLocalizedString("tarotMind.section3.bullet1.title", comment: "Externalizing Feelings") }
    static var tarotMindSection3Bullet1Text: String { NSLocalizedString("tarotMind.section3.bullet1.text", comment: "Seeing a problem represented on a card makes it feel more manageable and less personal.") }
    static var tarotMindSection3Bullet2Title: String { NSLocalizedString("tarotMind.section3.bullet2.title", comment: "Breaking Patterns") }
    static var tarotMindSection3Bullet2Text: String { NSLocalizedString("tarotMind.section3.bullet2.text", comment: "It helps you identify recurring thoughts or behaviors that might be holding you back, allowing you to make more conscious, empowered decisions.") }
    
    static var tarotMindSection4Title: String { NSLocalizedString("tarotMind.section4.title", comment: "Tarot as a Mindfulness Practice") }
    static var tarotMindSection4Intro: String { NSLocalizedString("tarotMind.section4.intro", comment: "Integrating Tarot into your daily routine can be a grounding ritual in a fast-paced world.") }
    static var tarotMindSection4Bullet1Title: String { NSLocalizedString("tarotMind.section4.bullet1.title", comment: "Card of the Day") }
    static var tarotMindSection4Bullet1Text: String { NSLocalizedString("tarotMind.section4.bullet1.text", comment: "Drawing one card each morning isn't about predicting the future; it's about setting an intention. It asks: 'What energy should I be mindful of today?'") }
    static var tarotMindSection4Bullet2Title: String { NSLocalizedString("tarotMind.section4.bullet2.title", comment: "Presence") }
    static var tarotMindSection4Bullet2Text: String { NSLocalizedString("tarotMind.section4.bullet2.text", comment: "The act of shuffling and focusing on the imagery encourages you to stay in the moment, making it a perfect companion for meditation or journaling.") }
    
    static var tarotMindConclusion: String { NSLocalizedString("tarotMind.conclusion", comment: "Think of Tarot not as a 'fortune teller,' but as a 'soul translator.' It gives a voice to your intuition when your logical mind is too loud.") }
    static var tarotMindInsightLabel: String { NSLocalizedString("tarotMind.insight.label", comment: "Insight:") }
    
    // FAQ View
    static var faqTitle: String { NSLocalizedString("faq.title", comment: "FAQ") }
    static var faqSubtitle: String { NSLocalizedString("faq.subtitle", comment: "Frequently Asked Questions") }
    
    static var faqQuestion1: String { NSLocalizedString("faq.question1", comment: "Is tarot real?") }
    static var faqAnswer1: String { NSLocalizedString("faq.answer1", comment: "Tarot is not scientifically proven. It is best used as a tool for reflection and intuition.") }
    
    static var faqQuestion2: String { NSLocalizedString("faq.question2", comment: "Can tarot predict the future?") }
    static var faqAnswer2: String { NSLocalizedString("faq.answer2", comment: "Tarot shows possibilities, not fixed outcomes.") }
    
    static var faqQuestion3: String { NSLocalizedString("faq.question3", comment: "Do I need special abilities?") }
    static var faqAnswer3: String { NSLocalizedString("faq.answer3", comment: "No. Anyone can learn tarot with practice.") }
    
    static var faqQuestion4: String { NSLocalizedString("faq.question4", comment: "How often should I use tarot?") }
    static var faqAnswer4: String { NSLocalizedString("faq.answer4", comment: "As often as you like — daily or when you need guidance.") }
    
    static var faqQuestion5: String { NSLocalizedString("faq.question5", comment: "What if I don't understand a card?") }
    static var faqAnswer5: String { NSLocalizedString("faq.answer5", comment: "Start with basic meanings and trust your intuition over time.") }
    
    static var faqQuestion6: String { NSLocalizedString("faq.question6", comment: "Can I ask the same question multiple times?") }
    static var faqAnswer6: String { NSLocalizedString("faq.answer6", comment: "Yes, but it's recommended to give yourself time between readings. Repeating the same question too often may lead to confusion rather than clarity.") }
    
    static var faqQuestion7: String { NSLocalizedString("faq.question7", comment: "What is the best way to ask a question?") }
    static var faqAnswer7: String { NSLocalizedString("faq.answer7", comment: "Open-ended questions work best. Instead of 'yes or no', try asking 'What should I know about this situation?'") }
    
    static var faqQuestion8: String { NSLocalizedString("faq.question8", comment: "What does a reversed card mean?") }
    static var faqAnswer8: String { NSLocalizedString("faq.answer8", comment: "A reversed card can suggest blocked energy, delays, or an internal aspect of the situation. Its meaning depends on context.") }
    
    static var faqQuestion9: String { NSLocalizedString("faq.question9", comment: "Can tarot help with decisions?") }
    static var faqAnswer9: String { NSLocalizedString("faq.answer9", comment: "Yes. Tarot can help you see different perspectives and better understand your options, but the final decision is always yours.") }
    
    static var faqQuestion10: String { NSLocalizedString("faq.question10", comment: "Is tarot connected to religion?") }
    static var faqAnswer10: String { NSLocalizedString("faq.answer10", comment: "Tarot is not tied to any specific religion. It is a symbolic system that can be used by anyone, regardless of beliefs.") }
    
    static var faqDisclaimerTitle: String { NSLocalizedString("faq.disclaimer.title", comment: "Important") }
    static var faqDisclaimerText: String { NSLocalizedString("faq.disclaimer.text", comment: "Tarot is intended for entertainment and self-reflection purposes only.") }
    
    // MARK: - Palm Reading Interpretations
    
    // Overall reading - Emotional-Mental Balance
    static var palmInterpretationBalanceDeepBoth: String { NSLocalizedString("palm.interpretation.balance.deepBoth", value: "Your palm reveals a powerful balance between heart and mind. You possess both emotional depth and intellectual clarity, allowing you to navigate life with wisdom and compassion. ", comment: "Palm interpretation for deep heart and head lines") }
    
    static var palmInterpretationBalanceDeepHeartFaintHead: String { NSLocalizedString("palm.interpretation.balance.deepHeartFaintHead", value: "Your heart leads the way in your life's journey. You feel deeply and passionately, though you may benefit from bringing more analytical thinking into your decision-making process. ", comment: "Palm interpretation for deep heart, faint head") }
    
    static var palmInterpretationBalanceFaintHeartDeepHead: String { NSLocalizedString("palm.interpretation.balance.faintHeartDeepHead", value: "You approach life through the lens of logic and reason. Your sharp intellect serves you well, though opening yourself to emotional experiences could bring greater fulfillment. ", comment: "Palm interpretation for faint heart, deep head") }
    
    static var palmInterpretationBalanceGentle: String { NSLocalizedString("palm.interpretation.balance.gentle", value: "Your palm shows a gentle, balanced approach to life. You navigate between heart and mind with flexibility, adapting to what each situation requires. ", comment: "Palm interpretation for balanced approach") }
    
    // Overall reading - Life Force
    static var palmInterpretationLifeDeepContinuous: String { NSLocalizedString("palm.interpretation.life.deepContinuous", value: "Your Life Line indicates strong vitality and resilience. You have the energy and determination to overcome challenges and pursue your goals with vigor. ", comment: "Palm interpretation for deep continuous life line") }
    
    static var palmInterpretationLifeBroken: String { NSLocalizedString("palm.interpretation.life.broken", value: "The breaks in your Life Line suggest significant transitions or transformative periods in your journey. These are opportunities for renewal and reinvention. ", comment: "Palm interpretation for broken life line") }
    
    // Overall reading - Fate Line
    static var palmInterpretationFateDeep: String { NSLocalizedString("palm.interpretation.fate.deep", value: "A prominent Fate Line indicates that external forces and opportunities play a significant role in your path. You are someone whose life may be shaped by destiny and synchronicity. ", comment: "Palm interpretation for deep fate line") }
    
    static var palmInterpretationFateSubtle: String { NSLocalizedString("palm.interpretation.fate.subtle", value: "Your subtle Fate Line suggests you have great freedom in crafting your own destiny. You are the architect of your own path. ", comment: "Palm interpretation for subtle fate line") }
    
    static var palmInterpretationFateAbsent: String { NSLocalizedString("palm.interpretation.fate.absent", value: "The absence of a prominent Fate Line reveals that you are a true free spirit, unbound by predetermined paths. Your life is yours to create. ", comment: "Palm interpretation for absent fate line") }
    
    // Overall reading - Summary
    static var palmInterpretationSummaryIntro: String { NSLocalizedString("palm.interpretation.summary.intro", value: "\n\nOverall, your palm tells the story of ", comment: "Summary introduction") }
    
    static var palmInterpretationSummaryHeartLong: String { NSLocalizedString("palm.interpretation.summary.heartLong", value: "a compassionate soul who forms deep connections, ", comment: "Summary for long heart line") }
    
    static var palmInterpretationSummaryHeadLong: String { NSLocalizedString("palm.interpretation.summary.headLong", value: "a thoughtful mind that considers many perspectives, ", comment: "Summary for long head line") }
    
    static var palmInterpretationSummaryLifeLong: String { NSLocalizedString("palm.interpretation.summary.lifeLong", value: "and a vibrant life force that will carry you through many years and experiences. ", comment: "Summary for long life line") }
    
    static var palmInterpretationClosing: String { NSLocalizedString("palm.interpretation.closing", value: "Remember, your palm is a map of potentials, not fixed destinies. The lines you see today may evolve as you do.", comment: "Closing statement") }
    
    // Individual Line Interpretations - Heart Line
    static var palmLineHeartTitle: String { NSLocalizedString("palm.line.heart.title", value: "**Heart Line - Emotions & Relationships**\n\n", comment: "Heart line title") }
    
    static var palmLineHeartLengthShort: String { NSLocalizedString("palm.line.heart.length.short", value: "Your Heart Line is relatively short, suggesting you may be selective in your emotional expressions. You value quality over quantity in relationships and may prefer a small circle of deep connections.\n\n", comment: "Heart line short length interpretation") }
    
    static var palmLineHeartLengthMedium: String { NSLocalizedString("palm.line.heart.length.medium", value: "Your Heart Line shows a balanced approach to emotions. You can connect deeply with others while maintaining healthy boundaries.\n\n", comment: "Heart line medium length interpretation") }
    
    static var palmLineHeartLengthLong: String { NSLocalizedString("palm.line.heart.length.long", value: "Your long Heart Line reveals a generous, loving nature. You have much love to give and form deep, lasting emotional bonds with others.\n\n", comment: "Heart line long length interpretation") }
    
    static var palmLineHeartDepthDeep: String { NSLocalizedString("palm.line.heart.depth.deep", value: "The depth of your Heart Line indicates intense emotional experiences. You feel things profoundly and are capable of great passion and empathy.", comment: "Heart line deep depth interpretation") }
    
    static var palmLineHeartDepthModerate: String { NSLocalizedString("palm.line.heart.depth.moderate", value: "Your Heart Line's moderate depth suggests emotional stability and resilience. You can feel deeply without being overwhelmed.", comment: "Heart line moderate depth interpretation") }
    
    static var palmLineHeartDepthFaint: String { NSLocalizedString("palm.line.heart.depth.faint", value: "A subtle Heart Line can indicate a more reserved emotional nature, or someone who expresses feelings through actions rather than words.", comment: "Heart line faint depth interpretation") }
    
    // Individual Line Interpretations - Head Line
    static var palmLineHeadTitle: String { NSLocalizedString("palm.line.head.title", value: "**Head Line - Intellect & Mental Approach**\n\n", comment: "Head line title") }
    
    static var palmLineHeadLengthShort: String { NSLocalizedString("palm.line.head.length.short", value: "Your shorter Head Line suggests you're decisive and direct in your thinking. You focus on practical matters and get to the point quickly.\n\n", comment: "Head line short length interpretation") }
    
    static var palmLineHeadLengthMedium: String { NSLocalizedString("palm.line.head.length.medium", value: "Your Head Line indicates balanced mental abilities. You can think both practically and creatively as situations require.\n\n", comment: "Head line medium length interpretation") }
    
    static var palmLineHeadLengthLong: String { NSLocalizedString("palm.line.head.length.long", value: "Your long Head Line reveals a complex, analytical mind. You consider many angles and enjoy deep thinking and planning.\n\n", comment: "Head line long length interpretation") }
    
    static var palmLineHeadDepthDeep: String { NSLocalizedString("palm.line.head.depth.deep", value: "The deep imprint of your Head Line shows strong mental focus and concentration. You have the ability to deeply analyze and solve complex problems.", comment: "Head line deep depth interpretation") }
    
    static var palmLineHeadDepthModerate: String { NSLocalizedString("palm.line.head.depth.moderate", value: "Your Head Line's clarity suggests reliable mental processes and good judgment. You think things through without overthinking.", comment: "Head line moderate depth interpretation") }
    
    static var palmLineHeadDepthFaint: String { NSLocalizedString("palm.line.head.depth.faint", value: "A lighter Head Line can indicate flexibility in thinking, or someone who trusts intuition as much as logic.", comment: "Head line faint depth interpretation") }
    
    // Individual Line Interpretations - Life Line
    static var palmLineLifeTitle: String { NSLocalizedString("palm.line.life.title", value: "**Life Line - Vitality & Life Path**\n\n", comment: "Life line title") }
    
    static var palmLineLifeLengthShort: String { NSLocalizedString("palm.line.life.length.short", value: "The length of your Life Line speaks to the intensity rather than duration of your vitality. You live fully in each moment.\n\n", comment: "Life line short length interpretation") }
    
    static var palmLineLifeLengthMedium: String { NSLocalizedString("palm.line.life.length.medium", value: "Your Life Line indicates steady, reliable energy throughout your journey. You have the stamina for what life brings.\n\n", comment: "Life line medium length interpretation") }
    
    static var palmLineLifeLengthLong: String { NSLocalizedString("palm.line.life.length.long", value: "Your long Life Line suggests robust vitality and endurance. You have the energy and resilience for a full, dynamic life.\n\n", comment: "Life line long length interpretation") }
    
    static var palmLineLifeContinuityContinuous: String { NSLocalizedString("palm.line.life.continuity.continuous", value: "The continuous flow of your Life Line indicates a steady life path with smooth transitions. You adapt well to life's changes.", comment: "Life line continuous continuity interpretation") }
    
    static var palmLineLifeContinuityBroken: String { NSLocalizedString("palm.line.life.continuity.broken", value: "Breaks in your Life Line suggest major life changes or transformative periods. These are opportunities for reinvention and growth.", comment: "Life line broken continuity interpretation") }
    
    static var palmLineLifeContinuityChained: String { NSLocalizedString("palm.line.life.continuity.chained", value: "A chained pattern in your Life Line can indicate fluctuating energy levels or a path marked by various challenges that ultimately strengthen you.", comment: "Life line chained continuity interpretation") }
    
    // Individual Line Interpretations - Fate Line
    static var palmLineFateTitle: String { NSLocalizedString("palm.line.fate.title", value: "**Fate Line - Destiny & External Influences**\n\n", comment: "Fate line title") }
    
    static var palmLineFateDepthDeep: String { NSLocalizedString("palm.line.fate.depth.deep", value: "Your prominent Fate Line indicates a life strongly influenced by external forces, opportunities, and synchronicities. Events and people may play significant roles in shaping your path.\n\n", comment: "Fate line deep depth interpretation") }
    
    static var palmLineFateDepthModerate: String { NSLocalizedString("palm.line.fate.depth.moderate", value: "Your Fate Line suggests a balance between predetermined circumstances and personal choice. You work with what life brings while steering your own course.\n\n", comment: "Fate line moderate depth interpretation") }
    
    static var palmLineFateDepthFaint: String { NSLocalizedString("palm.line.fate.depth.faint", value: "A subtle Fate Line reveals that you have great freedom in creating your destiny. You are less bound by external circumstances and more empowered to forge your own path.\n\n", comment: "Fate line faint depth interpretation") }
    
    static var palmLineFateClosing: String { NSLocalizedString("palm.line.fate.closing", value: "The Fate Line reminds us that while certain opportunities and challenges come our way, how we respond to them is always within our control.", comment: "Fate line closing statement") }
    
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
    static var learnPalmistryHistoryTitle: String { NSLocalizedString("learnPalmistry.history.title", comment: "History of Palmistry") }
    static var learnPalmistryHistorySubtitle: String { NSLocalizedString("learnPalmistry.history.subtitle", comment: "Origins and evolution") }
    
    static var learnPalmistryBasicMeaningsTitle: String { NSLocalizedString("learnPalmistry.basicMeanings.title", comment: "Palm Basic Meanings") }
    static var learnPalmistryBasicMeaningsSubtitle: String { NSLocalizedString("learnPalmistry.basicMeanings.subtitle", comment: "Lines, mounts and fingers") }
    
    static var learnPalmistryHowToReadTitle: String { NSLocalizedString("learnPalmistry.howToRead.title", comment: "How to Read") }
    static var learnPalmistryHowToReadSubtitle: String { NSLocalizedString("learnPalmistry.howToRead.subtitle", comment: "Master palm reading") }
    
    static var learnPalmistryMindTitle: String { NSLocalizedString("learnPalmistry.mind.title", comment: "Palmistry & Mind") }
    static var learnPalmistryMindSubtitle: String { NSLocalizedString("learnPalmistry.mind.subtitle", comment: "Self-discovery tool") }
    
    static var learnPalmistryFaqTitle: String { NSLocalizedString("learnPalmistry.faq.title", comment: "FAQ") }
    static var learnPalmistryFaqSubtitle: String { NSLocalizedString("learnPalmistry.faq.subtitle", comment: "Common questions") }
    
    // History of Palmistry View
    static var historyOfPalmistryTitle: String { NSLocalizedString("historyOfPalmistry.title", comment: "History of Palmistry") }
    static var historyOfPalmistrySubtitle: String { NSLocalizedString("historyOfPalmistry.subtitle", comment: "Ancient Art of Hand Reading") }
    static var historyOfPalmistryIntro: String { NSLocalizedString("historyOfPalmistry.intro", comment: "Palmistry, also known as chiromancy, is one of humanity's oldest methods of divination and self-discovery. For thousands of years, people across cultures have looked to their hands for insights into character, destiny, and life's path.") }
    
    static var historyOfPalmistryAncientTitle: String { NSLocalizedString("historyOfPalmistry.ancient.title", comment: "Ancient Origins") }
    static var historyOfPalmistryAncientIntro: String { NSLocalizedString("historyOfPalmistry.ancient.intro", comment: "The practice of palm reading has roots in multiple ancient civilizations, each contributing unique perspectives to this sacred art.") }
    
    static var historyOfPalmistryIndiaTitle: String { NSLocalizedString("historyOfPalmistry.india.title", comment: "India and Vedic Tradition") }
    static var historyOfPalmistryIndiaText: String { NSLocalizedString("historyOfPalmistry.india.text", comment: "Ancient Hindu texts dating back 5,000 years contain detailed references to palm reading. The Vedic scriptures describe how the lines of the hand reflect one's karma and spiritual journey.") }
    
    static var historyOfPalmistryChinaTitle: String { NSLocalizedString("historyOfPalmistry.china.title", comment: "China and I Ching") }
    static var historyOfPalmistryChinaText: String { NSLocalizedString("historyOfPalmistry.china.text", comment: "In ancient China, palm reading was integrated with traditional medicine and philosophy. Practitioners believed the hand revealed the balance of yin and yang energies within the body.") }
    
    static var historyOfPalmistryEgyptTitle: String { NSLocalizedString("historyOfPalmistry.egypt.title", comment: "Egypt and the Mysteries") }
    static var historyOfPalmistryEgyptText: String { NSLocalizedString("historyOfPalmistry.egypt.text", comment: "Ancient Egyptians studied hands as a way to understand divine will. Hieroglyphics show priests examining palms during religious ceremonies and healing rituals.") }
    
    static var historyOfPalmistryWesternTitle: String { NSLocalizedString("historyOfPalmistry.western.title", comment: "Western Development") }
    static var historyOfPalmistryWesternIntro: String { NSLocalizedString("historyOfPalmistry.western.intro", comment: "Palmistry traveled westward along trade routes, evolving as it encountered Greek philosophy and European mysticism.") }
    
    static var historyOfPalmistryGreeceTitle: String { NSLocalizedString("historyOfPalmistry.greece.title", comment: "Ancient Greece") }
    static var historyOfPalmistryGreeceText: String { NSLocalizedString("historyOfPalmistry.greece.text", comment: "Aristotle and other Greek philosophers studied palmistry as a science. They associated different parts of the hand with planets and elements, creating systematic methods still used today.") }
    
    static var historyOfPalmistryRenaissanceTitle: String { NSLocalizedString("historyOfPalmistry.renaissance.title", comment: "Renaissance Revival") }
    static var historyOfPalmistryRenaissanceText: String { NSLocalizedString("historyOfPalmistry.renaissance.text", comment: "During the Renaissance, palmistry experienced a revival among European scholars who sought to merge ancient wisdom with emerging scientific methods.") }
    
    static var historyOfPalmistryModernTitle: String { NSLocalizedString("historyOfPalmistry.modern.title", comment: "Modern Era") }
    static var historyOfPalmistryModernText: String { NSLocalizedString("historyOfPalmistry.modern.text", comment: "In the 19th and 20th centuries, palmistry became popular in Western society. Notable practitioners like Cheiro brought palm reading to royal courts and wrote influential texts that standardized interpretations.") }
    
    // History Timeline
    static var historyOfPalmistryTimelineTitle: String { NSLocalizedString("historyOfPalmistry.timeline.title", comment: "Timeline") }
    static var historyOfPalmistryTimelineEraHeader: String { NSLocalizedString("historyOfPalmistry.timeline.era", comment: "Era") }
    static var historyOfPalmistryTimelineMilestoneHeader: String { NSLocalizedString("historyOfPalmistry.timeline.milestone", comment: "Milestone") }
    
    static var historyOfPalmistryTimelineEra1: String { NSLocalizedString("historyOfPalmistry.timeline.era1", comment: "3000 BCE") }
    static var historyOfPalmistryTimelineMilestone1: String { NSLocalizedString("historyOfPalmistry.timeline.milestone1", comment: "Earliest references to palm reading appear in Vedic texts in India.") }
    
    static var historyOfPalmistryTimelineEra2: String { NSLocalizedString("historyOfPalmistry.timeline.era2", comment: "384–322 BCE") }
    static var historyOfPalmistryTimelineMilestone2: String { NSLocalizedString("historyOfPalmistry.timeline.milestone2", comment: "Aristotle writes about palmistry, establishing philosophical foundations.") }
    
    static var historyOfPalmistryTimelineEra3: String { NSLocalizedString("historyOfPalmistry.timeline.era3", comment: "Middle Ages") }
    static var historyOfPalmistryTimelineMilestone3: String { NSLocalizedString("historyOfPalmistry.timeline.milestone3", comment: "Palmistry spreads through Europe via Romani culture and scholarly texts.") }
    
    static var historyOfPalmistryTimelineEra4: String { NSLocalizedString("historyOfPalmistry.timeline.era4", comment: "Renaissance") }
    static var historyOfPalmistryTimelineMilestone4: String { NSLocalizedString("historyOfPalmistry.timeline.milestone4", comment: "European scholars revive interest in palmistry as both art and proto-science.") }
    
    static var historyOfPalmistryTimelineEra5: String { NSLocalizedString("historyOfPalmistry.timeline.era5", comment: "19th–20th Century") }
    static var historyOfPalmistryTimelineMilestone5: String { NSLocalizedString("historyOfPalmistry.timeline.milestone5", comment: "Palmistry gains popularity in Western society; standardized systems emerge.") }
    
    // Palm Basic Meanings View
    static var palmBasicMeaningsTitle: String { NSLocalizedString("palmBasicMeanings.title", comment: "Palm Basic Meanings") }
    static var palmBasicMeaningsSubtitle: String { NSLocalizedString("palmBasicMeanings.subtitle", comment: "Understanding Your Hand") }
    static var palmBasicMeaningsDiagramTitle: String { NSLocalizedString("palmBasicMeanings.diagram.title", comment: "Palm Reading Map") }
    
    static var palmBasicMeaningsMajorLinesTitle: String { NSLocalizedString("palmBasicMeanings.majorLines.title", comment: "The Major Lines") }
    
    static var palmBasicMeaningsHeartLineTitle: String { NSLocalizedString("palmBasicMeanings.heartLine.title", comment: "Heart Line") }
    static var palmBasicMeaningsHeartLineDescription: String { NSLocalizedString("palmBasicMeanings.heartLine.description", comment: "The uppermost horizontal line running across your palm.") }
    static var palmBasicMeaningsHeartLineMeaning: String { NSLocalizedString("palmBasicMeanings.heartLine.meaning", comment: "Represents emotions, relationships, and how you give and receive love. A deep, clear line suggests strong emotional connections, while a faint line may indicate emotional reserve.") }
    
    static var palmBasicMeaningsHeadLineTitle: String { NSLocalizedString("palmBasicMeanings.headLine.title", comment: "Head Line") }
    static var palmBasicMeaningsHeadLineDescription: String { NSLocalizedString("palmBasicMeanings.headLine.description", comment: "The horizontal line below the Heart Line.") }
    static var palmBasicMeaningsHeadLineMeaning: String { NSLocalizedString("palmBasicMeanings.headLine.meaning", comment: "Reveals your thinking style, intellect, and decision-making approach. A long line indicates analytical thinking, while a shorter line suggests more direct, practical reasoning.") }
    
    static var palmBasicMeaningsLifeLineTitle: String { NSLocalizedString("palmBasicMeanings.lifeLine.title", comment: "Life Line") }
    static var palmBasicMeaningsLifeLineDescription: String { NSLocalizedString("palmBasicMeanings.lifeLine.description", comment: "The curved line that wraps around the base of your thumb.") }
    static var palmBasicMeaningsLifeLineMeaning: String { NSLocalizedString("palmBasicMeanings.lifeLine.meaning", comment: "Indicates vitality, physical health, and major life changes. Contrary to myth, it doesn't predict lifespan but shows the quality and intensity of your life energy.") }
    
    static var palmBasicMeaningsFateLineTitle: String { NSLocalizedString("palmBasicMeanings.fateLine.title", comment: "Fate Line") }
    static var palmBasicMeaningsFateLineDescription: String { NSLocalizedString("palmBasicMeanings.fateLine.description", comment: "A vertical line running up the center of the palm (not everyone has this line).") }
    static var palmBasicMeaningsFateLineMeaning: String { NSLocalizedString("palmBasicMeanings.fateLine.meaning", comment: "Represents career, life direction, and the influence of external forces. A strong Fate Line suggests a clear path, while its absence indicates freedom to create your own destiny.") }
    
    static var palmBasicMeaningsMountsTitle: String { NSLocalizedString("palmBasicMeanings.mounts.title", comment: "The Mounts") }
    static var palmBasicMeaningsMountsIntro: String { NSLocalizedString("palmBasicMeanings.mounts.intro", comment: "Mounts are the fleshy pads on your palm, each associated with planetary energies and personality traits:") }
    
    static var palmBasicMeaningsVenusTitle: String { NSLocalizedString("palmBasicMeanings.venus.title", comment: "Mount of Venus") }
    static var palmBasicMeaningsVenusMeaning: String { NSLocalizedString("palmBasicMeanings.venus.meaning", comment: "Located at the base of the thumb. Represents love, passion, and vitality.") }
    
    static var palmBasicMeaningsJupiterTitle: String { NSLocalizedString("palmBasicMeanings.jupiter.title", comment: "Mount of Jupiter") }
    static var palmBasicMeaningsJupiterMeaning: String { NSLocalizedString("palmBasicMeanings.jupiter.meaning", comment: "Below the index finger. Associated with ambition, leadership, and confidence.") }
    
    static var palmBasicMeaningsSaturnTitle: String { NSLocalizedString("palmBasicMeanings.saturn.title", comment: "Mount of Saturn") }
    static var palmBasicMeaningsSaturnMeaning: String { NSLocalizedString("palmBasicMeanings.saturn.meaning", comment: "Below the middle finger. Relates to responsibility, wisdom, and discipline.") }
    
    static var palmBasicMeaningsApolloTitle: String { NSLocalizedString("palmBasicMeanings.apollo.title", comment: "Mount of Apollo (Sun)") }
    static var palmBasicMeaningsApolloMeaning: String { NSLocalizedString("palmBasicMeanings.apollo.meaning", comment: "Below the ring finger. Represents creativity, happiness, and success.") }
    
    static var palmBasicMeaningsMercuryTitle: String { NSLocalizedString("palmBasicMeanings.mercury.title", comment: "Mount of Mercury") }
    static var palmBasicMeaningsMercuryMeaning: String { NSLocalizedString("palmBasicMeanings.mercury.meaning", comment: "Below the pinky finger. Associated with communication, wit, and business acumen.") }
    
    static var palmBasicMeaningsMarsTitle: String { NSLocalizedString("palmBasicMeanings.mars.title", comment: "Mounts of Mars") }
    static var palmBasicMeaningsMarsMeaning: String { NSLocalizedString("palmBasicMeanings.mars.meaning", comment: "Two areas between thumb and fingers. Represent courage, aggression, and determination.") }
    
    static var palmBasicMeaningsMoonTitle: String { NSLocalizedString("palmBasicMeanings.moon.title", comment: "Mount of the Moon") }
    static var palmBasicMeaningsMoonMeaning: String { NSLocalizedString("palmBasicMeanings.moon.meaning", comment: "On the outer edge of palm. Relates to imagination, intuition, and emotions.") }
    
    static var palmBasicMeaningsFingersTitle: String { NSLocalizedString("palmBasicMeanings.fingers.title", comment: "The Fingers") }
    static var palmBasicMeaningsFingersIntro: String { NSLocalizedString("palmBasicMeanings.fingers.intro", comment: "Each finger carries its own significance:") }
    
    static var palmBasicMeaningsThumbTitle: String { NSLocalizedString("palmBasicMeanings.thumb.title", comment: "Thumb") }
    static var palmBasicMeaningsThumbMeaning: String { NSLocalizedString("palmBasicMeanings.thumb.meaning", comment: "Willpower, logic, and self-control.") }
    
    static var palmBasicMeaningsIndexTitle: String { NSLocalizedString("palmBasicMeanings.index.title", comment: "Index Finger (Jupiter)") }
    static var palmBasicMeaningsIndexMeaning: String { NSLocalizedString("palmBasicMeanings.index.meaning", comment: "Leadership, ambition, and authority.") }
    
    static var palmBasicMeaningsMiddleTitle: String { NSLocalizedString("palmBasicMeanings.middle.title", comment: "Middle Finger (Saturn)") }
    static var palmBasicMeaningsMiddleMeaning: String { NSLocalizedString("palmBasicMeanings.middle.meaning", comment: "Responsibility, balance, and introspection.") }
    
    static var palmBasicMeaningsRingTitle: String { NSLocalizedString("palmBasicMeanings.ring.title", comment: "Ring Finger (Apollo)") }
    static var palmBasicMeaningsRingMeaning: String { NSLocalizedString("palmBasicMeanings.ring.meaning", comment: "Creativity, expression, and happiness.") }
    
    static var palmBasicMeaningsPinkyTitle: String { NSLocalizedString("palmBasicMeanings.pinky.title", comment: "Pinky Finger (Mercury)") }
    static var palmBasicMeaningsPinkyMeaning: String { NSLocalizedString("palmBasicMeanings.pinky.meaning", comment: "Communication, intelligence, and persuasion.") }
    
    // How to Read Palm View
    static var howToReadPalmTitle: String { NSLocalizedString("howToReadPalm.title", comment: "How to Read a Palm") }
    
    static var howToReadPalmStep1Title: String { NSLocalizedString("howToReadPalm.step1.title", comment: "Choose the Hand") }
    static var howToReadPalmStep1Intro: String { NSLocalizedString("howToReadPalm.step1.intro", comment: "The first step in palm reading is deciding which hand to read.") }
    static var howToReadPalmStep1Bullet1Title: String { NSLocalizedString("howToReadPalm.step1.bullet1.title", comment: "Dominant Hand") }
    static var howToReadPalmStep1Bullet1Text: String { NSLocalizedString("howToReadPalm.step1.bullet1.text", comment: "Your dominant hand (the one you write with) shows your present and future—how you're actively shaping your life through choices and actions.") }
    static var howToReadPalmStep1Bullet2Title: String { NSLocalizedString("howToReadPalm.step1.bullet2.title", comment: "Non-Dominant Hand") }
    static var howToReadPalmStep1Bullet2Text: String { NSLocalizedString("howToReadPalm.step1.bullet2.text", comment: "Your non-dominant hand represents your potential, inherited traits, and past influences—the foundation you were born with.") }
    static var howToReadPalmStep1ProTip: String { NSLocalizedString("howToReadPalm.step1.proTip", comment: "For a complete reading, examine both hands and note the differences between them.") }
    
    static var howToReadPalmStep2Title: String { NSLocalizedString("howToReadPalm.step2.title", comment: "Examine the Hand Shape") }
    static var howToReadPalmStep2Intro: String { NSLocalizedString("howToReadPalm.step2.intro", comment: "The overall shape of the hand reveals personality traits, similar to the elements in astrology:") }
    static var howToReadPalmStep2Bullet1Title: String { NSLocalizedString("howToReadPalm.step2.bullet1.title", comment: "Earth Hands (square palm, short fingers)") }
    static var howToReadPalmStep2Bullet1Text: String { NSLocalizedString("howToReadPalm.step2.bullet1.text", comment: "Practical, grounded, reliable. Value stability and hard work.") }
    static var howToReadPalmStep2Bullet2Title: String { NSLocalizedString("howToReadPalm.step2.bullet2.title", comment: "Air Hands (square palm, long fingers)") }
    static var howToReadPalmStep2Bullet2Text: String { NSLocalizedString("howToReadPalm.step2.bullet2.text", comment: "Intellectual, communicative, social. Love ideas and mental stimulation.") }
    static var howToReadPalmStep2Bullet3Title: String { NSLocalizedString("howToReadPalm.step2.bullet3.title", comment: "Water Hands (rectangular palm, long fingers)") }
    static var howToReadPalmStep2Bullet3Text: String { NSLocalizedString("howToReadPalm.step2.bullet3.text", comment: "Emotional, intuitive, creative. Deeply sensitive to feelings.") }
    static var howToReadPalmStep2Bullet4Title: String { NSLocalizedString("howToReadPalm.step2.bullet4.title", comment: "Fire Hands (rectangular palm, short fingers)") }
    static var howToReadPalmStep2Bullet4Text: String { NSLocalizedString("howToReadPalm.step2.bullet4.text", comment: "Passionate, energetic, spontaneous. Driven by enthusiasm.") }
    
    static var howToReadPalmStep3Title: String { NSLocalizedString("howToReadPalm.step3.title", comment: "Read the Major Lines") }
    static var howToReadPalmStep3Intro: String { NSLocalizedString("howToReadPalm.step3.intro", comment: "Focus on the four main lines, paying attention to their depth, length, and any breaks or branches:") }
    static var howToReadPalmStep3Bullet1Title: String { NSLocalizedString("howToReadPalm.step3.bullet1.title", comment: "Deep, clear lines") }
    static var howToReadPalmStep3Bullet1Text: String { NSLocalizedString("howToReadPalm.step3.bullet1.text", comment: "Indicate strong energy in that area of life.") }
    static var howToReadPalmStep3Bullet2Title: String { NSLocalizedString("howToReadPalm.step3.bullet2.title", comment: "Faint or broken lines") }
    static var howToReadPalmStep3Bullet2Text: String { NSLocalizedString("howToReadPalm.step3.bullet2.text", comment: "Suggest challenges, transitions, or areas needing attention.") }
    static var howToReadPalmStep3Bullet3Title: String { NSLocalizedString("howToReadPalm.step3.bullet3.title", comment: "Branches") }
    static var howToReadPalmStep3Bullet3Text: String { NSLocalizedString("howToReadPalm.step3.bullet3.text", comment: "Usually positive, indicating opportunities or multiple paths.") }
    static var howToReadPalmStep3ProTip: String { NSLocalizedString("howToReadPalm.step3.proTip", comment: "Lines can change over time! Your palm is not fixed—it evolves with you.") }
    
    static var howToReadPalmStep4Title: String { NSLocalizedString("howToReadPalm.step4.title", comment: "Study the Mounts") }
    static var howToReadPalmStep4Intro: String { NSLocalizedString("howToReadPalm.step4.intro", comment: "Feel the mounts (the fleshy pads) on your palm. Prominent mounts indicate strong traits:") }
    static var howToReadPalmStep4Bullet1Title: String { NSLocalizedString("howToReadPalm.step4.bullet1.title", comment: "Well-developed mounts") }
    static var howToReadPalmStep4Bullet1Text: String { NSLocalizedString("howToReadPalm.step4.bullet1.text", comment: "Show active qualities (e.g., prominent Venus mount = passionate nature).") }
    static var howToReadPalmStep4Bullet2Title: String { NSLocalizedString("howToReadPalm.step4.bullet2.title", comment: "Flat mounts") }
    static var howToReadPalmStep4Bullet2Text: String { NSLocalizedString("howToReadPalm.step4.bullet2.text", comment: "Suggest those qualities are less emphasized in your personality.") }
    
    static var howToReadPalmStep5Title: String { NSLocalizedString("howToReadPalm.step5.title", comment: "Interpret Everything Together") }
    static var howToReadPalmStep5Intro: String { NSLocalizedString("howToReadPalm.step5.intro", comment: "Palm reading is holistic—no single feature tells the whole story. Combine all elements:") }
    static var howToReadPalmStep5Bullet1Title: String { NSLocalizedString("howToReadPalm.step5.bullet1.title", comment: "Look for patterns") }
    static var howToReadPalmStep5Bullet1Text: String { NSLocalizedString("howToReadPalm.step5.bullet1.text", comment: "Do the hand shape and lines tell a consistent story?") }
    static var howToReadPalmStep5Bullet2Title: String { NSLocalizedString("howToReadPalm.step5.bullet2.title", comment: "Trust intuition") }
    static var howToReadPalmStep5Bullet2Text: String { NSLocalizedString("howToReadPalm.step5.bullet2.text", comment: "What stands out to you most? That's often where the important message lies.") }
    
    static var howToReadPalmRememberTitle: String { NSLocalizedString("howToReadPalm.remember.title", comment: "Remember") }
    static var howToReadPalmRememberText: String { NSLocalizedString("howToReadPalm.remember.text", comment: "Your palm is a map of tendencies, not a fixed fate. Use palmistry as a tool for self-understanding and growth, not prediction.") }
    
    // Palmistry & Mind View
    static var palmistryMindTitle: String { NSLocalizedString("palmistryMind.title", comment: "Palmistry & Mind") }
    static var palmistryMindSubtitle: String { NSLocalizedString("palmistryMind.subtitle", comment: "A Tool for Self-Discovery") }
    
    static var palmistryMindSection1Title: String { NSLocalizedString("palmistryMind.section1.title", comment: "Palmistry as a Self-Discovery Tool") }
    static var palmistryMindSection1Text: String { NSLocalizedString("palmistryMind.section1.text", comment: "Palmistry offers a unique mirror for self-reflection. By examining the lines and shapes of your hands, you engage in an ancient practice of introspection that can reveal patterns in your thinking, feeling, and behaving.") }
    
    static var palmistryMindSection2Title: String { NSLocalizedString("palmistryMind.section2.title", comment: "The Mind-Body Connection") }
    static var palmistryMindSection2Text: String { NSLocalizedString("palmistryMind.section2.text", comment: "Your hands are directly connected to your brain through more nerve endings than almost any other part of your body. Some practitioners believe that repeated thoughts and behaviors can actually shape the lines on your palms over time, creating a physical map of your mental and emotional patterns.") }
    static var palmistryMindSection2Insight: String { NSLocalizedString("palmistryMind.section2.insight", comment: "This is why palmistry encourages you to see yourself not as fixed, but as constantly evolving. The person you become shapes the very lines you read.") }
    
    static var palmistryMindSection3Title: String { NSLocalizedString("palmistryMind.section3.title", comment: "Understanding Personality Through Your Palm") }
    static var palmistryMindSection3Intro: String { NSLocalizedString("palmistryMind.section3.intro", comment: "Palm reading can illuminate aspects of your personality you might not have fully recognized:") }
    static var palmistryMindSection3Bullet1Title: String { NSLocalizedString("palmistryMind.section3.bullet1.title", comment: "Emotional Patterns") }
    static var palmistryMindSection3Bullet1Text: String { NSLocalizedString("palmistryMind.section3.bullet1.text", comment: "The Heart Line reveals how you process emotions and form connections, helping you understand relationship patterns.") }
    static var palmistryMindSection3Bullet2Title: String { NSLocalizedString("palmistryMind.section3.bullet2.title", comment: "Mental Approach") }
    static var palmistryMindSection3Bullet2Text: String { NSLocalizedString("palmistryMind.section3.bullet2.text", comment: "The Head Line shows your thinking style—are you more analytical or intuitive? Practical or imaginative?") }
    static var palmistryMindSection3Bullet3Title: String { NSLocalizedString("palmistryMind.section3.bullet3.title", comment: "Life Energy") }
    static var palmistryMindSection3Bullet3Text: String { NSLocalizedString("palmistryMind.section3.bullet3.text", comment: "The Life Line indicates your vitality and how you approach challenges, revealing your core resilience.") }
    
    static var palmistryMindSection4Title: String { NSLocalizedString("palmistryMind.section4.title", comment: "Palmistry for Awareness and Growth") }
    static var palmistryMindSection4Intro: String { NSLocalizedString("palmistryMind.section4.intro", comment: "Using palmistry as a mindfulness practice can help you:") }
    static var palmistryMindSection4Bullet1Title: String { NSLocalizedString("palmistryMind.section4.bullet1.title", comment: "Recognize Strengths") }
    static var palmistryMindSection4Bullet1Text: String { NSLocalizedString("palmistryMind.section4.bullet1.text", comment: "Identify your natural talents and gifts that you can develop further.") }
    static var palmistryMindSection4Bullet2Title: String { NSLocalizedString("palmistryMind.section4.bullet2.title", comment: "Acknowledge Challenges") }
    static var palmistryMindSection4Bullet2Text: String { NSLocalizedString("palmistryMind.section4.bullet2.text", comment: "See where you might face obstacles, allowing you to prepare and adapt.") }
    
    static var palmistryMindSection5Title: String { NSLocalizedString("palmistryMind.section5.title", comment: "The Power of Observation") }
    static var palmistryMindSection5Text: String { NSLocalizedString("palmistryMind.section5.text", comment: "The simple act of studying your palm—really looking at it—creates a moment of presence and connection with yourself. In our busy lives, palmistry offers a reason to pause, reflect, and ask: 'Who am I? What am I becoming?'") }
    
    static var palmistryMindConclusion: String { NSLocalizedString("palmistryMind.conclusion", comment: "Like tarot, palmistry doesn't dictate your fate—it illuminates possibilities. Your hands hold stories, but you're the author writing them.") }
    static var palmistryMindInsightLabel: String { NSLocalizedString("palmistryMind.insight.label", comment: "Insight:") }
    
    // Palmistry FAQ View
    static var palmistryFaqTitle: String { NSLocalizedString("palmistryFaq.title", comment: "Palmistry FAQ") }
    static var palmistryFaqSubtitle: String { NSLocalizedString("palmistryFaq.subtitle", comment: "Frequently Asked Questions") }
    
    static var palmistryFaqQuestion1: String { NSLocalizedString("palmistryFaq.question1", comment: "Is palmistry scientifically proven?") }
    static var palmistryFaqAnswer1: String { NSLocalizedString("palmistryFaq.answer1", comment: "Palmistry is not scientifically validated. It's best understood as a tool for self-reflection and personal insight rather than empirical prediction.") }
    
    static var palmistryFaqQuestion2: String { NSLocalizedString("palmistryFaq.question2", comment: "Can palmistry predict my future?") }
    static var palmistryFaqAnswer2: String { NSLocalizedString("palmistryFaq.answer2", comment: "Palmistry doesn't predict fixed outcomes. It reveals tendencies, patterns, and potentials based on your current state. Your choices shape your future.") }
    
    static var palmistryFaqQuestion3: String { NSLocalizedString("palmistryFaq.question3", comment: "Which hand should I read?") }
    static var palmistryFaqAnswer3: String { NSLocalizedString("palmistryFaq.answer3", comment: "Your dominant hand shows your present and conscious choices. Your non-dominant hand reveals inherited traits and potential. Read both for a complete picture.") }
    
    static var palmistryFaqQuestion4: String { NSLocalizedString("palmistryFaq.question4", comment: "Do my palm lines change over time?") }
    static var palmistryFaqAnswer4: String { NSLocalizedString("palmistryFaq.answer4", comment: "Yes! Palm lines can and do change as you grow and your circumstances shift. They reflect your current life path, not a permanent fate.") }
    
    static var palmistryFaqQuestion5: String { NSLocalizedString("palmistryFaq.question5", comment: "Does the Life Line show how long I'll live?") }
    static var palmistryFaqAnswer5: String { NSLocalizedString("palmistryFaq.answer5", comment: "No. This is a common myth. The Life Line indicates vitality and life quality, not lifespan.") }
    
    static var palmistryFaqQuestion6: String { NSLocalizedString("palmistryFaq.question6", comment: "What if I don't have a Fate Line?") }
    static var palmistryFaqAnswer6: String { NSLocalizedString("palmistryFaq.answer6", comment: "Not everyone has a visible Fate Line. Its absence suggests freedom to create your own path without strong external influences.") }
    
    static var palmistryFaqQuestion7: String { NSLocalizedString("palmistryFaq.question7", comment: "What do breaks in my lines mean?") }
    static var palmistryFaqAnswer7: String { NSLocalizedString("palmistryFaq.answer7", comment: "Breaks can indicate transitions, challenges, or significant changes in that area of life. They're not necessarily negative—often they represent growth through transformation.") }
    
    static var palmistryFaqQuestion8: String { NSLocalizedString("palmistryFaq.question8", comment: "Can palmistry help with decisions?") }
    static var palmistryFaqAnswer8: String { NSLocalizedString("palmistryFaq.answer8", comment: "Palmistry can illuminate your natural tendencies and strengths, helping you make more informed choices. However, trust your judgment and intuition above all.") }
    
    static var palmistryFaqQuestion9: String { NSLocalizedString("palmistryFaq.question9", comment: "Do men and women's palms differ?") }
    static var palmistryFaqAnswer9: String { NSLocalizedString("palmistryFaq.answer9", comment: "The same principles apply to all palms regardless of gender. Individual variation matters more than gender-based differences.") }
    
    static var palmistryFaqQuestion10: String { NSLocalizedString("palmistryFaq.question10", comment: "Is palmistry connected to any religion?") }
    static var palmistryFaqAnswer10: String { NSLocalizedString("palmistryFaq.answer10", comment: "Palmistry has been practiced across many cultures and spiritual traditions, but it's not inherently religious. It's a tool anyone can use for self-understanding.") }
    
    static var palmistryFaqDisclaimerTitle: String { NSLocalizedString("palmistryFaq.disclaimer.title", comment: "Important") }
    static var palmistryFaqDisclaimerText: String { NSLocalizedString("palmistryFaq.disclaimer.text", comment: "Palmistry is intended for entertainment and self-reflection purposes only. It should not replace professional advice for health, legal, or financial matters.") }
    
    // MARK: - Horoscope & Cosmogram
    static var time: String { NSLocalizedString("Time", comment: "A label for the time picker.") }
    static var palmReadingCameraDescription: String { NSLocalizedString("To read your palm, we need access to your camera. Your palm image is processed locally and never leaves your device.", comment: "A description of the camera access required to read your palm.") }
    static var todaysLuckyElements: String { NSLocalizedString("Today's Lucky Elements", comment: "A heading for the lucky elements of the day.") }
    static var tryAgain: String { NSLocalizedString("Try Again", comment: "A button that triggers a new photo capture when pressed.") }
    static var useMyBirthDate: String { NSLocalizedString("Use My Birth Date", comment: "A button that allows users to use their birth date to select their zodiac sign.") }
    static var viewCardDetails: String { NSLocalizedString("View card details", comment: "A label describing a button that will open a new screen.") }
    static var viewCardDetailsCapitalized: String { NSLocalizedString("View Card Details", comment: "A label describing a button that will open a new screen.") }
    static var yearEnergy: String { NSLocalizedString("Year Energy", comment: "A label displayed in the year energy detail card.") }
    static var yourBigThree: String { NSLocalizedString("Your Big Three", comment: "A heading for the user's Big Three zodiac signs.") }
    
    // Format strings
    static func yourChartReveals(_ sun: String, _ moon: String, _ rising: String) -> String {
        String(format: NSLocalizedString("Your chart reveals a unique combination of energies. The %1$@ Sun gives you core vitality, while your %2$@ Moon shapes your emotional landscape. With %3$@ rising, you present yourself to the world with distinct grace. Together, these create your cosmic fingerprint.", comment: "A paragraph describing the user's cosmic blueprint, highlighting their Sun sign, Moon sign, and rising sign."), sun, moon, rising)
    }
    
    static var yourCosmicBlueprint: String { NSLocalizedString("Your Cosmic Blueprint", comment: "A title for the user's cosmic blueprint.") }
    static var yourLifePathNumber: String { NSLocalizedString("Your Life Path Number", comment: "A label displayed above the user's life path number.") }
    
    static func yourNumerologyComplements(_ sign: String) -> String {
        String(format: NSLocalizedString("Your numerology complements your %@ energy", comment: "A description of how the user's numerology relates to their zodiac sign."), sign)
    }
    
    static var yourPersonalNumbers: String { NSLocalizedString("Your Personal Numbers", comment: "A label displayed above the user's numerology numbers.") }
    
    // MARK: - Cosmogram View
    static var enterYourBirthDateCosmogram: String { NSLocalizedString("cosmogram.enterBirthDate", comment: "Enter Your Birth Date") }
    static var generateBirthChartPrompt: String { NSLocalizedString("cosmogram.generatePrompt", comment: "Generate your personal birth chart based on your birth date") }
    static var addBirthDateButton: String { NSLocalizedString("cosmogram.addBirthDate", comment: "Add Birth Date") }
    static var bigThreeTitle: String { NSLocalizedString("cosmogram.bigThree", comment: "Your Big Three") }
    static var sunSignTitle: String { NSLocalizedString("cosmogram.sunSign", comment: "Sun Sign") }
    static var sunSignDescription: String { NSLocalizedString("cosmogram.sunSign.desc", comment: "Your core identity and life force") }
    static var moonSignTitle: String { NSLocalizedString("cosmogram.moonSign", comment: "Moon Sign") }
    static var moonSignDescription: String { NSLocalizedString("cosmogram.moonSign.desc", comment: "Your emotional nature and inner world") }
    static var risingSignTitle: String { NSLocalizedString("cosmogram.risingSign", comment: "Rising Sign") }
    static var risingSignDescription: String { NSLocalizedString("cosmogram.risingSign.desc", comment: "Your outward personality and first impression") }
    static var elementalBalanceTitle: String { NSLocalizedString("cosmogram.elementalBalance", comment: "Elemental Balance") }
    static var elementFire: String { NSLocalizedString("cosmogram.element.fire", comment: "Fire") }
    static var elementEarth: String { NSLocalizedString("cosmogram.element.earth", comment: "Earth") }
    static var elementAir: String { NSLocalizedString("cosmogram.element.air", comment: "Air") }
    static var elementWater: String { NSLocalizedString("cosmogram.element.water", comment: "Water") }
    
    // Cosmogram element balance descriptions
    static func elementBalanceSame(_ element: String) -> String {
        String(format: NSLocalizedString("cosmogram.elementBalance.same", comment: "All three placements share the %@ element, creating powerful focus and intensity in this energy."), element)
    }
    static var elementBalanceTwoElements: String { NSLocalizedString("cosmogram.elementBalance.two", comment: "Your chart balances two elemental energies, creating dynamic interplay between different life approaches.") }
    static var elementBalanceThreeElements: String { NSLocalizedString("cosmogram.elementBalance.three", comment: "Three different elements create a well-rounded, multifaceted personality with diverse strengths and perspectives.") }
    
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
    static var selectYourZodiacSign: String { NSLocalizedString("Select Your Zodiac Sign", comment: "Prompt for selecting zodiac sign") }
    static var chooseManually: String { NSLocalizedString("Choose Manually", comment: "Button to manually choose zodiac sign") }
    static var todaysOverview: String { NSLocalizedString("Today's Overview", comment: "Horoscope section title") }
    static var loveAndRelationships: String { NSLocalizedString("Love & Relationships", comment: "Horoscope section title") }
    static var careerAndFinance: String { NSLocalizedString("Career & Finance", comment: "Horoscope section title") }
    
    // Lucky Elements
    static var color: String { NSLocalizedString("Color", comment: "Lucky color label") }
    static var number: String { NSLocalizedString("Number", comment: "Lucky number label") }
    
    // Lucky Colors
    static var luckyColorGold: String { NSLocalizedString("Gold", comment: "Lucky color: Gold") }
    static var luckyColorSilver: String { NSLocalizedString("Silver", comment: "Lucky color: Silver") }
    static var luckyColorBlue: String { NSLocalizedString("Blue", comment: "Lucky color: Blue") }
    static var luckyColorGreen: String { NSLocalizedString("Green", comment: "Lucky color: Green") }
    static var luckyColorRed: String { NSLocalizedString("Red", comment: "Lucky color: Red") }
    static var luckyColorPurple: String { NSLocalizedString("Purple", comment: "Lucky color: Purple") }
    static var luckyColorOrange: String { NSLocalizedString("Orange", comment: "Lucky color: Orange") }
    
    // Lucky Times
    static var luckyTimeMorning: String { NSLocalizedString("Morning", comment: "Lucky time: Morning") }
    static var luckyTimeNoon: String { NSLocalizedString("Noon", comment: "Lucky time: Noon") }
    static var luckyTimeAfternoon: String { NSLocalizedString("Afternoon", comment: "Lucky time: Afternoon") }
    static var luckyTimeEvening: String { NSLocalizedString("Evening", comment: "Lucky time: Evening") }
    static var luckyTimeNight: String { NSLocalizedString("Night", comment: "Lucky time: Night") }
    
    // Sign Picker
    static var selectYourSign: String { NSLocalizedString("Select Your Sign", comment: "Sign picker title") }
    
    // Zodiac Date Ranges
    static var ariesDateRange: String { NSLocalizedString("Mar 21 - Apr 19", comment: "Aries date range") }
    static var taurusDateRange: String { NSLocalizedString("Apr 20 - May 20", comment: "Taurus date range") }
    static var geminiDateRange: String { NSLocalizedString("May 21 - Jun 20", comment: "Gemini date range") }
    static var cancerDateRange: String { NSLocalizedString("Jun 21 - Jul 22", comment: "Cancer date range") }
    static var leoDateRange: String { NSLocalizedString("Jul 23 - Aug 22", comment: "Leo date range") }
    static var virgoDateRange: String { NSLocalizedString("Aug 23 - Sep 22", comment: "Virgo date range") }
    static var libraDateRange: String { NSLocalizedString("Sep 23 - Oct 22", comment: "Libra date range") }
    static var scorpioDateRange: String { NSLocalizedString("Oct 23 - Nov 21", comment: "Scorpio date range") }
    static var sagittariusDateRange: String { NSLocalizedString("Nov 22 - Dec 21", comment: "Sagittarius date range") }
    static var capricornDateRange: String { NSLocalizedString("Dec 22 - Jan 19", comment: "Capricorn date range") }
    static var aquariusDateRange: String { NSLocalizedString("Jan 20 - Feb 18", comment: "Aquarius date range") }
    static var piscesDateRange: String { NSLocalizedString("Feb 19 - Mar 20", comment: "Pisces date range") }
    
    // Daily Readings (5 variations)
    static var dailyReading1: String { NSLocalizedString("Today brings fresh opportunities for growth. Trust your instincts and embrace new experiences with an open heart.", comment: "Daily horoscope reading variation 1") }
    static var dailyReading2: String { NSLocalizedString("The cosmic energy today favors reflection and planning. Take time to consider your next steps carefully.", comment: "Daily horoscope reading variation 2") }
    static var dailyReading3: String { NSLocalizedString("Your natural strengths shine brightly today. Don't hesitate to showcase your talents and unique perspective.", comment: "Daily horoscope reading variation 3") }
    static var dailyReading4: String { NSLocalizedString("A day of unexpected connections and meaningful conversations. Stay open to wisdom from unlikely sources.", comment: "Daily horoscope reading variation 4") }
    static var dailyReading5: String { NSLocalizedString("Today's energy supports transformation. Let go of what no longer serves you and welcome positive change.", comment: "Daily horoscope reading variation 5") }
    
    // Love Readings (5 variations)
    static var loveReading1: String { NSLocalizedString("Communication flows easily in your relationships today. Express your feelings with honesty and compassion.", comment: "Love horoscope reading variation 1") }
    static var loveReading2: String { NSLocalizedString("A romantic opportunity may present itself unexpectedly. Stay present and authentic in your interactions.", comment: "Love horoscope reading variation 2") }
    static var loveReading3: String { NSLocalizedString("Focus on deepening existing bonds rather than seeking new connections. Quality over quantity brings fulfillment.", comment: "Love horoscope reading variation 3") }
    static var loveReading4: String { NSLocalizedString("Your emotional intuition is heightened. Trust your heart's wisdom in matters of love and connection.", comment: "Love horoscope reading variation 4") }
    static var loveReading5: String { NSLocalizedString("Independence and partnership find beautiful balance today. Honor both your needs and those of loved ones.", comment: "Love horoscope reading variation 5") }
    
    // Career Readings (5 variations)
    static var careerReading1: String { NSLocalizedString("Professional recognition is on the horizon. Your hard work and dedication are being noticed by those who matter.", comment: "Career horoscope reading variation 1") }
    static var careerReading2: String { NSLocalizedString("Collaboration brings success today. Seek input from colleagues and build on collective wisdom.", comment: "Career horoscope reading variation 2") }
    static var careerReading3: String { NSLocalizedString("Financial decisions require careful consideration. Trust your analytical mind and avoid impulsive choices.", comment: "Career horoscope reading variation 3") }
    static var careerReading4: String { NSLocalizedString("Your creative solutions impress others. Don't be afraid to think outside the box and propose innovative ideas.", comment: "Career horoscope reading variation 4") }
    static var careerReading5: String { NSLocalizedString("A good day for planning long-term goals. Set clear intentions and take practical steps toward your aspirations.", comment: "Career horoscope reading variation 5") }
    
    // MARK: - Numerology View
    static var enterYourBirthDate: String { NSLocalizedString("Enter Your Birth Date", comment: "Prompt to enter birth date for numerology") }
    static var discoverNumerologyProfile: String { NSLocalizedString("Discover your numerology profile based on your birth date", comment: "Description of numerology feature") }
    static var addBirthDate: String { NSLocalizedString("Add Birth Date", comment: "Button to add birth date") }
    
    // Personal Numbers
    static var expression: String { NSLocalizedString("Expression", comment: "Expression number label") }
    static var soulUrge: String { NSLocalizedString("Soul Urge", comment: "Soul urge number label") }
    static var birthday: String { NSLocalizedString("Birthday", comment: "Birthday number label") }
    static var maturity: String { NSLocalizedString("Maturity", comment: "Maturity number label") }
    
    // Personal Number Descriptions
    static var yourNaturalTalents: String { NSLocalizedString("Your natural talents", comment: "Expression number description") }
    static var yourInnerDesires: String { NSLocalizedString("Your inner desires", comment: "Soul urge number description") }
    static var yourSpecialGift: String { NSLocalizedString("Your special gift", comment: "Birthday number description") }
    static var yourLaterLifeFocus: String { NSLocalizedString("Your later life focus", comment: "Maturity number description") }
    
    // Life Path Meanings
    static var lifePathMeaning1: String { NSLocalizedString("The Leader - Independent, ambitious, and pioneering. You are here to forge new paths and inspire others with your courage.", comment: "Life path 1 meaning") }
    static var lifePathMeaning2: String { NSLocalizedString("The Peacemaker - Diplomatic, sensitive, and cooperative. You bring harmony and balance to relationships and situations.", comment: "Life path 2 meaning") }
    static var lifePathMeaning3: String { NSLocalizedString("The Creative - Expressive, optimistic, and social. You inspire joy and creativity in everything you touch.", comment: "Life path 3 meaning") }
    static var lifePathMeaning4: String { NSLocalizedString("The Builder - Practical, disciplined, and hardworking. You create solid foundations and lasting structures.", comment: "Life path 4 meaning") }
    static var lifePathMeaning5: String { NSLocalizedString("The Freedom Seeker - Adventurous, versatile, and dynamic. You embrace change and seek diverse experiences.", comment: "Life path 5 meaning") }
    static var lifePathMeaning6: String { NSLocalizedString("The Nurturer - Responsible, caring, and protective. You create harmony in home and community.", comment: "Life path 6 meaning") }
    static var lifePathMeaning7: String { NSLocalizedString("The Seeker - Analytical, introspective, and spiritual. You search for deeper truths and wisdom.", comment: "Life path 7 meaning") }
    static var lifePathMeaning8: String { NSLocalizedString("The Powerhouse - Ambitious, authoritative, and material. You master the material world with confidence.", comment: "Life path 8 meaning") }
    static var lifePathMeaning9: String { NSLocalizedString("The Humanitarian - Compassionate, wise, and selfless. You serve the greater good with understanding.", comment: "Life path 9 meaning") }
    static var lifePathMeaning11: String { NSLocalizedString("The Illuminator - Intuitive, inspirational, and enlightened. You bring spiritual insights to the world.", comment: "Life path 11 meaning") }
    static var lifePathMeaning22: String { NSLocalizedString("The Master Builder - Visionary, practical, and transformative. You manifest grand visions into reality.", comment: "Life path 22 meaning") }
    static var lifePathMeaningDefault: String { NSLocalizedString("Your unique number holds special meaning in your life journey.", comment: "Default life path meaning") }
    
    // MARK: - Learn Destiny Matrix
    // Main Learn Destiny Matrix View
    static var homeLearnDestinyMatrix: String { NSLocalizedString("home.learnDestinyMatrix", comment: "Learn Matrix") }
    static var homeLearnDestinyMatrixSubtitle: String { NSLocalizedString("home.learnDestinyMatrix.subtitle", comment: "Understand the 22 energies and your chart") }

    static var learnDestinyMatrixTitle: String { NSLocalizedString("learnDestinyMatrix.title", comment: "Learn Destiny Matrix") }
    static var learnDestinyMatrixSubtitle: String { NSLocalizedString("learnDestinyMatrix.subtitle", comment: "Decode the blueprint of your soul") }

    // Learn Options
    static var learnDestinyMatrixHistoryTitle: String { NSLocalizedString("learnDestinyMatrix.history.title", comment: "History of the Matrix") }
    static var learnDestinyMatrixHistorySubtitle: String { NSLocalizedString("learnDestinyMatrix.history.subtitle", comment: "Origins and evolution") }

    static var learnDestinyMatrixBasicMeaningsTitle: String { NSLocalizedString("learnDestinyMatrix.basicMeanings.title", comment: "The 22 Energies") }
    static var learnDestinyMatrixBasicMeaningsSubtitle: String { NSLocalizedString("learnDestinyMatrix.basicMeanings.subtitle", comment: "Archetypes and meanings") }

    static var learnDestinyMatrixHowToReadTitle: String { NSLocalizedString("learnDestinyMatrix.howToRead.title", comment: "How to Read Your Matrix") }
    static var learnDestinyMatrixHowToReadSubtitle: String { NSLocalizedString("learnDestinyMatrix.howToRead.subtitle", comment: "Map your personal chart") }

    static var learnDestinyMatrixMindTitle: String { NSLocalizedString("learnDestinyMatrix.mind.title", comment: "Matrix & Mind") }
    static var learnDestinyMatrixMindSubtitle: String { NSLocalizedString("learnDestinyMatrix.mind.subtitle", comment: "Self-reflection tool") }

    static var learnDestinyMatrixFaqTitle: String { NSLocalizedString("learnDestinyMatrix.faq.title", comment: "FAQ") }
    static var learnDestinyMatrixFaqSubtitle: String { NSLocalizedString("learnDestinyMatrix.faq.subtitle", comment: "Common questions") }

    // History of Destiny Matrix View
    static var historyOfMatrixTitle: String { NSLocalizedString("historyOfMatrix.title", comment: "History of the Destiny Matrix") }
    static var historyOfMatrixSubtitle: String { NSLocalizedString("historyOfMatrix.subtitle", comment: "Ancient Wisdom, Modern System") }
    static var historyOfMatrixIntro: String { NSLocalizedString("historyOfMatrix.intro", comment: "The Destiny Matrix is a contemporary spiritual system that blends ancient wisdom traditions—numerology, the Major Arcana of the Tarot, and Eastern energy practices—into a single personal chart calculated from your date of birth.") }

    static var historyOfMatrixRootsTitle: String { NSLocalizedString("historyOfMatrix.roots.title", comment: "Ancient Roots") }
    static var historyOfMatrixRootsIntro: String { NSLocalizedString("historyOfMatrix.roots.intro", comment: "Though the Matrix itself is a modern system, every part of it draws from traditions that span thousands of years.") }

    static var historyOfMatrixNumerologyTitle: String { NSLocalizedString("historyOfMatrix.numerology.title", comment: "Pythagorean Numerology") }
    static var historyOfMatrixNumerologyText: String { NSLocalizedString("historyOfMatrix.numerology.text", comment: "The mathematical backbone of the Matrix comes from Pythagorean numerology (6th century BCE), which taught that numbers carry archetypal vibrations and that a birth date reveals a soul's blueprint.") }

    static var historyOfMatrixTarotTitle: String { NSLocalizedString("historyOfMatrix.tarot.title", comment: "Tarot's Major Arcana") }
    static var historyOfMatrixTarotText: String { NSLocalizedString("historyOfMatrix.tarot.text", comment: "The 22 energies of the Matrix correspond directly to the 22 Major Arcana of the Tarot—archetypes refined in Renaissance Europe to describe every stage of the human journey from The Fool to The World.") }

    static var historyOfMatrixChakraTitle: String { NSLocalizedString("historyOfMatrix.chakra.title", comment: "Vedic Chakra System") }
    static var historyOfMatrixChakraText: String { NSLocalizedString("historyOfMatrix.chakra.text", comment: "From the Indian Vedic tradition, the Matrix borrows the seven-chakra model used to describe how life energy flows through key centers in the human body, from material survival to higher spiritual awareness.") }

    static var historyOfMatrixModernTitle: String { NSLocalizedString("historyOfMatrix.modern.title", comment: "Modern Formulation") }
    static var historyOfMatrixModernIntro: String { NSLocalizedString("historyOfMatrix.modern.intro", comment: "The system as practiced today took shape in the early 21st century, drawing the older traditions together into one diagram.") }

    static var historyOfMatrixLadiniTitle: String { NSLocalizedString("historyOfMatrix.ladini.title", comment: "Natalia Ladini") }
    static var historyOfMatrixLadiniText: String { NSLocalizedString("historyOfMatrix.ladini.text", comment: "Russian researcher Natalia Ladini is credited with systematizing the modern Destiny Matrix in the 2000s, mapping the 22 archetypes onto a precise octagonal diagram derived from the birth date.") }

    static var historyOfMatrixGlobalTitle: String { NSLocalizedString("historyOfMatrix.global.title", comment: "Global Spread") }
    static var historyOfMatrixGlobalText: String { NSLocalizedString("historyOfMatrix.global.text", comment: "From Eastern Europe, the Matrix has spread worldwide, embraced by coaches, healers, and self-development practitioners as a practical tool for archetypal self-discovery.") }

    // History Timeline
    static var historyOfMatrixTimelineTitle: String { NSLocalizedString("historyOfMatrix.timeline.title", comment: "Timeline") }
    static var historyOfMatrixTimelineEraHeader: String { NSLocalizedString("historyOfMatrix.timeline.era", comment: "Era") }
    static var historyOfMatrixTimelineMilestoneHeader: String { NSLocalizedString("historyOfMatrix.timeline.milestone", comment: "Milestone") }

    static var historyOfMatrixTimelineEra1: String { NSLocalizedString("historyOfMatrix.timeline.era1", comment: "6th c. BCE") }
    static var historyOfMatrixTimelineMilestone1: String { NSLocalizedString("historyOfMatrix.timeline.milestone1", comment: "Pythagoras teaches that numbers express the divine order of the cosmos.") }

    static var historyOfMatrixTimelineEra2: String { NSLocalizedString("historyOfMatrix.timeline.era2", comment: "Ancient India") }
    static var historyOfMatrixTimelineMilestone2: String { NSLocalizedString("historyOfMatrix.timeline.milestone2", comment: "Vedic texts describe the seven chakras as centers of life energy.") }

    static var historyOfMatrixTimelineEra3: String { NSLocalizedString("historyOfMatrix.timeline.era3", comment: "15th century") }
    static var historyOfMatrixTimelineMilestone3: String { NSLocalizedString("historyOfMatrix.timeline.milestone3", comment: "The Major Arcana of the Tarot is shaped in Renaissance Italy.") }

    static var historyOfMatrixTimelineEra4: String { NSLocalizedString("historyOfMatrix.timeline.era4", comment: "20th century") }
    static var historyOfMatrixTimelineMilestone4: String { NSLocalizedString("historyOfMatrix.timeline.milestone4", comment: "Jungian archetype theory revives interest in symbolic self-knowledge.") }

    static var historyOfMatrixTimelineEra5: String { NSLocalizedString("historyOfMatrix.timeline.era5", comment: "2000s") }
    static var historyOfMatrixTimelineMilestone5: String { NSLocalizedString("historyOfMatrix.timeline.milestone5", comment: "Natalia Ladini systematizes the modern Destiny Matrix.") }

    // Matrix Basic Meanings View
    static var matrixBasicMeaningsTitle: String { NSLocalizedString("matrixBasicMeanings.title", comment: "The 22 Energies") }
    static var matrixBasicMeaningsSubtitle: String { NSLocalizedString("matrixBasicMeanings.subtitle", comment: "Archetypes of the Matrix") }
    static var matrixBasicMeaningsIntro: String { NSLocalizedString("matrixBasicMeanings.intro", comment: "Every position in the Destiny Matrix is filled by one of 22 universal energies. Each energy carries a gift to develop and a shadow to integrate. These archetypes correspond to the 22 Major Arcana of the Tarot.") }
    static var matrixBasicMeaningsListTitle: String { NSLocalizedString("matrixBasicMeanings.list.title", comment: "The 22 Archetypes") }
    static var matrixBasicMeaningsLightLabel: String { NSLocalizedString("matrixBasicMeanings.light.label", comment: "Light") }
    static var matrixBasicMeaningsShadowLabel: String { NSLocalizedString("matrixBasicMeanings.shadow.label", comment: "Shadow") }

    // 22 Energies — name, light, shadow
    static var matrixEnergy1Name: String { NSLocalizedString("matrixEnergy.1.name", comment: "1 — The Magician") }
    static var matrixEnergy1Light: String { NSLocalizedString("matrixEnergy.1.light", comment: "Initiative, willpower, focused action, mastery of skills.") }
    static var matrixEnergy1Shadow: String { NSLocalizedString("matrixEnergy.1.shadow", comment: "Manipulation, scattered energy, ego-driven choices.") }

    static var matrixEnergy2Name: String { NSLocalizedString("matrixEnergy.2.name", comment: "2 — The High Priestess") }
    static var matrixEnergy2Light: String { NSLocalizedString("matrixEnergy.2.light", comment: "Intuition, inner wisdom, calm depth, sacred knowledge.") }
    static var matrixEnergy2Shadow: String { NSLocalizedString("matrixEnergy.2.shadow", comment: "Coldness, secrecy, withdrawal from life.") }

    static var matrixEnergy3Name: String { NSLocalizedString("matrixEnergy.3.name", comment: "3 — The Empress") }
    static var matrixEnergy3Light: String { NSLocalizedString("matrixEnergy.3.light", comment: "Creativity, abundance, nurturing love, sensual joy.") }
    static var matrixEnergy3Shadow: String { NSLocalizedString("matrixEnergy.3.shadow", comment: "Possessiveness, dependency, smothering care.") }

    static var matrixEnergy4Name: String { NSLocalizedString("matrixEnergy.4.name", comment: "4 — The Emperor") }
    static var matrixEnergy4Light: String { NSLocalizedString("matrixEnergy.4.light", comment: "Leadership, structure, stability, mastery of resources.") }
    static var matrixEnergy4Shadow: String { NSLocalizedString("matrixEnergy.4.shadow", comment: "Tyranny, rigidity, need to control everything.") }

    static var matrixEnergy5Name: String { NSLocalizedString("matrixEnergy.5.name", comment: "5 — The Hierophant") }
    static var matrixEnergy5Light: String { NSLocalizedString("matrixEnergy.5.light", comment: "Teaching, tradition, wisdom transmitted to others.") }
    static var matrixEnergy5Shadow: String { NSLocalizedString("matrixEnergy.5.shadow", comment: "Dogmatism, conformity, fear of new ideas.") }

    static var matrixEnergy6Name: String { NSLocalizedString("matrixEnergy.6.name", comment: "6 — The Lovers") }
    static var matrixEnergy6Light: String { NSLocalizedString("matrixEnergy.6.light", comment: "Conscious choice, alignment of values, soulful partnership.") }
    static var matrixEnergy6Shadow: String { NSLocalizedString("matrixEnergy.6.shadow", comment: "Indecision, codependency, divided heart.") }

    static var matrixEnergy7Name: String { NSLocalizedString("matrixEnergy.7.name", comment: "7 — The Chariot") }
    static var matrixEnergy7Light: String { NSLocalizedString("matrixEnergy.7.light", comment: "Willpower, discipline, victory through focused effort.") }
    static var matrixEnergy7Shadow: String { NSLocalizedString("matrixEnergy.7.shadow", comment: "Aggression, ego conflict, overdrive.") }

    static var matrixEnergy8Name: String { NSLocalizedString("matrixEnergy.8.name", comment: "8 — Justice") }
    static var matrixEnergy8Light: String { NSLocalizedString("matrixEnergy.8.light", comment: "Fairness, balance, honest decisions, karmic harmony.") }
    static var matrixEnergy8Shadow: String { NSLocalizedString("matrixEnergy.8.shadow", comment: "Harsh judgment, score-keeping, cold detachment.") }

    static var matrixEnergy9Name: String { NSLocalizedString("matrixEnergy.9.name", comment: "9 — The Hermit") }
    static var matrixEnergy9Light: String { NSLocalizedString("matrixEnergy.9.light", comment: "Inner search, solitude as gift, mentorship, deep wisdom.") }
    static var matrixEnergy9Shadow: String { NSLocalizedString("matrixEnergy.9.shadow", comment: "Isolation, avoidance of intimacy, loneliness.") }

    static var matrixEnergy10Name: String { NSLocalizedString("matrixEnergy.10.name", comment: "10 — Wheel of Fortune") }
    static var matrixEnergy10Light: String { NSLocalizedString("matrixEnergy.10.light", comment: "Trust in cycles, lucky timing, faith in the flow of life.") }
    static var matrixEnergy10Shadow: String { NSLocalizedString("matrixEnergy.10.shadow", comment: "Passivity, gambling on chance, blaming fate.") }

    static var matrixEnergy11Name: String { NSLocalizedString("matrixEnergy.11.name", comment: "11 — Strength") }
    static var matrixEnergy11Light: String { NSLocalizedString("matrixEnergy.11.light", comment: "Courage, gentle power, mastery of impulses, inner calm.") }
    static var matrixEnergy11Shadow: String { NSLocalizedString("matrixEnergy.11.shadow", comment: "Brutality, suppressed anger, raw force.") }

    static var matrixEnergy12Name: String { NSLocalizedString("matrixEnergy.12.name", comment: "12 — The Hanged Man") }
    static var matrixEnergy12Light: String { NSLocalizedString("matrixEnergy.12.light", comment: "Sacrifice for growth, surrender, fresh perspective.") }
    static var matrixEnergy12Shadow: String { NSLocalizedString("matrixEnergy.12.shadow", comment: "Victimhood, stagnation, martyr complex.") }

    static var matrixEnergy13Name: String { NSLocalizedString("matrixEnergy.13.name", comment: "13 — Death (Transformation)") }
    static var matrixEnergy13Light: String { NSLocalizedString("matrixEnergy.13.light", comment: "Endings that bring renewal, deep transformation, rebirth.") }
    static var matrixEnergy13Shadow: String { NSLocalizedString("matrixEnergy.13.shadow", comment: "Clinging to the past, fear of letting go.") }

    static var matrixEnergy14Name: String { NSLocalizedString("matrixEnergy.14.name", comment: "14 — Temperance") }
    static var matrixEnergy14Light: String { NSLocalizedString("matrixEnergy.14.light", comment: "Integration, healing, balance of opposites, harmony.") }
    static var matrixEnergy14Shadow: String { NSLocalizedString("matrixEnergy.14.shadow", comment: "Extremes, imbalance, impatience with process.") }

    static var matrixEnergy15Name: String { NSLocalizedString("matrixEnergy.15.name", comment: "15 — The Devil") }
    static var matrixEnergy15Light: String { NSLocalizedString("matrixEnergy.15.light", comment: "Magnetism, sensual aliveness, healthy material drive.") }
    static var matrixEnergy15Shadow: String { NSLocalizedString("matrixEnergy.15.shadow", comment: "Addiction, attachment, shadow appetites, manipulation.") }

    static var matrixEnergy16Name: String { NSLocalizedString("matrixEnergy.16.name", comment: "16 — The Tower") }
    static var matrixEnergy16Light: String { NSLocalizedString("matrixEnergy.16.light", comment: "Sudden breakthroughs, liberation from false structures.") }
    static var matrixEnergy16Shadow: String { NSLocalizedString("matrixEnergy.16.shadow", comment: "Crisis, destruction, ego collapse, abrupt loss.") }

    static var matrixEnergy17Name: String { NSLocalizedString("matrixEnergy.17.name", comment: "17 — The Star") }
    static var matrixEnergy17Light: String { NSLocalizedString("matrixEnergy.17.light", comment: "Hope, inspiration, talent, healing radiance.") }
    static var matrixEnergy17Shadow: String { NSLocalizedString("matrixEnergy.17.shadow", comment: "Idealization, escapism, disconnect from reality.") }

    static var matrixEnergy18Name: String { NSLocalizedString("matrixEnergy.18.name", comment: "18 — The Moon") }
    static var matrixEnergy18Light: String { NSLocalizedString("matrixEnergy.18.light", comment: "Dreams, deep intuition, contact with the subconscious.") }
    static var matrixEnergy18Shadow: String { NSLocalizedString("matrixEnergy.18.shadow", comment: "Illusion, fear, anxiety, hidden enemies of the mind.") }

    static var matrixEnergy19Name: String { NSLocalizedString("matrixEnergy.19.name", comment: "19 — The Sun") }
    static var matrixEnergy19Light: String { NSLocalizedString("matrixEnergy.19.light", comment: "Joy, vitality, success, radiant self-expression.") }
    static var matrixEnergy19Shadow: String { NSLocalizedString("matrixEnergy.19.shadow", comment: "Ego inflation, burnout, demand for constant praise.") }

    static var matrixEnergy20Name: String { NSLocalizedString("matrixEnergy.20.name", comment: "20 — Judgment") }
    static var matrixEnergy20Light: String { NSLocalizedString("matrixEnergy.20.light", comment: "Calling, awakening, hearing your life's purpose.") }
    static var matrixEnergy20Shadow: String { NSLocalizedString("matrixEnergy.20.shadow", comment: "Self-judgment, guilt, fear of being seen.") }

    static var matrixEnergy21Name: String { NSLocalizedString("matrixEnergy.21.name", comment: "21 — The World") }
    static var matrixEnergy21Light: String { NSLocalizedString("matrixEnergy.21.light", comment: "Completion, integration, wholeness, mastery of a cycle.") }
    static var matrixEnergy21Shadow: String { NSLocalizedString("matrixEnergy.21.shadow", comment: "Stagnation in comfort, fear of the next chapter.") }

    static var matrixEnergy22Name: String { NSLocalizedString("matrixEnergy.22.name", comment: "22 — The Fool") }
    static var matrixEnergy22Light: String { NSLocalizedString("matrixEnergy.22.light", comment: "Freedom, openness, fearless new beginnings, trust.") }
    static var matrixEnergy22Shadow: String { NSLocalizedString("matrixEnergy.22.shadow", comment: "Irresponsibility, naivety, scattered direction.") }

    // How To Read Matrix View
    static var howToReadMatrixTitle: String { NSLocalizedString("howToReadMatrix.title", comment: "How to Read Your Matrix") }

    static var howToReadMatrixStep1Title: String { NSLocalizedString("howToReadMatrix.step1.title", comment: "Calculate Your Chart") }
    static var howToReadMatrixStep1Intro: String { NSLocalizedString("howToReadMatrix.step1.intro", comment: "Your Matrix is built from your date of birth—day, month, and year. Each part is reduced to a single energy between 1 and 22, then combined to fill every position on the diagram.") }
    static var howToReadMatrixStep1Bullet1Title: String { NSLocalizedString("howToReadMatrix.step1.bullet1.title", comment: "Enter Birth Date") }
    static var howToReadMatrixStep1Bullet1Text: String { NSLocalizedString("howToReadMatrix.step1.bullet1.text", comment: "Use your exact birth date. The system handles the math for you.") }
    static var howToReadMatrixStep1Bullet2Title: String { NSLocalizedString("howToReadMatrix.step1.bullet2.title", comment: "Trust the Numbers") }
    static var howToReadMatrixStep1Bullet2Text: String { NSLocalizedString("howToReadMatrix.step1.bullet2.text", comment: "Don't worry about manual calculation—what matters is the meaning behind each energy.") }
    static var howToReadMatrixStep1ProTip: String { NSLocalizedString("howToReadMatrix.step1.proTip", comment: "If you're unsure of an exact time zone, the day, month, and year are what shape the Matrix.") }

    static var howToReadMatrixStep2Title: String { NSLocalizedString("howToReadMatrix.step2.title", comment: "Find the Central Square") }
    static var howToReadMatrixStep2Intro: String { NSLocalizedString("howToReadMatrix.step2.intro", comment: "At the heart of your Matrix is a square with four corner energies and a central one. Together they describe who you are and how you move through life.") }
    static var howToReadMatrixStep2Bullet1Title: String { NSLocalizedString("howToReadMatrix.step2.bullet1.title", comment: "Character (Sky)") }
    static var howToReadMatrixStep2Bullet1Text: String { NSLocalizedString("howToReadMatrix.step2.bullet1.text", comment: "Your conscious personality and the qualities you naturally express.") }
    static var howToReadMatrixStep2Bullet2Title: String { NSLocalizedString("howToReadMatrix.step2.bullet2.title", comment: "Karma (Earth)") }
    static var howToReadMatrixStep2Bullet2Text: String { NSLocalizedString("howToReadMatrix.step2.bullet2.text", comment: "Patterns carried from the past that ask to be transformed in this lifetime.") }
    static var howToReadMatrixStep2Bullet3Title: String { NSLocalizedString("howToReadMatrix.step2.bullet3.title", comment: "Talents & Comfort Zone") }
    static var howToReadMatrixStep2Bullet3Text: String { NSLocalizedString("howToReadMatrix.step2.bullet3.text", comment: "The gifts you bring forward and the comfortable habits you tend to repeat.") }
    static var howToReadMatrixStep2Bullet4Title: String { NSLocalizedString("howToReadMatrix.step2.bullet4.title", comment: "Heart / Mission Core") }
    static var howToReadMatrixStep2Bullet4Text: String { NSLocalizedString("howToReadMatrix.step2.bullet4.text", comment: "The integrating energy at the center—your essence and the gateway to your purpose.") }

    static var howToReadMatrixStep3Title: String { NSLocalizedString("howToReadMatrix.step3.title", comment: "Read the Life Lines") }
    static var howToReadMatrixStep3Intro: String { NSLocalizedString("howToReadMatrix.step3.intro", comment: "Around the central square are lines that describe your main areas of life. Each line is built from several energies that work together.") }
    static var howToReadMatrixStep3Bullet1Title: String { NSLocalizedString("howToReadMatrix.step3.bullet1.title", comment: "Money & Finance Line") }
    static var howToReadMatrixStep3Bullet1Text: String { NSLocalizedString("howToReadMatrix.step3.bullet1.text", comment: "How you attract resources, your relationship to abundance, and where money flows freely or gets blocked.") }
    static var howToReadMatrixStep3Bullet2Title: String { NSLocalizedString("howToReadMatrix.step3.bullet2.title", comment: "Relationship Line") }
    static var howToReadMatrixStep3Bullet2Text: String { NSLocalizedString("howToReadMatrix.step3.bullet2.text", comment: "How you bond with partners, the lessons love brings, and what kind of relationships nourish you.") }
    static var howToReadMatrixStep3Bullet3Title: String { NSLocalizedString("howToReadMatrix.step3.bullet3.title", comment: "Family & Ancestral Line") }
    static var howToReadMatrixStep3Bullet3Text: String { NSLocalizedString("howToReadMatrix.step3.bullet3.text", comment: "Patterns inherited from your family system that influence your roots and sense of belonging.") }
    static var howToReadMatrixStep3ProTip: String { NSLocalizedString("howToReadMatrix.step3.proTip", comment: "Read each line as a story: light versions describe what flows naturally, shadow versions show what's ready to be healed.") }

    static var howToReadMatrixStep4Title: String { NSLocalizedString("howToReadMatrix.step4.title", comment: "Look at Your Mission") }
    static var howToReadMatrixStep4Intro: String { NSLocalizedString("howToReadMatrix.step4.intro", comment: "The mission points reveal your purpose—why your soul chose this lifetime and the contribution you're invited to make.") }
    static var howToReadMatrixStep4Bullet1Title: String { NSLocalizedString("howToReadMatrix.step4.bullet1.title", comment: "Personal Mission") }
    static var howToReadMatrixStep4Bullet1Text: String { NSLocalizedString("howToReadMatrix.step4.bullet1.text", comment: "The growth your soul came here to experience for itself.") }
    static var howToReadMatrixStep4Bullet2Title: String { NSLocalizedString("howToReadMatrix.step4.bullet2.title", comment: "Social Mission") }
    static var howToReadMatrixStep4Bullet2Text: String { NSLocalizedString("howToReadMatrix.step4.bullet2.text", comment: "How you're meant to serve and what gift you offer to the world.") }

    static var howToReadMatrixStep5Title: String { NSLocalizedString("howToReadMatrix.step5.title", comment: "Bring It All Together") }
    static var howToReadMatrixStep5Intro: String { NSLocalizedString("howToReadMatrix.step5.intro", comment: "Once you understand the parts, read the whole Matrix as a conversation between archetypes. Notice repeated energies and how the light and shadow sides relate.") }
    static var howToReadMatrixStep5Bullet1Title: String { NSLocalizedString("howToReadMatrix.step5.bullet1.title", comment: "Look for Repetitions") }
    static var howToReadMatrixStep5Bullet1Text: String { NSLocalizedString("howToReadMatrix.step5.bullet1.text", comment: "Energies that appear in multiple positions carry a strong theme in your life.") }
    static var howToReadMatrixStep5Bullet2Title: String { NSLocalizedString("howToReadMatrix.step5.bullet2.title", comment: "Hold Light & Shadow Together") }
    static var howToReadMatrixStep5Bullet2Text: String { NSLocalizedString("howToReadMatrix.step5.bullet2.text", comment: "Each energy has both gifts and challenges. Working consciously with the shadow side is where real growth happens.") }

    static var howToReadMatrixRememberTitle: String { NSLocalizedString("howToReadMatrix.remember.title", comment: "Remember") }
    static var howToReadMatrixRememberText: String { NSLocalizedString("howToReadMatrix.remember.text", comment: "Your Matrix is a map, not a verdict. It points to potentials and patterns—your free will and conscious choices write the actual story of your life.") }

    // Matrix & Mind View
    static var matrixMindTitle: String { NSLocalizedString("matrixMind.title", comment: "Matrix & Mind") }
    static var matrixMindSubtitle: String { NSLocalizedString("matrixMind.subtitle", comment: "A Tool for Self-Reflection") }

    static var matrixMindSection1Title: String { NSLocalizedString("matrixMind.section1.title", comment: "A Map of Inner Archetypes") }
    static var matrixMindSection1Text: String { NSLocalizedString("matrixMind.section1.text", comment: "The Destiny Matrix can be understood as a map of inner archetypes—universal patterns that live inside every person. Reading your chart isn't about predicting fate; it's about meeting the parts of yourself that shape how you think, feel, and choose.") }

    static var matrixMindSection2Title: String { NSLocalizedString("matrixMind.section2.title", comment: "Working with the Shadow") }
    static var matrixMindSection2Text: String { NSLocalizedString("matrixMind.section2.text", comment: "Each of the 22 energies carries both a light expression and a shadow expression. The shadow is not bad—it's the part of an archetype that runs unconsciously when ignored. Naming it gently is the first step toward integration.") }
    static var matrixMindSection2Insight: String { NSLocalizedString("matrixMind.section2.insight", comment: "What you can name, you can work with. What stays unconscious, controls you.") }

    static var matrixMindSection3Title: String { NSLocalizedString("matrixMind.section3.title", comment: "Patterns of Behavior") }
    static var matrixMindSection3Intro: String { NSLocalizedString("matrixMind.section3.intro", comment: "When you look at the lines and positions of your Matrix, you start to see how certain patterns repeat across areas of life:") }
    static var matrixMindSection3Bullet1Title: String { NSLocalizedString("matrixMind.section3.bullet1.title", comment: "Comfort Zone") }
    static var matrixMindSection3Bullet1Text: String { NSLocalizedString("matrixMind.section3.bullet1.text", comment: "Habits and identities you cling to because they feel safe—even when they no longer serve growth.") }
    static var matrixMindSection3Bullet2Title: String { NSLocalizedString("matrixMind.section3.bullet2.title", comment: "Karmic Loops") }
    static var matrixMindSection3Bullet2Text: String { NSLocalizedString("matrixMind.section3.bullet2.text", comment: "Situations that keep reappearing in slightly different costumes until the lesson is consciously met.") }
    static var matrixMindSection3Bullet3Title: String { NSLocalizedString("matrixMind.section3.bullet3.title", comment: "Ancestral Patterns") }
    static var matrixMindSection3Bullet3Text: String { NSLocalizedString("matrixMind.section3.bullet3.text", comment: "Family inheritances—beliefs, fears, and gifts—visible in the family/karmic positions of your chart.") }

    static var matrixMindSection4Title: String { NSLocalizedString("matrixMind.section4.title", comment: "Mindful Practice") }
    static var matrixMindSection4Intro: String { NSLocalizedString("matrixMind.section4.intro", comment: "The Matrix becomes most powerful when used as a mirror for daily reflection rather than as a forecast.") }
    static var matrixMindSection4Bullet1Title: String { NSLocalizedString("matrixMind.section4.bullet1.title", comment: "Journaling") }
    static var matrixMindSection4Bullet1Text: String { NSLocalizedString("matrixMind.section4.bullet1.text", comment: "Pick one energy from your chart and journal on its light and shadow as you noticed them this week.") }
    static var matrixMindSection4Bullet2Title: String { NSLocalizedString("matrixMind.section4.bullet2.title", comment: "Conscious Choice") }
    static var matrixMindSection4Bullet2Text: String { NSLocalizedString("matrixMind.section4.bullet2.text", comment: "When you recognize a pattern playing out, pause and ask: which side of this energy do I want to express right now?") }

    static var matrixMindSection5Title: String { NSLocalizedString("matrixMind.section5.title", comment: "From Insight to Choice") }
    static var matrixMindSection5Text: String { NSLocalizedString("matrixMind.section5.text", comment: "Reading your Matrix is not the end—it's the start of a conscious dialogue with yourself. The chart describes the landscape; you choose the path. Used gently, it can support therapy, coaching, and any path of self-understanding.") }

    static var matrixMindConclusion: String { NSLocalizedString("matrixMind.conclusion", comment: "The Matrix doesn't decide who you are. It invites you to remember who you came here to be.") }
    static var matrixMindInsightLabel: String { NSLocalizedString("matrixMind.insight.label", comment: "Insight") }

    // Destiny Matrix FAQ View
    static var matrixFaqTitle: String { NSLocalizedString("matrixFaq.title", comment: "Frequently Asked Questions") }
    static var matrixFaqSubtitle: String { NSLocalizedString("matrixFaq.subtitle", comment: "Common questions about the Destiny Matrix") }

    static var matrixFaqQuestion1: String { NSLocalizedString("matrixFaq.question1", comment: "What is the Destiny Matrix?") }
    static var matrixFaqAnswer1: String { NSLocalizedString("matrixFaq.answer1", comment: "The Destiny Matrix is a personal chart built from your date of birth that maps 22 universal energies onto key positions of your life: your personality, relationships, money, family, and mission. It combines numerology, Tarot archetypes, and the Eastern chakra system into one diagram.") }

    static var matrixFaqQuestion2: String { NSLocalizedString("matrixFaq.question2", comment: "Is the Matrix the same as numerology?") }
    static var matrixFaqAnswer2: String { NSLocalizedString("matrixFaq.answer2", comment: "Numerology is one of its ingredients but not the whole system. The Matrix uses numerological calculation to place 22 archetypal energies—rooted in the Major Arcana of the Tarot—onto a specific diagram, giving a more layered picture than numbers alone.") }

    static var matrixFaqQuestion3: String { NSLocalizedString("matrixFaq.question3", comment: "Why are there exactly 22 energies?") }
    static var matrixFaqAnswer3: String { NSLocalizedString("matrixFaq.answer3", comment: "The 22 energies correspond to the 22 Major Arcana of the Tarot—a complete cycle of archetypes describing the human journey from beginning (The Fool) to wholeness (The World).") }

    static var matrixFaqQuestion4: String { NSLocalizedString("matrixFaq.question4", comment: "Can my Matrix change over time?") }
    static var matrixFaqAnswer4: String { NSLocalizedString("matrixFaq.answer4", comment: "The chart itself is fixed because it's calculated from your birth date. What changes is your relationship to it—how consciously you express the light or shadow side of each energy as you grow.") }

    static var matrixFaqQuestion5: String { NSLocalizedString("matrixFaq.question5", comment: "How is it different from Tarot or astrology?") }
    static var matrixFaqAnswer5: String { NSLocalizedString("matrixFaq.answer5", comment: "Tarot is a divination tool that responds to a specific question in the moment. Astrology maps planetary positions at your birth. The Matrix is a fixed birth-chart of archetypes, focused on identity, purpose, and personal patterns rather than transits or one-off questions.") }

    static var matrixFaqQuestion6: String { NSLocalizedString("matrixFaq.question6", comment: "Can it predict the future?") }
    static var matrixFaqAnswer6: String { NSLocalizedString("matrixFaq.answer6", comment: "The Matrix doesn't predict events. It describes potentials, patterns, and lessons. Your choices, awareness, and effort decide which version of each energy actually shows up in your life.") }

    static var matrixFaqQuestion7: String { NSLocalizedString("matrixFaq.question7", comment: "Do I need a birth time or place?") }
    static var matrixFaqAnswer7: String { NSLocalizedString("matrixFaq.answer7", comment: "No. Unlike a natal astrology chart, the Destiny Matrix only needs your day, month, and year of birth.") }

    static var matrixFaqQuestion8: String { NSLocalizedString("matrixFaq.question8", comment: "Can I read someone else's Matrix?") }
    static var matrixFaqAnswer8: String { NSLocalizedString("matrixFaq.answer8", comment: "Yes—if they share their birth date with you. Many people use it to better understand their partner, family member, or child. Always read with respect and ask before sharing interpretations.") }

    static var matrixFaqQuestion9: String { NSLocalizedString("matrixFaq.question9", comment: "Is the Destiny Matrix a religion?") }
    static var matrixFaqAnswer9: String { NSLocalizedString("matrixFaq.answer9", comment: "No. The Matrix is a symbolic self-development tool. It can sit alongside any faith—or none—and works as a mirror for reflection rather than as a belief system.") }

    static var matrixFaqQuestion10: String { NSLocalizedString("matrixFaq.question10", comment: "How should I start working with my chart?") }
    static var matrixFaqAnswer10: String { NSLocalizedString("matrixFaq.answer10", comment: "Begin with the central square—your personality, karma, talents, and core energy. Read both the light and shadow sides. Then explore one life line at a time (money, relationships, family) over several weeks rather than all at once.") }

    static var matrixFaqDisclaimerTitle: String { NSLocalizedString("matrixFaq.disclaimer.title", comment: "Important Note") }
    static var matrixFaqDisclaimerText: String { NSLocalizedString("matrixFaq.disclaimer.text", comment: "The Destiny Matrix is offered as a tool for reflection and self-discovery. It is not a substitute for medical, psychological, legal, or financial advice. Trust your own judgment and seek qualified professionals when you need real-world support.") }

    // MARK: - Paywall
    static var paywallTitle: String { NSLocalizedString("paywall.title", comment: "Paywall main title") }
    static var paywallSubtitle: String { NSLocalizedString("paywall.subtitle", comment: "Paywall header subtitle") }
    static var paywallFeatureTarotTitle: String { NSLocalizedString("paywall.feature.tarot.title", comment: "Paywall feature title for unlimited tarot readings") }
    static var paywallFeatureTarotSubtitle: String { NSLocalizedString("paywall.feature.tarot.subtitle", comment: "Paywall feature subtitle for unlimited tarot readings") }
    static var paywallFeatureMatrixTitle: String { NSLocalizedString("paywall.feature.matrix.title", comment: "Paywall feature title for Destiny and Couple Matrix") }
    static var paywallFeatureMatrixSubtitle: String { NSLocalizedString("paywall.feature.matrix.subtitle", comment: "Paywall feature subtitle for Destiny and Couple Matrix") }
    static var paywallFeaturePalmTitle: String { NSLocalizedString("paywall.feature.palm.title", comment: "Paywall feature title for palm reading") }
    static var paywallFeaturePalmSubtitle: String { NSLocalizedString("paywall.feature.palm.subtitle", comment: "Paywall feature subtitle for palm reading") }
    static var paywallFeatureCompatibilityTitle: String { NSLocalizedString("paywall.feature.compatibility.title", comment: "Paywall feature title for cosmic compatibility") }
    static var paywallFeatureCompatibilitySubtitle: String { NSLocalizedString("paywall.feature.compatibility.subtitle", comment: "Paywall feature subtitle for cosmic compatibility") }
    static var paywallFeatureSaveTitle: String { NSLocalizedString("paywall.feature.save.title", comment: "Title for saving matrices feature on the paywall") }
    static var paywallFeatureSaveSubtitle: String { NSLocalizedString("paywall.feature.save.subtitle", comment: "Subtitle for saving matrices feature on the paywall") }
    static var paywallFeatureLearnTitle: String { NSLocalizedString("paywall.feature.learn.title", comment: "Title for learning about the Destiny Matrix feature on the paywall") }
    static var paywallFeatureLearnSubtitle: String { NSLocalizedString("paywall.feature.learn.subtitle", comment: "Subtitle for learning about the Destiny Matrix feature on the paywall") }
    static var paywallProductsLoading: String { NSLocalizedString("paywall.products.loading", comment: "Placeholder shown while StoreKit products are loading") }
    static var paywallProductYearly: String { NSLocalizedString("paywall.product.yearly", comment: "Label for the yearly subscription option") }
    static var paywallProductMonthly: String { NSLocalizedString("paywall.product.monthly", comment: "Label for the monthly subscription option") }
    static var paywallPeriodYearly: String { NSLocalizedString("paywall.period.yearly", comment: "Per-year suffix shown next to the yearly price") }
    static var paywallPeriodMonthly: String { NSLocalizedString("paywall.period.monthly", comment: "Per-month suffix shown next to the monthly price") }
    static var paywallBadgeBestValue: String { NSLocalizedString("paywall.badge.bestValue", comment: "Best value badge on the yearly subscription option") }
    static var paywallCtaStartTrial: String { NSLocalizedString("paywall.cta.startTrial", comment: "Paywall primary button when a free trial is available") }
    static var paywallCtaContinue: String { NSLocalizedString("paywall.cta.continue", comment: "Paywall primary button when no free trial is available") }
    static var paywallRestore: String { NSLocalizedString("paywall.restore", comment: "Restore purchases button") }
    static var paywallDisclaimer: String { NSLocalizedString("paywall.disclaimer", comment: "Footer text below the subscribe button explaining auto-renewal") }
    static var paywallErrorTitle: String { NSLocalizedString("paywall.error.title", comment: "Title shown in the paywall error alert") }
    static func paywallTrialDays(_ days: Int) -> String {
        String(format: NSLocalizedString("paywall.trial.days", comment: "Free trial description; %d is replaced with the number of days"), days)
    }
    
    // MARK: – NotificationService
    static var notificationTitle: String { NSLocalizedString("notification.title", comment: "Your Daily Card Awaits") }
    static var notificationBody: String { NSLocalizedString("notification.body", comment: "The cards have a message for you today. Reveal your guidance.") }

    // MARK: - Mercury Retrograde
    static var mercuryTitle: String { NSLocalizedString("mercury.title", value: "Mercury Retrograde", comment: "Mercury Retrograde feature title") }
    static var mercurySubtitle: String { NSLocalizedString("mercury.subtitle", value: "Cosmic communication weather", comment: "Mercury Retrograde subtitle") }

    static var mercuryStatusActive: String { NSLocalizedString("mercury.status.active", value: "Mercury is Retrograde", comment: "Status when Mercury is currently retrograde") }
    static var mercuryStatusDirect: String { NSLocalizedString("mercury.status.direct", value: "Mercury is Direct", comment: "Status when Mercury is currently direct") }
    static var mercuryStatusPreShadow: String { NSLocalizedString("mercury.status.preShadow", value: "Pre-Shadow Phase", comment: "Status during pre-shadow") }
    static var mercuryStatusPostShadow: String { NSLocalizedString("mercury.status.postShadow", value: "Post-Shadow Phase", comment: "Status during post-shadow") }

    static var mercuryInSign: String { NSLocalizedString("mercury.inSign", value: "in", comment: "Connector between Mercury and zodiac sign, e.g. Mercury in Gemini") }
    static var mercuryDaysUntilEnd: String { NSLocalizedString("mercury.daysUntilEnd", value: "days until direct", comment: "Days remaining until Mercury goes direct") }
    static var mercuryDaysUntilStart: String { NSLocalizedString("mercury.daysUntilStart", value: "days until retrograde", comment: "Days remaining until retrograde begins") }
    static var mercuryDaysUntilPostShadowEnd: String { NSLocalizedString("mercury.daysUntilPostShadowEnd", value: "days until shadow ends", comment: "Days remaining until post-shadow ends") }
    static var mercuryDaysUntilPreShadow: String { NSLocalizedString("mercury.daysUntilPreShadow", value: "days until shadow begins", comment: "Days until next pre-shadow begins") }

    // Phase titles
    static var mercuryPhaseDirect: String { NSLocalizedString("mercury.phase.direct", value: "Direct Motion", comment: "Phase: Mercury moving direct") }
    static var mercuryPhasePreShadow: String { NSLocalizedString("mercury.phase.preShadow", value: "Pre-Shadow", comment: "Phase: pre-shadow before retrograde") }
    static var mercuryPhaseRetrograde: String { NSLocalizedString("mercury.phase.retrograde", value: "Retrograde", comment: "Phase: full retrograde") }
    static var mercuryPhasePostShadow: String { NSLocalizedString("mercury.phase.postShadow", value: "Post-Shadow", comment: "Phase: post-shadow after retrograde") }

    // Phase descriptions
    static var mercuryPhaseDirectDesc: String { NSLocalizedString("mercury.phase.direct.desc", value: "Mercury moves forward through the zodiac. Communication, travel, and signing contracts flow smoothly. A great time to launch new projects.", comment: "Description for direct phase") }
    static var mercuryPhasePreShadowDesc: String { NSLocalizedString("mercury.phase.preShadow.desc", value: "Mercury enters the degrees where it will turn retrograde. Themes that will return during retrograde begin to surface. Pay attention to early signals.", comment: "Description for pre-shadow phase") }
    static var mercuryPhaseRetrogradeDesc: String { NSLocalizedString("mercury.phase.retrograde.desc", value: "Mercury appears to move backwards. A potent time for review, reflection, and reconnection — but be careful with new commitments, electronics, and travel.", comment: "Description for retrograde phase") }
    static var mercuryPhasePostShadowDesc: String { NSLocalizedString("mercury.phase.postShadow.desc", value: "Mercury moves forward again but retraces the retrograde degrees. Loose ends find resolution. Apply lessons learned from the retrograde period.", comment: "Description for post-shadow phase") }

    // Sections
    static var mercuryShadowTimeline: String { NSLocalizedString("mercury.shadowTimeline", value: "Shadow Timeline", comment: "Shadow timeline section title") }
    static var mercuryYourSignImpact: String { NSLocalizedString("mercury.yourSignImpact", value: "Impact on Your Sign", comment: "Personal impact section title") }
    static var mercuryUpcoming: String { NSLocalizedString("mercury.upcoming", value: "Upcoming Retrogrades", comment: "Upcoming retrogrades list title") }
    static var mercuryDos: String { NSLocalizedString("mercury.dos", value: "What to Embrace", comment: "Do's list title") }
    static var mercuryDonts: String { NSLocalizedString("mercury.donts", value: "What to Avoid", comment: "Don'ts list title") }
    static var mercuryNotifications: String { NSLocalizedString("mercury.notifications", value: "Mercury Retrograde Alerts", comment: "Notifications toggle title") }
    static var mercuryNotificationsDesc: String { NSLocalizedString("mercury.notifications.desc", value: "Get notified when Mercury retrograde or shadow periods begin and end.", comment: "Notifications description") }

    static var mercuryAddBirthDateForImpact: String { NSLocalizedString("mercury.addBirthDateForImpact", value: "Add your birth date in Settings to see how this retrograde affects your sign.", comment: "Prompt to add birth date for personalized impact") }

    // Impact descriptions (by angular distance between user sign and retrograde sign)
    static var mercuryImpactSelf: String { NSLocalizedString("mercury.impact.self", value: "Mercury retrogrades through your sign — your communication style, identity, and self-expression are under review. Slow down and listen before you speak.", comment: "Impact when retrograde is in user's own sign") }
    static var mercuryImpactAdjacent: String { NSLocalizedString("mercury.impact.adjacent", value: "Themes around finances, values, secrets, or hidden matters surface. A quiet, introspective period — handle resources mindfully.", comment: "Impact when retrograde is in adjacent sign") }
    static var mercuryImpactSextile: String { NSLocalizedString("mercury.impact.sextile", value: "A supportive retrograde for you. Friendships, siblings, and casual contacts bring helpful information. Conversations open new doors.", comment: "Impact when retrograde sextiles user's sign") }
    static var mercuryImpactSquare: String { NSLocalizedString("mercury.impact.square", value: "Tension between home and career, or private and public life. Old patterns demand attention before you can move forward.", comment: "Impact when retrograde squares user's sign") }
    static var mercuryImpactTrine: String { NSLocalizedString("mercury.impact.trine", value: "A flowing, creative retrograde for you. Travel plans may shift, but learning, romance, or self-expression deepen in beautiful ways.", comment: "Impact when retrograde trines user's sign") }
    static var mercuryImpactInconjunct: String { NSLocalizedString("mercury.impact.inconjunct", value: "Daily routines, health, or work logistics need adjustment. Small recalibrations now prevent bigger disruptions later.", comment: "Impact when retrograde is inconjunct user's sign") }
    static var mercuryImpactOpposite: String { NSLocalizedString("mercury.impact.opposite", value: "Relationships, partnerships, and one-on-one dynamics come into focus. Past connections may reappear — for closure or rekindling.", comment: "Impact when retrograde opposes user's sign") }

    // Do's
    static var mercuryDoDirect1: String { NSLocalizedString("mercury.do.direct.1", value: "Launch new projects and sign contracts with confidence.", comment: "Direct do 1") }
    static var mercuryDoDirect2: String { NSLocalizedString("mercury.do.direct.2", value: "Communicate boldly — your message will land clearly.", comment: "Direct do 2") }
    static var mercuryDoDirect3: String { NSLocalizedString("mercury.do.direct.3", value: "Embrace travel, learning, and forward momentum.", comment: "Direct do 3") }
    static var mercuryDoPreShadow1: String { NSLocalizedString("mercury.do.preShadow.1", value: "Notice recurring themes — they will return during retrograde.", comment: "Pre-shadow do 1") }
    static var mercuryDoPreShadow2: String { NSLocalizedString("mercury.do.preShadow.2", value: "Back up important files and double-check travel plans.", comment: "Pre-shadow do 2") }
    static var mercuryDoPreShadow3: String { NSLocalizedString("mercury.do.preShadow.3", value: "Finish projects you don't want to revisit in the coming weeks.", comment: "Pre-shadow do 3") }
    static var mercuryDoRetrograde1: String { NSLocalizedString("mercury.do.retrograde.1", value: "Review, revise, and refine existing work.", comment: "Retrograde do 1") }
    static var mercuryDoRetrograde2: String { NSLocalizedString("mercury.do.retrograde.2", value: "Reconnect with old friends and unfinished conversations.", comment: "Retrograde do 2") }
    static var mercuryDoRetrograde3: String { NSLocalizedString("mercury.do.retrograde.3", value: "Reflect deeply — journal, meditate, and listen inward.", comment: "Retrograde do 3") }
    static var mercuryDoRetrograde4: String { NSLocalizedString("mercury.do.retrograde.4", value: "Slow down. Read instructions twice. Speak with care.", comment: "Retrograde do 4") }
    static var mercuryDoPostShadow1: String { NSLocalizedString("mercury.do.postShadow.1", value: "Apply the lessons learned during retrograde.", comment: "Post-shadow do 1") }
    static var mercuryDoPostShadow2: String { NSLocalizedString("mercury.do.postShadow.2", value: "Tie up loose ends and finalize decisions postponed during retrograde.", comment: "Post-shadow do 2") }
    static var mercuryDoPostShadow3: String { NSLocalizedString("mercury.do.postShadow.3", value: "Begin gently re-launching plans that were put on hold.", comment: "Post-shadow do 3") }

    // Don'ts
    static var mercuryDontDirect1: String { NSLocalizedString("mercury.dont.direct.1", value: "Don't postpone decisions waiting for a 'better' moment.", comment: "Direct dont 1") }
    static var mercuryDontDirect2: String { NSLocalizedString("mercury.dont.direct.2", value: "Don't blame Mercury for ordinary miscommunications.", comment: "Direct dont 2") }
    static var mercuryDontPreShadow1: String { NSLocalizedString("mercury.dont.preShadow.1", value: "Avoid rushing major contracts you won't be able to revisit.", comment: "Pre-shadow dont 1") }
    static var mercuryDontPreShadow2: String { NSLocalizedString("mercury.dont.preShadow.2", value: "Don't ignore the early signals of returning themes.", comment: "Pre-shadow dont 2") }
    static var mercuryDontPreShadow3: String { NSLocalizedString("mercury.dont.preShadow.3", value: "Postpone buying expensive electronics if you can.", comment: "Pre-shadow dont 3") }
    static var mercuryDontRetrograde1: String { NSLocalizedString("mercury.dont.retrograde.1", value: "Avoid signing major contracts or making irreversible commitments.", comment: "Retrograde dont 1") }
    static var mercuryDontRetrograde2: String { NSLocalizedString("mercury.dont.retrograde.2", value: "Don't buy new electronics, cars, or communication devices.", comment: "Retrograde dont 2") }
    static var mercuryDontRetrograde3: String { NSLocalizedString("mercury.dont.retrograde.3", value: "Resist starting brand-new projects from scratch.", comment: "Retrograde dont 3") }
    static var mercuryDontRetrograde4: String { NSLocalizedString("mercury.dont.retrograde.4", value: "Don't assume your message was received — confirm twice.", comment: "Retrograde dont 4") }
    static var mercuryDontPostShadow1: String { NSLocalizedString("mercury.dont.postShadow.1", value: "Don't rush forward before integrating retrograde lessons.", comment: "Post-shadow dont 1") }
    static var mercuryDontPostShadow2: String { NSLocalizedString("mercury.dont.postShadow.2", value: "Avoid making the same mistakes the retrograde just highlighted.", comment: "Post-shadow dont 2") }

    // Notifications
    static var mercuryNotifPreShadowTitle: String { NSLocalizedString("mercury.notif.preShadow.title", value: "Mercury Enters Shadow", comment: "Notification title for pre-shadow start") }
    static var mercuryNotifPreShadowBody: String { NSLocalizedString("mercury.notif.preShadow.body", value: "The retrograde window opens. Watch for themes that will resurface.", comment: "Notification body for pre-shadow start") }
    static var mercuryNotifRetrogradeStartTitle: String { NSLocalizedString("mercury.notif.retrogradeStart.title", value: "Mercury Goes Retrograde", comment: "Notification title for retrograde start") }
    static var mercuryNotifRetrogradeStartBody: String { NSLocalizedString("mercury.notif.retrogradeStart.body", value: "Time to slow down, reflect, and review. Tap to see what to embrace and avoid.", comment: "Notification body for retrograde start") }
    static var mercuryNotifRetrogradeEndTitle: String { NSLocalizedString("mercury.notif.retrogradeEnd.title", value: "Mercury Goes Direct", comment: "Notification title for retrograde end") }
    static var mercuryNotifRetrogradeEndBody: String { NSLocalizedString("mercury.notif.retrogradeEnd.body", value: "Mercury stations direct. Momentum returns — but stay gentle through post-shadow.", comment: "Notification body for retrograde end") }
    static var mercuryNotifPostShadowEndTitle: String { NSLocalizedString("mercury.notif.postShadowEnd.title", value: "Shadow Period Ends", comment: "Notification title for post-shadow end") }
    static var mercuryNotifPostShadowEndBody: String { NSLocalizedString("mercury.notif.postShadowEnd.body", value: "Mercury fully clears the shadow. The path ahead is open.", comment: "Notification body for post-shadow end") }

    // MARK: - Mercury Retrograde × Couple
    static var mercuryCoupleTitle: String { NSLocalizedString("mercury.couple.title", value: "Mercury Retrograde Impact", comment: "Title for the retrograde card inside compatibility view") }
    static var mercuryCoupleSubtitle: String { NSLocalizedString("mercury.couple.subtitle", value: "How this retrograde shapes your bond", comment: "Subtitle under the retrograde card") }
    static var mercuryCoupleImpactYou: String { NSLocalizedString("mercury.couple.impactYou", value: "For you", comment: "Label above the user's personal impact in the compatibility retrograde card") }
    static var mercuryCoupleImpactPartner: String { NSLocalizedString("mercury.couple.impactPartner", value: "For your partner", comment: "Label above the partner's impact in the compatibility retrograde card") }
    static var mercuryCoupleAdvice: String { NSLocalizedString("mercury.couple.advice", value: "Guidance for the Two of You", comment: "Header for couple guidance list") }

    // Pre-shadow couple guidance
    static var mercuryCoupleAdvicePreShadow1: String { NSLocalizedString("mercury.couple.advice.preShadow.1", value: "Notice subtle shifts in how you communicate — they will become themes during retrograde.", comment: "Couple pre-shadow advice 1") }
    static var mercuryCoupleAdvicePreShadow2: String { NSLocalizedString("mercury.couple.advice.preShadow.2", value: "Finish important conversations now, before words get tangled.", comment: "Couple pre-shadow advice 2") }
    static var mercuryCoupleAdvicePreShadow3: String { NSLocalizedString("mercury.couple.advice.preShadow.3", value: "Back up shared memories — photos, messages, plans you both rely on.", comment: "Couple pre-shadow advice 3") }

    // Retrograde couple guidance
    static var mercuryCoupleAdviceRetrograde1: String { NSLocalizedString("mercury.couple.advice.retrograde.1", value: "Pause before reacting. Misreadings of tone and intent spike right now.", comment: "Couple retrograde advice 1") }
    static var mercuryCoupleAdviceRetrograde2: String { NSLocalizedString("mercury.couple.advice.retrograde.2", value: "Old relationship patterns may resurface — a chance to heal them, not repeat them.", comment: "Couple retrograde advice 2") }
    static var mercuryCoupleAdviceRetrograde3: String { NSLocalizedString("mercury.couple.advice.retrograde.3", value: "Past partners or unresolved connections may reach out. Honor your current path.", comment: "Couple retrograde advice 3") }
    static var mercuryCoupleAdviceRetrograde4: String { NSLocalizedString("mercury.couple.advice.retrograde.4", value: "Postpone major commitments — moving in, engagement, breakups — when you can.", comment: "Couple retrograde advice 4") }
    static var mercuryCoupleAdviceRetrograde5: String { NSLocalizedString("mercury.couple.advice.retrograde.5", value: "Schedule a gentle 'state of us' check-in. Listen more than you speak.", comment: "Couple retrograde advice 5") }

    // Post-shadow couple guidance
    static var mercuryCoupleAdvicePostShadow1: String { NSLocalizedString("mercury.couple.advice.postShadow.1", value: "Integrate what you learned about each other during the retrograde.", comment: "Couple post-shadow advice 1") }
    static var mercuryCoupleAdvicePostShadow2: String { NSLocalizedString("mercury.couple.advice.postShadow.2", value: "Re-launch postponed plans gently — trust the renewed clarity.", comment: "Couple post-shadow advice 2") }
    static var mercuryCoupleAdvicePostShadow3: String { NSLocalizedString("mercury.couple.advice.postShadow.3", value: "Acknowledge the growth your relationship made through the challenges.", comment: "Couple post-shadow advice 3") }

    // MARK: - Learn Mercury Retrograde
    static var learnMercuryTitle: String { NSLocalizedString("learnMercury.title", value: "Learn About Mercury Retrograde", comment: "Title for the Learn Mercury Retrograde view") }
    static var learnMercurySubtitle: String { NSLocalizedString("learnMercury.subtitle", value: "What it is, why it matters, and how to navigate it.", comment: "Subtitle for the Learn Mercury Retrograde view") }
    static var learnMercuryHistoryTitle: String { NSLocalizedString("learnMercury.history.title", value: "History of Mercury Retrograde", comment: "Title of the navigation link to the history view") }
    static var learnMercuryHistorySubtitle: String { NSLocalizedString("learnMercury.history.subtitle", value: "From Babylonian sky-watchers to modern astrology", comment: "Subtitle of the navigation link to the history view") }

    // What Is Mercury Retrograde?
    static var learnMercuryWhatIsTitle: String { NSLocalizedString("learnMercury.whatIs.title", value: "What Is Mercury Retrograde?", comment: "Section title: what is Mercury retrograde") }
    static var learnMercuryWhatIsIntro: String { NSLocalizedString("learnMercury.whatIs.intro", value: "Three or four times a year, Mercury — the swift messenger of the cosmos — appears to slow down, stop, and travel backwards through the zodiac for about three weeks. This is an optical illusion: Mercury never actually reverses course. Instead, because Mercury orbits the Sun faster than Earth, it occasionally laps us. When it does, our perspective makes Mercury seem to glide backwards against the distant stars.", comment: "Intro paragraph explaining what retrograde is") }
    static var learnMercuryWhatIsBody: String { NSLocalizedString("learnMercury.whatIs.body", value: "Astronomers call this 'apparent retrograde motion'. Astrologers, observing the same phenomenon for thousands of years, noticed that the themes ruled by Mercury — communication, contracts, travel, technology, and learning — often felt more tangled during these windows. Whether you read this symbolically or psychologically, retrograde is an invitation to slow down and revisit, rather than rush forward.", comment: "Body paragraph explaining apparent motion") }

    // The Three Phases
    static var learnMercuryPhasesTitle: String { NSLocalizedString("learnMercury.phases.title", value: "The Three Phases", comment: "Section title: phases of retrograde") }
    static var learnMercuryPhasesIntro: String { NSLocalizedString("learnMercury.phases.intro", value: "A complete Mercury retrograde cycle spans about seven weeks. It is divided into three phases — the pre-shadow, the retrograde itself, and the post-shadow.", comment: "Phases intro") }
    static var learnMercuryPhasePreShadowTitle: String { NSLocalizedString("learnMercury.phase.preShadow.title", value: "Pre-Shadow (~2 weeks before)", comment: "Phase 1 title") }
    static var learnMercuryPhasePreShadowText: String { NSLocalizedString("learnMercury.phase.preShadow.text", value: "Mercury enters the degrees of the zodiac where it will later turn retrograde. Themes that will surface during retrograde begin to whisper. Pay attention to small disruptions, hints, and recurring topics — they often preview the lessons ahead.", comment: "Phase 1 text") }
    static var learnMercuryPhaseRetrogradeTitle: String { NSLocalizedString("learnMercury.phase.retrograde.title", value: "Retrograde (~3 weeks)", comment: "Phase 2 title") }
    static var learnMercuryPhaseRetrogradeText: String { NSLocalizedString("learnMercury.phase.retrograde.text", value: "Mercury appears to move backwards. This is the core review-and-revise window. Old conversations may return, plans may shift, and technology may misbehave. The keywords for this phase begin with 're-': review, revise, reflect, reconnect, repair, return.", comment: "Phase 2 text") }
    static var learnMercuryPhasePostShadowTitle: String { NSLocalizedString("learnMercury.phase.postShadow.title", value: "Post-Shadow (~2 weeks after)", comment: "Phase 3 title") }
    static var learnMercuryPhasePostShadowText: String { NSLocalizedString("learnMercury.phase.postShadow.text", value: "Mercury moves forward again but retraces the same zodiac degrees. Loose ends find resolution. Lessons from the retrograde solidify. By the time Mercury clears the shadow, the path ahead feels noticeably clearer.", comment: "Phase 3 text") }

    // Why it matters
    static var learnMercuryWhyTitle: String { NSLocalizedString("learnMercury.why.title", value: "Why It Matters", comment: "Section title: why it matters") }
    static var learnMercuryWhyIntro: String { NSLocalizedString("learnMercury.why.intro", value: "Mercury governs the wiring of daily life. When the messenger appears to stumble, the systems we rely on can feel out of sync. Understanding these patterns helps you cooperate with them rather than fight them.", comment: "Why intro") }
    static var learnMercuryWhyCommunicationTitle: String { NSLocalizedString("learnMercury.why.communication.title", value: "Communication", comment: "Why 1 title") }
    static var learnMercuryWhyCommunicationText: String { NSLocalizedString("learnMercury.why.communication.text", value: "Misreadings, missed messages, and emotional subtext spike. Re-read before sending, and confirm important information twice.", comment: "Why 1 text") }
    static var learnMercuryWhyTechnologyTitle: String { NSLocalizedString("learnMercury.why.technology.title", value: "Technology & Travel", comment: "Why 2 title") }
    static var learnMercuryWhyTechnologyText: String { NSLocalizedString("learnMercury.why.technology.text", value: "Devices act up, files vanish, and travel plans wobble. Back up important data, allow buffer time, and postpone large electronics purchases when you can.", comment: "Why 2 text") }
    static var learnMercuryWhyReflectionTitle: String { NSLocalizedString("learnMercury.why.reflection.title", value: "Reflection & Renewal", comment: "Why 3 title") }
    static var learnMercuryWhyReflectionText: String { NSLocalizedString("learnMercury.why.reflection.text", value: "Retrograde is one of the cosmos's natural pause buttons. It is an excellent time to journal, finish unfinished work, and revisit goals from a calmer place.", comment: "Why 3 text") }

    // Common myths
    static var learnMercuryMythsTitle: String { NSLocalizedString("learnMercury.myths.title", value: "Common Myths", comment: "Section title: myths") }
    static var learnMercuryMythsIntro: String { NSLocalizedString("learnMercury.myths.intro", value: "Mercury retrograde is one of the most misunderstood astrological events. A few clarifications go a long way.", comment: "Myths intro") }
    static var learnMercuryMyth1Title: String { NSLocalizedString("learnMercury.myth.1.title", value: "Myth: Nothing good can happen during retrograde", comment: "Myth 1 title") }
    static var learnMercuryMyth1Text: String { NSLocalizedString("learnMercury.myth.1.text", value: "Reality: Retrograde is excellent for anything beginning with 're-' — reconnecting, revising, returning, finishing. Life does not pause; it just rewards a different kind of attention.", comment: "Myth 1 text") }
    static var learnMercuryMyth2Title: String { NSLocalizedString("learnMercury.myth.2.title", value: "Myth: You should never sign anything", comment: "Myth 2 title") }
    static var learnMercuryMyth2Text: String { NSLocalizedString("learnMercury.myth.2.text", value: "Reality: Major irreversible commitments are best timed for after retrograde when possible. But life continues — if you must sign, read the fine print twice, and build in flexibility.", comment: "Myth 2 text") }
    static var learnMercuryMyth3Title: String { NSLocalizedString("learnMercury.myth.3.title", value: "Myth: It is the cause of every problem", comment: "Myth 3 title") }
    static var learnMercuryMyth3Text: String { NSLocalizedString("learnMercury.myth.3.text", value: "Reality: Plenty of ordinary chaos happens outside retrograde. Use the window for self-reflection, not as a scapegoat for unrelated frustrations.", comment: "Myth 3 text") }

    // MARK: - History of Mercury Retrograde
    static var historyOfMercuryTitle: String { NSLocalizedString("historyOfMercury.title", value: "History of Mercury Retrograde", comment: "Title for history view") }
    static var historyOfMercurySubtitle: String { NSLocalizedString("historyOfMercury.subtitle", value: "How astrologers have watched Mercury turn for over three thousand years.", comment: "Subtitle for history view") }
    static var historyOfMercuryIntro: String { NSLocalizedString("historyOfMercury.intro", value: "Mercury retrograde is not a modern invention. The backward dance of the swift planet has been recorded since the earliest days of astronomy, when stargazers had no choice but to watch the heavens carefully and write down what they saw. The story of how humans interpreted Mercury's apparent reversals reflects the story of astrology itself — from omens scratched on clay tablets to the psychological astrology of the twentieth century.", comment: "History intro paragraph") }

    // Ancient Roots
    static var historyOfMercuryAncientTitle: String { NSLocalizedString("historyOfMercury.ancient.title", value: "Ancient Roots", comment: "Section title: ancient roots") }
    static var historyOfMercuryAncientIntro: String { NSLocalizedString("historyOfMercury.ancient.intro", value: "The earliest astrologers were also the earliest astronomers. Long before telescopes, they tracked the seven 'wandering stars' — including Mercury — across the sky and noticed that Mercury occasionally seemed to pause, reverse, pause again, then resume its forward path.", comment: "Ancient roots intro") }
    static var historyOfMercuryBabyloniansTitle: String { NSLocalizedString("historyOfMercury.babylonians.title", value: "Babylonian Sky-Watchers", comment: "Babylonians title") }
    static var historyOfMercuryBabyloniansText: String { NSLocalizedString("historyOfMercury.babylonians.text", value: "By around 1000 BCE, Babylonian astronomer-priests were recording planetary motions on cuneiform tablets. They named Mercury 'Nabu' — the scribe of the gods — and watched closely when he changed direction, treating it as an omen requiring careful interpretation.", comment: "Babylonians text") }
    static var historyOfMercuryGreeksTitle: String { NSLocalizedString("historyOfMercury.greeks.title", value: "Greek Astronomy & Ptolemy", comment: "Greeks title") }
    static var historyOfMercuryGreeksText: String { NSLocalizedString("historyOfMercury.greeks.text", value: "Around 150 CE, Claudius Ptolemy of Alexandria compiled centuries of observations into the Almagest and the Tetrabiblos. He described Mercury's retrograde motion mathematically using epicycles — and astrologically associated it with delays, hesitation, and the need to revisit decisions.", comment: "Greeks text") }
    static var historyOfMercuryMedievalTitle: String { NSLocalizedString("historyOfMercury.medieval.title", value: "Medieval Astrology", comment: "Medieval title") }
    static var historyOfMercuryMedievalText: String { NSLocalizedString("historyOfMercury.medieval.text", value: "Through the Islamic Golden Age and into Renaissance Europe, astrologers continued to interpret Mercury retrograde as a moment for caution in contracts, messages, and journeys. Astrological almanacs from this period regularly warned readers to postpone important communications when Mercury was retrograde.", comment: "Medieval text") }

    // Modern Era
    static var historyOfMercuryModernTitle: String { NSLocalizedString("historyOfMercury.modern.title", value: "The Modern Era", comment: "Section title: modern era") }
    static var historyOfMercuryModernIntro: String { NSLocalizedString("historyOfMercury.modern.intro", value: "In the twentieth century, astrology was reshaped by psychology and then again by the internet. Both transformations changed how everyday people relate to Mercury retrograde.", comment: "Modern intro") }
    static var historyOfMercuryPsychologicalTitle: String { NSLocalizedString("historyOfMercury.psychological.title", value: "Psychological Astrology", comment: "Psychological title") }
    static var historyOfMercuryPsychologicalText: String { NSLocalizedString("historyOfMercury.psychological.text", value: "Influenced by Carl Jung and astrologers like Dane Rudhyar and Liz Greene, mid-twentieth-century astrology shifted from fate-based predictions to inner reflection. Mercury retrograde became a window for introspection — a time to listen to what the unconscious had been quietly saying.", comment: "Psychological text") }
    static var historyOfMercuryDigitalTitle: String { NSLocalizedString("historyOfMercury.digital.title", value: "The Digital Age", comment: "Digital title") }
    static var historyOfMercuryDigitalText: String { NSLocalizedString("historyOfMercury.digital.text", value: "When personal computers, smartphones, and social media became part of daily life, Mercury retrograde took on a new resonance. Frozen devices, missed messages, and software glitches gave the ancient symbolism a startlingly modern shape — and brought retrograde from astrologers' charts into mainstream conversation.", comment: "Digital text") }

    // Timeline
    static var historyOfMercuryTimelineTitle: String { NSLocalizedString("historyOfMercury.timeline.title", value: "Timeline", comment: "Section title: timeline") }
    static var historyOfMercuryTimelineEraHeader: String { NSLocalizedString("historyOfMercury.timeline.eraHeader", value: "Era", comment: "Timeline table column: era") }
    static var historyOfMercuryTimelineMilestoneHeader: String { NSLocalizedString("historyOfMercury.timeline.milestoneHeader", value: "Milestone", comment: "Timeline table column: milestone") }
    static var historyOfMercuryTimelineEra1: String { NSLocalizedString("historyOfMercury.timeline.era.1", value: "~1000 BCE", comment: "Timeline era 1") }
    static var historyOfMercuryTimelineMilestone1: String { NSLocalizedString("historyOfMercury.timeline.milestone.1", value: "Babylonian astronomer-priests track Mercury (Nabu) on cuneiform tablets and treat its retrograde motion as a meaningful omen.", comment: "Timeline milestone 1") }
    static var historyOfMercuryTimelineEra2: String { NSLocalizedString("historyOfMercury.timeline.era.2", value: "~150 CE", comment: "Timeline era 2") }
    static var historyOfMercuryTimelineMilestone2: String { NSLocalizedString("historyOfMercury.timeline.milestone.2", value: "Ptolemy formalizes retrograde motion mathematically and associates it astrologically with delays and revision.", comment: "Timeline milestone 2") }
    static var historyOfMercuryTimelineEra3: String { NSLocalizedString("historyOfMercury.timeline.era.3", value: "9th–15th c.", comment: "Timeline era 3") }
    static var historyOfMercuryTimelineMilestone3: String { NSLocalizedString("historyOfMercury.timeline.milestone.3", value: "Islamic and medieval European astrologers preserve and refine retrograde lore in handbooks and almanacs.", comment: "Timeline milestone 3") }
    static var historyOfMercuryTimelineEra4: String { NSLocalizedString("historyOfMercury.timeline.era.4", value: "20th c.", comment: "Timeline era 4") }
    static var historyOfMercuryTimelineMilestone4: String { NSLocalizedString("historyOfMercury.timeline.milestone.4", value: "Psychological astrology reframes retrograde as a window for inner reflection rather than fated misfortune.", comment: "Timeline milestone 4") }
    static var historyOfMercuryTimelineEra5: String { NSLocalizedString("historyOfMercury.timeline.era.5", value: "21st c.", comment: "Timeline era 5") }
    static var historyOfMercuryTimelineMilestone5: String { NSLocalizedString("historyOfMercury.timeline.milestone.5", value: "The digital age makes Mercury retrograde a mainstream cultural reference — glitchy phones, missed emails, and viral memes give the ancient symbolism modern life.", comment: "Timeline milestone 5") }

    // MARK: - Subscription
    static var subscriptionErrorVerification: String { NSLocalizedString("subscription.error.verification", comment: "Error message when a StoreKit transaction fails verification") }

    // MARK: - Astrology / Zodiac Signs
    // These are used by AstrologyService for zodiac sign names

    // MARK: - Widget
    static var widgetCardOfTheDayTitle: String { NSLocalizedString("widget.cardOfTheDay.title", value: "Card of the Day", comment: "Widget headline") }
    static var widgetCardOfTheDayDisplayName: String { NSLocalizedString("widget.cardOfTheDay.displayName", value: "Card of the Day", comment: "Widget picker display name") }
    static var widgetCardOfTheDayDescription: String { NSLocalizedString("widget.cardOfTheDay.description", value: "See when your daily tarot card is ready to be revealed.", comment: "Widget picker description") }
    static var widgetCardOfTheDayTapToReveal: String { NSLocalizedString("widget.cardOfTheDay.tapToReveal", value: "Tap to reveal today's card", comment: "Widget hint shown before user reveals the card") }
    static var widgetCardOfTheDayAwaiting: String { NSLocalizedString("widget.cardOfTheDay.awaiting", value: "Your card awaits", comment: "Short hint on the small widget") }
    static var widgetCardOfTheDayInlineAwaiting: String { NSLocalizedString("widget.cardOfTheDay.inlineAwaiting", value: "Reveal today's card", comment: "Very short hint on the inline lock-screen accessory") }
    static var widgetCardOfTheDayTodaysEnergy: String { NSLocalizedString("widget.cardOfTheDay.todaysEnergy", value: "Today's energy", comment: "Label above the revealed card name") }
    static var widgetCardOfTheDayReversed: String { NSLocalizedString("widget.cardOfTheDay.reversed", value: "reversed", comment: "Suffix for reversed cards") }
}
