//
//  TarotInterpretations.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import Foundation

struct TarotInterpretations {
    
    // Main interpretations for each card, category, and orientation
    static let interpretations: [String: String] = [
        // The Fool - Love
        "the_fool_love_upright": "A new romance is on the horizon, filled with excitement and spontaneity. You're being called to take a leap of faith in matters of the heart. Don't overthink it—follow your instincts and embrace the adventure that awaits. This is a time to be open, authentic, and fearless in love.",
        "the_fool_love_reversed": "You may be rushing into something without thinking it through. There's a naivety here that could lead to heartache. Take a step back and ask yourself if you're being realistic about this connection. Don't ignore red flags in favor of excitement.",
        
        // The Fool - Career
        "the_fool_career_upright": "A fresh start is coming your way—perhaps a new job, project, or entrepreneurial venture. This card tells you to trust your vision and take that risk you've been considering. The universe supports bold moves right now. Stay curious and open to learning.",
        "the_fool_career_reversed": "You're hesitating when you should be moving forward, or perhaps you're being reckless without a plan. Find the balance between courage and preparation. Don't let fear hold you back, but don't jump without looking either.",
        
        // The Fool - Finance
        "the_fool_finance_upright": "New financial opportunities are emerging. This could be an investment, a side hustle, or a completely new income stream. Trust your instincts, but do your homework. Fortune favors the brave, but the prepared brave do even better.",
        "the_fool_finance_reversed": "Careless spending or poor financial planning could be your downfall right now. Don't make impulsive purchases or investments. You need a solid plan before you leap. Seek advice from someone more experienced.",
        
        // The Fool - Health
        "the_fool_health_upright": "This is the perfect time to start a new health journey. Whether it's a fitness routine, dietary change, or wellness practice, the energy supports new beginnings. Approach it with enthusiasm and an open mind. Your body is ready for positive change.",
        "the_fool_health_reversed": "You might be ignoring warning signs or taking unnecessary risks with your health. Slow down and listen to what your body is telling you. Recklessness now could lead to problems later. Seek professional guidance if needed.",
        
        // The Fool - General
        "the_fool_general_upright": "You're standing at the edge of something new and wonderful. This card invites you to take a leap of faith, to trust in the journey ahead even if you can't see the whole path. Embrace uncertainty with an open heart. The universe has your back.",
        "the_fool_general_reversed": "Fear or foolishness is holding you back. Either you're too scared to move forward, or you're being reckless without thinking things through. Find your center. What does wise courage look like in this situation?",
        
        // The Magician - Love
        "the_magician_love_upright": "You have all the tools you need to manifest the love you desire. If you're single, your magnetic energy is strong—put yourself out there. If you're partnered, this is a time to actively create the relationship you want through clear communication and intention.",
        "the_magician_love_reversed": "Manipulation or deception may be at play, either from you or your partner. Are you being honest about what you want? Is someone using charm to mislead you? Trust your gut if something feels off.",
        
        // The Magician - Career
        "the_magician_career_upright": "You're in a powerful position to manifest your career goals. You have the skills, resources, and opportunities right in front of you. This is your moment to take action with confidence. Communicate your vision clearly and watch it come to life.",
        "the_magician_career_reversed": "You're not using your full potential, or you're being manipulative to get ahead. Are you underestimating yourself? Or are you trying to trick others? Neither path leads to lasting success. Be authentic and own your power.",
        
        // The Magician - Finance
        "the_magician_finance_upright": "Financial manifestation is within your reach. You have the resources and knowledge to create wealth—now it's about taking strategic action. This is an excellent time for negotiations, investments, or launching financial ventures.",
        "the_magician_finance_reversed": "Trickery or poor planning could undermine your financial goals. Don't cut corners or try to manipulate the system. Also watch for scams or too-good-to-be-true offers. Stay grounded in reality.",
        
        // The Magician - Health
        "the_magician_health_upright": "You have the power to transform your health. Mind over matter is especially strong now. Whether through visualization, intention-setting, or disciplined action, you can manifest real improvements in your wellbeing.",
        "the_magician_health_reversed": "You might be deceiving yourself about your health or trying quick fixes instead of real solutions. Face the truth of your situation. Real healing requires honesty and sustained effort.",
        
        // The Magician - General
        "the_magician_general_upright": "This is your time to shine. You have everything you need to manifest your desires—the only thing missing is action. Channel your will with clarity and purpose. As above, so below. What you focus on, you create.",
        "the_magician_general_reversed": "Untapped potential or manipulation is the theme. Either you're not using your gifts, or you're using them in ways that don't serve your highest good. Redirect your energy toward authentic creation.",
        
        // The High Priestess - Love
        "the_high_priestess_love_upright": "Trust your intuition in matters of love right now. What is your inner voice telling you? There may be secrets or unspoken feelings beneath the surface. Pay attention to what's not being said. Your psychic senses are heightened.",
        "the_high_priestess_love_reversed": "You're ignoring your intuition, or secrets are creating distance in a relationship. What are you not willing to see? What's being hidden? It's time to look deeper and trust what you feel, even if you can't prove it.",
        
        // The High Priestess - Career
        "the_high_priestess_career_upright": "Listen to your gut instincts about your career path. The answer you seek won't come from external advice—it's already within you. This is also a time for quiet observation. Pay attention to what's happening behind the scenes.",
        "the_high_priestess_career_reversed": "You're disconnected from your inner knowing, or there's workplace secrecy affecting you. Trust has been broken, or information is being withheld. Reconnect with your intuition to navigate this situation.",
        
        // The High Priestess - Finance
        "the_high_priestess_finance_upright": "Hidden financial opportunities or information may come to light. Trust your instincts about investments and financial decisions. Do your research, but also honor that gut feeling. Wisdom comes from within.",
        "the_high_priestess_finance_reversed": "Financial secrets or intuition being ignored could lead to problems. Are you hiding spending from yourself or others? Are you ignoring warning signs? Bring things into the light.",
        
        // The High Priestess - Health
        "the_high_priestess_health_upright": "Your body is trying to tell you something. Listen to subtle signals and honor your need for rest and introspection. Holistic or intuitive healing modalities may be particularly beneficial now. Trust your body's wisdom.",
        "the_high_priestess_health_reversed": "You're ignoring symptoms or disconnected from your body's messages. Repressed emotions may be manifesting physically. It's time to tune in and address what you've been avoiding.",
        
        // The High Priestess - General
        "the_high_priestess_general_upright": "The answers you seek lie within. This is a time for stillness, meditation, and deep inner listening. Trust your intuition even when logic can't explain it. The mysteries will reveal themselves when the time is right.",
        "the_high_priestess_general_reversed": "You're cut off from your inner wisdom, or secrets are causing harm. Reconnect with your intuitive self. What truth have you been afraid to acknowledge? It's time to face it.",
        
        // Add more cards... (Due to space, I'll add a few key cards and a pattern you can follow)
        
        // The Lovers - Love
        "the_lovers_love_upright": "This is the card of deep, authentic connection. You're being called to make an important choice in love from a place of alignment with your values. True partnership requires vulnerability and honesty. Are you ready to show up fully?",
        "the_lovers_love_reversed": "Misalignment, disharmony, or difficult choices plague your love life. Values may clash, or you're settling for less than you deserve. Don't ignore these incompatibilities—they matter more than you think.",
        
        // The Lovers - General
        "the_lovers_general_upright": "A significant choice stands before you. Choose from your heart and your values, not from fear or obligation. This decision will shape your path forward. What does alignment feel like in your body?",
        "the_lovers_general_reversed": "Inner conflict or poor choices are creating disharmony. You may be at odds with yourself or making decisions that don't reflect your true values. Realign with what matters most to you.",
        
        // Death - Love
        "death_love_upright": "A profound transformation is occurring in your love life. This could mean the end of a relationship, or the death of old patterns within one. Grieve what's ending, but know that something more authentic is being born.",
        "death_love_reversed": "You're resisting necessary change in your relationships. Holding on to what's already dead will only prolong the pain. Let go. Transformation is trying to happen, but you're fighting it.",
        
        // Death - General
        "death_general_upright": "An ending is here, and with it, a powerful transformation. Don't resist this change—it's making room for your rebirth. What must die so that you can truly live? Embrace the transition.",
        "death_general_reversed": "You're clinging to what needs to end. Fear of change is keeping you stuck in a stagnant situation. The death card reversed is about resisting the natural cycles of life. Let go and trust the process.",
        
        // The Tower - Love
        "the_tower_love_upright": "Sudden upheaval is shaking your relationship or romantic life. Foundations you thought were solid are crumbling. This is painful but necessary—false structures must fall so truth can emerge. What's being revealed?",
        "the_tower_love_reversed": "You're barely avoiding disaster, or delaying inevitable upheaval. The tower moment is coming whether you're ready or not. Instead of fearing it, prepare for the truth that's about to surface.",
        
        // The Tower - General
        "the_tower_general_upright": "Sudden, disruptive change is shattering your world. Everything you thought was stable is being shaken. This is the universe's way of breaking down false structures. In the rubble, you'll find truth. Chaos precedes clarity.",
        "the_tower_general_reversed": "You're resisting necessary upheaval, or narrowly avoiding catastrophe. You can't prevent the tower moment forever—it's coming to liberate you from illusions. Brace yourself and look for the gift in the destruction.",
        
        // The Sun - Love
        "the_sun_love_upright": "Pure joy, warmth, and celebration shine on your love life. If you're single, your radiance is attracting wonderful connections. If partnered, you're experiencing a beautiful period of harmony and happiness. Bask in this beautiful energy.",
        "the_sun_love_reversed": "Temporary clouds are dimming your romantic happiness. Pessimism or unrealistic expectations may be blocking joy. Remember that this is temporary. The sun always returns. Adjust your perspective.",
        
        // The Sun - General
        "the_sun_general_upright": "Success, joy, and vitality are yours. This is one of the most positive cards in the deck. Whatever you're working on is blessed with the universe's favor. Celebrate your wins and share your light with others.",
        "the_sun_general_reversed": "Your inner light is temporarily dimmed by sadness, pessimism, or setbacks. This doesn't last forever. What small joy can you connect with today? The sun is still there, even behind the clouds."
    ]
    
