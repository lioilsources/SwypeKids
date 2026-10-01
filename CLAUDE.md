# SwypeKids — CLAUDE.md

## Overview

Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Duolingo-inspired progression: a lesson map with units, 1–3 stars per lesson, collectible emoji stickers per unit ("Zvěřinec"), persisted progress. Content is data-driven: one JSON content pack per language in `assets/packs/`. Gameplay & content-model design doc: `docs/GAMEPLAY.md`. Product roadmap (v2.2 → v4.0): `docs/ROADMAP.md`. Brief for the illustrator (mascot, animals, Rive inputs): `docs/ILLUSTRATOR_BRIEF.md`. Playtest protocol (5 kids × 15 min per release): `docs/PLAYTEST.md`. Privacy policy (offline, no data collection; cs + en): `docs/PRIVACY.md` — keep it true: never add network calls, analytics or ads without updating it.

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
│   ├── onboarding_screen.dart # First start without reading: flag → avatar → name, TTS guide phrases per language
│   ├── home_shell.dart      # Drawer shell, view switching (map/sentence/collection/book)
│   ├── lesson_map_screen.dart   # Lesson map: units, nodes, linear unlocking
│   ├── game_screen.dart     # Plays one unit; stars, listen rounds, progress writes
│   ├── unit_complete_screen.dart # Unit celebration (new sticker)
│   ├── collection_screen.dart    # Zvěřinec as an island: BiomeBand per unit, tap sticker → TTS label, secrets, badge shelf
│   ├── word_sentence_screen.dart # Mini builder right after a new word (wordToSentence)
│   ├── book_screen.dart     # Má knížka: saved sentences, tap = read aloud
│   ├── win_screen.dart      # Whole-pack completion
│   └── sentence_builder_screen.dart # Second mode: build a sentence
├── parent/
│   ├── parent_gate.dart     # Parent gate: a × b question instead of a PIN
│   └── parent_screen.dart   # Parent corner: overview, letter grid (strength), tips, method, settings (sound/season/profiles)
├── services/
│   ├── pack_service.dart    # Loads JSON packs (rootBundle); broken pack → falls back to en
│   ├── achievement_service.dart # GameBadge enum + check(trigger, pack) → newly earned badges
│   ├── session_service.dart # Daily foreground play time + parent limit (limitReached notifier, extend today)
│   ├── settings_service.dart # Parent settings: leftHanded, sessionLimitMin (persisted ChangeNotifier)
│   ├── profile_service.dart # Child profiles (siblings): avatar, name, active id; profile 1 = legacy keys, others sk.p{id}.…
│   ├── progress_service.dart # shared_preferences: stars, collectibles, language, word bag, book, badges (sk.global)
│   └── tts_service.dart     # flutter_tts wrapper (listen rounds, sentences)
├── world/
│   ├── world_clock.dart     # WorldClockService (ChangeNotifier: day phase, season + parent override), WorldTheme, Biome
│   ├── world_backdrop.dart  # Map sky: sun/moon, stars at night, drifting clouds with parallax
│   ├── particle_layer.dart  # Petals / fireflies / leaves / snow over the map
│   └── biome_band.dart      # One unit's piece of world: biome ground + decor, fog on locked units, reveal
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

1. First start: `OnboardingScreen` (language by flag, avatar, optional name) → `ProfileService.onboarded`
2. Lesson map shows units and lesson nodes; linear unlocking, persisted progress
3. Tapping a node plays the unit from that lesson in `GameScreen`
4. Challenge card shows target word/syllable (or hides it + plays TTS in `listen` rounds)
5. Child swipes across keyboard letters in order
6. Correct swype → 1–3 stars (by attempt count), next lesson; errors never block progress
7. Unit finished → collectible sticker → back to map; whole pack finished → WinScreen

## Content model

- One pack per language: `assets/packs/{cs,en,de,es,it,fr,zh,ja,pt}.json` (schema v2, see `docs/GAMEPLAY.md` §5)
- `target` is uppercase diacritic-free Latin (what is swyped); `display` carries accents/tones/hiragana
- Lesson `type`: `swype` | `listen` | `missingLetter` (`gap` index) | `pictureOnly` | `reviewMix` (resolved at runtime to the weakest learned word, `resolveReviewMix`); unknown types fall back to `swype`
- Session limit: `SessionService` counts foreground time (HomeShell lifecycle); when reached the game finishes the round and pops, the map shows the bedtime card and blocks lessons; extension only in the parent corner
- Parent corner (drawer 👪 → `ParentGate` → `ParentScreen`): sound/music/ambient toggles and season override live here, not in the child's drawer; letter status = mean word strength per letter (≥ 4 mastered)
- Profiles: `ProgressService.init(profile: id)` loads one child's progress (keys namespaced per profile, profile 1 unprefixed so old installs need no migration); switching rebuilds HomeShell screens via a keyed IndexedStack. Settings (sound, season) stay global
- Badges (`GameBadge`, 14 from roadmap P4) are global across languages; `AchievementService.check` is called on LessonDone / UnitDone (game), SessionStart (map open) — never add streak-style pressure
- Word strength 0–5 per target (`ProgressService.recordAttempt`); map offers “Procvičování” (5 weakest learned) via `GameScreen(practice: …)`, which never writes lesson completion or stickers
- Never add lessons to an existing unit (it would re-lock later units for kids who finished it); add new units, or change an existing lesson's type (id + progress stay)
- `reward.label` = sticker name in the pack language (required; Zvěřinec says it aloud). Each `Biome` has a `secret` sticker found by tapping the hidden ✨ on the map
- `unit.scene.biome` names the unit's biome (`Biome` enum in `world/world_clock.dart`; unknown → meadow). Map sky = day phase × season; season is calendar-based unless the parent overrides it in the drawer
- Word bag: a correct swype of a lesson with `vocab` adds the word to the bag (`ProgressService.addWord`); builder tiles with `unlockedBy: "vocab"` stay locked (“?” silhouette) until then
- JSON packs are the single source of truth (Dart lessons removed in v2.3); edit `assets/packs/*.json` directly, `flutter test` validates them (every lesson needs a `parentNote` in the pack's language; hint emoji ≤ Unicode 12)

## Assets

- Custom fonts in `fonts/`
- Content packs in `assets/packs/`
- Sfx in `assets/audio/sfx/`, ambient loops in `assets/audio/ambient/`, title music in `assets/audio/music/` + catalog `assets/audio/manifest.json` (`sfx`, `ambient`, `music`)
- Screenshots in `GALLERY.md`
