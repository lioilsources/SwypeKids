# SwypeKids — CLAUDE.md

## Overview

Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Duolingo-inspired progression: a lesson map with units, 1–3 stars per lesson, collectible emoji stickers per unit ("Zvěřinec"), persisted progress. Content is data-driven: one JSON content pack per language in `assets/packs/`. Gameplay & content-model design doc: `docs/GAMEPLAY.md`. Product roadmap (v2.2 → v4.0): `docs/ROADMAP.md`. Brief for the illustrator (mascot, animals, Rive inputs): `docs/ILLUSTRATOR_BRIEF.md`. Playtest protocol (5 kids × 15 min per release): `docs/PLAYTEST.md`. Store submission kit (listing texts in cs/en/de/es/pt-BR/fr/it with length checks, review notes, privacy/data-safety answers, manual steps): `docs/STORE.md`. Monetization plan (today's content + device language free; new islands = pásmo B/C, languages, theme packs, voice as 29 Kč / $0.99 non-consumables + "all forever" bundle; separate paid school app; never visible to the child; 5 phases): `docs/MONETIZATION.md`. Plan for the Zvěřinec play world (pet screen, gifts from the word bag, wishes, badges, sticker reactions; 4 phases): `docs/PLAN_ZVERINEC_HRA.md`. Plan for sentence quality (rules for what may be combined, explicit forms, sentence corpus export, LLM + native-speaker review; phases 0–4): `docs/PLAN_VETY_KVALITA.md`. How to run a sentence review round (machine + native speaker, new language checklist): `docs/SENTENCES_REVIEW.md`. Privacy policy (offline, no data collection; cs + en): `docs/PRIVACY.md` — keep it true: never add network calls, analytics or ads without updating it.

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
tool/store_screenshots.sh <dir>             # real-app screenshots of every section (macOS run, muted) → phone-*.png, desktop-*.png, appstore-iphone-*.png (1320×2868), appstore-ipad-*.png (2064×2752)
python3 tool/store_feature_graphic.py <DynaPuff.ttf>  # Google Play feature graphic 1024×500 → build/store/
```

## Architecture

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
│   └── biome_band.dart      # One unit's piece of world: biome ground + decor, fog on locked units, reveal
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
- Lesson `type`: `swype` | `listen` | `missingLetter` (`gap` index) | `pictureOnly` | `reviewMix` (resolved at runtime to the weakest learned word, `resolveReviewMix`) | `letterHunt` (1-letter target, TTS, tap) | `syllableJoin` (`parts` shown as chips, swype whole word) | `rhymePick` (`options` + `answer`, picture choice instead of keyboard); unknown types fall back to `swype`
- Session limit: `SessionService` counts foreground time (HomeShell lifecycle); when reached the game finishes the round and pops, the map shows the bedtime card and blocks lessons; extension only in the parent corner
- Parent corner (drawer 👪 → `ParentGate` → `ParentScreen`): sound/music/ambient toggles and season override live here, not in the child's drawer; letter status = mean word strength per letter (≥ 4 mastered)
- Guides: each profile picks its guide in the profile sheet (drawer → avatar); `ProfileService.guide` notifies, `Mascot` follows it. The guide behaves the same everywhere — use `DraggableGuide` on any new screen with the guide and wrap tap targets the guide must not cover in `GuideAvoid`
- Profiles: `ProgressService.init(profile: id)` loads one child's progress (keys namespaced per profile, profile 1 unprefixed so old installs need no migration); switching rebuilds HomeShell screens via a keyed IndexedStack. Settings (sound, season) stay global
- Builder subjects from Zvěřinec: every collected animal/person sticker becomes a sentence subject (`TileUnlock.sticker`, generated from `reward.subject` by `PetSentence.stickerSubjects`; things like 🍌 are not subjects)
- Pet world (`docs/PLAN_ZVERINEC_HRA.md`): `reward.subject` = the sticker as a sentence subject (article/particle included: „Die Maus", „ねこは"); gifts are only food/drink/toys (`StickerKind.giftable`); a sentence uses an object only when `sentence.objects` has it (cases), otherwise subject + verb — never ungrammatical; `sentence.order: "sov"` puts the verb last (ja). Every sentence the app can offer (builder incl. Zvěřinec subjects, pet world) is enumerated by `SentenceCorpus.of(pack)` with stable ids; review state per sentence lives in `review/sentences_<lang>.tsv` (text hash → a changed sentence goes back to pending), summary in `review/STATUS.md`. After changing packs or rules run `UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart`; `SentenceRules` (in `sentence.dart`) is the single place that decides what may be composed. A sentence is offered only if the verb takes the subject's `kind` (`person`/`animal`/`thing`) and one of the object's `tags` (`food`, `drink`, `toy`, `vehicle`, `place`, `thing`, `body`) AND the object has an **explicit** form for the verb's `frame` (no silent base-form fallback — give an object a form only where the sentence makes sense; frames are free keys per pack, e.g. ja `ga`). Verb `text` is the tile label, `forms[person]` the form in a sentence („hraju si“ → „si hraje“). Things as pet-world residents use `reward.verb` („Oko se dívá na…“) or the naming sentence (`sentence.naming` + `forms.nom`). `tool/sentences/migrate_rules.py` holds the authored tables for all 9 packs. Guards: `test/sentence_rules_test.dart` (T1–T8, incl. random tapping in the builder ⊆ corpus) Stickers react to touch everywhere (`EmojiArt.reaction`, via `Listener` — never steals the parent's tap); poses `assets/emoji/<cp>-<eat|happy|sleep>.webp`
- Badges (`GameBadge`, 14 from roadmap P4 + 4 pet-world badges via `PetAction`) are global across languages; `AchievementService.check` is called on LessonDone / UnitDone (game), SessionStart (map open) — never add streak-style pressure
- Word strength 0–5 per target (`ProgressService.recordAttempt`); map offers “Procvičování” (5 weakest learned) via `GameScreen(practice: …)`, which never writes lesson completion or stickers
- Monetization (`docs/MONETIZATION.md`, phase 1) ships **switched off**: `StoreConfig.enabled = false` → everything unlocked, nothing purchase-related anywhere. A unit has `band` (`a` default = Ostrov písmenek, `b`, `c`) and optional `product` (theme-pack tag, e.g. `theme.zima`, one product for all languages); `lang.<id>` is derived in code. `assets/store/catalog.json` lists products with explicit `unlocks` (`all` | `languages`+`bands` | `tags` | `features`). Always ask `EntitlementService.instance` (`unlocked(pack, unit)`, `unitOpen`, `playableUnits`, `childLanguages`) instead of assuming a unit/language is available; never render prices or buy actions outside the parent corner — the child sees at most the fogged island on the map. Tests switch locks on with `storeOn()` from `test/store_fixture.dart` (reset with `storeOff()` in tearDown)
- Never add lessons to an existing unit (it would re-lock later units for kids who finished it); add new units, or change an existing lesson's type (id + progress stay)
- `reward.label` = sticker name in the pack language (required; Zvěřinec says it aloud). Each `Biome` has a `secret` sticker found by tapping the hidden ✨ on the map
- `unit.scene.biome` names the unit's biome (`Biome` enum in `world/world_clock.dart`; unknown → meadow). Map sky = day phase × season; season is calendar-based unless the parent overrides it in the drawer
- Word bag: a correct swype of a lesson with `vocab` adds the word to the bag (`ProgressService.addWord`); builder tiles with `unlockedBy: "vocab"` stay locked (“?” silhouette) until then
- JSON packs are the single source of truth (Dart lessons removed in v2.3); edit `assets/packs/*.json` directly, `flutter test` validates them (every lesson needs a `parentNote` in the pack's language; hint emoji ≤ Unicode 12)

## Assets

- UI chrome is localized (12 ARBs in `lib/l10n/`, template `app_cs.arb`): never hardcode user-facing strings in widgets — add a key to every ARB, run `flutter gen-l10n`, use `context.l.key`. UI language follows the pack language (`AppLanguage`) unless the profile has a family language (`ChildProfile.home`, `ProfileService.home`): uk, ru and vi are UI-only languages (`kHomeOnlyLanguages` in `lib/ui/l10n.dart`, no content pack — never add them to the `Language` enum) for children who learn to read in another language than the one spoken at home (Ukrainian child in a Czech school). Chosen by the 🗣 flags in onboarding or per profile in the parent corner; speech from packs stays in the pack language, only the onboarding phrases are spoken in the family language (`OnboardingScreen.homePhrases`, `TtsService.speakIn`). `kFont` is a getter (Baloo 2 for the Vietnamese UI, Cyrillic falls back to Nunito) — never cache a `TextStyle` with it in a `static final`. Widget tests wrap screens in `localizedApp(...)` from `test/helpers.dart`
- Fonts come from the shared package `cute_kid_fonts` (lioilsources/CuteKidFonts, git ref in pubspec): DynaPuff for all text incl. the parent corner (`kFont`, always with `fontFamilyFallback: kFontFallback`; also the ThemeData default for unstyled text), `BubbleText` for the card label, `KidKeyLabel` on keys. OpenDyslexic (SIL OFL, `fonts/`) replaces it when the parent enables it. Never hardcode a font family — use `kFont` from `lib/ui/app_font.dart`; `test/app_start_test.dart` fails if any text renders in a system font. Widget tests: `findText()` from `test/helpers.dart` also finds `BubbleText`
- Emoji are shown as stickers: always render pack/UI emoji with `EmojiArt(emoji, size: …)` (not `Text`). Stickers live in `assets/emoji/` (WebP, 320 px, cut out from flux-schnell drafts in `drafts/stickers/round3/out/`, gitignored); `python3 tool/emoji_art/build.py <drafts> [--reject cp,…]` rebuilds them and the index. A new emoji without a sticker still works (fallback). Control symbols (🔊 ✅ ➡️) and flags stay emoji. Widget tests: `findText()` also matches `EmojiArt`; fix day/night with `WorldClockService.instance.debugNowOverride` (reset in tearDown); screens with stickers never settle — use `settle(tester)` instead of `pumpAndSettle`
- Content packs in `assets/packs/`
- Sfx in `assets/audio/sfx/`, ambient loops in `assets/audio/ambient/`, title music in `assets/audio/music/` + catalog `assets/audio/manifest.json` (`sfx`, `ambient`, `music`)
- Screenshots in `GALLERY.md`
