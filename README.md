# Swype Kids 🎹

Výuková hra pro děti 5–9 let. Učí písmena a slabiky swyp tahem po klávesnici s emoji.

Gameplay, progrese a obsahový model: viz [docs/GAMEPLAY.md](docs/GAMEPLAY.md).

## Struktura projektu

```
assets/
  packs/                     # JSON content packy (jednotky + lekce per jazyk)
lib/
  main.dart                  # Entry point (init persistence, volba jazyka)
  data/
    keyboard_data.dart       # Barvy kláves (+ re-export layoutu)
    keyboard_layout.dart     # QWERTY layout + emoji (čistý Dart)
    lessons.dart             # Model Lesson + enum Language/LessonType
    lessons_index.dart       # Dart lekce (fallback, než se smažou ve fázi 2)
    lessons/                 # Lekce per jazyk (cs, en, de, …) — fallback
    models/
      content_pack.dart      # ContentPack / Unit / CollectibleReward
  screens/
    home_shell.dart          # Drawer + přepínání pohledů
    lesson_map_screen.dart   # Mapa lekcí (jednotky, uzly, odemykání)
    game_screen.dart         # Herní obrazovka (jedna jednotka)
    unit_complete_screen.dart# Oslava jednotky (nová nálepka)
    collection_screen.dart   # Zvěřinec – sbírka nálepek
    win_screen.dart          # Dokončení celého jazyka
    sentence_builder_screen.dart # Mód Skládej větu
  services/
    pack_service.dart        # Načítání JSON packů (+ fallback na Dart lekce)
    progress_service.dart    # Persistence: hvězdy, nálepky, jazyk
    tts_service.dart         # Text-to-speech (poslechová kola, věty)
  widgets/
    challenge_card.dart      # Karta s cílem (hint + písmena, poslechový režim)
    keyboard_widget.dart     # Klávesnice + swype detekce
    key_widget.dart          # Jedna klávesa (aktivní / neaktivní)
    swype_painter.dart       # CustomPainter – svítící čára
test/
  pack_loading_test.dart     # Validace všech JSON packů
  progress_service_test.dart # Persistence postupu
tool/
  export_lessons_to_json.dart# Generátor packů z Dart lekcí
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

## Testy

```bash
flutter test            # validace JSON packů + persistence postupu
flutter analyze
```

Po úpravě Dart lekcí lze packy přegenerovat:
`dart run tool/export_lessons_to_json.dart` (přepíše ruční úpravy JSONů!).

## Rozšíření (TODO)

Roadmapa fází je v [docs/GAMEPLAY.md](docs/GAMEPLAY.md). Krátkodobě:

- [x] Konfigurovatelné sady slov (JSON content packy)
- [x] Uložení postupu (hvězdy, nálepky, jazyk)
- [x] Poslechové kolo (TTS)
- [ ] Další typy kol (`missingLetter`, `pictureOnly`, `reviewMix`)
- [ ] Zvuky/sfx – `audioplayers` nebo `just_audio`
- [ ] Animace emoji při zásahu (scale bounce)
- [ ] Diakritika (Á, É, Ě, Š...) jako long-press nebo druhá vrstva
- [ ] Statistiky pro rodiče (které lekce trvaly nejdéle)
