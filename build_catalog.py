#!/usr/bin/env python3
"""
Script to build a comprehensive String Catalog from existing .strings files
"""

import json
import os
import re

# All language codes
LANGUAGES = ["en", "de", "es", "fr", "it", "ja", "nb", "pl", "pt-BR", "sv", "uk"]

# Read a .strings file and return dict of key: value
def parse_strings_file(filepath):
    if not os.path.exists(filepath):
        return {}

    strings = {}
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        # Match pattern: "key" = "value";
        pattern = r'"([^"]+)"\s*=\s*"([^"]*(?:\\.[^"]*)*)"\s*;'
        matches = re.findall(pattern, content)
        for key, value in matches:
            # Unescape the value
            value = value.replace('\\"', '"')
            strings[key] = value

    return strings

# Base directory
base_dir = "/Users/sebastianstrus/Desktop/TarotGo/TarotGo"

# Load all strings from all languages
all_keys = set()
translations = {}

for lang in LANGUAGES:
    if lang == "pt-BR":
        filepath = os.path.join(base_dir, "pt-BR.lproj", "Localizable.strings")
    else:
        filepath = os.path.join(base_dir, f"{lang}.lproj", "Localizable.strings")

    strings_dict = parse_strings_file(filepath)
    translations[lang] = strings_dict
    all_keys.update(strings_dict.keys())

# Additional keys from L10n enum that must be included
additional_keys = [
    "position.past.short",
    "position.past.short.desc",
    "position.present.short",
    "position.present.short.desc",
    "position.future.short",
    "position.future.short.desc",
    "position.challenge",
    "position.challenge.desc",
    "position.foundation",
    "position.foundation.desc",
    "position.approaching",
    "position.approaching.desc",
    "position.above",
    "position.above.desc",
    "position.below",
    "position.below.desc",
    "position.advice",
    "position.advice.desc",
    "position.external",
    "position.external.desc",
    "position.hopes",
    "position.hopes.desc",
    "position.outcome",
    "position.outcome.desc",
    "position.you",
    "position.you.desc",
    "position.them",
    "position.them.desc",
    "position.connection",
    "position.connection.desc",
    "position.current",
    "position.current.desc",
    "position.obstacles",
    "position.obstacles.desc",
    "position.strengths",
    "position.strengths.desc",
    "position.action",
    "position.action.desc",
    "position.careerOutcome",
    "position.careerOutcome.desc",
]

all_keys.update(additional_keys)

# English fallback values for missing keys
english_fallbacks = {
    "position.past.short": "Past",
    "position.past.short.desc": "What brought you here",
    "position.present.short": "Present",
    "position.present.short.desc": "Your current situation",
    "position.future.short": "Future",
    "position.future.short.desc": "What's coming",
    "position.challenge": "Challenge",
    "position.challenge.desc": "What crosses you",
    "position.foundation": "Foundation",
    "position.foundation.desc": "Foundation of the situation",
    "position.approaching": "Approaching",
    "position.approaching.desc": "What's approaching",
    "position.above": "Above",
    "position.above.desc": "Your goal or aspiration",
    "position.below": "Below",
    "position.below.desc": "Unconscious influences",
    "position.advice": "Advice",
    "position.advice.desc": "Your best approach",
    "position.external": "External",
    "position.external.desc": "Outside influences",
    "position.hopes": "Hopes & Fears",
    "position.hopes.desc": "Your inner emotions",
    "position.outcome": "Outcome",
    "position.outcome.desc": "Final result",
    "position.you": "You",
    "position.you.desc": "Your emotional state",
    "position.them": "Them",
    "position.them.desc": "Their emotional state",
    "position.connection": "Connection",
    "position.connection.desc": "The relationship dynamic",
    "position.current": "Current Situation",
    "position.current.desc": "Where you are now",
    "position.obstacles": "Obstacles",
    "position.obstacles.desc": "What's blocking you",
    "position.strengths": "Strengths",
    "position.strengths.desc": "Your assets",
    "position.action": "Action",
    "position.action.desc": "What to do next",
    "position.careerOutcome": "Outcome",
    "position.careerOutcome.desc": "Potential result",
}

# Polish translations for position keys
polish_translations = {
    "position.past.short": "Przeszłość",
    "position.past.short.desc": "Co Cię tu przywiodło",
    "position.present.short": "Teraźniejszość",
    "position.present.short.desc": "Twoja obecna sytuacja",
    "position.future.short": "Przyszłość",
    "position.future.short.desc": "Co nadchodzi",
    "position.challenge": "Wyzwanie",
    "position.challenge.desc": "Co Cię krzyżuje",
    "position.foundation": "Fundament",
    "position.foundation.desc": "Podstawa sytuacji",
    "position.approaching": "Nadchodzące",
    "position.approaching.desc": "Co się zbliża",
    "position.above": "Powyżej",
    "position.above.desc": "Twój cel lub aspiracja",
    "position.below": "Poniżej",
    "position.below.desc": "Nieświadome wpływy",
    "position.advice": "Rada",
    "position.advice.desc": "Twoje najlepsze podejście",
    "position.external": "Zewnętrzne",
    "position.external.desc": "Wpływy zewnętrzne",
    "position.hopes": "Nadzieje i Obawy",
    "position.hopes.desc": "Twoje wewnętrzne emocje",
    "position.outcome": "Wynik",
    "position.outcome.desc": "Końcowy rezultat",
    "position.you": "Ty",
    "position.you.desc": "Twój stan emocjonalny",
    "position.them": "Oni",
    "position.them.desc": "Ich stan emocjonalny",
    "position.connection": "Połączenie",
    "position.connection.desc": "Dynamika związku",
    "position.current": "Obecna Sytuacja",
    "position.current.desc": "Gdzie jesteś teraz",
    "position.obstacles": "Przeszkody",
    "position.obstacles.desc": "Co Cię blokuje",
    "position.strengths": "Mocne strony",
    "position.strengths.desc": "Twoje atuty",
    "position.action": "Działanie",
    "position.action.desc": "Co robić dalej",
    "position.careerOutcome": "Wynik",
    "position.careerOutcome.desc": "Potencjalny rezultat",
}

# Build the String Catalog structure
catalog = {
    "sourceLanguage": "en",
    "strings": {},
    "version": "1.0"
}

# Process each key
for key in sorted(all_keys):
    catalog["strings"][key] = {
        "extractionState": "manual",
        "localizations": {}
    }

    for lang in LANGUAGES:
        # Get translation or fall back to English
        if key in translations.get(lang, {}):
            value = translations[lang][key]
        elif lang == "pl" and key in polish_translations:
            value = polish_translations[key]
        elif key in english_fallbacks:
            value = english_fallbacks[key]
        elif "en" in translations and key in translations["en"]:
            value = translations["en"][key]
        else:
            value = key  # Last resort

        catalog["strings"][key]["localizations"][lang] = {
            "stringUnit": {
                "state": "translated",
                "value": value
            }
        }

# Write the catalog
output_path = os.path.join(base_dir, "Localizable.xcstrings")
with open(output_path, 'w', encoding='utf-8') as f:
    json.dump(catalog, f, ensure_ascii=False, indent=2)

print(f"✅ Created String Catalog with {len(all_keys)} keys")
print(f"📁 Written to: {output_path}")
print(f"🌍 Languages: {', '.join(LANGUAGES)}")
