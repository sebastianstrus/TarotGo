# TarotGo 🌙✨

A professional, immersive tarot reading iOS application built with SwiftUI. TarotGo simulates a real tarot reading session with physical gestures, beautiful animations, and mystical atmosphere.

## Features

### 🎴 Complete Tarot Experience
- **78 Tarot Cards**: Full deck including 22 Major Arcana and 56 Minor Arcana
- **Multiple Spreads**: Three Card, Celtic Cross, Love Triangle, Career Path
- **5 Reading Categories**: Love, Career, Finance, Health, General
- **Personalized Interpretations**: Each card has unique interpretations for every category
- **Reversed Cards**: Automatic detection and interpretation of reversed cards

### 🎯 Immersive User Experience
- **Physical Gestures**: Long press rituals (5 seconds for readings, 3 seconds for daily card)
- **Haptic Feedback**: Comprehensive haptic system with different styles for various actions
- **Sound Effects**: Professional sound system with ambient music and effect sounds
- **Beautiful Animations**: Smooth transitions, card flip animations, particle effects
- **Dark Mystical Theme**: Elegant gradient backgrounds with animated elements

### 📱 Core Features
1. **Splash Screen**: Animated app launch with particle effects
2. **Onboarding Flow**: First-time user guide (shown once)
3. **New Reading**: Full tarot reading with chosen spread
4. **Card of the Day**: Quick daily guidance (consistent card per day)
5. **Reading History**: Save, review, and manage past readings
6. **Settings**: Configure daily notifications and preferences

### 🔮 Reading Flow
1. **Intention Selection**: Choose category and optional custom question
2. **Shuffling Ritual**: 5-second long press with progress indicator and haptic pulses
3. **Card Selection**: Interactive fan layout - choose cards that call to you
4. **Card Revelation**: Tap to flip each card with 3D animation
5. **Interpretation**: Reader-style narrative for each card
6. **Resonance Check**: "Does this resonate?" with alternative interpretations
7. **Summary**: Full reading overview with notes and sharing options

### 💾 Data & Storage
- **SwiftData**: Local storage for reading sessions
- **Offline First**: All content and interpretations embedded in app
- **Privacy**: All data stays on device
- **Export**: Share readings as screenshots (planned)

### 🔔 Notifications
- **Daily Card Reminder**: Customizable time
- **Local Notifications**: No server required
- **Full Control**: Enable/disable in settings

## Technical Architecture

### Project Structure
```
TarotGo/
├── Models/
│   ├── IntentionCategory.swift
│   ├── SpreadType.swift
│   ├── TarotCard.swift
│   └── ReadingSession.swift
├── ViewModels/
│   ├── AppViewModel.swift
│   └── ReadingViewModel.swift
├── Data/
│   ├── TarotDeck.swift (78 cards)
│   └── TarotInterpretations.swift
├── Views/
│   ├── SplashScreenView.swift
│   ├── OnboardingFlowView.swift
│   ├── HomeView.swift
│   ├── OnboardingView.swift
│   ├── ShuffleRitualView.swift
│   ├── CardSelectionView.swift
│   ├── InterpretationView.swift
│   ├── SummaryView.swift
│   ├── HistoryView.swift
│   ├── CardOfTheDayView.swift
│   ├── SettingsView.swift
│   └── Components/
│       └── LoadingView.swift
├── Services/
│   ├── HapticService.swift
│   ├── SoundService.swift
│   └── NotificationService.swift
└── Sounds/
    └── README.md (sound file requirements)
```

### Technologies Used
- **SwiftUI**: Modern declarative UI framework
- **SwiftData**: Model and persistence layer
- **Combine**: Reactive programming for ViewModels
- **AVFoundation**: Audio playback system
- **UserNotifications**: Local notifications
- **UIKit**: Haptic feedback

### Design Patterns
- **MVVM Architecture**: ViewModels handle business logic
- **Service Pattern**: Centralized services for haptics, sounds, notifications
- **State Management**: @Published properties with Combine
- **Dependency Injection**: ViewModels injected into views

