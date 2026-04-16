# TarotGo - Specyfikacja Kart Tarota

## 📐 Specyfikacje Techniczne

### Wymiary
- **Szerokość**: 1108 px
- **Wysokość**: 1900 px
- **Aspect Ratio**: 1108:1900 (≈0.583)

### Format
- **Typ pliku**: PNG
- **Kompresja**: Bezstratna
- **Głębia kolorów**: 24-bit RGB
- **Przezroczystość**: Nie wymagana

### Naming Convention
- **Format**: snake_case
- **Rozszerzenie**: .png
- **Przykłady**: `the_fool.png`, `ace_of_cups.png`, `king_of_wands.png`

## 🎴 Talia Kart

### Wykorzystana Talia
**Rider-Waite Tarot** (oryginalna wersja)
- Artystka: Pamela Colman Smith (1909)
- Jedna z najbardziej rozpoznawalnych i klasycznych talii tarota
- 78 kart: 22 Major Arcana + 56 Minor Arcana

## 📂 Struktura Plików

Wszystkie karty znajdują się w:
```
TarotGo/Assets.xcassets/TarotCards/
```

Każda karta ma własny `.imageset` folder zawierający:
- `Contents.json` - konfiguracja Asset Catalog
- `[card_name].png` - plik graficzny karty (1108x1900)

## 📋 Lista Wszystkich Kart (78)

### MAJOR ARCANA (22 karty)
1. `the_fool.png`
2. `the_magician.png`
3. `the_high_priestess.png`
4. `the_empress.png`
5. `the_emperor.png`
6. `the_hierophant.png`
7. `the_lovers.png`
8. `the_chariot.png`
9. `strength.png`
10. `the_hermit.png`
11. `wheel_of_fortune.png`
12. `justice.png`
13. `the_hanged_man.png`
14. `death.png`
15. `temperance.png`
16. `the_devil.png`
17. `the_tower.png`
18. `the_star.png`
19. `the_moon.png`
20. `the_sun.png`
21. `judgement.png`
22. `the_world.png`

### CUPS - Kielichy (14 kart)
- `ace_of_cups.png`
- `two_of_cups.png`
- `three_of_cups.png`
- `four_of_cups.png`
- `five_of_cups.png`
- `six_of_cups.png`
- `seven_of_cups.png`
- `eight_of_cups.png`
- `nine_of_cups.png`
- `ten_of_cups.png`
- `page_of_cups.png`
- `knight_of_cups.png`
- `queen_of_cups.png`
- `king_of_cups.png`

### PENTACLES - Pentakle/Monety (14 kart)
- `ace_of_pentacles.png`
- `two_of_pentacles.png`
- `three_of_pentacles.png`
- `four_of_pentacles.png`
- `five_of_pentacles.png`
- `six_of_pentacles.png`
- `seven_of_pentacles.png`
- `eight_of_pentacles.png`
- `nine_of_pentacles.png`
- `ten_of_pentacles.png`
- `page_of_pentacles.png`
- `knight_of_pentacles.png`
- `queen_of_pentacles.png`
- `king_of_pentacles.png`

### SWORDS - Miecze (14 kart)
- `ace_of_swords.png`
- `two_of_swords.png`
- `three_of_swords.png`
- `four_of_swords.png`
- `five_of_swords.png`
- `six_of_swords.png`
- `seven_of_swords.png`
- `eight_of_swords.png`
- `nine_of_swords.png`
- `ten_of_swords.png`
- `page_of_swords.png`
- `knight_of_swords.png`
- `queen_of_swords.png`
- `king_of_swords.png`

### WANDS - Różdżki/Laski (14 kart)
- `ace_of_wands.png`
- `two_of_wands.png`
- `three_of_wands.png`
- `four_of_wands.png`
- `five_of_wands.png`
- `six_of_wands.png`
- `seven_of_wands.png`
- `eight_of_wands.png`
- `nine_of_wands.png`
- `ten_of_wands.png`
- `page_of_wands.png`
- `knight_of_wands.png`
- `queen_of_wands.png`
- `king_of_wands.png`

## 🔧 Implementacja w Kodzie

### Aspect Ratio
Kod używa aspect ratio `1108/1900` dla wszystkich kart:

```swift
.aspectRatio(1108/1900, contentMode: .fit)
```

### Ładowanie Obrazów
Karty są ładowane używając ID karty z `TarotDeck.swift`:

```swift
if let uiImage = UIImage(named: card.id) {
    Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: geometry.size.width, height: geometry.size.height)
        .clipped()
        .cornerRadius(12)
}
```

### Corner Radius
- Karty mają zaokrąglone rogi z promieniem **12 punktów**
- Corner radius jest aplikowany programowo w SwiftUI
- Same obrazy PNG są prostokątne (bez zaokrągleń)

## ✅ Weryfikacja

Użyj skryptu `verify_cards.sh` aby sprawdzić:
- Czy wszystkie 78 kart jest obecnych
- Czy wszystkie karty mają poprawne wymiary (1108x1900)

```bash
./verify_cards.sh
```

## 📊 Statystyki

- **Łączna liczba kart**: 78
- **Major Arcana**: 22
- **Minor Arcana**: 56 (4 kolory × 14 kart)
- **Przeciętny rozmiar pliku**: ~3.1 MB na kartę
- **Łączny rozmiar wszystkich kart**: ~242 MB

## 🎨 Wizualizacja Kart

### Kolory Dominujące (według koloru)
- **Cups**: Niebieski, morskie tony
- **Pentacles**: Żółty, złoty, zielony
- **Swords**: Szary, srebrny, niebieski
- **Wands**: Pomarańczowy, czerwony, żółty

### Efekty Wizualne w Aplikacji
- Złota ramka wokół każdej karty
- Cień z odcieniem złota (opacity 0.3, radius 10)
- Obrót o 180° dla kart odwróconych
- Gradient border (lightGold → gold → darkGold)

## 📝 Notatki

- Nazwy plików są zgodne z polem `id` w `TarotDeck.swift`
- Nie ma potrzeby dodawania wersji @2x i @3x (używamy tylko @1x)
- iOS automatycznie skaluje obrazy dla różnych rozdzielczości ekranu
- Obrazy są ładowane asynchronicznie dla lepszej wydajności
