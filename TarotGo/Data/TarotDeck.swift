//
//  TarotDeck.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

struct TarotDeck {
    static let allCards: [TarotCard] = majorArcana + minorArcana
    
    static let majorArcana: [TarotCard] = [
        TarotCard(
            id: "the_fool",
            name: "The Fool",
            suit: .majorArcana,
            arcanaNumber: 0,
            keywords: ["New beginnings", "Innocence", "Adventure", "Freedom"],
            reversedKeywords: ["Recklessness", "Naivety", "Poor judgment", "Folly"]
        ),
        TarotCard(
            id: "the_magician",
            name: "The Magician",
            suit: .majorArcana,
            arcanaNumber: 1,
            keywords: ["Manifestation", "Power", "Skill", "Resourcefulness"],
            reversedKeywords: ["Manipulation", "Trickery", "Untapped potential", "Deceit"]
        ),
        TarotCard(
            id: "the_high_priestess",
            name: "The High Priestess",
            suit: .majorArcana,
            arcanaNumber: 2,
            keywords: ["Intuition", "Mystery", "Inner wisdom", "Divine feminine"],
            reversedKeywords: ["Secrets", "Disconnection", "Repressed feelings", "Silence"]
        ),
        TarotCard(
            id: "the_empress",
            name: "The Empress",
            suit: .majorArcana,
            arcanaNumber: 3,
            keywords: ["Abundance", "Nurturing", "Fertility", "Nature"],
            reversedKeywords: ["Neglect", "Smothering", "Creative block", "Dependence"]
        ),
        TarotCard(
            id: "the_emperor",
            name: "The Emperor",
            suit: .majorArcana,
            arcanaNumber: 4,
            keywords: ["Authority", "Structure", "Control", "Leadership"],
            reversedKeywords: ["Tyranny", "Rigidity", "Domination", "Inflexibility"]
        ),
        TarotCard(
            id: "the_hierophant",
            name: "The Hierophant",
            suit: .majorArcana,
            arcanaNumber: 5,
            keywords: ["Tradition", "Conformity", "Education", "Beliefs"],
            reversedKeywords: ["Rebellion", "Unconventional", "Personal beliefs", "Freedom"]
        ),
        TarotCard(
            id: "the_lovers",
            name: "The Lovers",
            suit: .majorArcana,
            arcanaNumber: 6,
            keywords: ["Love", "Harmony", "Partnerships", "Choices"],
            reversedKeywords: ["Disharmony", "Imbalance", "Misalignment", "Conflict"]
        ),
        TarotCard(
            id: "the_chariot",
            name: "The Chariot",
            suit: .majorArcana,
            arcanaNumber: 7,
            keywords: ["Willpower", "Determination", "Success", "Control"],
            reversedKeywords: ["Lack of direction", "Opposition", "Aggression", "Obstacles"]
        ),
        TarotCard(
            id: "strength",
            name: "Strength",
            suit: .majorArcana,
            arcanaNumber: 8,
            keywords: ["Courage", "Inner strength", "Compassion", "Confidence"],
            reversedKeywords: ["Self-doubt", "Weakness", "Insecurity", "Low confidence"]
        ),
        TarotCard(
            id: "the_hermit",
            name: "The Hermit",
            suit: .majorArcana,
            arcanaNumber: 9,
            keywords: ["Introspection", "Soul searching", "Guidance", "Solitude"],
            reversedKeywords: ["Isolation", "Loneliness", "Withdrawal", "Paranoia"]
        ),
        TarotCard(
            id: "wheel_of_fortune",
            name: "Wheel of Fortune",
            suit: .majorArcana,
            arcanaNumber: 10,
            keywords: ["Destiny", "Change", "Cycles", "Good fortune"],
            reversedKeywords: ["Bad luck", "Resistance to change", "Breaking cycles", "Setbacks"]
        ),
        TarotCard(
            id: "justice",
            name: "Justice",
            suit: .majorArcana,
            arcanaNumber: 11,
            keywords: ["Fairness", "Truth", "Law", "Accountability"],
            reversedKeywords: ["Injustice", "Dishonesty", "Unfairness", "Lack of accountability"]
        ),
        TarotCard(
            id: "the_hanged_man",
            name: "The Hanged Man",
            suit: .majorArcana,
            arcanaNumber: 12,
            keywords: ["Surrender", "New perspective", "Pause", "Letting go"],
            reversedKeywords: ["Stalling", "Resistance", "Indecision", "Delays"]
        ),
        TarotCard(
            id: "death",
            name: "Death",
            suit: .majorArcana,
            arcanaNumber: 13,
            keywords: ["Transformation", "Endings", "Change", "Transition"],
            reversedKeywords: ["Resistance to change", "Stagnation", "Fear of change", "Decay"]
        ),
        TarotCard(
            id: "temperance",
            name: "Temperance",
            suit: .majorArcana,
            arcanaNumber: 14,
            keywords: ["Balance", "Moderation", "Patience", "Harmony"],
            reversedKeywords: ["Imbalance", "Excess", "Lack of harmony", "Extremes"]
        ),
        TarotCard(
            id: "the_devil",
            name: "The Devil",
            suit: .majorArcana,
            arcanaNumber: 15,
            keywords: ["Bondage", "Materialism", "Addiction", "Restriction"],
            reversedKeywords: ["Release", "Freedom", "Breaking chains", "Detachment"]
        ),
        TarotCard(
            id: "the_tower",
            name: "The Tower",
            suit: .majorArcana,
            arcanaNumber: 16,
            keywords: ["Upheaval", "Sudden change", "Revelation", "Chaos"],
            reversedKeywords: ["Delayed disaster", "Avoiding change", "Fear of change", "Narrow escape"]
        ),
        TarotCard(
            id: "the_star",
            name: "The Star",
            suit: .majorArcana,
            arcanaNumber: 17,
            keywords: ["Hope", "Inspiration", "Renewal", "Serenity"],
            reversedKeywords: ["Hopelessness", "Despair", "Disconnection", "Negativity"]
        ),
        TarotCard(
            id: "the_moon",
            name: "The Moon",
            suit: .majorArcana,
            arcanaNumber: 18,
            keywords: ["Illusion", "Intuition", "Anxiety", "The subconscious"],
            reversedKeywords: ["Clarity", "Release of fear", "Revelation", "Subsiding anxiety"]
        ),
        TarotCard(
            id: "the_sun",
            name: "The Sun",
            suit: .majorArcana,
            arcanaNumber: 19,
            keywords: ["Success", "Joy", "Vitality", "Positivity"],
            reversedKeywords: ["Temporary setbacks", "Sadness", "Pessimism", "Unrealistic expectations"]
        ),
        TarotCard(
            id: "judgement",
            name: "Judgement",
            suit: .majorArcana,
            arcanaNumber: 20,
            keywords: ["Reflection", "Reckoning", "Awakening", "Rebirth"],
            reversedKeywords: ["Self-doubt", "Lack of self-awareness", "Refusal to learn", "Self-loathing"]
        ),
        TarotCard(
            id: "the_world",
            name: "The World",
            suit: .majorArcana,
            arcanaNumber: 21,
            keywords: ["Completion", "Achievement", "Fulfillment", "Travel"],
            reversedKeywords: ["Incompletion", "Shortcuts", "Delays", "Lack of closure"]
        )
    ]
    
