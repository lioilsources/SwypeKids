# SwypeKids — CLAUDE.md

## Overview

Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Progressive lesson unlocking system.

## Commands

```bash
flutter pub get
flutter run
flutter run -d ios
flutter run -d android
flutter build apk
flutter build ios
flutter analyze
```

## Architecture

```
lib/
├── main.dart
├── data/
│   ├── keyboard_data.dart   # QWERTY layout, emoji assignments, colors per key
│   └── lessons.dart         # All lessons + progressive unlock logic
├── screens/
│   ├── game_screen.dart     # Main game screen
│   └── win_screen.dart      # Win celebration screen
└── widgets/
    ├── challenge_card.dart  # Target card (hint + letters to swipe)
    ├── keyboard_widget.dart # Full keyboard + swype gesture detection
    ├── key_widget.dart      # Single key (active/inactive state)
    └── swype_painter.dart   # CustomPainter — glowing swype trail line
```

## Platforms

iOS, Android, macOS, Linux (check pubspec for active platforms).

## Game Flow

1. Challenge card shows target word/syllable
2. Child swipes across keyboard letters in order
3. Correct swype → win animation, next challenge
4. Lessons unlock progressively (lessons.dart controls unlock logic)

## Assets

- Custom fonts in `fonts/`
- Images in `assets/`
- Screenshots in `GALLERY.md`