## Setup Instructions

### Requirements
- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

### Installation
1. Clone or download the project
2. Open `TarotGo.xcodeproj` in Xcode
3. Add sound files to `TarotGo/Sounds/` folder (see Sounds/README.md)
4. Build and run on simulator or device

### Sound Files (Optional but Recommended)
Place these files in `TarotGo/Sounds/`:
- `card_flip.mp3` - Card flip sound
- `card_shuffle.mp3` - Shuffling sound
- `card_draw.mp3` - Card selection sound
- `bell_chime.mp3` - Mystical chime
- `success.mp3` - Success confirmation
- `whoosh.mp3` - UI transitions
- `ambient_mystic.mp3` - Background music (optional)

The app works without sound files - it just won't play audio.

## Usage

### First Launch
1. **Splash Screen**: Animated app introduction
2. **Onboarding**: Four slides explaining features
3. **Get Started**: Begin your first reading

### Creating a Reading
1. Tap "New Reading" on home screen
2. Select your intention category
3. Optionally add a custom question
4. Press and hold on the deck for 5 seconds
5. Select cards from the fan layout
6. Tap each card to reveal and read interpretation
7. Answer "Does this resonate?" for each card
8. Review full reading summary
9. Add notes and save

### Card of the Day
1. Tap "Card of the Day"
2. Press and hold for 3 seconds
3. Receive your daily guidance
4. Reflect on the message

### Managing History
1. Tap "Reading History"
2. Filter by category if desired
3. Tap any reading to view details
4. Edit notes or delete readings

## Customization

### Adding More Cards
Edit `TarotGo/Data/TarotDeck.swift` to add cards to the deck.

### Adding Interpretations
Edit `TarotGo/Data/TarotInterpretations.swift` to add or modify interpretations. Format:
```swift
"card_id_category_orientation": "Interpretation text..."
```

### Custom Spreads
Add new spread types in `Models/SpreadType.swift`:
```swift
case customSpread = "Custom Spread"
// Add positions array in computed property
```

### Theming
Modify `AnimatedBackgroundView` in any view file to customize colors and gradients.

## Future Enhancements

### Planned Features
- [ ] iOS Widget for Card of the Day
- [ ] Real tarot card artwork (currently using SF Symbols)
- [ ] More spread layouts
- [ ] Journal entries with each reading
- [ ] Export readings as beautiful images
- [ ] iCloud sync for readings
- [ ] Multiple language support
- [ ] Custom card decks
- [ ] Reading statistics and insights
- [ ] Apple Watch companion app

### Known Limitations
- Sound files need to be added manually
- Widget requires extension target (not yet implemented)
- Card images are placeholders
- Share functionality is basic
- Only ~20 sample card interpretations (structure in place for all 78)

## Architecture Highlights

### Haptic Feedback System
```swift
HapticService.shared.impact(.medium)
HapticService.shared.pulse(count: 3)
HapticService.shared.customPattern([.light, .medium, .heavy])
```

### Sound System
```swift
SoundService.shared.play(.cardFlip, volume: 0.7)
SoundService.shared.playAmbient(.ambientMystic, loop: true)
SoundService.shared.stopAmbient(fadeOut: true)
```

### Reading Flow
ViewModels handle business logic while Views focus on presentation:
- `ReadingViewModel` manages card shuffling and drawing
- `AppViewModel` handles app state and onboarding
- Services provide reusable functionality

## Performance

- **Instant Launch**: Preloaded sounds and data
- **Smooth Animations**: 60 FPS with optimized SwiftUI
- **Low Memory**: Efficient image and data handling
- **Offline**: No network calls, all data local

## Credits

- **Design**: Mystical dark theme with purple/blue gradients
- **Architecture**: MVVM with SwiftUI best practices
- **Tarot Knowledge**: Traditional tarot card meanings and spreads

## License

This is a demo/portfolio project. Feel free to use as reference or starting point for your own tarot app.

---

**Built with ❤️ using SwiftUI**

For questions or suggestions, please create an issue or pull request.
