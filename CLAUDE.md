# SwypeKids — CLAUDE.md

## Overview

Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Duolingo-inspired progression: a lesson map with units, 1–3 stars per lesson, collectible emoji stickers per unit ("Zvěřinec"), persisted progress. Content is data-driven: one JSON content pack per language in `assets/packs/`. Gameplay & content-model design doc: `docs/GAMEPLAY.md`.

## Commands

```bash
flutter pub get
flutter run
flutter run -d ios
flutter run -d android
flutter build apk
flutter build ios
flutter analyze
flutter test                                # pack validation + progress tests
dart run tool/export_lessons_to_json.dart   # regenerate JSON packs from Dart lessons (overwrites manual JSON edits)
```

## Architecture

```
assets/packs/                # JSON content packs (units + lessons per language)
lib/
├── main.dart                # Init (ProgressService), saved-language detection
├── data/
│   ├── keyboard_data.dart   # Key colors (+ re-exports layout)
│   ├── keyboard_layout.dart # QWERTY rows + per-key emoji per language (pure Dart, no Flutter)
│   ├── lessons.dart         # Lesson model, Language/LessonType enums
│   ├── lessons_index.dart   # Dart lessons aggregate (fallback; delete in phase 2)
│   ├── lessons/             # Per-language Dart lessons (fallback source)
│   └── models/
│       └── content_pack.dart # ContentPack / Unit / CollectibleReward + fromJson
├── screens/
│   ├── home_shell.dart      # Drawer shell, view switching (map/sentence/collection)
│   ├── lesson_map_screen.dart   # Lesson map: units, nodes, linear unlocking
│   ├── game_screen.dart     # Plays one unit; stars, listen rounds, progress writes
│   ├── unit_complete_screen.dart # Unit celebration (new sticker)
│   ├── collection_screen.dart    # Sticker album (Zvěřinec)
│   ├── win_screen.dart      # Whole-pack completion
│   └── sentence_builder_screen.dart # Second mode: build a sentence
├── services/
│   ├── pack_service.dart    # Loads JSON packs (rootBundle), falls back to Dart lessons
│   ├── progress_service.dart # shared_preferences: stars, collectibles, language
│   └── tts_service.dart     # flutter_tts wrapper (listen rounds, sentences)
└── widgets/
    ├── challenge_card.dart  # Target card (hint + letters; hidden mode for listen)
    ├── keyboard_widget.dart # Full keyboard + swype gesture detection
    ├── key_widget.dart      # Single key (active/inactive state)
    └── swype_painter.dart   # CustomPainter — glowing swype trail line
test/
├── pack_loading_test.dart   # Validates all 9 packs (targets ⊆ unlocked ⊆ keys, unique ids, drift vs Dart)
└── progress_service_test.dart
tool/
└── export_lessons_to_json.dart # One-off generator Dart lessons → JSON packs
```

## Platforms

iOS, Android, macOS, Linux (check pubspec for active platforms).

## Game Flow

1. Lesson map shows units and lesson nodes; linear unlocking, persisted progress
2. Tapping a node plays the unit from that lesson in `GameScreen`
3. Challenge card shows target word/syllable (or hides it + plays TTS in `listen` rounds)
4. Child swipes across keyboard letters in order
5. Correct swype → 1–3 stars (by attempt count), next lesson; errors never block progress
6. Unit finished → collectible sticker → back to map; whole pack finished → WinScreen

## Content model

- One pack per language: `assets/packs/{cs,en,de,es,it,fr,zh,ja,pt}.json` (schema v1, see `docs/GAMEPLAY.md`)
- `target` is uppercase diacritic-free Latin (what is swyped); `display` carries accents/tones/hiragana
- Lesson `type`: `swype` | `listen`; unknown types fall back to `swype`
- `PackService` falls back to Dart lessons (`lib/data/lessons/`) if an asset is missing/broken; a test guards lesson-count drift between the two sources

## Assets

- Custom fonts in `fonts/`
- Content packs in `assets/packs/`
- Screenshots in `GALLERY.md`
