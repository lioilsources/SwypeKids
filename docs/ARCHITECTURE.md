# Architecture

Moved from CLAUDE.md. Source tree, platforms and game flow.

## Source tree

```
assets/packs/                # JSON content packs (units + lessons per language)
lib/
├── main.dart                # Init (services), saved-language detection, MaterialApp locale = AppLanguage
├── l10n/                    # ARB per language (app_cs.arb is the template) + generated AppLocalizations
├── ui/
│   ├── emoji_art.dart       # EmojiArt: sticker image instead of an emoji (assets/emoji/<codepoints>.webp), breathes + pops; falls back to the emoji
│   ├── emoji_art_index.dart # Generated set of emoji with a sticker (tool/emoji_art/build.py)
│   ├── app_font.dart        # kFont = DynaPuff from cute_kid_fonts everywhere (+ kFontFallback for pinyin); OpenDyslexic overrides it
│   └── l10n.dart            # context.l shortcut, AppLanguage notifier, GameBadge/Season label extensions
├── characters/
│   ├── guide.dart           # Guide enum (panda, capybara, giraffe, cheetah): name per language (diminutive), assets/characters/<guide>/
│   ├── mascot.dart          # The active child's guide: moods → images, Mascot.name(lang), tap = wave (replay)
│   └── draggable_guide.dart # Guide on the map AND game screen (same behaviour): drag anywhere, slowly steps off GuideAvoid areas, reads when idle 20 s, sleeps at night; position per place in SettingsService
├── audio/
│   └── audio_service.dart   # flutter_soloud sfx (key tones, fanfare, stars…); silent no-op if engine fails
├── data/
│   ├── keyboard_data.dart   # Key colors (+ re-exports layout)
│   ├── keyboard_layout.dart # QWERTY rows + per-key emoji per language (pure Dart, no Flutter)
│   ├── lessons.dart         # Lesson model, Language/LessonType enums
│   └── models/
│       ├── content_pack.dart # ContentPack / Unit / CollectibleReward + fromJson
│       └── sentence.dart     # Sentence builder tiles (pack.sentence), TileUnlock
├── pet/
│   ├── pet_screen.dart      # Svět zvířátka (Zvěřinec row / unit complete): resident in its biome, stroke/tickle/lift, gifts from the tray → eat/drink/play + sentence → Má knížka; asleep at night/limit
│   ├── wish.dart            # PetLearning: wish = weak word from the bag; mini-round type by word strength (GameScreen practice)
│   └── gift.dart            # Gift tray (word bag food/drink/toys + always builder objects) and PetSentence (reward.subject + v2/v3/v6 + object forms; SOV for ja)
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
│   ├── parent_screen.dart   # Parent corner: overview, letter grid (strength), tips, method, settings (sound/season/profiles)
│   └── store_debug_panel.dart # kDebugMode only: simulate an enabled store + FakeStore purchases
├── services/
│   ├── pack_service.dart    # Loads JSON packs (rootBundle); broken pack → falls back to en
│   ├── achievement_service.dart # GameBadge enum + check(trigger, pack) → newly earned badges
│   ├── entitlement_service.dart # What the family has unlocked: owns/unlocked/languageUnlocked, freeLanguage, grandfathering (sk.store.*, global)
│   ├── session_service.dart # Daily foreground play time + parent limit (limitReached notifier, extend today)
│   ├── settings_service.dart # Parent settings: leftHanded, sessionLimitMin (persisted ChangeNotifier)
│   ├── profile_service.dart # Child profiles (siblings): avatar, name, active id; profile 1 = legacy keys, others sk.p{id}.…
│   ├── progress_service.dart # shared_preferences: stars, collectibles, language, word bag, book, badges (sk.global)
│   └── tts_service.dart     # flutter_tts wrapper (listen rounds, sentences)
├── store/
│   ├── store_config.dart    # StoreConfig.enabled — the one switch; false = everything unlocked, no purchase UI
│   ├── catalog.dart         # StoreCatalog / CatalogProduct / ProductUnlocks ← assets/store/catalog.json
│   └── store_service.dart   # StoreService interface (products, buy, restore) + FakeStore; no in_app_purchase yet
├── world/
│   ├── world_clock.dart     # WorldClockService (ChangeNotifier: day phase, season + parent override), WorldTheme, Biome
│   ├── world_backdrop.dart  # Map sky: sun/moon, stars at night, drifting clouds with parallax
│   ├── particle_layer.dart  # Petals / fireflies / leaves / snow over the map
│   ├── biome_band.dart      # One unit's piece of world: biome ground + decor, fog on locked units, reveal
│   └── meadow_trail.dart    # Path between a unit's lesson nodes: swaying meadow by season, biome animals hopping along it (asleep at night, still with reduced motion)
└── widgets/
    ├── challenge_card.dart  # Target card (hint + letters; hidden mode for listen)
    ├── keyboard_widget.dart # Full keyboard + swype gesture detection
    ├── key_widget.dart      # Single key (active/inactive state)
    ├── star_celebration.dart # Falling stars + confetti after a correct swype
    └── swype_painter.dart   # CustomPainter — glowing swype trail + fireflies
test/
├── pack_loading_test.dart   # Validates all 9 packs (targets ⊆ unlocked ⊆ keys, unique ids, drift vs Dart) + store catalog
├── entitlement_service_test.dart # Locks, free language, grandfathering, FakeStore purchases (store_fixture.dart = in-memory pack with bands)
├── store_lock_test.dart     # Widget tests with the store switched on: map fog island, GameScreen refusal, child picker
├── progress_service_test.dart
├── game_screen_test.dart   # Widget test: swype → stars → next lesson → sticker
├── world_clock_test.dart
└── audio_service_test.dart
tool/
└── generate_sfx.dart        # Synthesized placeholder sfx → assets/audio/
```

`test/` lists only the main tests; see the folder for all of them.

## Platforms

iOS, Android, macOS, Linux, Windows (platform folders in the repo; check pubspec for active platforms).

## Game Flow

1. First start: `OnboardingScreen` (language by flag, avatar, optional name) → `ProfileService.onboarded`
2. Lesson map shows units and lesson nodes; linear unlocking, persisted progress
3. Tapping a node plays the unit from that lesson in `GameScreen`
4. Challenge card shows target word/syllable (or hides it + plays TTS in `listen` rounds)
5. Child swipes across keyboard letters in order
6. Correct swype → 1–3 stars (by attempt count), next lesson; errors never block progress
7. Unit finished → collectible sticker → back to map; whole pack finished → WinScreen
