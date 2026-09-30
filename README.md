# Swype Kids 🎹

Výuková hra pro děti 5–9 let. Učí písmena a slabiky swyp tahem po klávesnici s emoji.

Gameplay, progrese a obsahový model: viz [docs/GAMEPLAY.md](docs/GAMEPLAY.md).
Roadmapa (postavičky, svět, zvuk, lekce, rodiče): viz [docs/ROADMAP.md](docs/ROADMAP.md).

## Struktura projektu

```
assets/
  packs/                     # JSON content packy (jednotky + lekce per jazyk) — jediný zdroj obsahu
  audio/                     # Sfx + manifest.json (dočasné syntetizované zvuky)
lib/
  main.dart                  # Entry point (init persistence, audio, volba jazyka)
  audio/
    audio_service.dart       # Zvukové efekty (flutter_soloud)
  data/
    keyboard_data.dart       # Barvy kláves (+ re-export layoutu)
    keyboard_layout.dart     # QWERTY layout + emoji (čistý Dart)
    lessons.dart             # Model Lesson + enum Language/LessonType
    models/
      content_pack.dart      # ContentPack / Unit / CollectibleReward
      sentence.dart          # Dlaždice builderu vět (pack.sentence)
  screens/
    home_shell.dart          # Drawer + přepínání pohledů
    lesson_map_screen.dart   # Mapa lekcí (jednotky, uzly, odemykání)
    game_screen.dart         # Herní obrazovka (jedna jednotka)
    unit_complete_screen.dart# Oslava jednotky (nová nálepka)
    collection_screen.dart   # Zvěřinec – sbírka nálepek
    win_screen.dart          # Dokončení celého jazyka
    sentence_builder_screen.dart # Mód Skládej větu
  services/
    pack_service.dart        # Načítání JSON packů (rozbitý pack → fallback en)
    progress_service.dart    # Persistence: hvězdy, nálepky, jazyk
    tts_service.dart         # Text-to-speech (poslechová kola, věty)
  world/
    world_clock.dart         # Denní doba + roční období, téma mapy
  widgets/
    challenge_card.dart      # Karta s cílem (hint + písmena, poslechový režim)
    keyboard_widget.dart     # Klávesnice + swype detekce
    key_widget.dart          # Jedna klávesa (aktivní / neaktivní)
    star_celebration.dart    # Padající hvězdy + konfety
    swype_painter.dart       # CustomPainter – svítící čára + světlušky
test/
  pack_loading_test.dart     # Validace všech JSON packů
  progress_service_test.dart # Persistence postupu
tool/
  generate_sfx.dart          # Generátor dočasných zvuků
```

## Instalace & spuštění

```bash
# Závislosti
flutter pub get

# iOS simulátor / zařízení
flutter run -d ios

# Android emulátor / zařízení
flutter run -d android

# Release build – iOS
flutter build ios --release

# Release APK – Android
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk
```

## Minimální požadavky

| Platform | Verze         |
|----------|---------------|
| iOS      | 12.0+         |
| Android  | API 21+ (5.0) |
| Flutter  | 3.10+         |
| Dart     | 3.0+          |

## Jak funguje swype detekce

Standardní `pointerenter` na Flutteru nefunguje při tahu, protože pointer je
"zachycen" prvním elementem. Řešení:

1. `GestureDetector.onPanUpdate` na celém kontejneru klávesnice
2. `d.globalPosition` → pro každou aktivní klávesu `RenderBox.globalToLocal()` + `paintBounds.contains()`
3. Středy navštívených kláves ukládáme jako `Offset` → `CustomPainter` kreslí svítící čáru

## Fáze výuky

| Fáze | Aktivní písmena     | Lekce               |
|------|---------------------|---------------------|
| 1    | M, A                | MA MA               |
| 2    | + T                 | TA, MA              |
| 3    | + B                 | BA, MA, TA          |
| 4    | + E, L              | ME, LE, MA, TA      |
| 5    | + O, K              | KO, LO, ME          |
| 6    | tatáž               | MÁMA, TÁTA, BÁBA... |
| 7    | + S, N, P           | LES, PES, NOS       |
| 8    | + I, U              | MI, TU, MISKA, LÍPA |
| 9    | + D, V              | VO, DA, VODA, DŮM   |
| 10   | + J, R              | JÁ, RAK, JE, JABLKO |
| 11   | + Z                 | ZA, ZUB, ZIMA       |
| 12   | tatáž               | SOVA, VLAK, RUKA, LOĎ |

Tabulka platí pro češtinu (pásmo A, 54 lekcí); angličtina má vlastní pořadí
podle SATPIN (51 lekcí). Zdroj pravdy je `assets/packs/*.json`.

## Testy

```bash
flutter test            # validace JSON packů + persistence postupu
flutter analyze
```

Obsah se upravuje přímo v `assets/packs/*.json`; `flutter test` pack validuje.

## Rozšíření (TODO)

Roadmapa fází je v [docs/ROADMAP.md](docs/ROADMAP.md). Krátkodobě:

- [x] Konfigurovatelné sady slov (JSON content packy)
- [x] Uložení postupu (hvězdy, nálepky, jazyk)
- [x] Poslechové kolo (TTS)
- [ ] Další typy kol (`missingLetter`, `pictureOnly`, `reviewMix`)
- [ ] Zvuky/sfx – `audioplayers` nebo `just_audio`
- [ ] Animace emoji při zásahu (scale bounce)
- [ ] Diakritika (Á, É, Ě, Š...) jako long-press nebo druhá vrstva
- [ ] Statistiky pro rodiče (které lekce trvaly nejdéle)
