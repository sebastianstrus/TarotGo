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
        "the_world_general_reversed": "Incompletion, shortcuts, delays, and lack of closure. Finish what you started. Taking the easy way out prevents real fulfillment.",
        
        // CUPS SUIT - Ace of Cups
        "ace_of_cups_love_upright": "A new emotional beginning in love. If single, you're open to receiving love. If partnered, renewed feelings deepen your connection. Your heart is overflowing with love and ready to give and receive.",
        "ace_of_cups_love_reversed": "Emotional blockage in love. You may be closing your heart due to past pain. Fear of vulnerability prevents new love from entering. Release old wounds to make space for new feelings.",
        
        "ace_of_cups_career_upright": "A fulfilling new professional opportunity that feeds your soul. This work aligns with your passion and brings emotional satisfaction. Follow what feels right in your heart.",
        "ace_of_cups_career_reversed": "Professional opportunities lack emotional fulfillment. Your heart isn't in your work. Creativity feels blocked. Reconnect with what brings you joy in your career.",
        
        "ace_of_cups_finance_upright": "Financial opportunities that align with your values bring joy. Money flows when you're emotionally aligned with your work. Abundance through heartfelt effort.",
        "ace_of_cups_finance_reversed": "Financial decisions lack heart or emotional satisfaction. Money might be coming but brings no joy. Blocked abundance due to closed heart. Open to receive.",
        
        "ace_of_cups_health_upright": "Emotional healing begins. Your heart and spirit are ready to heal. New wellness practices that nurture your emotional body. Self-love supports physical health.",
        "ace_of_cups_health_reversed": "Emotional blockages affect physical health. Suppressed feelings manifest in the body. Your heart needs attention and healing. Release to restore flow.",
        
        "ace_of_cups_general_upright": "A new beginning in your emotional life. Love, joy, and creative inspiration overflow. Your heart is open and ready. This is a beautiful time of emotional awakening and spiritual connection.",
        "ace_of_cups_general_reversed": "Emotional blockage or closed heart. Past wounds prevent you from fully feeling. Repressed emotions need release. Open yourself to receive the love that's available.",
        
        // Two of Cups
        "two_of_cups_love_upright": "Deep mutual connection and partnership. This is about true union—balanced, harmonious, and mutually fulfilling. Whether new or established, this relationship has real potential.",
        "two_of_cups_love_reversed": "Disconnection or imbalance in partnership. One person may be more invested than the other. Communication breaks down. Work to restore balance or consider if this is right.",
        
        "two_of_cups_career_upright": "Successful professional partnership or collaboration. Mutual respect and shared goals create harmony. This working relationship benefits both parties equally.",
        "two_of_cups_career_reversed": "Professional partnerships are unbalanced or strained. Lack of mutual respect or unequal effort. Tensions in collaborations need addressing.",
        
        "two_of_cups_finance_upright": "Financial partnerships or agreements are balanced and fair. Shared resources work harmoniously. Mutual financial goals align beautifully.",
        "two_of_cups_finance_reversed": "Financial imbalance in partnerships. One person gives more than receives. Money creates tension in relationships. Restore fairness in shared resources.",
        
        "two_of_cups_health_upright": "Mind-body connection strengthens. Emotional and physical health are in harmony. Partnership or support in your health journey benefits you greatly.",
        "two_of_cups_health_reversed": "Mind-body disconnection or imbalanced approach to health. Conflicting health goals with partner. Need for better balance in wellness approach.",
        
        "two_of_cups_general_upright": "Beautiful partnership and mutual connection. Whether romantic, friendship, or professional—this is about true union. Balance, respect, and shared energy create something greater than the sum of its parts.",
        "two_of_cups_general_reversed": "Disconnection, imbalance, or broken partnerships. Lack of mutual respect or understanding. Tensions strain the relationship. Restore balance or recognize when to let go.",
        
        // Three of Cups
        "three_of_cups_love_upright": "Celebration, joy, and community support in love. Your relationship is blessed by friends and family. Social connections enhance your romantic life. Abundance of love surrounds you.",
        "three_of_cups_love_reversed": "Social dynamics strain relationships. Gossip or third-party interference affects your love life. Overindulgence damages connection. Isolation from support network.",
        
        "three_of_cups_career_upright": "Professional success through teamwork and celebration. Collaborative victories and workplace friendships thrive. Your contributions are recognized and celebrated by colleagues.",
        "three_of_cups_career_reversed": "Workplace gossip or toxic social dynamics. Overindulgence affecting professional reputation. Feeling isolated from team. Office politics create problems.",
        
        "three_of_cups_finance_upright": "Financial celebration and shared abundance. Group investments or celebrations bring joy. Prosperity is enhanced through community and generosity.",
        "three_of_cups_finance_reversed": "Overspending on social activities or celebrations. Financial strain from trying to keep up with others. Gossip about money matters. Financial isolation.",
        
        "three_of_cups_health_upright": "Health benefits from social connection and celebration. Friends support your wellness journey. Joyful group activities boost wellbeing. Emotional health thrives through community.",
        "three_of_cups_health_reversed": "Overindulgence affecting health. Social pressures lead to unhealthy choices. Loneliness impacts wellness. Need balance in social activities and self-care.",
        
        "three_of_cups_general_upright": "Celebration, friendship, and community joy. Life is asking you to connect, share, and celebrate with others. Your tribe supports you. Abundance multiplies when shared.",
        "three_of_cups_general_reversed": "Isolation, overindulgence, or toxic social dynamics. Gossip and drama drain your energy. You're either partying too much or withdrawing too much. Find healthy balance.",
        
        // Four of Cups
        "four_of_cups_love_upright": "Romantic apathy or taking love for granted. You're so focused on what's missing that you don't see what's being offered. Look up—there's love right in front of you.",
        "four_of_cups_love_reversed": "Awakening to love's possibilities. You're finally seeing what's been offered. Renewed appreciation for your relationship. Motivation to engage returns.",
        
        "four_of_cups_career_upright": "Professional boredom or apathy. You're contemplating change but not yet acting. Opportunities are presented but don't excite you. Time for honest reevaluation.",
        "four_of_cups_career_reversed": "Renewed career motivation and recognition of opportunities. You're seeing possibilities you missed before. Ready to engage with work again.",
        
        "four_of_cups_finance_upright": "Financial apathy or taking abundance for granted. You're not seeing the opportunities available. Contemplation before financial decisions is wise, but don't miss what's offered.",
        "four_of_cups_finance_reversed": "Financial awakening and renewed motivation. You're seeing money opportunities clearly now. Acceptance of what's available rather than focusing on lack.",
        
        "four_of_cups_health_upright": "Health contemplation and possible apathy. You know you should make changes but lack motivation. Don't ignore the opportunities for wellness being offered.",
        "four_of_cups_health_reversed": "Renewed health motivation and awareness. You're finally ready to accept help and make changes. New perspectives on wellness emerge.",
        
        "four_of_cups_general_upright": "Apathy, contemplation, and missed opportunities. You're so focused inward or on what's wrong that you don't see what's being offered. This is a wake-up call to look around you.",
        "four_of_cups_general_reversed": "Awakening from apathy. Renewed motivation and fresh perspectives arrive. You're finally seeing the opportunities that have been there all along. Acceptance replaces dissatisfaction.",
        
        // Five of Cups
        "five_of_cups_love_upright": "Grief and disappointment in love. You're mourning what's lost and can't yet see what remains. Yes, this hurts. But turn around—not everything is gone.",
        "five_of_cups_love_reversed": "Healing from romantic loss. You're beginning to move on and see hope again. Forgiveness—of self and others—brings peace. The worst of the grief is passing.",
        
        "five_of_cups_career_upright": "Professional disappointment and loss. A job, project, or opportunity didn't work out. You're mourning what failed. Valid feelings, but don't lose sight of what remains.",
        "five_of_cups_career_reversed": "Recovery from career setbacks. You're making peace with past failures and seeing new possibilities. Moving forward with lessons learned.",
        
        "five_of_cups_finance_upright": "Financial loss or disappointment. Money slip through your fingers and you're focused on what's gone. Grief is natural, but assess what resources remain.",
        "five_of_cups_finance_reversed": "Financial recovery and acceptance. You're making peace with losses and seeing remaining resources clearly. Finding forgiveness and moving forward.",
        
        "five_of_cups_health_upright": "Health disappointment or grief about physical changes. Mourning lost vitality or wellness. Your feelings are valid, but don't overlook your body's remaining strengths.",
        "five_of_cups_health_reversed": "Health acceptance and emotional healing. You're making peace with limitations and seeing what's still possible. Finding hope and moving forward in wellness.",
        
        "five_of_cups_general_upright": "Loss, grief, and disappointment dominate your focus. Something has ended and you're mourning. Your feelings are valid. But this card reminds you: not everything is lost. Two cups still stand.",
        "five_of_cups_general_reversed": "Healing, forgiveness, and moving on. You're beginning to see past the loss. Acceptance brings peace. The grief is subsiding and you're finding your way forward.",
        
        // Six of Cups
        "six_of_cups_love_upright": "Nostalgia and sweet memories in love. Past relationships or childhood sweethearts may resurface. Innocence and comfort in familiar connections. The past informs present love.",
        "six_of_cups_love_reversed": "Living in the past prevents present love. Idealizing old relationships blocks new ones. You're stuck in what was instead of embracing what is. Move forward.",
        
        "six_of_cups_career_upright": "Career nostalgia or returning to past work. Old colleagues reconnect. Your past experience informs current success. Simpler times in professional life appeal to you.",
        "six_of_cups_career_reversed": "Career stuck in past patterns. Outdated approaches don't work anymore. Naive expectations about work. Need to update your professional perspective.",
        
        "six_of_cups_finance_upright": "Financial nostalgia or returns from past investments. Old approaches to money serve you well. Gifts or support from the past. Simple financial satisfaction.",
        "six_of_cups_finance_reversed": "Unrealistic financial expectations based on the past. What worked before doesn't work now. Living beyond means trying to recreate old lifestyle. Update money approach.",
        
        "six_of_cups_health_upright": "Health practices from the past serve you well. Returning to simpler wellness routines. Childhood activities bring joy and health. Nostalgia supports healing.",
        "six_of_cups_health_reversed": "Outdated health approaches don't work anymore. Living in denial about your body's current needs. Past health issues resurface. Need to update wellness practices.",
        
        "six_of_cups_general_upright": "Nostalgia, memories, and innocence. The past is present—whether through reunions, memories, or returning to familiar places. There's sweetness here, but don't get too lost in what was.",
        "six_of_cups_general_reversed": "Stuck in the past or unrealistic nostalgia. You're idealizing what was and can't move forward. Naive expectations block growth. It's time to live in the present.",
        
        // Seven of Cups
        "seven_of_cups_love_upright": "Romantic fantasies and illusions. You're seeing what you want to see, not what is. Many options feel overwhelming. Ground yourself in reality before choosing.",
        "seven_of_cups_love_reversed": "Romantic clarity emerges from confusion. You're seeing people and situations more realistically. Making clear decisions about love. Illusions dissolve.",
        
        "seven_of_cups_career_upright": "Too many career options create confusion. Wishful thinking about professional possibilities. Some opportunities aren't real. Need clarity before committing to a path.",
        "seven_of_cups_career_reversed": "Career clarity and realistic assessment of options. You're seeing opportunities clearly now. Ready to make grounded professional decisions. Fantasy gives way to practical action.",
        
        "seven_of_cups_finance_upright": "Financial illusions or too many investment options. If it sounds too good to be true, it probably is. Fantasies about wealth cloud judgment. Seek clarity and expert advice.",
        "seven_of_cups_finance_reversed": "Financial clarity and realistic money decisions. You're seeing through get-rich-quick schemes. Making practical choices about resources. Sobriety replaces fantasy.",
        
        "seven_of_cups_health_upright": "Health illusions or overwhelm by too many wellness options. Confusion about what approach to take. Some health claims aren't real. Need clarity and professional guidance.",
        "seven_of_cups_health_reversed": "Health clarity and realistic wellness decisions. You're seeing through false health promises. Making grounded choices about your body. Clear path forward emerges.",
        
        "seven_of_cups_general_upright": "Illusion, fantasy, and overwhelming choices. You're presented with many options but not all are real. Your imagination runs wild. Ground yourself and see clearly before deciding.",
        "seven_of_cups_general_reversed": "Clarity, reality checks, and clear decisions. The fog is lifting. You're seeing situations realistically and ready to make grounded choices. Wishful thinking gives way to wisdom.",
        
        // Eight of Cups
        "eight_of_cups_love_upright": "Walking away from unfulfilling love to find something deeper. This relationship doesn't feed your soul anymore. It's hard to leave, but staying is harder. Trust your need for more.",
        "eight_of_cups_love_reversed": "Avoiding necessary departure from unfulfilling relationship. Fear of change keeps you in what doesn't serve you. Running from commitment or refusing to face relationship truth.",
        
        "eight_of_cups_career_upright": "Leaving professional security to find meaningful work. Your job doesn't fulfill you anymore. Time to seek deeper purpose even if it means walking away from comfort.",
        "eight_of_cups_career_reversed": "Avoiding necessary career change due to fear. Staying in unfulfilling work because leaving feels scary. Running from opportunities for deeper professional meaning.",
        
        "eight_of_cups_finance_upright": "Walking away from financial security to pursue what truly matters. Money isn't everything. Seeking deeper fulfillment may mean temporary material sacrifice.",
        "eight_of_cups_finance_reversed": "Fear of leaving financial security even when it doesn't bring happiness. Avoiding necessary financial changes. Staying in golden handcuffs.",
        
        "eight_of_cups_health_upright": "Walking away from unhealthy patterns to find true wellness. Leaving behind what no longer serves your body. Journey toward deeper health and wholeness.",
        "eight_of_cups_health_reversed": "Avoiding necessary health changes. Fear keeps you in unhealthy patterns. Running from wellness journey or refusing to face health truth.",
        
        "eight_of_cups_general_upright": "Walking away to find deeper meaning. What once satisfied you doesn't anymore. This is about having the courage to leave behind what no longer serves your soul, even when it's hard.",
        "eight_of_cups_general_reversed": "Avoiding necessary departure or staying in bad situations. Fear of change keeps you stuck. You might also be running away from everything instead of discerning what truly needs to change.",
        
        // Nine of Cups
        "nine_of_cups_love_upright": "Deep romantic satisfaction and wishes fulfilled in love. You have the relationship you desired. Contentment and happiness in matters of the heart. Count your blessings.",
        "nine_of_cups_love_reversed": "Romantic dissatisfaction despite having what you thought you wanted. Greed for more prevents enjoying what is. Materialism over authentic connection. Check your expectations.",
        
        "nine_of_cups_career_upright": "Professional satisfaction and career wishes fulfilled. You're enjoying the fruits of your labor. Success brings contentment. This is what you worked for—savor it.",
        "nine_of_cups_career_reversed": "Professional dissatisfaction despite success. Your achievements don't bring expected joy. Constantly wanting more prevents satisfaction. Reevaluate what success means.",
        
        "nine_of_cups_finance_upright": "Financial satisfaction and prosperity. Your money wishes are fulfilled. You have the abundance you desired. Time to enjoy your resources and share generously.",
        "nine_of_cups_finance_reversed": "Financial dissatisfaction despite having enough. Greed or materialism prevents contentment. Unfulfilled expectations about what money would bring. Practice gratitude.",
        
        "nine_of_cups_health_upright": "Health satisfaction and wellness goals achieved. Your body feels good and you're content with your vitality. Enjoy this phase of physical wellbeing.",
        "nine_of_cups_health_reversed": "Health dissatisfaction or unrealistic body expectations. You have wellness but can't see it. Overindulgence affects health. Gratitude for your body's gifts needed.",
        
        "nine_of_cups_general_upright": "Wishes fulfilled, satisfaction, and contentment. You have what you desired. This is the card of having it all—emotionally, materially, spiritually. Enjoy this beautiful moment of completion.",
        "nine_of_cups_general_reversed": "Dissatisfaction despite having much. Greed, materialism, or unrealistic expectations prevent contentment. You achieved your wishes but they didn't bring expected happiness. Look deeper.",
        
        // Ten of Cups
        "ten_of_cups_love_upright": "Ultimate romantic and family harmony. Your relationship brings deep fulfillment. Love flows freely in your home. This is the happily ever after you've been building toward.",
        "ten_of_cups_love_reversed": "Family or relationship discord disturbs peace. Disconnection from loved ones despite surface appearances. Broken relationship ideals. Work needed to restore harmony.",
        
        "ten_of_cups_career_upright": "Professional fulfillment aligned with family life. Work supports rather than disrupts home harmony. Your career contributes to overall life satisfaction and values alignment.",
        "ten_of_cups_career_reversed": "Work-life imbalance strains family harmony. Career demands disrupt home life. Professional success but family disconnection. Realign priorities.",
        
        "ten_of_cups_finance_upright": "Financial abundance supports family harmony. Prosperity allows you to care for loved ones. Resources create security and joy for all. Wealth with purpose and love.",
        "ten_of_cups_finance_reversed": "Financial issues strain family harmony. Money problems create tension at home. Wealth without emotional connection. Material focus disrupts relationships.",
        
        "ten_of_cups_health_upright": "Health and happiness in alignment. Your wellness supports family life and relationships. Emotional and physical health create beautiful harmony. Wholeness in all areas.",
        "ten_of_cups_health_reversed": "Health issues strain family harmony. Wellness imbalance affects relationships. Disconnection between physical and emotional health. Need for integrated healing.",
        
        "ten_of_cups_general_upright": "Ultimate emotional fulfillment, harmony, and happiness in family and relationships. This is about having the life you dreamed of—love, connection, and peace. Celebrate this blessing.",
        "ten_of_cups_general_reversed": "Broken relationships or family discord. The ideal you worked toward feels shattered. Surface happiness hiding deep disconnection. Disharmony in home and heart needs attention.",
        
        // Page of Cups
        "page_of_cups_love_upright": "New romantic message or creative expression of feelings. Innocent, sincere love emerges. Your heart opens to new emotional experiences. Sweet beginnings in love.",
        "page_of_cups_love_reversed": "Emotional immaturity in love or mixed romantic signals. Creative blocks in expressing feelings. Bad news in relationships. Insecurity prevents authentic connection.",
        
        "page_of_cups_career_upright": "Creative professional opportunities or good news about work. Your intuition guides career decisions. Artistic or emotionally fulfilling job prospects arrive.",
        "page_of_cups_career_reversed": "Creative blocks at work or professional immaturity. Bad career news or missed creative opportunities. Escapism affecting professional performance.",
        
        "page_of_cups_finance_upright": "Good financial news or creative money opportunities. Intuitive approach to finances serves you. New artistic income streams emerge.",
        "page_of_cups_finance_reversed": "Bad financial news or emotionally-driven poor money decisions. Creative financial ventures don't pan out. Financial immaturity blocks prosperity.",
        
        "page_of_cups_health_upright": "Good health news or intuitive wellness insights. Creative approaches to health benefit you. Your body sends clear messages—listen.",
        "page_of_cups_health_reversed": "Bad health news or emotional immaturity affecting wellness. Escapism blocks health progress. Ignoring intuitive body messages.",
        
        "page_of_cups_general_upright": "Creative opportunities, messages, and new emotional experiences. Your intuition is heightened. Approach life with curiosity and an open heart. Beautiful beginnings await.",
        "page_of_cups_general_reversed": "Emotional immaturity, creative blocks, or bad news. Escapism and insecurity prevent growth. You're not hearing your intuition clearly. Ground yourself emotionally.",
        
        // Knight of Cups
        "knight_of_cups_love_upright": "Romantic pursuit and following your heart in love. Someone is making emotional overtures or you're swept up in romance. Charm and imagination guide love. Beautiful feelings flow.",
        "knight_of_cups_love_reversed": "Moodiness or unrealistic romantic expectations. Jealousy and emotional manipulation in love. Someone's too swept up in fantasy to see reality. Drama over substance.",
        
        "knight_of_cups_career_upright": "Following your heart in career decisions. Creative professional pursuit driven by passion. Charming professional opportunities arrive. Imagination serves your work.",
        "knight_of_cups_career_reversed": "Professional moodiness or unrealistic career expectations. Letting emotions override professional judgment. Drama at work. Need for more grounding.",
        
        "knight_of_cups_finance_upright": "Following intuition in financial decisions. Creative income opportunities driven by passion. Money flows through heartfelt work. Generosity and prosperity align.",
        "knight_of_cups_finance_reversed": "Emotional financial decisions lack grounding. Unrealistic money expectations. Jealousy about others' prosperity. Need practical financial approach.",
        
        "knight_of_cups_health_upright": "Following your heart in wellness choices. Creative, emotionally-driven health approaches. Your body responds to loving attention. Intuitive healing.",
        "knight_of_cups_health_reversed": "Mood swings affect health. Unrealistic wellness expectations. Emotional eating or health escapism. Need more grounded self-care.",
        
        "knight_of_cups_general_upright": "Following your heart, romantic pursuit, and creative action. You're led by emotions and imagination. This is beautiful but ensure you're also grounded in reality.",
        "knight_of_cups_general_reversed": "Moodiness, unrealistic expectations, and emotional drama. Jealousy and overemotional reactions. You're so swept up in feelings that you've lost touch with what's real.",
        
        // Queen of Cups
        "queen_of_cups_love_upright": "Emotionally mature, intuitive, and deeply caring love. You or your partner embody compassionate understanding. Emotional security allows vulnerability. Nurturing love flows freely.",
        "queen_of_cups_love_reversed": "Emotional insecurity in relationships. Codependency or martyrdom affects love. Overwhelmed by others' emotions. Need for better boundaries and self-care.",
        
        "queen_of_cups_career_upright": "Compassionate professional leadership. Your emotional intelligence serves work well. Caring and intuition guide career success. You create emotionally safe workplaces.",
        "queen_of_cups_career_reversed": "Professional overwhelm or poor emotional boundaries at work. Codependency with colleagues. Taking on others' problems. Need for self-care and limits.",
        
        "queen_of_cups_finance_upright": "Intuitive financial decisions and caring approach to resources. Prosperity through compassionate work. Emotional security allows generous giving.",
        "queen_of_cups_finance_reversed": "Financial codependency or martyrdom with money. Poor boundaries around resources. Overwhelmed by others' financial needs. Protect yourself.",
        
        "queen_of_cups_health_upright": "Emotionally secure approach to health. Intuitive understanding of your body's needs. Compassionate self-care. Emotional healing supports physical wellness.",
        "queen_of_cups_health_reversed": "Health overwhelm or emotional flooding affecting wellness. Poor self-care due to caring for others. Need for boundaries and personal health focus.",
        
        "queen_of_cups_general_upright": "Emotional maturity, compassion, intuition, and caring. You're deeply connected to your feelings and others'. Your emotional intelligence is your superpower. Lead with love.",
        "queen_of_cups_general_reversed": "Emotional insecurity, codependency, or martyrdom. You're overwhelmed by feelings—yours and others'. Poor boundaries drain you. Put on your own oxygen mask first.",
        
        // King of Cups
        "king_of_cups_love_upright": "Emotionally balanced and mature love. Calm compassion and diplomatic care. You or your partner masters emotions without suppressing them. Wise, stable partnership.",
        "king_of_cups_love_reversed": "Emotional manipulation or cold detachment in love. Volatile feelings or complete repression. Using emotions as weapons or refusing to feel. Unhealthy emotional control.",
        
        "king_of_cups_career_upright": "Emotionally intelligent professional leadership. Balanced, diplomatic approach to work challenges. Your calm presence inspires others. Compassionate authority.",
        "king_of_cups_career_reversed": "Professional emotional manipulation or coldness. Volatile work behavior or complete emotional shutdown. Abusing power through emotional control. Unhealthy leadership.",
        
        "king_of_cups_finance_upright": "Balanced, wise financial decisions. Emotional maturity guides money choices. You're neither greedy nor careless with resources. Compassionate prosperity.",
        "king_of_cups_finance_reversed": "Financial manipulation or cold detachment from money's impact. Emotional volatility around resources. Using wealth as emotional weapon. Unhealthy money control.",
        
        "king_of_cups_health_upright": "Emotional balance supports physical health. Wise, compassionate approach to wellness. You master stress without suppressing feelings. Integrated mind-body health.",
        "king_of_cups_health_reversed": "Emotional repression affecting health. Volatility or coldness toward your body's needs. Using control as health strategy. Need for more feeling and flexibility.",
        
        "king_of_cups_general_upright": "Emotional mastery, balance, compassion, and wise control. You feel deeply but don't let emotions control you. Your calm presence and diplomatic wisdom serve you well.",
        "king_of_cups_general_reversed": "Emotional manipulation, coldness, volatility, or repression. You're either controlling through emotions or refusing to feel. Neither extreme serves you. Find balance.",
        
        // PENTACLES SUIT - Ace of Pentacles
        "ace_of_pentacles_love_upright": "New relationship with solid potential and real-world stability. Love grounded in reality and practical commitment. Material security supports emotional connection. Tangible beginnings.",
        "ace_of_pentacles_love_reversed": "Romantic opportunity missed or poor planning in love. Relationship lacks material foundation. Financial instability affects partnership. Greed damages connection.",
        
        "ace_of_pentacles_career_upright": "Excellent new career opportunity with real potential. Solid job offer or business venture. Material success within reach. Professional manifestation begins.",
        "ace_of_pentacles_career_reversed": "Career opportunity missed or poor professional planning. Job prospects don't pan out. Financial instability in work. Need better preparation and timing.",
        
        "ace_of_pentacles_finance_upright": "New financial opportunity and material manifestation. Excellent time for investments and money ventures. Abundance begins to flow. Prosperity is tangible and real.",
        "ace_of_pentacles_finance_reversed": "Financial opportunity lost or poor money planning. Investments don't work out. Scarcity mindset blocks abundance. Greed undermines prosperity. Reassess approach.",
        
        "ace_of_pentacles_health_upright": "New health beginning with tangible results. Body responds well to wellness efforts. Physical manifestation of healing. Solid foundation for long-term health.",
        "ace_of_pentacles_health_reversed": "Health opportunity missed or poor wellness planning. Physical efforts don't yield results. Need better health foundation and practical approach.",
        
        "ace_of_pentacles_general_upright": "New material opportunity and manifestation. This is the seed of real-world abundance—whether financial, physical, or practical. The beginning of something solid and lasting.",
        "ace_of_pentacles_general_reversed": "Lost opportunities, poor planning, or scarcity thinking. Material manifestation is blocked. Greed or lack of preparation undermines success. Get grounded and try again.",
        
        // Two of Pentacles
        "two_of_pentacles_love_upright": "Balancing relationship with other life demands. Juggling love and responsibilities successfully. Adaptability in partnership. Keeping romance alive despite busyness.",
        "two_of_pentacles_love_reversed": "Relationship imbalance due to life demands. Too many responsibilities strain love. Overwhelmed by juggling partnership and everything else. Something must give.",
        
        "two_of_pentacles_career_upright": "Successfully managing multiple professional responsibilities. Adaptability serves your career well. Flexible approach to work challenges. You're juggling and succeeding.",
        "two_of_pentacles_career_reversed": "Professional overwhelm and imbalance. Too many work responsibilities. Disorganization affects career. Stress from juggling too much. Need to prioritize.",
        
        "two_of_pentacles_finance_upright": "Successfully balancing financial demands. Flexible money management serves you. Juggling resources wisely. Adaptable approach to financial challenges.",
        "two_of_pentacles_finance_reversed": "Financial imbalance and overwhelm. Juggling too many money demands unsuccessfully. Disorganized finances create stress. Need better budget and priorities.",
        
        "two_of_pentacles_health_upright": "Successfully balancing health with life demands. Flexible wellness approach works. Managing physical needs despite busy life. Adaptability supports wellbeing.",
        "two_of_pentacles_health_reversed": "Health suffers from life imbalance. Too overwhelmed to care for body. Stress from juggling everything affects wellness. Need to prioritize self-care.",
        
        "two_of_pentacles_general_upright": "Balance, adaptability, and juggling priorities successfully. You're managing multiple demands with grace and flexibility. Life is busy but you're handling it well.",
        "two_of_pentacles_general_reversed": "Imbalance, overwhelm, and too much juggling. You're dropping balls and feeling stressed. Disorganization creates chaos. Time to prioritize and let some things go.",
        
        // Three of Pentacles
        "three_of_pentacles_love_upright": "Building relationship through teamwork and collaboration. Quality time and effort strengthen partnership. Working together on shared goals. Love built on solid foundation.",
        "three_of_pentacles_love_reversed": "Lack of teamwork strains relationship. Poor collaboration or unequal effort. Conflicts about shared goals. Quality of partnership suffers. Work together better.",
        
        "three_of_pentacles_career_upright": "Professional success through collaboration and skilled teamwork. Your expertise is recognized. Quality work and cooperation bring advancement. You're building something lasting.",
        "three_of_pentacles_career_reversed": "Workplace disorganization and lack of teamwork. Poor collaboration affects results. Conflicts with colleagues. Quality of work suffers. Communication breakdown.",
        
        "three_of_pentacles_finance_upright": "Financial success through collaboration and skilled effort. Teamwork brings prosperity. Quality financial planning pays off. Building wealth through expertise.",
        "three_of_pentacles_finance_reversed": "Financial disorganization or poor money teamwork. Conflicts about shared resources. Quality of financial planning suffers. Need better collaboration.",
        
        "three_of_pentacles_health_upright": "Health success through teamwork with practitioners. Quality wellness efforts pay off. Skilled approach to health. Building solid foundation through collaboration.",
        "three_of_pentacles_health_reversed": "Health disorganization or poor collaboration with care team. Quality of wellness efforts suffers. Conflicts about treatment. Need better health teamwork.",
        
        "three_of_pentacles_general_upright": "Teamwork, collaboration, and skilled quality work. You're building something lasting through cooperation and expertise. Your efforts are recognized. Success through shared goals.",
        "three_of_pentacles_general_reversed": "Lack of teamwork, disorganization, and poor quality results. Conflicts disrupt progress. Collaboration fails. Skills aren't recognized. Better communication and effort needed.",
        
        // Four of Pentacles
        "four_of_pentacles_love_upright": "Security and stability in relationship but possibly too much control. You're holding on tight to love. This creates safety but may limit growth. Balance security with openness.",
        "four_of_pentacles_love_reversed": "Possessiveness and greed damage relationship. Holding on too tight out of fear. Materialism over authentic connection. Control issues strain love. Let go.",
        
        "four_of_pentacles_career_upright": "Professional security through careful control. Stable career but possibly too conservative. Your caution protects you but may limit growth. Balance safety with risk.",
        "four_of_pentacles_career_reversed": "Career stagnation through excessive caution. Greed or possessiveness at work. Holding too tight to position or control. Fear prevents professional growth.",
        
        "four_of_pentacles_finance_upright": "Financial security through careful conservation. Your resources are protected but possibly too controlled. Healthy saving but be careful of hoarding. Find balance.",
        "four_of_pentacles_finance_reversed": "Financial greed or excessive hoarding. Possessiveness about money prevents flow. Materialism over wellbeing. Control over resources backfires. Loosen grip.",
        
        "four_of_pentacles_health_upright": "Health stability through careful control. Protective approach to wellness. You're guarding your physical resources wisely but don't let fear dominate.",
        "four_of_pentacles_health_reversed": "Excessive control over health creates rigidity. Possessive about body or wellness approach. Fear-based health decisions. Need more flexibility and trust.",
        
        "four_of_pentacles_general_upright": "Security, conservation, and control. You're protecting your resources and holding on tight. This creates stability but check if fear is making you too rigid. Balance needed.",
        "four_of_pentacles_general_reversed": "Greed, possessiveness, and holding on too tight. Materialism and excessive control backfire. You're blocking flow through fear. Let go and trust.",
        
        // Five of Pentacles
        "five_of_pentacles_love_upright": "Relationship struggles and feeling left out in the cold. Financial stress affects love. Isolation in partnership. Help is available but you're not seeing it. Look for the light.",
        "five_of_pentacles_love_reversed": "Recovery from relationship hardship. Finding support and renewed hope in love. Coming in from the cold. Accepting help strengthens partnership.",
        
        "five_of_pentacles_career_upright": "Professional struggle and workplace isolation. Job loss or financial hardship from work. You feel excluded or unsupported. Help exists but you must seek it.",
        "five_of_pentacles_career_reversed": "Career recovery and renewed hope. Finding professional support. Coming out of workplace hardship. Accepting help improves situation.",
        
        "five_of_pentacles_finance_upright": "Financial hardship and loss. Money struggles create stress. You feel impoverished even if help is nearby. Reach out—resources and support are available.",
        "five_of_pentacles_finance_reversed": "Financial recovery and improved circumstances. Finding support and charity. Renewed hope about money. Accepting help restores stability.",
        
        "five_of_pentacles_health_upright": "Health struggles and physical hardship. Feeling isolated in illness. Resources for healing exist but you're not accessing them. Seek support and care.",
        "five_of_pentacles_health_reversed": "Health recovery and renewed hope. Finding medical support and healing resources. Coming through illness. Accepting help improves wellness.",
        
        "five_of_pentacles_general_upright": "Financial loss, hardship, isolation, and struggle. You're in a difficult time and feel alone in it. But here's the truth: help exists. Look for the lighted window nearby.",
        "five_of_pentacles_general_reversed": "Recovery, renewed hope, and finding support. You're coming through hardship. Accepting help and charity restores you. The worst is behind you.",
        
        // Six of Pentacles
        "six_of_pentacles_love_upright": "Generous giving and receiving in relationships. Balanced exchange of support and care. Charity and kindness flow both ways in love. Healthy partnership dynamics.",
        "six_of_pentacles_love_reversed": "Unbalanced giving in relationships. Strings attached to love or support. One person gives too much or takes too much. Debt mentality affects partnership. Restore balance.",
        
        "six_of_pentacles_career_upright": "Professional generosity and fair compensation. Your work is valued and rewarded. Giving and receiving support at work. Mentorship benefits career.",
        "six_of_pentacles_career_reversed": "Workplace unfairness or one-sided professional relationships. Strings attached to opportunities. Debt or obligation at work. Power imbalances affect career.",
        
        "six_of_pentacles_finance_upright": "Financial generosity and balanced prosperity. You have enough to share. Giving and receiving money flows well. Charity brings joy and maintains balance.",
        "six_of_pentacles_finance_reversed": "Financial imbalance or strings attached to money. One-sided financial relationships. Debt creates dependency. Selfishness or exploitation with resources.",
        
        "six_of_pentacles_health_upright": "Balanced approach to health giving and receiving. Sharing wellness resources generously. Receiving care graciously. Health support flows both ways.",
        "six_of_pentacles_health_reversed": "Imbalanced health support. Giving too much care to others or refusing to receive help. Strings attached to wellness resources. Restore balance.",
        
        "six_of_pentacles_general_upright": "Generosity, charity, sharing, and balanced give-and-take. You're in a position to help others while also receiving support when needed. Prosperity flows through giving.",
        "six_of_pentacles_general_reversed": "One-sided relationships, strings attached, debt, or selfishness. The balance of giving and receiving is off. Power dynamics create inequality. Restore fairness.",
        
        // Seven of Pentacles
        "seven_of_pentacles_love_upright": "Patience with relationship growth and assessing love's progress. You've invested time and effort—now waiting to see results. Long-term view of partnership. Trust the process.",
        "seven_of_pentacles_love_reversed": "Impatience with relationship progress. Disappointment in love's returns. Feels like wasted effort on partnership. Reevaluate investment or adjust expectations.",
        
        "seven_of_pentacles_career_upright": "Patient career building and assessing professional progress. Your work efforts are growing slowly but surely. Long-term view pays off. Trust your investment.",
        "seven_of_pentacles_career_reversed": "Career impatience and disappointment in progress. Work feels unrewarding. Efforts don't yield expected results. Reevaluate professional path or adjust approach.",
        
        "seven_of_pentacles_finance_upright": "Patient financial growth and long-term investment view. Your money efforts are bearing fruit slowly. Trust the process of wealth building. Perseverance pays.",
        "seven_of_pentacles_finance_reversed": "Financial impatience and disappointment in returns. Investments don't meet expectations. Feels like wasted money effort. Reevaluate strategy.",
        
        "seven_of_pentacles_health_upright": "Patient health progress and long-term wellness view. Your health efforts are working slowly but surely. Trust your body's timeline. Perseverance brings results.",
        "seven_of_pentacles_health_reversed": "Impatience with health progress. Wellness efforts don't yield expected results. Disappointment in body's response. Reevaluate approach or adjust expectations.",
        
        "seven_of_pentacles_general_upright": "Patience, long-term investment, and assessment of progress. You've worked hard and now you're pausing to see results. Trust the process—your efforts will pay off.",
        "seven_of_pentacles_general_reversed": "Impatience, lack of progress, and wasted effort. Your investments aren't paying off as expected. Disappointment makes you question everything. Reevaluate or persevere.",
        
        // Eight of Pentacles
        "eight_of_pentacles_love_upright": "Dedicated effort to improve relationship. Working on communication and connection skills. Crafting quality partnership through attention to detail. Love as practice.",
        "eight_of_pentacles_love_reversed": "Lack of effort in relationship or perfectionism strains love. Not working on partnership skills. Shortcuts damage connection quality. Reevaluate commitment level.",
        
        "eight_of_pentacles_career_upright": "Skill development and dedication to professional craft. Diligent work and attention to detail bring career success. You're mastering your field through focused effort.",
        "eight_of_pentacles_career_reversed": "Lack of professional focus or shortcuts at work. Mediocrity from insufficient effort. Perfectionism creates paralysis. Balance quality with completion.",
        
        "eight_of_pentacles_finance_upright": "Financial skill development and diligent money management. Detailed attention to resources. Building wealth through dedicated effort and mastery.",
        "eight_of_pentacles_finance_reversed": "Financial lack of focus or money management shortcuts. Mediocre financial results. Perfectionism prevents financial progress. Need better effort and attention.",
        
        "eight_of_pentacles_health_upright": "Dedicated health effort and skill development in wellness. Detailed attention to body's needs. Mastering health practices through diligent focus.",
        "eight_of_pentacles_health_reversed": "Lack of health focus or wellness shortcuts. Mediocre self-care results. Perfectionism about health creates stress. Balance effort with self-compassion.",
        
        "eight_of_pentacles_general_upright": "Skill development, diligence, craftsmanship, and attention to detail. You're dedicating yourself to mastery. Quality work through focused effort. You're becoming an expert.",
        "eight_of_pentacles_general_reversed": "Lack of focus, mediocrity, shortcuts, or perfectionism. You're either not putting in effort or obsessing over details. Find balance between quality and completion.",
        
        // Nine of Pentacles
        "nine_of_pentacles_love_upright": "Independence and self-sufficiency in love. You're complete on your own and relationship enhances rather than completes you. Luxury and quality in partnership.",
        "nine_of_pentacles_love_reversed": "Relationship codependency or isolation from over-independence. Living beyond means to impress partner. Work-life imbalance affects love. Find healthy interdependence.",
        
        "nine_of_pentacles_career_upright": "Professional independence and career accomplishment. Self-made success and recognition. You've built something impressive through your own efforts. Enjoy your achievement.",
        "nine_of_pentacles_career_reversed": "Career overwork or professional isolation. Hustling without balance. Living beyond means or dependent on job. Lost sense of accomplishment. Reassess.",
        
        "nine_of_pentacles_finance_upright": "Financial independence and self-made prosperity. Luxury earned through your efforts. Self-sufficiency with resources. Enjoying abundance you created.",
        "nine_of_pentacles_finance_reversed": "Financial overwork or living beyond means. Dependency on income source. Hustling without enjoying fruits. Isolation through materialism. Find balance.",
        
        "nine_of_pentacles_health_upright": "Health independence and wellness accomplishment. Self-sufficient in caring for your body. Enjoying physical luxury and comfort you've earned through effort.",
        "nine_of_pentacles_health_reversed": "Health suffers from overwork. Self-care neglect due to hustling. Living in ways that tax body. Need for better health-work balance.",
        
        "nine_of_pentacles_general_upright": "Independence, luxury, self-sufficiency, and accomplishment. You've built this through your own efforts. Enjoy the fruits of your labor. You earned this abundance.",
        "nine_of_pentacles_general_reversed": "Overworking, hustling, living beyond means, or isolation through independence. You've lost balance. Dependency disguised as independence. Reassess priorities.",
        
        // Ten of Pentacles
        "ten_of_pentacles_love_upright": "Relationship stability and family legacy in love. Long-term partnership built on solid foundation. Generational blessing and lasting commitment. Building family together.",
        "ten_of_pentacles_love_reversed": "Family disputes affect relationship. Financial instability strains partnership. Broken family legacy or relationship insecurity. Foundation needs repair.",
        
        "ten_of_pentacles_career_upright": "Career legacy and professional establishment. Building lasting work impact. Family business success. Your professional achievements will outlast you.",
        "ten_of_pentacles_career_reversed": "Career instability or professional family disputes. Legacy threatened by conflict. Financial failure at work. Foundation of professional life crumbling.",
        
        "ten_of_pentacles_finance_upright": "Financial wealth and lasting prosperity. Legacy money and generational wealth. Establishment of lasting financial security. Resources that will outlast you.",
        "ten_of_pentacles_finance_reversed": "Financial failure or family money disputes. Wealth loss and instability. Debt threatens legacy. Foundation of financial security crumbling.",
        
        "ten_of_pentacles_health_upright": "Health legacy and lasting wellness foundation. Physical strength runs in family. Generational health wisdom. Building health that lasts.",
        "ten_of_pentacles_health_reversed": "Health instability or inherited health challenges. Physical foundation threatened. Family health patterns affect you. Need to break negative cycles.",
        
        "ten_of_pentacles_general_upright": "Wealth, legacy, family, and lasting establishment. You're building something that will outlast you. Generational blessings and permanent security. This is about dynasty.",
        "ten_of_pentacles_general_reversed": "Financial failure, family disputes, instability, and broken legacy. What should be secure is threatened. Debt and conflict undermine the foundation. Repair needed.",
        
        // Page of Pentacles
        "page_of_pentacles_love_upright": "New relationship with practical potential. Ambitious approach to love. Learning about partnership. Grounded romantic beginnings with real-world possibility.",
        "page_of_pentacles_love_reversed": "Relationship lacks direction or practical foundation. Procrastination about love commitment. Poor planning in partnership. Missed romantic opportunity.",
        
        "page_of_pentacles_career_upright": "New career opportunity or beginning professional journey. Ambitious learning phase. Practical approach to work. Manifestation of job prospects.",
        "page_of_pentacles_career_reversed": "Career procrastination or lack of professional progress. Poor work planning. Missed job opportunity. Need more ambition and focus.",
        
        "page_of_pentacles_finance_upright": "New financial opportunity or learning about money. Ambitious approach to wealth building. Practical manifestation begins. Good time for financial education.",
        "page_of_pentacles_finance_reversed": "Financial procrastination or poor money planning. Missed investment opportunity. Lack of financial progress. Need better money education and action.",
        
        "page_of_pentacles_health_upright": "New health beginning or learning wellness practices. Ambitious approach to fitness. Practical health manifestation. Good time for body education.",
        "page_of_pentacles_health_reversed": "Health procrastination or poor wellness planning. Missed health opportunity. Lack of physical progress. Need better health education and action.",
        
        "page_of_pentacles_general_upright": "New opportunity, learning, ambition, and practical manifestation. You're at the beginning of something solid. Stay focused and diligent. Study and grow.",
        "page_of_pentacles_general_reversed": "Procrastination, lack of progress, poor planning, and missed opportunities. You're not following through. Get practical and take action.",
        
        // Knight of Pentacles
        "knight_of_pentacles_love_upright": "Reliable, steady, and hardworking approach to relationship. Patient courtship and dependable partnership. Routine creates security in love. Slow but sure progress.",
        "knight_of_pentacles_love_reversed": "Relationship laziness or obsessive routine. Work-life imbalance affects love. Perfectionism prevents partnership progress. Too slow or too rigid in love.",
        
        "knight_of_pentacles_career_upright": "Reliable, hardworking professional approach. Steady career progress through routine and dedication. Conservative but successful work style. Dependability serves you.",
        "knight_of_pentacles_career_reversed": "Career laziness or work obsessiveness. Perfectionism prevents professional progress. Routine becomes rut. Work-life imbalance from career rigidity.",
        
        "knight_of_pentacles_finance_upright": "Reliable, conservative financial approach. Steady wealth building through hard work and routine. Patient investment strategy. Dependable money management.",
        "knight_of_pentacles_finance_reversed": "Financial laziness or money obsessiveness. Perfectionism prevents prosperity. Too conservative or too rigid with resources. Need more flexibility.",
        
        "knight_of_pentacles_health_upright": "Reliable, steady wellness approach. Patient health progress through routine and hard work. Conservative but effective health practices. Dependability serves body.",
        "knight_of_pentacles_health_reversed": "Health laziness or wellness obsessiveness. Perfectionism about body prevents progress. Routine becomes unhealthy rut. Work-health imbalance.",
        
        "knight_of_pentacles_general_upright": "Reliability, hard work, routine, and conservative approach. You're making steady, patient progress. Dependable and dedicated. Slow but sure wins the race.",
        "knight_of_pentacles_general_reversed": "Laziness, obsessiveness, work-life imbalance, or perfectionism. You're either not moving at all or so rigid you can't adapt. Find balance.",
        
        // Queen of Pentacles
        "queen_of_pentacles_love_upright": "Nurturing, practical relationship approach. Down-to-earth love and providing for partner. Grounded care creates security. Home and heart align beautifully.",
        "queen_of_pentacles_love_reversed": "Self-care neglect in relationship or smothering partner. Work-home imbalance affects love. Jealousy or materialism damages partnership. Need better boundaries.",
        
        "queen_of_pentacles_career_upright": "Nurturing, practical professional approach. Down-to-earth leadership and providing for team. Your groundedness creates workplace security. Success through caring.",
        "queen_of_pentacles_career_reversed": "Self-care neglect from work demands or smothering colleagues. Work-home imbalance creates problems. Professional jealousy or materialism affects career.",
        
        "queen_of_pentacles_finance_upright": "Nurturing, practical approach to money. Down-to-earth prosperity and financial providing. Grounded generosity creates abundance. Wealth with warmth.",
        "queen_of_pentacles_finance_reversed": "Financial self-care neglect or money obsession. Materialism over wellbeing. Jealousy about others' wealth. Work-life imbalance affects finances.",
        
        "queen_of_pentacles_health_upright": "Nurturing, practical approach to wellness. Down-to-earth self-care and body-wise decisions. Grounded health practices. Providing for your body's needs.",
        "queen_of_pentacles_health_reversed": "Self-care neglect from caring for others. Work-health imbalance. Smothering concerns about body. Need practical self-care boundaries.",
        
        "queen_of_pentacles_general_upright": "Nurturing, practical, providing, and down-to-earth. You create security through grounded care. Financial and emotional abundance flow from your warmth. Home and work harmonize.",
        "queen_of_pentacles_general_reversed": "Self-care neglect, work-home imbalance, smothering, or jealousy. You're either giving too much or obsessing over material concerns. Restore balance.",
        
        // King of Pentacles
        "king_of_pentacles_love_upright": "Abundant, secure relationship built on discipline and leadership. Providing stable foundation for love. Material comfort supports emotional connection. Mature partnership.",
        "king_of_pentacles_love_reversed": "Relationship greed or materialism over love. Stubborn control in partnership. Corrupt approach to commitment. Using wealth to manipulate. Unhealthy power dynamics.",
        
        "king_of_pentacles_career_upright": "Career abundance through leadership and discipline. Professional security and material success. Your authority and business acumen bring prosperity. Established expertise.",
        "king_of_pentacles_career_reversed": "Professional greed or career corruption. Stubborn leadership and materialistic approach. Abusing power for personal gain. Work obsession over ethics.",
        
        "king_of_pentacles_finance_upright": "Financial abundance and material mastery. Disciplined wealth building and secure prosperity. Leadership in money matters. Your business acumen creates lasting wealth.",
        "king_of_pentacles_finance_reversed": "Financial greed and materialism. Corruption in money matters. Stubborn approach to wealth. Using resources to control others. Ethical issues with prosperity.",
        
        "king_of_pentacles_health_upright": "Health abundance through discipline and leadership. Secure approach to wellness. Material resources support physical care. Mastery over body's needs.",
        "king_of_pentacles_health_reversed": "Health affected by greed or materialism. Stubborn about wellness approach. Corrupt body practices. Obsession over physical control. Need more flexibility.",
        
        "king_of_pentacles_general_upright": "Abundance, security, leadership, and discipline. You've mastered the material world through wisdom and hard work. Financial success and stability are yours. Share generously.",
        "king_of_pentacles_general_reversed": "Greed, materialism, corruption, or stubborn control. You're abusing power or obsessing over wealth. Material success without ethics. Lose control to find balance.",
        
        // SWORDS SUIT - Ace of Swords
        "ace_of_swords_love_upright": "Mental clarity and breakthrough in love. Truth cuts through romantic confusion. New perspective on relationships. Clear communication transforms partnership.",
        "ace_of_swords_love_reversed": "Romantic confusion and lack of clarity. Miscommunication damages love. Chaotic thoughts about relationship. Mental breakthrough blocked. Seek truth.",
        
        "ace_of_swords_career_upright": "Professional breakthrough and mental clarity. New ideas and clear thinking advance career. Truth and communication bring success. Intellectual victory at work.",
        "ace_of_swords_career_reversed": "Career confusion and professional miscommunication. Chaotic thinking affects work. Lack of clarity blocks advancement. Mental fog prevents breakthrough.",
        
        "ace_of_swords_finance_upright": "Financial clarity and breakthrough. Clear thinking about money. New ideas bring prosperity. Truth about resources empowers you. Mental approach to wealth.",
        "ace_of_swords_finance_reversed": "Financial confusion and lack of money clarity. Chaotic thinking about resources. Miscommunication affects finances. Mental fog blocks prosperity.",
        
        "ace_of_swords_health_upright": "Health clarity and mental breakthrough about wellness. Clear diagnosis or understanding. New ideas improve health. Truth about body empowers you.",
        "ace_of_swords_health_reversed": "Health confusion and unclear symptoms. Mental chaos affects wellness. Miscommunication with providers. Lack of clarity blocks healing.",
        
        "ace_of_swords_general_upright": "Breakthrough, clarity, new ideas, and mental power. The fog lifts and you see truth clearly. Sharp thinking cuts through confusion. This is your moment of intellectual victory.",
        "ace_of_swords_general_reversed": "Confusion, chaos, lack of clarity, and miscommunication. Your thinking is muddled. Truth is obscured. Mental breakthrough is blocked. Seek clarity before acting.",
        
        // Two of Swords
        "two_of_swords_love_upright": "Difficult romantic decision or relationship stalemate. Avoiding love truth creates tension. You're stuck between choices. Remove the blindfold and see clearly.",
        "two_of_swords_love_reversed": "Romantic indecision worsens or breakthrough from relationship stalemate. Overwhelming love choices or finally making decision. Confusion clears.",
        
        "two_of_swords_career_upright": "Difficult professional decision or career stalemate. Avoiding work truth. Stuck between job choices. Information needed for decision.",
        "two_of_swords_career_reversed": "Career indecision worsens or professional stalemate breaks. Delayed work decisions or breakthrough finally comes. Choose path forward.",
        
        "two_of_swords_finance_upright": "Difficult financial decision or money stalemate. Avoiding money truth creates stress. Stuck between financial choices. Need more information.",
        "two_of_swords_finance_reversed": "Financial indecision worsens or money breakthrough comes. Overwhelming financial choices or finally deciding. Face truth.",
        
        "two_of_swords_health_upright": "Difficult health decision or wellness stalemate. Avoiding body truth. Stuck between treatment choices. Need more health information.",
        "two_of_swords_health_reversed": "Health indecision worsens or wellness breakthrough. Delayed health decisions or finally choosing treatment. Face body truth.",
        
        "two_of_swords_general_upright": "Difficult decisions, stalemate, avoidance, and denial. You're stuck and refusing to see the truth. Remove the blindfold. Make the choice you're avoiding.",
        "two_of_swords_general_reversed": "Indecision worsens, confusion deepens, or breakthrough arrives. Delayed decisions create more problems or stalemate finally breaks. Face truth now.",
        
        // Three of Swords
        "three_of_swords_love_upright": "Heartbreak and emotional pain in love. Betrayal or deep romantic disappointment. Truth hurts but must be faced. Grief in relationships is real and valid.",
        "three_of_swords_love_reversed": "Recovery from romantic heartbreak. Forgiveness begins healing. Moving on from love pain. The worst of relationship grief passes.",
        
        "three_of_swords_career_upright": "Professional heartbreak and work disappointment. Betrayal or rejection at work. Career pain is real. Truth about job situation hurts but clarifies.",
        "three_of_swords_career_reversed": "Recovery from career heartbreak. Forgiveness of professional betrayal. Moving on from work pain. Healing begins.",
        
        "three_of_swords_finance_upright": "Financial heartbreak and money pain. Betrayal or loss involving resources. Truth about finances hurts. Grief about money is valid.",
        "three_of_swords_finance_reversed": "Recovery from financial heartbreak. Forgiveness around money issues. Moving on from financial pain. Healing begins.",
        
        "three_of_swords_health_upright": "Health heartbreak and physical pain. Difficult diagnosis or body betrayal. Truth about health hurts but brings clarity. Grief about wellness is valid.",
        "three_of_swords_health_reversed": "Recovery from health heartbreak. Forgiveness of body. Moving on from physical pain. Healing begins.",
        
        "three_of_swords_general_upright": "Heartbreak, sorrow, pain, and grief. Truth cuts deep and hurts. Betrayal or loss pierces your heart. Your pain is real and valid. Feel it fully to heal.",
        "three_of_swords_general_reversed": "Recovery, forgiveness, moving on, and healing. The worst of the pain is passing. You're beginning to mend. Grief transforms into wisdom.",
        
        // Four of Swords
        "four_of_swords_love_upright": "Relationship rest and romantic contemplation. Taking break from love intensity. Meditation on partnership needs. Recovery time strengthens connection.",
        "four_of_swords_love_reversed": "Restless relationship or avoiding necessary love reflection. Burnout from partnership or refusing recovery time. Stress prevents relationship progress.",
        
        "four_of_swords_career_upright": "Career rest and professional contemplation. Taking work break for recovery. Mental recuperation improves performance. Strategic pause serves career.",
        "four_of_swords_career_reversed": "Professional restlessness or career burnout. Refusing work recovery time. Stress prevents professional progress. Lack of rest undermines career.",
        
        "four_of_swords_finance_upright": "Financial rest and money contemplation. Taking break from financial stress. Meditation on resource management. Recovery improves financial decisions.",
        "four_of_swords_finance_reversed": "Financial restlessness or money burnout. Refusing necessary financial pause. Stress prevents smart money decisions. Rest needed.",
        
        "four_of_swords_health_upright": "Physical rest and health recovery. Mental recuperation supports healing. Meditation and contemplation benefit body. Strategic pause restores wellness.",
        "four_of_swords_health_reversed": "Restless health or refusing recovery. Burnout prevents healing. Stress undermines wellness. Lack of rest harms body. Stop and recover.",
        
        "four_of_swords_general_upright": "Rest, recovery, contemplation, and meditation. Your mind and body need a break. Strategic pause restores energy. Stillness is action. Give yourself permission to stop.",
        "four_of_swords_general_reversed": "Restlessness, burnout, stress, and refusing rest. You're pushing too hard and it's counterproductive. Lack of recovery undermines progress. Stop now.",
        
        // Five of Swords
        "five_of_swords_love_upright": "Relationship conflict and win-at-all-costs mentality. Betrayal or fighting dirty in love. Victory but at what price? Examine if winning is worth losing the relationship.",
        "five_of_swords_love_reversed": "Reconciliation after conflict or making amends in love. Moving on from relationship betrayal. Compromise replaces combat. Healing begins.",
        
        "five_of_swords_career_upright": "Professional conflict and workplace betrayal. Win-at-all-costs approach at work. Career victory but damaged relationships. Examine your methods.",
        "five_of_swords_career_reversed": "Workplace reconciliation or making professional amends. Moving on from career conflict. Compromise and cooperation return.",
        
        "five_of_swords_finance_upright": "Financial conflict and money betrayal. Win-at-all-costs with resources. Financial victory but damaged relationships. Examine if wealth is worth the cost.",
        "five_of_swords_finance_reversed": "Financial reconciliation or making money amends. Moving on from resource conflict. Compromise about finances.",
        
        "five_of_swords_health_upright": "Health conflict and fighting body. Win-at-all-costs approach to wellness. Pushing too hard damages health. Examine your methods.",
        "five_of_swords_health_reversed": "Health reconciliation with body. Making amends with physical self. Moving on from wellness conflict. Cooperation with body.",
        
        "five_of_swords_general_upright": "Conflict, defeat, win-at-all-costs, and betrayal. You might win the battle but lose the war. Fighting dirty damages relationships. Is this victory worth the cost?",
        "five_of_swords_general_reversed": "Reconciliation, making amends, moving on, and compromise. You're ready to end the conflict. Choosing peace over victory. Cooperation replaces combat.",
        
        // Six of Swords
        "six_of_swords_love_upright": "Relationship transition and moving forward from love pain. Healing journey in partnership. Leaving romantic turbulence for calmer waters. Progress through difficulty.",
        "six_of_swords_love_reversed": "Stuck in past relationship pain. Resisting necessary love transition. Unfinished romantic business prevents moving forward. Rough emotional waters continue.",
        
        "six_of_swords_career_upright": "Career transition and professional healing journey. Moving forward from workplace difficulty. Leaving turbulent job for calmer prospects. Progress through challenges.",
        "six_of_swords_career_reversed": "Stuck in past career pain. Resisting necessary professional transition. Unfinished work business blocks progress. Continued career turbulence.",
        
        "six_of_swords_finance_upright": "Financial transition and moving forward from money difficulty. Healing journey with resources. Leaving financial turbulence for stability. Progress through hardship.",
        "six_of_swords_finance_reversed": "Stuck in past financial pain. Resisting necessary money transition. Unfinished financial business prevents progress. Continued resource turbulence.",
        
        "six_of_swords_health_upright": "Health transition and healing journey. Moving forward from physical difficulty. Leaving wellness turbulence for recovery. Progress through illness.",
        "six_of_swords_health_reversed": "Stuck in past health pain. Resisting necessary wellness transition. Unfinished healing business blocks recovery. Continued physical turbulence.",
        
        "six_of_swords_general_upright": "Transition, moving forward, healing journey, and release. You're leaving turbulent waters for calmer ones. Progress is happening even if slow. Trust the journey.",
        "six_of_swords_general_reversed": "Stuck in past, resistance to transition, unfinished business, and rough waters ahead. You're not ready to move on. Let go to progress.",
        
        // Seven of Swords
        "seven_of_swords_love_upright": "Relationship deception or strategic approach to love. Sneaking around or getting away with something in partnership. Dishonesty damages trust. Examine your methods.",
        "seven_of_swords_love_reversed": "Coming clean in relationship or confessing love secrets. Honesty replaces deception. Rethinking strategic approach to partnership. Truth emerges.",
        
        "seven_of_swords_career_upright": "Professional deception or strategic workplace approach. Sneaky behavior at work. Getting away with something professionally. Examine if methods are ethical.",
        "seven_of_swords_career_reversed": "Coming clean at work or professional confession. Honesty replaces workplace deception. Rethinking career strategy. Truth emerges.",
        
        "seven_of_swords_finance_upright": "Financial deception or strategic money approach. Sneaky resource behavior. Getting away with financial something. Examine if methods are ethical.",
        "seven_of_swords_finance_reversed": "Financial confession or coming clean about money. Honesty replaces financial deception. Rethinking resource strategy. Truth emerges.",
        
        "seven_of_swords_health_upright": "Health deception or strategic wellness approach. Sneaking unhealthy behaviors. Getting away with poor self-care. Examine your methods.",
        "seven_of_swords_health_reversed": "Health confession or coming clean about wellness. Honesty about body needs. Rethinking health strategy. Truth emerges.",
        
        "seven_of_swords_general_upright": "Deception, strategy, sneakiness, and getting away with something. You're being strategic—maybe too strategic. Are your methods ethical? Truth will emerge eventually.",
        "seven_of_swords_general_reversed": "Coming clean, confessing, honesty, and rethinking approach. You're ready to tell the truth. Deception no longer serves you. Choose transparency.",
        
        // Eight of Swords
        "eight_of_swords_love_upright": "Feeling trapped in relationship but chains aren't real. Victim mentality about love. Self-imposed romantic restriction. You have more power than you think.",
        "eight_of_swords_love_reversed": "Release from relationship restrictions. Freedom and new perspective in love. Self-acceptance allows romantic progress. Recognizing your power.",
        
        "eight_of_swords_career_upright": "Feeling trapped professionally but prison is self-made. Career victim mentality. Self-imposed work restrictions. You have more options than you see.",
        "eight_of_swords_career_reversed": "Release from career restrictions. Professional freedom and new perspective. Self-acceptance allows work progress. Recognizing your power.",
        
        "eight_of_swords_finance_upright": "Feeling financially trapped but restrictions are self-imposed. Money victim mentality. You have more financial options than you see.",
        "eight_of_swords_finance_reversed": "Release from financial restrictions. Money freedom and new perspective. Self-acceptance allows prosperity. Recognizing your power.",
        
        "eight_of_swords_health_upright": "Feeling trapped by health but some restrictions are self-imposed. Wellness victim mentality. You have more options than you see.",
        "eight_of_swords_health_reversed": "Release from health restrictions. Wellness freedom and new perspective. Self-acceptance allows healing. Recognizing your power.",
        
        "eight_of_swords_general_upright": "Restriction, imprisonment, victim mentality, and helplessness. You feel trapped but the chains aren't real. You have more power than you think. Remove the blindfold.",
        "eight_of_swords_general_reversed": "Release, freedom, new perspective, and self-acceptance. The restrictions are lifting. You're recognizing your power and options. Liberation begins.",
        
        // Nine of Swords
        "nine_of_swords_love_upright": "Romantic anxiety and relationship worry. Nightmares about love keep you up. Fear about partnership is overwhelming. Your mind torments you. Reach out for support.",
        "nine_of_swords_love_reversed": "Romantic anxiety subsiding and relationship hope emerging. Reaching out for love support. Despair about partnership lifting. Recovery begins.",
        
        "nine_of_swords_career_upright": "Career anxiety and professional worry. Work nightmares and overwhelming job fear. Your mind torments you about career. Reach out for support.",
        "nine_of_swords_career_reversed": "Career anxiety subsiding and professional hope emerging. Reaching out for work support. Despair about job lifting. Recovery begins.",
        
        "nine_of_swords_finance_upright": "Financial anxiety and money worry. Nightmares about resources. Overwhelming fear about finances. Your mind torments you. Reach out for support.",
        "nine_of_swords_finance_reversed": "Financial anxiety subsiding and money hope emerging. Reaching out for financial support. Despair about resources lifting. Recovery begins.",
        
        "nine_of_swords_health_upright": "Health anxiety and wellness worry. Nightmares about body. Overwhelming fear about physical state. Your mind torments you. Reach out for support.",
        "nine_of_swords_health_reversed": "Health anxiety subsiding and wellness hope emerging. Reaching out for medical support. Despair about body lifting. Recovery begins.",
        
        "nine_of_swords_general_upright": "Anxiety, worry, nightmares, and fear. Your mind is your worst enemy right now. Thoughts spiral and keep you up at night. This is primarily mental—reach out for support.",
        "nine_of_swords_general_reversed": "Hope emerging, reaching out for help, and anxiety subsiding. The worst of the despair is passing. You're not alone. Recovery begins when you ask for support.",
        
        // Ten of Swords
        "ten_of_swords_love_upright": "Relationship rock bottom and painful romantic ending. Love betrayal cuts deep. Crisis in partnership. This is the worst it can get—the only way is up.",
        "ten_of_swords_love_reversed": "Recovery from relationship crisis or resisting love ending. Regeneration after romantic rock bottom. Avoiding inevitable partnership conclusion.",
        
        "ten_of_swords_career_upright": "Career rock bottom and painful professional ending. Work betrayal and job crisis. This is the worst it can get—transformation begins here.",
        "ten_of_swords_career_reversed": "Recovery from career crisis or resisting professional ending. Regeneration after work rock bottom. Avoiding inevitable job conclusion.",
        
        "ten_of_swords_finance_upright": "Financial rock bottom and painful money ending. Resource betrayal and financial crisis. This is the worst it can get—rebuilding begins here.",
        "ten_of_swords_finance_reversed": "Recovery from financial crisis or resisting money ending. Regeneration after resource rock bottom. Avoiding inevitable financial conclusion.",
        
        "ten_of_swords_health_upright": "Health rock bottom and physical crisis. Body betrayal and wellness breakdown. This is the worst it can get—healing begins here.",
        "ten_of_swords_health_reversed": "Recovery from health crisis or resisting physical truth. Regeneration after wellness rock bottom. Avoiding inevitable health conclusion.",
        
        "ten_of_swords_general_upright": "Rock bottom, painful ending, betrayal, and crisis. This is as bad as it gets. You're done. But here's the truth: the only way from here is up. Dawn comes.",
        "ten_of_swords_general_reversed": "Recovery, regeneration, resisting end, or delayed disaster. You're either rising from rock bottom or refusing to let something die. Stop resisting.",
        
        // Page of Swords
        "page_of_swords_love_upright": "Curious approach to love and relationship communication. Mental agility in partnership. Vigilant about romantic truth. Messages about love arrive.",
        "page_of_swords_love_reversed": "Relationship gossip or hasty love communication. Scattered romantic thoughts. Cynicism about partnership. Bad relationship news.",
        
        "page_of_swords_career_upright": "Curious professional approach and work communication. Mental agility at job. Vigilant about career truth. Professional messages and learning.",
        "page_of_swords_career_reversed": "Workplace gossip or hasty professional communication. Scattered work thoughts. Career cynicism. Bad job news.",
        
        "page_of_swords_finance_upright": "Curious financial approach and money communication. Mental agility with resources. Vigilant about financial truth. Learning about prosperity.",
        "page_of_swords_finance_reversed": "Financial gossip or hasty money communication. Scattered resource thoughts. Cynicism about prosperity. Bad financial news.",
        
        "page_of_swords_health_upright": "Curious wellness approach and health communication. Mental agility about body. Vigilant about physical truth. Learning about healing.",
        "page_of_swords_health_reversed": "Health gossip or hasty wellness communication. Scattered body thoughts. Cynicism about healing. Bad health news.",
        
        "page_of_swords_general_upright": "Curiosity, mental agility, vigilance, and communication. You're learning, observing, and staying alert. Your mind is sharp and quick. Messages arrive.",
        "page_of_swords_general_reversed": "Gossiping, hastiness, scattered thoughts, and cynicism. Your mind works against you. Slow down and think before speaking. Bad news arrives.",
        
        // Knight of Swords
        "knight_of_swords_love_upright": "Ambitious, fast-moving approach to love. Action-oriented and driven in romance. Quick thinking about relationships. Passionate pursuit of partnership.",
        "knight_of_swords_love_reversed": "Reckless in love or impatient with relationship. Unfocused romantic energy. Impulsive partnership decisions. Slow down and think.",
        
        "knight_of_swords_career_upright": "Ambitious, action-oriented professional approach. Fast-thinking and driven at work. Career advancement through quick decisions. Mental clarity serves ambition.",
        "knight_of_swords_career_reversed": "Reckless career moves or professional impatience. Unfocused work energy. Impulsive job decisions. Slow down and strategize.",
        
        "knight_of_swords_finance_upright": "Ambitious, fast-moving financial approach. Action-oriented money decisions. Quick thinking about resources. Driven toward prosperity.",
        "knight_of_swords_finance_reversed": "Reckless financial moves or money impatience. Unfocused resource energy. Impulsive spending or investments. Slow down and plan.",
        
        "knight_of_swords_health_upright": "Ambitious, action-oriented wellness approach. Fast-moving health improvements. Quick thinking about body needs. Driven toward healing.",
        "knight_of_swords_health_reversed": "Reckless health moves or wellness impatience. Unfocused body energy. Impulsive health decisions. Slow down and listen to body.",
        
        "knight_of_swords_general_upright": "Action, ambition, fast thinking, and driven energy. You're moving quickly and decisively. Mental clarity fuels forward momentum. Strike while the iron is hot.",
        "knight_of_swords_general_reversed": "Recklessness, impatience, unfocused energy, and impulsiveness. You're moving too fast without thinking. Slow down before you crash.",
        
        // Queen of Swords
        "queen_of_swords_love_upright": "Independent, clear-thinking approach to love. Honest and direct in relationships. Intellectual partnership. Truth and boundaries strengthen connection.",
        "queen_of_swords_love_reversed": "Coldness or cruelty in love. Bitter about relationships. Isolated through defensiveness. Harsh honesty damages partnership. Soften.",
        
        "queen_of_swords_career_upright": "Independent, clear-thinking professional approach. Honest and direct at work. Intellectual leadership. Truth and boundaries serve career.",
        "queen_of_swords_career_reversed": "Professional coldness or workplace cruelty. Career bitterness. Isolated through defensiveness. Harsh communication damages work relationships.",
        
        "queen_of_swords_finance_upright": "Independent, clear-thinking financial approach. Honest and direct about money. Intellectual resource management. Truth about finances empowers.",
        "queen_of_swords_finance_reversed": "Financial coldness or money cruelty. Bitter about resources. Isolated through financial defensiveness. Harsh money decisions damage relationships.",
        
        "queen_of_swords_health_upright": "Independent, clear-thinking wellness approach. Honest about body needs. Intellectual health management. Truth about physical state empowers.",
        "queen_of_swords_health_reversed": "Health coldness or cruel self-talk about body. Bitter about wellness. Isolated through physical defensiveness. Harsh health approach damages self.",
        
        "queen_of_swords_general_upright": "Independence, clear thinking, honesty, and directness. You see truth clearly and speak it. Boundaries protect you. Your mind is sharp and your heart is guarded wisely.",
        "queen_of_swords_general_reversed": "Coldness, cruelty, bitterness, and isolation. Your sharp mind has become a weapon. Defensiveness isolates you. Soften your edges.",
        
        // King of Swords
        "king_of_swords_love_upright": "Authoritative, truthful approach to love. Intellectual power and clear mind in relationships. Honest leadership in partnership. Logic serves connection.",
        "king_of_swords_love_reversed": "Relationship manipulation or abuse of power in love. Tyrannical control over partner. Cruelty through intellect. Using truth as weapon.",
        
        "king_of_swords_career_upright": "Authoritative, truthful professional approach. Intellectual power and clear mind at work. Honest career leadership. Logic and ethics guide success.",
        "king_of_swords_career_reversed": "Professional manipulation or abuse of workplace power. Tyrannical leadership. Career cruelty. Using intellect and position as weapons.",
        
        "king_of_swords_finance_upright": "Authoritative, truthful financial approach. Intellectual power with money. Clear-minded resource management. Honest leadership in prosperity.",
        "king_of_swords_finance_reversed": "Financial manipulation or abuse of money power. Tyrannical control over resources. Using wealth as weapon. Cruel financial leadership.",
        
        "king_of_swords_health_upright": "Authoritative, clear-minded wellness approach. Intellectual power serves health. Honest assessment of body. Logic guides healing.",
        "king_of_swords_health_reversed": "Health manipulation or tyrannical control over body. Cruel wellness approach. Abusing intellectual power for harmful health practices.",
        
        "king_of_swords_general_upright": "Authority, truth, intellectual power, and clear mind. You lead with logic and ethics. Your judgment is sound and your communication is authoritative. Power through clarity.",
        "king_of_swords_general_reversed": "Manipulation, abuse of power, tyranny, and cruelty. You're using your intellect and position as weapons. Logic without compassion becomes tyranny. Soften.",
        
        // WANDS SUIT - Ace of Wands
        "ace_of_wands_love_upright": "Passionate new romantic beginning. Inspired love and creative connection. Growth potential in relationships. Enthusiasm brings fresh energy to partnership.",
        "ace_of_wands_love_reversed": "Romantic delays or missed love opportunities. Lack of direction in relationships. Partnership setbacks. Passion blocked or misdirected.",
        
        "ace_of_wands_career_upright": "Exciting new career opportunity. Inspired professional beginning. Creative work prospects. Growth potential in job. Enthusiasm drives success.",
        "ace_of_wands_career_reversed": "Career delays or missed professional opportunities. Lack of work direction. Job setbacks. Creative energy blocked.",
        
        "ace_of_wands_finance_upright": "Exciting new financial opportunity. Inspired money ventures. Creative prosperity potential. Growth in resources. Enthusiasm brings abundance.",
        "ace_of_wands_finance_reversed": "Financial delays or missed money opportunities. Lack of financial direction. Resource setbacks. Prosperity energy blocked.",
        
        "ace_of_wands_health_upright": "Exciting new health beginning. Inspired wellness potential. Creative vitality. Physical growth opportunity. Enthusiasm for body care.",
        "ace_of_wands_health_reversed": "Health delays or missed wellness opportunities. Lack of health direction. Physical setbacks. Vitality blocked.",
        
        "ace_of_wands_general_upright": "Inspiration, new opportunities, growth, and potential. Creative fire ignites within you. This is the spark of something exciting and new. Seize the moment.",
        "ace_of_wands_general_reversed": "Delays, lack of direction, missed opportunities, and setbacks. Your creative fire is blocked or misdirected. Reignite your passion.",
        
        // Two of Wands
        "two_of_wands_love_upright": "Planning romantic future and relationship vision. Progress in love through decisions. Partnership at crossroads. Choose your path forward together.",
        "two_of_wands_love_reversed": "Fear of romantic unknown or lack of relationship planning. Playing it safe in love. Bad partnership planning. Unclear relationship vision.",
        
        "two_of_wands_career_upright": "Planning professional future and career vision. Work progress through decisions. Job at crossroads. Choose your path forward.",
        "two_of_wands_career_reversed": "Fear of career unknown or lack of professional planning. Playing it safe at work. Bad job planning. Unclear career vision.",
        
        "two_of_wands_finance_upright": "Planning financial future and money vision. Resource progress through decisions. Prosperity at crossroads. Choose your financial path.",
        "two_of_wands_finance_reversed": "Fear of financial unknown or lack of money planning. Playing it safe with resources. Bad financial planning. Unclear prosperity vision.",
        
        "two_of_wands_health_upright": "Planning wellness future and health vision. Physical progress through decisions. Body at crossroads. Choose your healing path.",
        "two_of_wands_health_reversed": "Fear of health unknown or lack of wellness planning. Playing it safe with body. Bad health planning. Unclear wellness vision.",
        
        "two_of_wands_general_upright": "Planning, future vision, progress, and decisions. You're at a crossroads with the world in your hands. Choose your path and commit to the journey.",
        "two_of_wands_general_reversed": "Fear of unknown, lack of planning, playing it safe, and bad planning. You're stuck at the crossroads. Make a decision and move forward.",
        
        // Three of Wands
        "three_of_wands_love_upright": "Relationship expansion and romantic foresight. Love grows beyond current boundaries. Partnership leadership. Looking ahead to love's potential.",
        "three_of_wands_love_reversed": "Romantic delays or relationship obstacles. Lack of love foresight. Partnership frustration. Expansion blocked.",
        
        "three_of_wands_career_upright": "Professional expansion and career foresight. Work grows beyond current boundaries. Leadership opportunities. Looking ahead to career potential.",
        "three_of_wands_career_reversed": "Career delays or professional obstacles. Lack of work foresight. Job frustration. Professional expansion blocked.",
        
        "three_of_wands_finance_upright": "Financial expansion and money foresight. Resources grow beyond current boundaries. Prosperity leadership. Looking ahead to wealth potential.",
        "three_of_wands_finance_reversed": "Financial delays or money obstacles. Lack of prosperity foresight. Resource frustration. Wealth expansion blocked.",
        
        "three_of_wands_health_upright": "Health expansion and wellness foresight. Body grows beyond current limitations. Taking charge of healing. Looking ahead to vitality potential.",
        "three_of_wands_health_reversed": "Health delays or wellness obstacles. Lack of healing foresight. Physical frustration. Vitality expansion blocked.",
        
        "three_of_wands_general_upright": "Expansion, foresight, overseas opportunities, and leadership. You're looking ahead and planning growth. Your world is expanding. Opportunities await beyond the horizon.",
        "three_of_wands_general_reversed": "Delays, obstacles, lack of foresight, and frustration. Expansion is blocked. Your vision isn't materializing as planned. Reassess and adjust.",
        
        // Four of Wands
        "four_of_wands_love_upright": "Relationship celebration and romantic harmony. Love milestone reached. Partnership stability and joy. Home and heart aligned beautifully.",
        "four_of_wands_love_reversed": "Relationship instability or lack of love support. Partnership transition challenges. Home conflict affects romance. Celebration delayed.",
        
        "four_of_wands_career_upright": "Professional celebration and work harmony. Career milestone reached. Job stability and support. Workplace feels like home.",
        "four_of_wands_career_reversed": "Career instability or lack of professional support. Work transition challenges. Office conflict. Celebration delayed.",
        
        "four_of_wands_finance_upright": "Financial celebration and money harmony. Prosperity milestone reached. Resource stability. Celebrating financial home.",
        "four_of_wands_finance_reversed": "Financial instability or lack of money support. Resource transition challenges. Financial conflict. Prosperity celebration delayed.",
        
        "four_of_wands_health_upright": "Health celebration and wellness harmony. Physical milestone reached. Body stability and support. Celebrating vitality.",
        "four_of_wands_health_reversed": "Health instability or lack of wellness support. Body transition challenges. Physical conflict. Health celebration delayed.",
        
        "four_of_wands_general_upright": "Celebration, harmony, home, and milestone. You've reached an important point worth celebrating. Stability and support surround you. Joy and accomplishment.",
        "four_of_wands_general_reversed": "Instability, lack of support, transition, and home conflict. What should be celebratory feels shaky. Delays prevent joy. Work to restore harmony.",
        
        // Five of Wands
        "five_of_wands_love_upright": "Relationship competition or romantic conflict. Love tension and disagreements. Diversity of opinions in partnership. Healthy debate or unnecessary drama?",
        "five_of_wands_love_reversed": "Avoiding relationship conflict or romantic resolution. Love cooperation emerges. Partnership agreement. Ending unnecessary competition.",
        
        "five_of_wands_career_upright": "Professional competition and workplace conflict. Work tension and diverse opinions. Healthy challenge or unnecessary drama? Navigate carefully.",
        "five_of_wands_career_reversed": "Avoiding career conflict or professional resolution. Workplace cooperation. Job agreement. Ending unnecessary competition.",
        
        "five_of_wands_finance_upright": "Financial competition or money conflict. Resource tension and diverse opinions about prosperity. Healthy challenge or unnecessary drama?",
        "five_of_wands_finance_reversed": "Avoiding financial conflict or money resolution. Resource cooperation. Prosperity agreement. Ending unnecessary competition.",
        
        "five_of_wands_health_upright": "Health competition or wellness conflict. Body tension and diverse opinions about healing. Competing needs within self.",
        "five_of_wands_health_reversed": "Avoiding health conflict or wellness resolution. Body cooperation. Healing agreement. Ending internal competition.",
        
        "five_of_wands_general_upright": "Competition, conflict, tension, and diversity. Everyone's fighting for their way. Is this healthy challenge or unnecessary drama? Navigate the chaos.",
        "five_of_wands_general_reversed": "Avoiding conflict, resolution, cooperation, and agreement. The fighting ends. Peace emerges. Unnecessary competition dissolves.",
        
        // Six of Wands
        "six_of_wands_love_upright": "Relationship success and romantic recognition. Love victory and partnership achievement. Public acknowledgment of connection. Celebrating love wins.",
        "six_of_wands_love_reversed": "Relationship failure or lack of romantic recognition. Love arrogance or partnership egotism. Private challenges despite public appearance.",
        
        "six_of_wands_career_upright": "Professional success and career recognition. Work victory and job achievement. Public acknowledgment of accomplishments. Celebrating career wins.",
        "six_of_wands_career_reversed": "Career failure or lack of professional recognition. Work arrogance or job egotism. Private struggles despite public success.",
        
        "six_of_wands_finance_upright": "Financial success and prosperity recognition. Money victory and resource achievement. Public acknowledgment of wealth. Celebrating financial wins.",
        "six_of_wands_finance_reversed": "Financial failure or lack of prosperity recognition. Money arrogance or resource egotism. Private financial struggles.",
        
        "six_of_wands_health_upright": "Health success and wellness recognition. Physical victory and body achievement. Celebrating healing wins. Acknowledged vitality.",
        "six_of_wands_health_reversed": "Health setbacks or lack of wellness recognition. Physical arrogance ignoring body needs. Private health struggles.",
        
        "six_of_wands_general_upright": "Success, recognition, victory, and achievement. You're winning and everyone sees it. Public acknowledgment of your efforts. Take a bow—you earned this.",
        "six_of_wands_general_reversed": "Failure, lack of recognition, arrogance, and egotism. Success isn't coming or you're too full of yourself. Check your ego.",
        
        // Seven of Wands
        "seven_of_wands_love_upright": "Defending relationship and maintaining romantic control. Love under challenge. Standing your ground in partnership. Persevering through opposition.",
        "seven_of_wands_love_reversed": "Exhausted from defending relationship. Giving up on love. Overwhelmed by partnership challenges. Losing romantic ground.",
        
        "seven_of_wands_career_upright": "Defending professional position and maintaining work control. Career under challenge. Standing your ground at job. Persevering through opposition.",
        "seven_of_wands_career_reversed": "Exhausted from career defense. Giving up professionally. Overwhelmed by work challenges. Losing job ground.",
        
        "seven_of_wands_finance_upright": "Defending financial position and maintaining money control. Resources under challenge. Standing your ground with prosperity. Persevering through opposition.",
        "seven_of_wands_finance_reversed": "Exhausted from financial defense. Giving up on prosperity. Overwhelmed by money challenges. Losing resource ground.",
        
        "seven_of_wands_health_upright": "Defending wellness and maintaining health control. Body under challenge. Standing your ground with healing. Persevering through physical opposition.",
        "seven_of_wands_health_reversed": "Exhausted from health defense. Giving up on wellness. Overwhelmed by body challenges. Losing physical ground.",
        
        "seven_of_wands_general_upright": "Defense, perseverance, maintaining control, and challenge. You're under attack but holding your ground. Standing up to opposition. Don't give up now.",
        "seven_of_wands_general_reversed": "Exhaustion, giving up, overwhelmed, and losing ground. You can't defend anymore. Time to either retreat or find another approach.",
        
        // Eight of Wands
        "eight_of_wands_love_upright": "Relationship speed and romantic action. Fast-moving love developments. Quick partnership progress. Movement and momentum in connection.",
        "eight_of_wands_love_reversed": "Romantic delays or resisting love change. Frustration with relationship pace. Internal alignment needed before partnership movement.",
        
        "eight_of_wands_career_upright": "Professional speed and career action. Fast-moving work developments. Quick job progress. Career momentum and movement.",
        "eight_of_wands_career_reversed": "Career delays or resisting professional change. Frustration with work pace. Internal alignment needed before job movement.",
        
        "eight_of_wands_finance_upright": "Financial speed and money action. Fast-moving prosperity developments. Quick resource progress. Momentum in wealth building.",
        "eight_of_wands_finance_reversed": "Financial delays or resisting money change. Frustration with prosperity pace. Internal alignment needed before resource movement.",
        
        "eight_of_wands_health_upright": "Health speed and wellness action. Fast-moving healing developments. Quick physical progress. Momentum in body recovery.",
        "eight_of_wands_health_reversed": "Health delays or resisting wellness change. Frustration with healing pace. Internal alignment needed before physical movement.",
        
        "eight_of_wands_general_upright": "Speed, action, movement, and swift change. Things are happening fast. Messages arrive. Travel possible. Ride the momentum.",
        "eight_of_wands_general_reversed": "Delays, frustration, resisting change, and need for internal alignment. Nothing's moving as fast as you want. Patience required.",
        
        // Nine of Wands
        "nine_of_wands_love_upright": "Relationship resilience and romantic persistence. Love boundaries after challenges. Last stand in partnership. Guarded but not giving up.",
        "nine_of_wands_love_reversed": "Relationship exhaustion or romantic paranoia. Struggling on in love without support. Refusing partnership help. Barely holding on.",
        
        "nine_of_wands_career_upright": "Professional resilience and career persistence. Work boundaries after challenges. Last stand at job. Guarded but not giving up.",
        "nine_of_wands_career_reversed": "Career exhaustion or professional paranoia. Struggling on at work without support. Refusing job help. Barely holding on.",
        
        "nine_of_wands_finance_upright": "Financial resilience and money persistence. Resource boundaries after challenges. Last stand with prosperity. Guarded but not giving up.",
        "nine_of_wands_finance_reversed": "Financial exhaustion or money paranoia. Struggling on with resources without support. Refusing prosperity help. Barely holding on.",
        
        "nine_of_wands_health_upright": "Physical resilience and wellness persistence. Health boundaries after challenges. Last stand with body. Guarded but not giving up.",
        "nine_of_wands_health_reversed": "Health exhaustion or wellness paranoia. Struggling on with body without support. Refusing healing help. Barely holding on.",
        
        "nine_of_wands_general_upright": "Resilience, persistence, last stand, and boundaries. You're battle-weary but not beaten. One more push. Protect yourself but don't isolate.",
        "nine_of_wands_general_reversed": "Exhaustion, paranoia, struggling on, and refusing help. You can barely hold on. Accept support. You don't have to do this alone.",
        
        // Ten of Wands
        "ten_of_wands_love_upright": "Relationship burden and romantic responsibility. Love feels heavy. Partnership requires hard work. Taking on too much in connection. Stress affects intimacy.",
        "ten_of_wands_love_reversed": "Releasing relationship burden or delegating love responsibilities. Letting go of partnership stress. Lightening romantic load.",
        
        "ten_of_wands_career_upright": "Professional burden and work responsibility. Career feels overwhelming. Job requires excessive hard work. Taking on too much at work. Stress affects performance.",
        "ten_of_wands_career_reversed": "Releasing career burden or delegating work. Letting go of job stress. Lightening professional load.",
        
        "ten_of_wands_finance_upright": "Financial burden and money responsibility. Resources feel heavy. Prosperity requires hard work. Taking on too much financial stress.",
        "ten_of_wands_finance_reversed": "Releasing financial burden or delegating money responsibilities. Letting go of resource stress. Lightening prosperity load.",
        
        "ten_of_wands_health_upright": "Health burden and wellness responsibility. Body feels heavy. Physical demands overwhelming. Taking on too much stress affects health.",
        "ten_of_wands_health_reversed": "Releasing health burden or delegating wellness responsibilities. Letting go of physical stress. Lightening body load.",
        
        "ten_of_wands_general_upright": "Burden, responsibility, hard work, and stress. You're carrying too much. Almost at the destination but overwhelmed. Delegate or let go of something.",
        "ten_of_wands_general_reversed": "Release, delegation, letting go, and lightening load. You're finally putting down some burdens. Relief comes through releasing responsibility.",
        
        // Page of Wands
        "page_of_wands_love_upright": "Enthusiastic romantic beginning and love exploration. Free-spirited connection. Discovery in relationships. Curious approach to partnership.",
        "page_of_wands_love_reversed": "Relationship lack of direction or love procrastination. Hasty romantic decisions. Partnership setbacks. Unclear love exploration.",
        
        "page_of_wands_career_upright": "Enthusiastic professional beginning and career exploration. Free-spirited work approach. Job discovery. Curious about opportunities.",
        "page_of_wands_career_reversed": "Career lack of direction or professional procrastination. Hasty work decisions. Job setbacks. Unclear career exploration.",
        
        "page_of_wands_finance_upright": "Enthusiastic financial beginning and money exploration. Free-spirited prosperity approach. Resource discovery. Curious about wealth.",
        "page_of_wands_finance_reversed": "Financial lack of direction or money procrastination. Hasty resource decisions. Prosperity setbacks. Unclear financial exploration.",
        
        "page_of_wands_health_upright": "Enthusiastic wellness beginning and health exploration. Free-spirited body approach. Physical discovery. Curious about healing.",
        "page_of_wands_health_reversed": "Health lack of direction or wellness procrastination. Hasty body decisions. Physical setbacks. Unclear health exploration.",
        
        "page_of_wands_general_upright": "Enthusiasm, exploration, discovery, and free spirit. You're excited about new possibilities. Curious energy drives you. Adventure begins.",
        "page_of_wands_general_reversed": "Lack of direction, procrastination, setbacks, and hasty decisions. Your enthusiasm lacks focus. Slow down and plan.",
        
        // Knight of Wands
        "knight_of_wands_love_upright": "Passionate romantic pursuit and energetic love. Adventurous relationship approach. Impulsive partnership. Following your heart quickly.",
        "knight_of_wands_love_reversed": "Reckless love or relationship haste. Romantic frustration. Passive partnership despite passionate feelings. Impulsive connection problems.",
        
        "knight_of_wands_career_upright": "Passionate professional pursuit and energetic work. Adventurous career approach. Impulsive job moves. Following passion quickly.",
        "knight_of_wands_career_reversed": "Reckless career or professional haste. Work frustration. Passive despite passionate feelings. Impulsive job problems.",
        
        "knight_of_wands_finance_upright": "Passionate financial pursuit and energetic money approach. Adventurous prosperity. Impulsive resource moves. Following passion to wealth.",
        "knight_of_wands_finance_reversed": "Reckless finances or money haste. Resource frustration. Passive prosperity despite passionate feelings. Impulsive financial problems.",
        
        "knight_of_wands_health_upright": "Passionate wellness pursuit and energetic body approach. Adventurous healing. Impulsive health moves. Following passion to vitality.",
        "knight_of_wands_health_reversed": "Reckless health or wellness haste. Physical frustration. Passive body care despite passionate feelings. Impulsive health problems.",
        
        "knight_of_wands_general_upright": "Energy, passion, adventure, and impulsiveness. You're charging forward with enthusiasm. Following your passion wherever it leads. Excitement drives action.",
        "knight_of_wands_general_reversed": "Recklessness, haste, frustration, and passive energy. Your passion is misdirected or blocked. Slow down and channel energy wisely.",
        
        // Queen of Wands
        "queen_of_wands_love_upright": "Confident romantic leadership and vibrant love. Determined partnership approach. Social connection. Magnetic relationship energy.",
        "queen_of_wands_love_reversed": "Relationship selfishness or romantic jealousy. Love insecurity. Temperamental partnership. Attention-seeking in connection.",
        
        "queen_of_wands_career_upright": "Confident professional leadership and vibrant work. Determined career approach. Social success. Magnetic workplace energy.",
        "queen_of_wands_career_reversed": "Career selfishness or professional jealousy. Work insecurity. Temperamental job behavior. Attention-seeking professionally.",
        
        "queen_of_wands_finance_upright": "Confident financial leadership and vibrant prosperity. Determined money approach. Social wealth. Magnetic resource energy.",
        "queen_of_wands_finance_reversed": "Financial selfishness or money jealousy. Prosperity insecurity. Temperamental resource behavior. Attention-seeking about wealth.",
        
        "queen_of_wands_health_upright": "Confident wellness leadership and vibrant health. Determined body approach. Social vitality. Magnetic physical energy.",
        "queen_of_wands_health_reversed": "Health selfishness or wellness jealousy. Physical insecurity. Temperamental body approach. Attention-seeking about health.",
        
        "queen_of_wands_general_upright": "Confidence, determination, vibrancy, and social magnetism. You're a natural leader who attracts others. Your passion and warmth inspire. Own your power.",
        "queen_of_wands_general_reversed": "Selfishness, jealousy, insecurity, and temperamental behavior. Your confidence has become arrogance. Attention-seeking undermines relationships.",
        
        // King of Wands
        "king_of_wands_love_upright": "Visionary romantic leadership and honorable love. Entrepreneurial relationship approach. Natural partnership authority. Passionate mature connection.",
        "king_of_wands_love_reversed": "Relationship impulsiveness or romantic tyranny. Love arrogance. Ruthless partnership behavior. Impatient with connection.",
        
        "king_of_wands_career_upright": "Visionary professional leadership and honorable work. Entrepreneurial career approach. Natural job authority. Passionate mature success.",
        "king_of_wands_career_reversed": "Career impulsiveness or professional tyranny. Work arrogance. Ruthless job behavior. Impatient with colleagues.",
        
        "king_of_wands_finance_upright": "Visionary financial leadership and honorable prosperity. Entrepreneurial money approach. Natural wealth authority. Passionate mature abundance.",
        "king_of_wands_finance_reversed": "Financial impulsiveness or money tyranny. Prosperity arrogance. Ruthless resource behavior. Impatient with wealth building.",
        
        "king_of_wands_health_upright": "Visionary wellness leadership and honorable health. Entrepreneurial body approach. Natural healing authority. Passionate mature vitality.",
        "king_of_wands_health_reversed": "Health impulsiveness or wellness tyranny. Physical arrogance. Ruthless body behavior. Impatient with healing.",
        
        "king_of_wands_general_upright": "Leadership, vision, entrepreneurship, and honor. You're a natural born leader with passion and vision. Your enthusiasm inspires others. Channel your fire wisely.",
        "king_of_wands_general_reversed": "Impulsiveness, tyranny, arrogance, and ruthlessness. Your leadership has become domination. Passion without wisdom destroys. Temper your fire."
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
