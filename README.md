# Swype Kids 🎹

Výuková hra pro děti 5–9 let. Učí písmena a slabiky swyp tahem po klávesnici s emoji.

## Struktura projektu

```
lib/
  main.dart                  # Entry point
  data/
    keyboard_data.dart       # QWERTY layout, emoji, barvy
    lessons.dart             # Všechny lekce + postupné odemykání
  screens/
    game_screen.dart         # Hlavní herní obrazovka
    win_screen.dart          # Obrazovka vítěze
  widgets/
    challenge_card.dart      # Karta s cílem (hint + písmena)
    keyboard_widget.dart     # Klávesnice + swype detekce
    key_widget.dart          # Jedna klávesa (aktivní / neaktivní)
    swype_painter.dart       # CustomPainter – svítící čára
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

## Rozšíření (TODO)

- [ ] Zvuky – `audioplayers` nebo `just_audio`, výslovnost písmene/slova
- [ ] Animace emoji při zásahu (scale bounce)
- [ ] Přizpůsobení orientace – landscape layout s větší klávesnicí
- [ ] Konfigurovatelné sady slov (JSON / Firestore)
- [ ] Diakritika (Á, É, Ě, Š...) jako long-press nebo druhá vrstva
- [ ] Statistiky pro rodiče (které lekce trvaly nejdéle)