    static let minorArcana: [TarotCard] = cupsCards + pentaclesCards + swordsCards + wandsCards
    
    static let cupsCards: [TarotCard] = [
        TarotCard(id: "ace_of_cups", name: "Ace of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["New love", "Emotional awakening", "Joy", "Spiritual connection"],
                  reversedKeywords: ["Emotional loss", "Blocked creativity", "Emptiness", "Sadness"]),
        TarotCard(id: "two_of_cups", name: "Two of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Partnership", "Unity", "Connection", "Attraction"],
                  reversedKeywords: ["Disconnection", "Imbalance", "Tension", "Breakup"]),
        TarotCard(id: "three_of_cups", name: "Three of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Celebration", "Friendship", "Community", "Joy"],
                  reversedKeywords: ["Isolation", "Overindulgence", "Gossip", "Loneliness"]),
        TarotCard(id: "four_of_cups", name: "Four of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Meditation", "Contemplation", "Apathy", "Reevaluation"],
                  reversedKeywords: ["Awareness", "New perspectives", "Acceptance", "Motivation"]),
        TarotCard(id: "five_of_cups", name: "Five of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Loss", "Grief", "Disappointment", "Regret"],
                  reversedKeywords: ["Acceptance", "Moving on", "Finding peace", "Forgiveness"]),
        TarotCard(id: "six_of_cups", name: "Six of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Nostalgia", "Memories", "Innocence", "Reunion"],
                  reversedKeywords: ["Living in the past", "Unrealistic expectations", "Stuck", "Naivety"]),
        TarotCard(id: "seven_of_cups", name: "Seven of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Choices", "Illusion", "Fantasy", "Wishful thinking"],
                  reversedKeywords: ["Clarity", "Reality check", "Decisions", "Sobriety"]),
        TarotCard(id: "eight_of_cups", name: "Eight of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Walking away", "Seeking truth", "Letting go", "Journey"],
                  reversedKeywords: ["Avoidance", "Fear of change", "Staying in bad situation", "Stagnation"]),
        TarotCard(id: "nine_of_cups", name: "Nine of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Satisfaction", "Wishes fulfilled", "Contentment", "Luxury"],
                  reversedKeywords: ["Greed", "Dissatisfaction", "Materialism", "Unfulfilled wishes"]),
        TarotCard(id: "ten_of_cups", name: "Ten of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Harmony", "Family", "Alignment", "Happiness"],
                  reversedKeywords: ["Disconnection", "Family conflict", "Broken relationships", "Disharmony"]),
        TarotCard(id: "page_of_cups", name: "Page of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Creative opportunity", "Messages", "Curiosity", "Intuition"],
                  reversedKeywords: ["Emotional immaturity", "Creative blocks", "Escapism", "Bad news"]),
        TarotCard(id: "knight_of_cups", name: "Knight of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Romance", "Charm", "Imagination", "Following your heart"],
                  reversedKeywords: ["Moodiness", "Unrealistic", "Jealousy", "Overemotional"]),
        TarotCard(id: "queen_of_cups", name: "Queen of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Compassion", "Intuition", "Emotional security", "Caring"],
                  reversedKeywords: ["Insecurity", "Codependency", "Martyrdom", "Overwhelmed"]),
        TarotCard(id: "king_of_cups", name: "King of Cups", suit: .cups, arcanaNumber: nil,
                  keywords: ["Emotional balance", "Diplomacy", "Compassion", "Control"],
                  reversedKeywords: ["Emotional manipulation", "Coldness", "Volatility", "Repression"])
    ]
    
    static let pentaclesCards: [TarotCard] = [
        TarotCard(id: "ace_of_pentacles", name: "Ace of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["New opportunity", "Prosperity", "Manifestation", "Abundance"],
                  reversedKeywords: ["Lost opportunity", "Scarcity", "Poor planning", "Greed"]),
        TarotCard(id: "two_of_pentacles", name: "Two of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Balance", "Adaptability", "Juggling priorities", "Flexibility"],
                  reversedKeywords: ["Imbalance", "Overwhelmed", "Disorganization", "Stress"]),
        TarotCard(id: "three_of_pentacles", name: "Three of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Teamwork", "Collaboration", "Skills", "Quality"],
                  reversedKeywords: ["Lack of teamwork", "Disorganization", "Poor quality", "Conflict"]),
        TarotCard(id: "four_of_pentacles", name: "Four of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Security", "Conservation", "Control", "Stability"],
                  reversedKeywords: ["Greed", "Materialism", "Holding on too tight", "Possessiveness"]),
        TarotCard(id: "five_of_pentacles", name: "Five of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Financial loss", "Hardship", "Isolation", "Struggle"],
                  reversedKeywords: ["Recovery", "Renewed hope", "Improvement", "Charity"]),
        TarotCard(id: "six_of_pentacles", name: "Six of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Generosity", "Charity", "Sharing", "Prosperity"],
                  reversedKeywords: ["Selfishness", "Strings attached", "Debt", "One-sided"]),
        TarotCard(id: "seven_of_pentacles", name: "Seven of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Patience", "Investment", "Long-term view", "Perseverance"],
                  reversedKeywords: ["Impatience", "Lack of progress", "Wasted effort", "Disappointment"]),
        TarotCard(id: "eight_of_pentacles", name: "Eight of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Skill development", "Diligence", "Craftsmanship", "Detail"],
                  reversedKeywords: ["Lack of focus", "Mediocrity", "Shortcuts", "Perfectionism"]),
        TarotCard(id: "nine_of_pentacles", name: "Nine of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Independence", "Luxury", "Self-sufficiency", "Accomplishment"],
                  reversedKeywords: ["Overworking", "Hustling", "Living beyond means", "Dependence"]),
        TarotCard(id: "ten_of_pentacles", name: "Ten of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Wealth", "Legacy", "Family", "Establishment"],
                  reversedKeywords: ["Financial failure", "Family disputes", "Instability", "Debt"]),
        TarotCard(id: "page_of_pentacles", name: "Page of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Opportunity", "New venture", "Ambition", "Manifestation"],
                  reversedKeywords: ["Procrastination", "Lack of progress", "Poor planning", "Missed opportunity"]),
        TarotCard(id: "knight_of_pentacles", name: "Knight of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Reliability", "Hard work", "Routine", "Conservatism"],
                  reversedKeywords: ["Laziness", "Obsessiveness", "Work-life imbalance", "Perfectionism"]),
        TarotCard(id: "queen_of_pentacles", name: "Queen of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Nurturing", "Practical", "Providing", "Down-to-earth"],
                  reversedKeywords: ["Self-care neglect", "Work-home imbalance", "Smothering", "Jealousy"]),
        TarotCard(id: "king_of_pentacles", name: "King of Pentacles", suit: .pentacles, arcanaNumber: nil,
                  keywords: ["Abundance", "Security", "Leadership", "Discipline"],
                  reversedKeywords: ["Greed", "Materialism", "Corruption", "Stubborn"])
    ]
    
    static let swordsCards: [TarotCard] = [
        TarotCard(id: "ace_of_swords", name: "Ace of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Breakthrough", "Clarity", "New ideas", "Mental clarity"],
                  reversedKeywords: ["Confusion", "Chaos", "Lack of clarity", "Miscommunication"]),
        TarotCard(id: "two_of_swords", name: "Two of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Difficult decisions", "Stalemate", "Avoidance", "Denial"],
                  reversedKeywords: ["Indecision", "Confusion", "Delayed decisions", "Overwhelming choices"]),
        TarotCard(id: "three_of_swords", name: "Three of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Heartbreak", "Sorrow", "Pain", "Grief"],
                  reversedKeywords: ["Recovery", "Forgiveness", "Moving on", "Healing"]),
        TarotCard(id: "four_of_swords", name: "Four of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Rest", "Recovery", "Contemplation", "Meditation"],
                  reversedKeywords: ["Restlessness", "Burnout", "Stress", "Lack of progress"]),
        TarotCard(id: "five_of_swords", name: "Five of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Conflict", "Defeat", "Win at all costs", "Betrayal"],
                  reversedKeywords: ["Reconciliation", "Making amends", "Moving on", "Compromise"]),
        TarotCard(id: "six_of_swords", name: "Six of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Transition", "Moving forward", "Healing journey", "Release"],
                  reversedKeywords: ["Stuck in past", "Resistance", "Unfinished business", "Rough waters"]),
        TarotCard(id: "seven_of_swords", name: "Seven of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Deception", "Strategy", "Sneakiness", "Getting away"],
                  reversedKeywords: ["Coming clean", "Confessing", "Honesty", "Rethinking approach"]),
        TarotCard(id: "eight_of_swords", name: "Eight of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Restriction", "Imprisonment", "Victim mentality", "Helplessness"],
                  reversedKeywords: ["Release", "Freedom", "New perspective", "Self-acceptance"]),
        TarotCard(id: "nine_of_swords", name: "Nine of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Anxiety", "Worry", "Nightmares", "Fear"],
                  reversedKeywords: ["Hope", "Reaching out", "Despair subsiding", "Recovery"]),
        TarotCard(id: "ten_of_swords", name: "Ten of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Rock bottom", "Painful ending", "Betrayal", "Crisis"],
                  reversedKeywords: ["Recovery", "Regeneration", "Resisting end", "Delayed disaster"]),
        TarotCard(id: "page_of_swords", name: "Page of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Curiosity", "Mental agility", "Vigilance", "Communication"],
                  reversedKeywords: ["Gossiping", "Hastiness", "Scattered thoughts", "Cynicism"]),
        TarotCard(id: "knight_of_swords", name: "Knight of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Action", "Ambition", "Fast thinking", "Driven"],
                  reversedKeywords: ["Recklessness", "Impatience", "Unfocused", "Impulsiveness"]),
        TarotCard(id: "queen_of_swords", name: "Queen of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Independence", "Clear thinking", "Honest", "Direct"],
                  reversedKeywords: ["Coldness", "Cruelty", "Bitterness", "Isolation"]),
        TarotCard(id: "king_of_swords", name: "King of Swords", suit: .swords, arcanaNumber: nil,
                  keywords: ["Authority", "Truth", "Intellectual power", "Clear mind"],
                  reversedKeywords: ["Manipulation", "Abuse of power", "Tyranny", "Cruelty"])
    ]
    
    static let wandsCards: [TarotCard] = [
        TarotCard(id: "ace_of_wands", name: "Ace of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Inspiration", "New opportunities", "Growth", "Potential"],
                  reversedKeywords: ["Delays", "Lack of direction", "Missed opportunities", "Setbacks"]),
        TarotCard(id: "two_of_wands", name: "Two of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Planning", "Future vision", "Progress", "Decisions"],
                  reversedKeywords: ["Fear of unknown", "Lack of planning", "Playing safe", "Bad planning"]),
        TarotCard(id: "three_of_wands", name: "Three of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Expansion", "Foresight", "Overseas", "Leadership"],
                  reversedKeywords: ["Delays", "Obstacles", "Lack of foresight", "Frustration"]),
        TarotCard(id: "four_of_wands", name: "Four of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Celebration", "Harmony", "Home", "Milestone"],
                  reversedKeywords: ["Instability", "Lack of support", "Transition", "Home conflict"]),
        TarotCard(id: "five_of_wands", name: "Five of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Competition", "Conflict", "Tension", "Diversity"],
                  reversedKeywords: ["Avoiding conflict", "Resolution", "Cooperation", "Agreement"]),
        TarotCard(id: "six_of_wands", name: "Six of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Success", "Recognition", "Victory", "Achievement"],
                  reversedKeywords: ["Failure", "Lack of recognition", "Arrogance", "Egotism"]),
        TarotCard(id: "seven_of_wands", name: "Seven of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Defense", "Perseverance", "Maintaining control", "Challenge"],
                  reversedKeywords: ["Exhaustion", "Giving up", "Overwhelmed", "Losing ground"]),
        TarotCard(id: "eight_of_wands", name: "Eight of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Speed", "Action", "Air travel", "Movement"],
                  reversedKeywords: ["Delays", "Frustration", "Resisting change", "Internal alignment"]),
        TarotCard(id: "nine_of_wands", name: "Nine of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Resilience", "Persistence", "Last stand", "Boundaries"],
                  reversedKeywords: ["Exhaustion", "Paranoia", "Struggling on", "Refusing help"]),
        TarotCard(id: "ten_of_wands", name: "Ten of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Burden", "Responsibility", "Hard work", "Stress"],
                  reversedKeywords: ["Release", "Delegation", "Letting go", "Lightening load"]),
        TarotCard(id: "page_of_wands", name: "Page of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Enthusiasm", "Exploration", "Discovery", "Free spirit"],
                  reversedKeywords: ["Lack of direction", "Procrastination", "Setbacks", "Hasty decisions"]),
        TarotCard(id: "knight_of_wands", name: "Knight of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Energy", "Passion", "Adventure", "Impulsiveness"],
                  reversedKeywords: ["Recklessness", "Haste", "Frustration", "Passive"]),
        TarotCard(id: "queen_of_wands", name: "Queen of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Confidence", "Determination", "Vibrancy", "Social"],
                  reversedKeywords: ["Selfishness", "Jealousy", "Insecurity", "Temperamental"]),
        TarotCard(id: "king_of_wands", name: "King of Wands", suit: .wands, arcanaNumber: nil,
                  keywords: ["Leadership", "Vision", "Entrepreneur", "Honor"],
                  reversedKeywords: ["Impulsiveness", "Tyranny", "Arrogance", "Ruthlessness"])
    ]
}
