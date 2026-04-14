#!/usr/bin/env python3
import json

# Read the String Catalog
with open('/Users/sebastianstrus/Desktop/TarotGo/TarotGo/Localizable.xcstrings', 'r') as f:
    catalog = json.load(f)

# Define the onboarding translations that are missing
onboarding_translations = {
    "onboarding.welcome": {
        "en": "Welcome to TarotGo",
        "pl": "Witamy w TarotGo",
        "de": "Willkommen bei TarotGo",
        "es": "Bienvenido a TarotGo",
        "fr": "Bienvenue sur TarotGo",
        "it": "Benvenuto in TarotGo",
        "sv": "Välkommen till TarotGo",
        "nb": "Velkommen til TarotGo",
        "pt-BR": "Bem-vindo ao TarotGo",
        "uk": "Ласкаво просимо до TarotGo",
        "ja": "TarotGoへようこそ"
    },
    "onboarding.welcome.desc": {
        "en": "Your journey into the wisdom of tarot begins here",
        "pl": "Twoja podróż w mądrość tarota zaczyna się tutaj",
        "de": "Deine Reise in die Weisheit des Tarot beginnt hier",
        "es": "Tu viaje a la sabiduría del tarot comienza aquí",
        "fr": "Votre voyage dans la sagesse du tarot commence ici",
        "it": "Il tuo viaggio nella saggezza dei tarocchi inizia qui",
        "sv": "Din resa in i tarotvisdom börjar här",
        "nb": "Din reise inn i tarotvisdom begynner her",
        "pt-BR": "Sua jornada na sabedoria do tarô começa aqui",
        "uk": "Ваша подорож у мудрість таро починається тут",
        "ja": "タロットの知恵への旅はここから始まります"
    },
    "onboarding.shuffle.title": {
        "en": "Shuffle with Intention",
        "pl": "Tasuj z Intencją",
        "de": "Mit Absicht mischen",
        "es": "Baraja con intención",
        "fr": "Mélangez avec intention",
        "it": "Mescola con intenzione",
        "sv": "Blanda med avsikt",
        "nb": "Stokk med intensjon",
        "pt-BR": "Embaralhe com intenção",
        "uk": "Тасуйте з наміром",
        "ja": "意図を持ってシャッフル"
    },
    "onboarding.shuffle.desc": {
        "en": "Hold the deck and focus on your question for a deeper connection",
        "pl": "Trzymaj talię i skup się na swoim pytaniu dla głębszego połączenia",
        "de": "Halte das Deck und konzentriere dich auf deine Frage für eine tiefere Verbindung",
        "es": "Sostén el mazo y concéntrate en tu pregunta para una conexión más profunda",
        "fr": "Tenez le jeu et concentrez-vous sur votre question pour une connexion plus profonde",
        "it": "Tieni il mazzo e concentrati sulla tua domanda per una connessione più profonda",
        "sv": "Håll kortleken och fokusera på din fråga för en djupare kontakt",
        "nb": "Hold kortstokken og fokuser på spørsmålet ditt for en dypere forbindelse",
        "pt-BR": "Segure o baralho e concentre-se em sua pergunta para uma conexão mais profunda",
        "uk": "Тримайте колоду і зосередьтеся на своєму запитанні для глибшого зв'язку",
        "ja": "デッキを持ち、より深いつながりのために質問に集中してください"
    },
    "onboarding.select.title": {
        "en": "Choose Your Cards",
        "pl": "Wybierz Swoje Karty",
        "de": "Wähle deine Karten",
        "es": "Elige tus cartas",
        "fr": "Choisissez vos cartes",
        "it": "Scegli le tue carte",
        "sv": "Välj dina kort",
        "nb": "Velg kortene dine",
        "pt-BR": "Escolha suas cartas",
        "uk": "Виберіть свої карти",
        "ja": "カードを選んでください"
    },
    "onboarding.select.desc": {
        "en": "Trust your intuition when selecting cards from the spread",
        "pl": "Zaufaj swojej intuicji wybierając karty z rozkładu",
        "de": "Vertraue deiner Intuition bei der Auswahl der Karten aus der Legung",
        "es": "Confía en tu intuición al seleccionar cartas de la tirada",
        "fr": "Faites confiance à votre intuition lors de la sélection des cartes du tirage",
        "it": "Fidati della tua intuizione quando selezioni le carte dalla stesa",
        "sv": "Lita på din intuition när du väljer kort från utläggningen",
        "nb": "Stol på intuisjonen din når du velger kort fra spredningen",
        "pt-BR": "Confie em sua intuição ao selecionar cartas da tiragem",
        "uk": "Довіряйте своїй інтуїції, вибираючи карти з розкладу",
        "ja": "スプレッドからカードを選ぶ際は直感を信じてください"
    },
    "onboarding.interpret.title": {
        "en": "Receive Guidance",
        "pl": "Otrzymaj Wskazówki",
        "de": "Empfange Führung",
        "es": "Recibe orientación",
        "fr": "Recevez des conseils",
        "it": "Ricevi guida",
        "sv": "Ta emot vägledning",
        "nb": "Motta veiledning",
        "pt-BR": "Receba orientação",
        "uk": "Отримайте вказівки",
        "ja": "ガイダンスを受ける"
    },
    "onboarding.interpret.desc": {
        "en": "Each card offers wisdom tailored to your question",
        "pl": "Każda karta oferuje mądrość dostosowaną do twojego pytania",
        "de": "Jede Karte bietet Weisheit, die auf deine Frage zugeschnitten ist",
        "es": "Cada carta ofrece sabiduría adaptada a tu pregunta",
        "fr": "Chaque carte offre une sagesse adaptée à votre question",
        "it": "Ogni carta offre saggezza su misura per la tua domanda",
        "sv": "Varje kort erbjuder visdom skräddarsydd för din fråga",
        "nb": "Hvert kort tilbyr visdom skreddersydd for spørsmålet ditt",
        "pt-BR": "Cada carta oferece sabedoria adaptada à sua pergunta",
        "uk": "Кожна карта пропонує мудрість, адаптовану до вашого запитання",
        "ja": "各カードはあなたの質問に合わせた知恵を提供します"
    },
    "onboarding.getStarted": {
        "en": "Get Started",
        "pl": "Rozpocznij",
        "de": "Loslegen",
        "es": "Comenzar",
        "fr": "Commencer",
        "it": "Inizia",
        "sv": "Kom igång",
        "nb": "Kom i gang",
        "pt-BR": "Começar",
        "uk": "Почати",
        "ja": "始める"
    },
    "onboarding.next": {
        "en": "Next",
        "pl": "Dalej",
        "de": "Weiter",
        "es": "Siguiente",
        "fr": "Suivant",
        "it": "Avanti",
        "sv": "Nästa",
        "nb": "Neste",
        "pt-BR": "Próximo",
        "uk": "Далі",
        "ja": "次へ"
    },
    "onboarding.skip": {
        "en": "Skip",
        "pl": "Pomiń",
        "de": "Überspringen",
        "es": "Omitir",
        "fr": "Ignorer",
        "it": "Salta",
        "sv": "Hoppa över",
        "nb": "Hopp over",
        "pt-BR": "Pular",
        "uk": "Пропустити",
        "ja": "スキップ"
    }
}

# Update the catalog with proper structure
for key, translations in onboarding_translations.items():
    if key in catalog['strings']:
        # Update existing entry
        catalog['strings'][key] = {
            "extractionState": "manual",
            "localizations": {}
        }
        # Add comment if it existed
        if 'comment' in catalog['strings'][key]:
            catalog['strings'][key]['comment'] = translations['en']

        for lang_code, translation in translations.items():
            catalog['strings'][key]['localizations'][lang_code] = {
                "stringUnit": {
                    "state": "translated",
                    "value": translation
                }
            }

# Write back to file
with open('/Users/sebastianstrus/Desktop/TarotGo/TarotGo/Localizable.xcstrings', 'w') as f:
    json.dump(catalog, f, indent=2, ensure_ascii=False)

print("✅ Added missing onboarding translations to String Catalog")
print(f"Updated {len(onboarding_translations)} keys")
