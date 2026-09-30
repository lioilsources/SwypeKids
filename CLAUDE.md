# SwypeKids — CLAUDE.md

## Overview

Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Duolingo-inspired progression: a lesson map with units, 1–3 stars per lesson, collectible emoji stickers per unit ("Zvěřinec"), persisted progress. Content is data-driven: one JSON content pack per language in `assets/packs/`. Gameplay & content-model design doc: `docs/GAMEPLAY.md`. Product roadmap (v2.2 → v4.0): `docs/ROADMAP.md`.

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
dart run tool/generate_sfx.dart             # regenerate placeholder sfx (assets/audio/) — synthesized, no licences
```

## Architecture

```
assets/packs/                # JSON content packs (units + lessons per language)
lib/
├── main.dart                # Init (ProgressService), saved-language detection
├── audio/
│   └── audio_service.dart   # flutter_soloud sfx (key tones, fanfare, stars…); silent no-op if engine fails
├── data/
│   ├── keyboard_data.dart   # Key colors (+ re-exports layout)
│   ├── keyboard_layout.dart # QWERTY rows + per-key emoji per language (pure Dart, no Flutter)
│   ├── lessons.dart         # Lesson model, Language/LessonType enums
│   └── models/
│       ├── content_pack.dart # ContentPack / Unit / CollectibleReward + fromJson
│       └── sentence.dart     # Sentence builder tiles (pack.sentence), TileUnlock
├── screens/
│   ├── home_shell.dart      # Drawer shell, view switching (map/sentence/collection)
│   ├── lesson_map_screen.dart   # Lesson map: units, nodes, linear unlocking
│   ├── game_screen.dart     # Plays one unit; stars, listen rounds, progress writes
│   ├── unit_complete_screen.dart # Unit celebration (new sticker)
│   ├── collection_screen.dart    # Sticker album (Zvěřinec)
│   ├── win_screen.dart      # Whole-pack completion
│   └── sentence_builder_screen.dart # Second mode: build a sentence
├── services/
│   ├── pack_service.dart    # Loads JSON packs (rootBundle); broken pack → falls back to en
│   ├── progress_service.dart # shared_preferences: stars, collectibles, language
│   └── tts_service.dart     # flutter_tts wrapper (listen rounds, sentences)
├── world/
│   └── world_clock.dart     # WorldClockService (day phase, season; injectable clock) + WorldTheme
└── widgets/
    ├── challenge_card.dart  # Target card (hint + letters; hidden mode for listen)
    ├── keyboard_widget.dart # Full keyboard + swype gesture detection
    ├── key_widget.dart      # Single key (active/inactive state)
    ├── star_celebration.dart # Falling stars + confetti after a correct swype
    └── swype_painter.dart   # CustomPainter — glowing swype trail + fireflies
test/
├── pack_loading_test.dart   # Validates all 9 packs (targets ⊆ unlocked ⊆ keys, unique ids, drift vs Dart)
├── progress_service_test.dart
├── game_screen_test.dart   # Widget test: swype → stars → next lesson → sticker
├── world_clock_test.dart
└── audio_service_test.dart
tool/
└── generate_sfx.dart        # Synthesized placeholder sfx → assets/audio/
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

- One pack per language: `assets/packs/{cs,en,de,es,it,fr,zh,ja,pt}.json` (schema v2, see `docs/GAMEPLAY.md` §5)
- `target` is uppercase diacritic-free Latin (what is swyped); `display` carries accents/tones/hiragana
- Lesson `type`: `swype` | `listen` | `missingLetter` (`gap` index) | `pictureOnly` | `reviewMix` (resolved at runtime to the weakest learned word, `resolveReviewMix`); unknown types fall back to `swype`
- Word strength 0–5 per target (`ProgressService.recordAttempt`); map offers “Procvičování” (5 weakest learned) via `GameScreen(practice: …)`, which never writes lesson completion or stickers
- Never add lessons to an existing unit (it would re-lock later units for kids who finished it); add new units, or change an existing lesson's type (id + progress stay)
- Word bag: a correct swype of a lesson with `vocab` adds the word to the bag (`ProgressService.addWord`); builder tiles with `unlockedBy: "vocab"` stay locked (“?” silhouette) until then
- JSON packs are the single source of truth (Dart lessons removed in v2.3); edit `assets/packs/*.json` directly, `flutter test` validates them

## Assets

- Custom fonts in `fonts/`
- Content packs in `assets/packs/`
- Sfx in `assets/audio/sfx/` + catalog `assets/audio/manifest.json`
- Screenshots in `GALLERY.md`
