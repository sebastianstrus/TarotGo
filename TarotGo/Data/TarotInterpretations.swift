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
        
        // The Lovers - Career
        "the_lovers_career_upright": "An important professional choice is before you. This decision should align with your core values and long-term vision. Don't choose based on money alone—choose what feels right in your soul.",
        "the_lovers_career_reversed": "Career decisions feel misaligned with your values. You might be settling or compromising too much. Examine if your work reflects who you truly are.",
        
        // The Lovers - Finance
        "the_lovers_finance_upright": "Financial decisions require value alignment. Make choices that honor both your practical needs and your ethical standards. Partnership opportunities may be favorable.",
        "the_lovers_finance_reversed": "Financial values conflict or partnerships are unbalanced. Someone's priorities don't match yours. Reassess shared resources and agreements.",
        
        // The Lovers - Health
        "the_lovers_health_upright": "Mind-body-spirit alignment is key to your wellbeing now. Choose health practices that resonate with your whole self. Partnership in your health journey may be beneficial.",
        "the_lovers_health_reversed": "Internal conflict affects your health. Your choices may not align with your body's needs. Listen more deeply to what truly nourishes you.",
        
        // The Lovers - General
        "the_lovers_general_upright": "A significant choice stands before you. Choose from your heart and your values, not from fear or obligation. This decision will shape your path forward. What does alignment feel like in your body?",
        "the_lovers_general_reversed": "Inner conflict or poor choices are creating disharmony. You may be at odds with yourself or making decisions that don't reflect your true values. Realign with what matters most to you.",
        
        // The Empress - Love
        "the_empress_love_upright": "Abundant love and nurturing energy flow through your relationships. This is a fertile time for romance—either new love or deepening existing bonds. Embrace your sensual, creative side.",
        "the_empress_love_reversed": "You're neglecting yourself or others in relationships. Creative or sexual energy feels blocked. Are you smothering or being smothered? Find balance in giving and receiving.",
        
        // The Empress - Career
        "the_empress_career_upright": "Creative projects flourish now. Your nurturing leadership style creates abundance. This is an excellent time for growth, collaboration, and bringing ideas to fruition.",
        "the_empress_career_reversed": "Creative blocks or lack of growth in your career. You might be neglecting your projects or feeling stifled. Reconnect with what makes your work fulfilling.",
        
        // The Empress - Finance
        "the_empress_finance_upright": "Financial abundance and growth are available. Your investments and efforts bear fruit. This is a fertile time for creating wealth through creative or nurturing endeavors.",
        "the_empress_finance_reversed": "Financial neglect or overspending on comfort items. Resources may be blocked. Review your relationship with material abundance and self-worth.",
        
        // The Empress - Health
        "the_empress_health_upright": "Your body is in a fertile, creative phase. Excellent time for nurturing health practices, gentle movement, and connecting with nature. Listen to your body's wisdom.",
        "the_empress_health_reversed": "Neglecting self-care or overindulging. Your body needs more attention and nurturing. Don't ignore physical or emotional needs.",
        
        // The Empress - General
        "the_empress_general_upright": "Abundance, creativity, and nurturing energy surround you. This is a time of growth and manifestation. Connect with nature and your sensual self. Beauty and fertility in all forms.",
        "the_empress_general_reversed": "Creative blocks, neglect, or dependency issues arise. You may be smothering or being smothered. Reclaim your creative power and learn healthy nurturing.",
        
        // The Emperor - Love
        "the_emperor_love_upright": "Structure and commitment strengthen relationships. Clear boundaries and leadership create security. This is about building something stable and lasting in love.",
        "the_emperor_love_reversed": "Control issues or rigidity strain relationships. Someone's being too domineering or inflexible. Soften your approach and allow more flexibility.",
        
        // The Emperor - Career
        "the_emperor_career_upright": "Leadership opportunities arise. Your ability to create structure and take charge serves you well. This is your time to build something enduring and take authority.",
        "the_emperor_career_reversed": "Tyrannical leadership or excessive rigidity at work. You might be too controlling or facing an inflexible boss. Find balance between structure and adaptability.",
        
        // The Emperor - Finance
        "the_emperor_finance_upright": "Strong financial structure and discipline create security. Strategic planning and leadership in managing resources bring success. Build your empire wisely.",
        "the_emperor_finance_reversed": "Financial control issues or rigid thinking limit growth. Excessive control or lack of flexibility with money. Loosen your grip while maintaining structure.",
        
        // The Emperor - Health
        "the_emperor_health_upright": "Disciplined health routines bring results. Structure and consistency in wellness practices serve you well. Take charge of your health with authority.",
        "the_emperor_health_reversed": "Overly rigid health approaches or ignoring your body's needs. Control issues around diet or exercise. Find balance between discipline and self-compassion.",
        
        // The Emperor - General
        "the_emperor_general_upright": "Structure, authority, and leadership define this moment. Take charge of your life with confidence. Build solid foundations. Set clear boundaries and honor them.",
        "the_emperor_general_reversed": "Control issues, tyranny, or excessive rigidity block progress. Are you being too domineering or facing someone who is? Soften while maintaining strength.",
        
        // The Hierophant - Love
        "the_hierophant_love_upright": "Traditional relationship values and commitments may be important now. Marriage, partnerships blessed by community, or shared spiritual values strengthen bonds.",
        "the_hierophant_love_reversed": "Challenging traditions or feeling confined by relationship expectations. You might need to forge your own path rather than follow conventional wisdom.",
        
        // The Hierophant - Career
        "the_hierophant_career_upright": "Traditional career paths, education, or established institutions support your growth. Mentorship and formal learning bring advancement. Honor proven methods.",
        "the_hierophant_career_reversed": "Rebelling against traditional career expectations or institutional structures. You may need to find your own unconventional path. Question authority.",
        
        // The Hierophant - Finance
        "the_hierophant_finance_upright": "Traditional financial institutions, advisors, or conventional wisdom guide your prosperity. Follow established financial principles and seek expert counsel.",
        "the_hierophant_finance_reversed": "Questioning traditional financial advice or feeling restricted by conventional approaches. You might need alternative financial strategies that match your values.",
        
        // The Hierophant - Health
        "the_hierophant_health_upright": "Traditional medicine, established health practices, or seeking expert medical advice serves you well. Trust proven methods and professional guidance.",
        "the_hierophant_health_reversed": "Traditional health approaches may not resonate. Explore alternative healing modalities. Trust your inner knowing over external authority.",
        
        // The Hierophant - General
        "the_hierophant_general_upright": "Tradition, education, and established institutions guide your path. Seek mentorship and honor proven wisdom. Conformity serves a purpose now.",
        "the_hierophant_general_reversed": "Rebellion against convention and traditional structures. You're being called to find your own path and question authority. Personal beliefs over dogma.",
        
        // The Chariot - Love
        "the_chariot_love_upright": "Determination and willpower move your love life forward. You know what you want and you're going after it. Victory in matters of the heart through focused action.",
        "the_chariot_love_reversed": "Lack of direction or opposing forces in relationships. Control struggles or losing momentum in love. Realign your intentions and find clear direction.",
        
        // The Chariot - Career
        "the_chariot_career_upright": "Career victory through determination and willpower. You're in the driver's seat—stay focused and you'll succeed. Overcome obstacles through sheer determination.",
        "the_chariot_career_reversed": "Career obstacles feel overwhelming or you're heading in conflicting directions. Lack of focus or control. Regain your sense of direction.",
        
        // The Chariot - Finance
        "the_chariot_finance_upright": "Financial success through determined action and self-control. You have the willpower to achieve your monetary goals. Stay focused and disciplined.",
        "the_chariot_finance_reversed": "Financial obstacles or lack of control over spending. Opposing forces drain resources. Regain control through focused intention.",
        
        // The Chariot - Health
        "the_chariot_health_upright": "Determination drives health victories. Your willpower is strong—use it to overcome health challenges. Mind over matter brings real results now.",
        "the_chariot_health_reversed": "Struggling to maintain healthy habits or feeling pulled in opposite directions. Lack of discipline or control. Refocus your health intentions.",
        
        // The Chariot - General
        "the_chariot_general_upright": "Victory through determination and willpower. You're in control and moving forward with confidence. Overcome obstacles through focused intention and discipline.",
        "the_chariot_general_reversed": "Loss of direction or control. Opposing forces pull you apart. Aggression and obstacles block progress. Regain your focus and sense of purpose.",
        
        // Strength - Love
        "strength_love_upright": "Compassionate courage strengthens relationships. Patience, understanding, and inner strength deepen love. Gentle power, not force, wins hearts.",
        "strength_love_reversed": "Self-doubt or insecurity weakens relationships. You might be too forceful or not assertive enough. Find your inner courage and balance.",
        
        // Strength - Career
        "strength_career_upright": "Inner strength and quiet confidence bring professional success. Your ability to handle challenges with grace impresses others. Courage and compassion are your superpowers.",
        "strength_career_reversed": "Professional self-doubt or misuse of power. You might be too aggressive or too passive. Reconnect with your inner strength and confidence.",
        
        // Strength - Finance
        "strength_finance_upright": "Financial courage and disciplined restraint create success. You have the inner strength to resist temptation and make wise choices. Patience pays off.",
        "strength_finance_reversed": "Financial fear or lack of discipline. You might lack confidence in money matters or be too forceful. Find your center of power.",
        
        // Strength - Health
        "strength_health_upright": "Inner strength overcomes health challenges. Your courage and gentle persistence with wellness practices bring results. Mind and body work together.",
        "strength_health_reversed": "Health setbacks trigger self-doubt. You might be pushing too hard or not hard enough. Find compassionate discipline with yourself.",
        
        // Strength - General
        "strength_general_upright": "Inner strength, courage, and compassion define this time. You have the power to overcome challenges through gentle persistence. Confidence without arrogance.",
        "strength_general_reversed": "Self-doubt, weakness, or misuse of power block your path. Are you being too forceful or too timid? Reconnect with your inner courage.",
        
        // The Hermit - Love
        "the_hermit_love_upright": "Solitude and self-reflection are necessary in your love life now. Step back to gain clarity. The answers you seek come from within, not from others.",
        "the_hermit_love_reversed": "Isolation becomes loneliness in love. You might be withdrawing too much or avoiding connection. Balance solitude with healthy relationship.",
        
        // The Hermit - Career
        "the_hermit_career_upright": "Soul-searching about your career path brings wisdom. Step back from the noise and listen to your inner guidance. Mentorship or deep expertise develops.",
        "the_hermit_career_reversed": "Professional isolation or refusing guidance. You might be too withdrawn or paranoid about colleagues. Rejoin the conversation.",
        
        // The Hermit - Finance
        "the_hermit_finance_upright": "Careful financial reflection and conservative approaches serve you well. Seek wisdom before making decisions. Inner guidance over external noise.",
        "the_hermit_finance_reversed": "Financial isolation or refusing help when you need it. Paranoia about money or complete withdrawal from financial planning. Seek balanced perspective.",
        
        // The Hermit - Health
        "the_hermit_health_upright": "Solitude and introspection support healing. Your body needs quiet time to recover. Listen deeply to your inner wisdom about what you need.",
        "the_hermit_health_reversed": "Unhealthy isolation or ignoring health needs. Withdrawal from healthy activities or refusing support. Find balance between solitude and connection.",
        
        // The Hermit - General
        "the_hermit_general_upright": "Time for introspection, soul-searching, and inner guidance. Step away from the noise and find your own light. Wisdom comes from within.",
        "the_hermit_general_reversed": "Isolation, loneliness, or paranoid withdrawal from life. You're either too isolated or refusing to do necessary inner work. Find balance.",
        
        // Wheel of Fortune - Love
        "wheel_of_fortune_love_upright": "Destiny brings changes to your love life. Good fortune and lucky meetings arrive. Trust the cycles—what's meant for you will come.",
        "wheel_of_fortune_love_reversed": "Resistant to changes in relationships or experiencing difficult cycles. Bad timing or luck. Remember that all cycles turn—this too shall pass.",
        
        // Wheel of Fortune - Career
        "wheel_of_fortune_career_upright": "Career destiny unfolds favorably. Lucky breaks and good timing bring opportunities. Trust the natural cycles of professional growth.",
        "wheel_of_fortune_career_reversed": "Career setbacks or resisting necessary changes. Bad timing or luck. Don't fight the wheel—work with the cycles, not against them.",
        
        // Wheel of Fortune - Finance
        "wheel_of_fortune_finance_upright": "Financial luck and fortunate changes come your way. Trust the cycles of abundance. What goes around comes around—in your favor now.",
        "wheel_of_fortune_finance_reversed": "Financial setbacks or cycles of scarcity. Resisting the natural ebb and flow of resources. This cycle will turn—prepare for the next phase.",
        
        // Wheel of Fortune - Health
        "wheel_of_fortune_health_upright": "Health improves through natural cycles and fortunate timing. Your body is entering a positive phase. Trust the process of healing.",
        "wheel_of_fortune_health_reversed": "Health challenges due to natural cycles or bad timing. Don't resist—work with your body's rhythms. This phase will pass.",
        
        // Wheel of Fortune - General
        "wheel_of_fortune_general_upright": "Destiny, change, and good fortune arrive. Life's wheel turns in your favor. Trust the cycles and go with the flow. What's meant for you won't miss you.",
        "wheel_of_fortune_general_reversed": "Bad luck, setbacks, or resistance to life's natural cycles. The wheel is turning—you can't stop it, but you can prepare. This too shall pass.",
        
        // Justice - Love
        "justice_love_upright": "Truth and fairness bring clarity to relationships. Balanced give-and-take is essential. Karmic relationships or legal matters in love resolve fairly.",
        "justice_love_reversed": "Unfairness or dishonesty in relationships. Imbalanced dynamics or avoiding accountability. Face the truth and restore balance.",
        
        // Justice - Career
        "justice_career_upright": "Fairness and accountability in professional matters. Contracts, legal issues, or evaluations work in your favor. Truth and integrity bring success.",
        "justice_career_reversed": "Workplace injustice or dishonesty. Unfair treatment or avoiding accountability. Stand up for what's right, or face the consequences of avoiding truth.",
        
        // Justice - Finance
        "justice_finance_upright": "Financial fairness and balanced accounts. Legal or contractual money matters resolve justly. You get what you deserve—make sure you deserve abundance.",
        "justice_finance_reversed": "Financial injustice or dishonest dealings. Imbalanced accounts or avoiding financial truth. Face the numbers honestly.",
        
        // Justice - Health
        "justice_health_upright": "Your health reflects your lifestyle choices—cause and effect are clear. Balance in all things brings wellness. Diagnoses reveal truth.",
        "justice_health_reversed": "Imbalanced health approaches or refusing to face health truths. Your body reflects your choices. Take accountability.",
        
        // Justice - General
        "justice_general_upright": "Truth, fairness, and accountability prevail. Legal matters resolve justly. Karmic balance is restored. You reap what you sow—ensure you're planting good seeds.",
        "justice_general_reversed": "Injustice, dishonesty, or avoiding accountability. Unfair treatment or refusal to face truth. Restore balance through honesty.",
        
        // The Hanged Man - Love
        "the_hanged_man_love_upright": "Surrender control in love. A new perspective on relationships emerges through letting go. Pause and see things differently.",
        "the_hanged_man_love_reversed": "Stalling or resisting necessary relationship changes. Indecision keeps you stuck. Stop avoiding the inevitable pause.",
        
        // The Hanged Man - Career
        "the_hanged_man_career_upright": "Career pause brings new perspective. Surrender old approaches and see your path differently. Sometimes not moving forward is the right move.",
        "the_hanged_man_career_reversed": "Resisting necessary career pauses or delays. Indecision and stalling waste time. Embrace the suspension or make a decision.",
        
        // The Hanged Man - Finance
        "the_hanged_man_finance_upright": "Financial sacrifice or pause leads to long-term gain. See your resources from a new angle. Let go of old financial attachments.",
        "the_hanged_man_finance_reversed": "Resisting necessary financial adjustments or stuck in financial limbo. Stop stalling and make the change.",
        
        // The Hanged Man - Health
        "the_hanged_man_health_upright": "Rest and surrender support healing. See your health from a new perspective. Sometimes doing nothing is doing something.",
        "the_hanged_man_health_reversed": "Resisting necessary rest or stuck in unhealthy patterns. Stop fighting and surrender to what your body needs.",
        
        // The Hanged Man - General
        "the_hanged_man_general_upright": "Surrender, new perspective, and necessary pause. Let go of control and see things upside down. Sacrifice leads to enlightenment.",
        "the_hanged_man_general_reversed": "Resistance, stalling, and refusing to let go. Indecision keeps you suspended in limbo. Embrace the pause or move on.",
        
        // Death - Love
        "death_love_upright": "A profound transformation is occurring in your love life. This could mean the end of a relationship, or the death of old patterns within one. Grieve what's ending, but know that something more authentic is being born.",
        "death_love_reversed": "You're resisting necessary change in your relationships. Holding on to what's already dead will only prolong the pain. Let go. Transformation is trying to happen, but you're fighting it.",
        
        // Death - Career
        "death_career_upright": "Major career transformation is occurring. A job, role, or entire career path is ending to make way for something new. Embrace this profound change.",
        "death_career_reversed": "Resisting necessary career endings keeps you stuck. You know something must change but you're holding on. Let the old professional identity die.",
        
        // Death - Finance
        "death_finance_upright": "Financial transformation through endings. Old income sources or money patterns must die for new abundance to emerge. Profound change in your relationship with resources.",
        "death_finance_reversed": "Clinging to failing financial strategies or situations. Resisting necessary financial transformation only prolongs suffering. Let go.",
        
        // Death - Health
        "death_health_upright": "Major health transformation. Old patterns die to make way for vibrant new wellness. Embrace this profound shift in your physical being.",
        "death_health_reversed": "Resisting necessary health changes keeps you in decay. Your body demands transformation. Stop fighting the inevitable change.",
        
        // Death - General
        "death_general_upright": "An ending is here, and with it, a powerful transformation. Don't resist this change—it's making room for your rebirth. What must die so that you can truly live? Embrace the transition.",
        "death_general_reversed": "You're clinging to what needs to end. Fear of change is keeping you stuck in a stagnant situation. The death card reversed is about resisting the natural cycles of life. Let go and trust the process.",
        
        // Temperance - Love
        "temperance_love_upright": "Balance and moderation heal relationships. Patience and harmony create lasting love. Blend opposites to find the middle way together.",
        "temperance_love_reversed": "Imbalance or extremes strain relationships. Lack of patience or harmony. Find the middle ground and restore equilibrium.",
        
        // Temperance - Career
        "temperance_career_upright": "Professional balance and patient progress bring success. Blend different elements of your work skillfully. Moderation and harmony in your approach.",
        "temperance_career_reversed": "Work-life imbalance or extremes in professional approach. Lack of patience with career progress. Restore moderation.",
        
        // Temperance - Finance
        "temperance_finance_upright": "Balanced financial approach brings stability. Moderate spending and saving create harmony. Patient wealth-building through steady effort.",
        "temperance_finance_reversed": "Financial extremes or imbalanced resource management. Excessive spending or hoarding. Find the middle way with money.",
        
        // Temperance - Health
        "temperance_health_upright": "Balanced lifestyle brings healing. Moderation in all things supports wellness. Patience with your body's natural rhythms.",
        "temperance_health_reversed": "Imbalanced health habits or extremes in diet/exercise. Lack of patience with healing. Restore moderation and harmony.",
        
        // Temperance - General
        "temperance_general_upright": "Balance, moderation, and patience guide your path. Blend opposites skillfully. Harmony comes through the middle way. Trust divine timing.",
        "temperance_general_reversed": "Imbalance, excess, and extremes create discord. Lack of patience or harmony. Restore moderation and find your center.",
        
        // The Devil - Love
        "the_devil_love_upright": "Unhealthy attachments or addictive patterns in relationships. Bondage to materialism or toxicity. Recognize the chains—they're not locked.",
        "the_devil_love_reversed": "Breaking free from toxic relationship patterns. Releasing unhealthy attachments. You're recognizing your power to leave.",
        
        // The Devil - Career
        "the_devil_career_upright": "Trapped in unfulfilling work or unhealthy professional patterns. Materialism over meaning. Recognize what holds you—only you can free yourself.",
        "the_devil_career_reversed": "Breaking free from career bondage. Releasing attachment to toxic work situations. Choosing meaning over money.",
        
        // The Devil - Finance
        "the_devil_finance_upright": "Materialism, greed, or unhealthy financial attachments. Bondage to debt or addictive spending. You have more power than you think.",
        "the_devil_finance_reversed": "Breaking free from financial bondage. Releasing unhealthy money patterns. Detachment from materialism brings freedom.",
        
        // The Devil - Health
        "the_devil_health_upright": "Addictive behaviors or unhealthy attachments affect wellbeing. Bondage to harmful habits. The chains are self-imposed—break free.",
        "the_devil_health_reversed": "Breaking free from unhealthy habits. Releasing addictive patterns. Choosing freedom over familiar bondage.",
        
        // The Devil - General
        "the_devil_general_upright": "Bondage, addiction, and unhealthy attachments. You're more trapped by beliefs than reality. The chains aren't locked—you can free yourself anytime.",
        "the_devil_general_reversed": "Breaking free, releasing attachments, and choosing freedom. You're recognizing your power to leave toxic situations. Liberation is coming.",
        
        // The Tower - Love
        "the_tower_love_upright": "Sudden upheaval is shaking your relationship or romantic life. Foundations you thought were solid are crumbling. This is painful but necessary—false structures must fall so truth can emerge. What's being revealed?",
        "the_tower_love_reversed": "You're barely avoiding disaster, or delaying inevitable upheaval. The tower moment is coming whether you're ready or not. Instead of fearing it, prepare for the truth that's about to surface.",
        
        // The Tower - Career
        "the_tower_career_upright": "Sudden career upheaval shatters false structures. Job loss, restructuring, or dramatic revelations shake your professional foundation. This destruction makes way for truth.",
        "the_tower_career_reversed": "Narrowly avoiding career disaster or resisting inevitable workplace upheaval. The tower moment is coming—prepare for truth.",
        
        // The Tower - Finance
        "the_tower_finance_upright": "Sudden financial upheaval or loss. False security crumbles. This shocking change reveals the truth about your resources. Build on solid ground next time.",
        "the_tower_finance_reversed": "Narrowly avoiding financial catastrophe or delaying inevitable money crisis. The truth about your finances will emerge.",
        
        // The Tower - Health
        "the_tower_health_upright": "Sudden health crisis or shocking diagnosis. Your body's false stability shatters. This upheaval forces necessary change and reveals truth.",
        "the_tower_health_reversed": "Narrowly avoiding health crisis or ignoring warning signs. The tower moment for your health approaches—don't wait.",
        
        // The Tower - General
        "the_tower_general_upright": "Sudden, disruptive change is shattering your world. Everything you thought was stable is being shaken. This is the universe's way of breaking down false structures. In the rubble, you'll find truth. Chaos precedes clarity.",
        "the_tower_general_reversed": "You're resisting necessary upheaval, or narrowly avoiding catastrophe. You can't prevent the tower moment forever—it's coming to liberate you from illusions. Brace yourself and look for the gift in the destruction.",
        
        // The Star - Love
        "the_star_love_upright": "Hope, healing, and renewal in love. After difficulty, optimism returns. A spiritually aligned connection or renewed faith in romance. You're being guided toward true love.",
        "the_star_love_reversed": "Hopelessness or disconnection in love. Pessimism blocks romantic possibility. Reconnect with faith in love's potential.",
        
        // The Star - Career
        "the_star_career_upright": "Career hope and inspiration after difficulty. Your professional dreams are valid—keep faith. Divine guidance lights your path forward.",
        "the_star_career_reversed": "Professional despair or disconnection from career dreams. Negativity blocks opportunity. Reconnect with hope and inspiration.",
        
        // The Star - Finance
        "the_star_finance_upright": "Financial hope and renewal after hardship. Trust that abundance flows to you. Spiritual approach to prosperity brings results.",
        "the_star_finance_reversed": "Financial hopelessness or disconnection from abundance mindset. Negativity blocks prosperity. Restore faith in your worth.",
        
        // The Star - Health
        "the_star_health_upright": "Health healing and renewal. Hope returns after illness. Spiritual healing practices support recovery. Your body is regenerating.",
        "the_star_health_reversed": "Health despair or disconnection from healing. Hopelessness blocks recovery. Reconnect with faith in your body's wisdom.",
        
        // The Star - General
        "the_star_general_upright": "Hope, inspiration, renewal, and serenity. After the storm, peace returns. You're being guided by divine light. Trust in the universe's plan for you.",
        "the_star_general_reversed": "Hopelessness, despair, and disconnection from source. Negativity blocks blessings. Reconnect with faith and trust. The light is still there.",
        
        // The Moon - Love
        "the_moon_love_upright": "Illusions, secrets, or anxiety cloud romantic clarity. Trust your intuition even when things seem unclear. Not everything is as it appears in love.",
        "the_moon_love_reversed": "Clarity emerges from romantic confusion. Fears subside and truth is revealed. Anxiety about love begins to release.",
        
        // The Moon - Career
        "the_moon_career_upright": "Professional uncertainty, workplace secrets, or career anxiety. Trust your intuition—things aren't what they seem. Navigate by inner knowing.",
        "the_moon_career_reversed": "Career clarity emerges from confusion. Workplace secrets revealed. Professional anxiety subsides as truth comes to light.",
        
        // The Moon - Finance
        "the_moon_finance_upright": "Financial uncertainty or illusions about money. Hidden factors affect your resources. Trust your instincts about financial matters.",
        "the_moon_finance_reversed": "Financial clarity emerges. Money secrets revealed. Anxiety about resources subsides as you see the truth.",
        
        // The Moon - Health
        "the_moon_health_upright": "Health anxiety or unclear symptoms. Trust your intuition about your body. Explore subconscious factors affecting wellness.",
        "the_moon_health_reversed": "Health clarity emerges. Diagnosis or understanding comes. Anxiety about wellbeing subsides as truth is revealed.",
        
        // The Moon - General
        "the_moon_general_upright": "Illusion, intuition, anxiety, and subconscious forces. Not everything is as it seems. Trust your inner knowing to navigate uncertainty and mystery.",
        "the_moon_general_reversed": "Clarity emerges from confusion. Release of fear and revelation of truth. Anxiety subsides as illusions dissolve.",
        
        // The Sun - Love
        "the_sun_love_upright": "Pure joy, warmth, and celebration shine on your love life. If you're single, your radiance is attracting wonderful connections. If partnered, you're experiencing a beautiful period of harmony and happiness. Bask in this beautiful energy.",
        "the_sun_love_reversed": "Temporary clouds are dimming your romantic happiness. Pessimism or unrealistic expectations may be blocking joy. Remember that this is temporary. The sun always returns. Adjust your perspective.",
        
        // The Sun - Career
        "the_sun_career_upright": "Career success and recognition shine brightly. Your work brings joy and accolades. Professional vitality and positive energy attract opportunities.",
        "the_sun_career_reversed": "Temporary career setbacks or dimmed professional joy. Pessimism about work clouds your vision. Remember this is temporary—success returns.",
        
        // The Sun - Finance
        "the_sun_finance_upright": "Financial success and abundance. Money flows with joy and ease. Your positive energy attracts prosperity. Celebrate your wins.",
        "the_sun_finance_reversed": "Temporary financial disappointments or unrealistic money expectations. Sadness about resources clouds judgment. The sun will shine again.",
        
        // The Sun - Health
        "the_sun_health_upright": "Vibrant health and vitality. Your body radiates wellness and joy. Energy levels are high. Celebrate feeling good.",
        "the_sun_health_reversed": "Temporary health setbacks or low energy. Pessimism about wellness. Remember your vitality will return—this is just a passing cloud.",
        
        // The Sun - General
        "the_sun_general_upright": "Success, joy, and vitality are yours. This is one of the most positive cards in the deck. Whatever you're working on is blessed with the universe's favor. Celebrate your wins and share your light with others.",
        "the_sun_general_reversed": "Your inner light is temporarily dimmed by sadness, pessimism, or setbacks. This doesn't last forever. What small joy can you connect with today? The sun is still there, even behind the clouds.",
        
        // Judgement - Love
        "judgement_love_upright": "Relationship reckoning and awakening. Past patterns are reviewed and released. Rebirth in love through honest self-reflection. Important love decisions clarify.",
        "judgement_love_reversed": "Avoiding relationship self-reflection or harsh self-judgment. Refusing to learn from past romantic patterns. Self-doubt blocks love rebirth.",
        
        // Judgement - Career
        "judgement_career_upright": "Career awakening and professional reckoning. Evaluate your work honestly and make important decisions. Past efforts are judged—rebirth follows reflection.",
        "judgement_career_reversed": "Avoiding career self-assessment or harsh professional self-criticism. Refusing to learn from past mistakes. Self-doubt blocks career rebirth.",
        
        // Judgement - Finance
        "judgement_finance_upright": "Financial reckoning and honest assessment. Review past money decisions and awaken to new financial consciousness. Rebirth through accountability.",
        "judgement_finance_reversed": "Avoiding financial reality or harsh money self-judgment. Refusing to learn from past financial mistakes. Self-loathing blocks prosperity.",
        
        // Judgement - Health
        "judgement_health_upright": "Health awakening through honest assessment. Review past wellness choices and make important health decisions. Rebirth through accountability.",
        "judgement_health_reversed": "Avoiding health reality or harsh body judgment. Refusing to learn from past health patterns. Self-criticism blocks healing.",
        
        // Judgement - General
        "judgement_general_upright": "Reflection, reckoning, awakening, and rebirth. Honest self-assessment leads to transformation. Past decisions are reviewed—learn and rise renewed.",
        "judgement_general_reversed": "Self-doubt, lack of self-awareness, or refusal to learn from the past. Harsh self-judgment or complete denial. Face truth with compassion.",
        
        // The World - Love
        "the_world_love_upright": "Relationship completion and fulfillment. A love cycle concludes successfully. Total satisfaction and harmony. Your romantic journey reaches a beautiful milestone.",
        "the_world_love_reversed": "Incomplete relationship cycles or delays in love fulfillment. Shortcuts won't work—do the full journey. Lack of closure keeps you stuck.",
        
        // The World - Career
        "the_world_career_upright": "Career completion and achievement. A major professional cycle concludes successfully. Recognition and fulfillment. Your work journey reaches completion.",
        "the_world_career_reversed": "Incomplete career projects or professional delays. Taking shortcuts undermines success. Lack of closure in old roles blocks new ones.",
        
        // The World - Finance
        "the_world_finance_upright": "Financial completion and prosperity. Money goals are achieved. A cycle of wealth creation concludes successfully. Celebrate your financial journey.",
        "the_world_finance_reversed": "Incomplete financial cycles or delayed prosperity. Shortcuts with money backfire. Lack of closure in old financial patterns.",
        
        // The World - Health
        "the_world_health_upright": "Health completion and wholeness. Wellness goals achieved. A healing cycle concludes successfully. Your body feels complete and integrated.",
        "the_world_health_reversed": "Incomplete healing or delays in health goals. Shortcuts don't bring real wellness. Finish the full health journey.",
        
        // The World - General
        "the_world_general_upright": "Completion, achievement, fulfillment, and wholeness. A major life cycle concludes successfully. Celebrate your journey and prepare for the next adventure.",
        "the_world_general_reversed": "Incompletion, shortcuts, delays, and lack of closure. Finish what you started. Taking the easy way out prevents real fulfillment."
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