    // Alternative interpretations based on resonance level
    static let alternativeInterpretations: [String: String] = [
        // The Fool - Love - Alternative angles
        "the_fool_love_upright_unclear": "Perhaps the message here isn't about a new romance, but about approaching your current situation with fresh eyes. What if you could release expectations and just be present with what is? Sometimes 'the fool' energy is about innocent curiosity rather than action.",
        "the_fool_love_upright_not_resonating": "Let me offer another perspective: This card might be highlighting where you're being too cautious in love. The fool asks: what would you do if you couldn't fail? That question itself might be the guidance you need right now.",
        
        "the_magician_love_upright_unclear": "Another way to see this: You might be giving your power away in relationships. The Magician reversed in love can mean you're not recognizing your own worth. You have everything you need to create the love you desire—do you believe that?",
        "the_magician_love_upright_not_resonating": "Here's a different angle: Perhaps this card is asking you to examine if you're being authentic in love, or if you're performing a version of yourself. True magic in relationships comes from showing up as you really are.",
        
        // Add more alternative interpretations as needed
    ]
    
    // Spread summaries - contextual interpretations that tie multiple cards together
    static func spreadSummary(for cards: [DrawnCard], category: IntentionCategory, spreadType: SpreadType) -> String {
        let majorArcanaCount = cards.filter { $0.card.suit == .majorArcana }.count
        let reversedCount = cards.filter { $0.isReversed }.count
        let suitCounts = cards.reduce(into: [TarotSuit: Int]()) { counts, drawnCard in
            counts[drawnCard.card.suit, default: 0] += 1
        }
        
        var summary = ""
        
        // Opening based on Major Arcana presence
        if majorArcanaCount >= cards.count / 2 {
            summary += "This reading carries significant weight. With \(majorArcanaCount) Major Arcana cards, you're dealing with major life themes and important soul lessons. "
        }
        
        // Reversed cards insight
        if reversedCount > cards.count / 2 {
            summary += "I notice many reversed cards here, which suggests internal blocks or resistance to the natural flow. What are you holding onto that needs to be released? "
        }
        
        // Suit dominance
        if let dominantSuit = suitCounts.max(by: { $0.value < $1.value })?.key, 
           let count = suitCounts[dominantSuit], count > 2 {
            switch dominantSuit {
            case .cups:
                summary += "Your reading is dominated by Cups, the suit of emotions and relationships. Your heart is speaking loudly right now. "
            case .swords:
                summary += "Swords dominate this reading—there's a lot of mental energy here. You're processing, analyzing, perhaps overthinking. Your mind is very active. "
            case .wands:
                summary += "Wands appear frequently here, bringing fire and passion to your situation. There's creative energy and drive, but also potential for burnout. "
            case .pentacles:
                summary += "Pentacles ground this reading in the material world. This is about tangible results, physical reality, and practical matters. "
            case .majorArcana:
                summary += "The Major Arcana dominates, meaning this is about your soul's journey more than day-to-day concerns. "
            }
        }
        
        // Category-specific insights
        switch category {
        case .love:
            summary += "In matters of love, "
        case .career:
            summary += "Regarding your career path, "
        case .finance:
            summary += "When it comes to your finances, "
        case .health:
            summary += "For your health and wellbeing, "
        case .general:
            summary += "Looking at your life as a whole, "
        }
        
        summary += "these cards are telling a story that requires your attention and honest reflection."
        
        return summary
    }
}
