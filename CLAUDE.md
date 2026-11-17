# SwypeKids

<!-- Max 80 lines. Details go to docs/ with one link here. Public repo: no LAN IPs, home paths or IDs. -->

## Účel
Flutter educational game for children aged 5–9. Teaches letters and syllables by swiping across a QWERTY keyboard with emoji. Duolingo-inspired progression: lesson map with units, 1–3 stars per lesson, collectible emoji stickers per unit ("Zvěřinec"), persisted progress. Content is data-driven: one JSON content pack per language in `assets/packs/`.

## Build a test
```bash
flutter pub get
flutter run                                 # -d ios / -d android
flutter analyze
flutter test                                # pack validation + progress tests
flutter gen-l10n                            # after editing ARBs
UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart  # after changing packs or sentence rules
dart run tool/generate_sfx.dart             # regenerate placeholder sfx (assets/audio/)
```
Store screenshots, metadata and graphics: [docs/STORE_TOOLING.md](docs/STORE_TOOLING.md).

## Mapa
- `assets/packs/` — JSON content packs (cs, en, de, es, it, fr, zh, ja, pt), single source of truth for lessons
- `lib/` — `screens/`, `pet/`, `parent/`, `services/`, `store/`, `world/`, `widgets/`, `characters/`, `ui/`, `l10n/`
- `test/` — widget and pack tests; `test/helpers.dart`, `test/store_fixture.dart`
- `tool/` — sfx, sticker index, sentence tools, store tooling
- `review/` — sentence review state per language
- Full tree, platforms, game flow: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

## Invarianty
Full rules with details: [docs/CONTENT_RULES.md](docs/CONTENT_RULES.md). The most important:
- Edit `assets/packs/*.json` directly; `flutter test` validates them (every lesson needs a `parentNote`, hint emoji ≤ Unicode 12).
- Never add lessons to an existing unit (re-locks later units); add units or change a lesson's type.
- `SentenceRules` (`sentence.dart`) is the single place that decides what may be composed; never ungrammatical sentences.
- Monetization ships switched off (`StoreConfig.enabled = false`). Always ask `EntitlementService.instance`; no prices or buy actions outside the parent corner.
- uk, ru, vi are UI-only languages (`kHomeOnlyLanguages`); never add them to the `Language` enum.
- Font only via `kFont` (a getter — never cache a `TextStyle` with it in a `static final`).
- Emoji render via `EmojiArt(...)`, not `Text`; screens with stickers never settle — use `settle(tester)`.
- Guide on any new screen = `DraggableGuide`; wrap tap targets it must not cover in `GuideAvoid`.
- Badges never add streak-style pressure. Practice mode never writes lesson completion or stickers.
- `docs/PRIVACY.md` must stay true: no network calls, analytics or ads without updating it.

## Kam dál
- `docs/GAMEPLAY.md` — gameplay and content-model design (schema v2 in §5)
- `docs/ROADMAP.md` — product roadmap (v2.2 → v4.0)
- `docs/ILLUSTRATOR_BRIEF.md` — mascot, animals, Rive inputs
- `docs/PLAYTEST.md` — playtest protocol (5 kids × 15 min per release)
- `docs/STORE.md` — store submission kit, listing texts for 13 locales (source for `tool/store_metadata.py`)
- `docs/MONETIZATION.md` — monetization plan (5 phases)
- `docs/PLAN_ZVERINEC_HRA.md` — Zvěřinec play world plan
- `docs/PLAN_VETY_KVALITA.md` — sentence quality plan; `docs/SENTENCES_REVIEW.md` — how to run a review round
- `docs/PRIVACY.md` — privacy policy (offline, no data collection)
- `GALLERY.md` — screenshots
