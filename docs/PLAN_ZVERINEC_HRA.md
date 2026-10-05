# Plán: Zvěřinec jako hřiště — „Hraj si se zvířátkem"

Stav: zadání k implementaci (říjen 2026, od v2.10.0). Navazuje na
`docs/ROADMAP.md` P4 („Zvěřinec 2.0: zvířátka lze krmit/pohladit") a P5
(slovíčka → věty) a na `docs/GAMEPLAY.md` §4. Určeno jako zadání pro
implementaci po fázích; každá fáze je samostatný PR + release.

---

## 0. Co chceme (zadání od autora)

> Po kliknutí na řádek ve Zvěřinci se otevře svět, kde si můžu se
> zvířátkem hrát: dát mu najíst, napít známými slovíčky/emoji, podrbat ho.
> Propojení mezi achievementy, skládáním věty a trénováním slov, které už
> umím. Co nejvíc emoji/nálepek rozhýbat na dotyk a na akci.

## 1. Princip: hra je opakování, které dítě nepozná

Zvířátko je **důvod** sáhnout po naučených slovech:

| Dítě dělá | Appka učí | Kde to je dnes |
|---|---|---|
| Vybírá z tácku, co zvířátku dá | **Obrázek → slovo** (vybavení z batohu) | batoh slov (`ProgressService.wordBag`) |
| Než dárek podá, slovo „řekne" (mini-kolo) | **Psaní / doplnění slova** podle síly | `GameScreen(practice:)`, síla slov 0–5 |
| Zvířátko si něco přeje (bublina s obrázkem) | **Slovo → obrázek**, přednostně slabá slova | `weakestLearned` |
| Po dárku se objeví věta „Myška jí banán." | **Skládání věty**, 3. osoba, pád předmětu | `ComposedSentence`, `pack.sentence` |
| Větu uloží do knížky, sbírá odznaky | **Achievementy** bez tlaku | `addToBook`, `AchievementService` |
| Hladí, šimrá, uspává | Odměna, klid, žádná mechanika péče | — |

Pravidla, která platí (viz ROADMAP §1): žádný hlad, žádné „zvířátko
umře", žádný časovač. Zvířátko je vždycky rádo, že dítě přišlo. Chyba ve
slově nic neblokuje (po chybě se slovo odkryje — stávající scaffolding).

## 2. Jak to vypadá

### 2.1 Vstup

- **Zvěřinec:** ťuknutí na řádek (pás biotopu) s *získanou* nálepkou
  otevře `PetScreen` daného zvířátka (Hero nálepky z pásu do světa).
  Nezískaný řádek: nic (mlha), jako dnes.
- **Po dokončení jednotky:** na `UnitCompleteScreen` přibude tlačítko
  „🏡 Pojď si hrát" vedle „Zpět na mapu" — otevře svět nového zvířátka.
- **Netýká se** jen zvířat: svět se otevře pro každou nálepku jednotky
  (🍌, 🚗, ☀️ …). Obyvatel = nálepka jednotky; u „věcí" fungují stejné
  interakce, jen reakce jsou „hravé" místo „jí" (viz 2.4). Tajná nálepka
  biotopu (🐞, 🐢…) bydlí ve stejném světě jako druhý obyvatel, pokud je
  nalezená.

### 2.2 Scéna (`PetScreen`)

```
┌──────────────────────────────┐
│ ←   🌼 Louka · Myška     📖 │  lišta: zpět, biotop + jméno, knížka
│                              │
│      ☁️      ☀️              │  obloha podle WorldClock (den/noc/období)
│                              │
│   💭🍌  ← přání (bublina)     │
│        🐭  ← obyvatel         │  biotop jako na mapě (BiomeBand styl),
│   🐞            🥣  💧  🛏️    │  dekorace biotopu, props: miska, voda, pelíšek
│  „Myška jí banán."  🔊 ⭐    │  věta po akci (bublina), přečíst / do knížky
├──────────────────────────────┤
│  🍌  🥛  🍎  ⚽  🚗  📖  … │  tácek: naučená slova (batoh), vodorovný scroll
└──────────────────────────────┘
```

- Průvodce (`DraggableGuide`, place `pet`) je tu taky — stejné chování
  jako jinde (přetáhnout, uhne, ťuknutí = zamává); fandí při dárku.
- Bez textu to jde celé ovládat: tácek jsou obrázky, přání je obrázek,
  věta je navíc (čte se nahlas).

### 2.3 Interakce s obyvatelem

| Gesto | Reakce (zvíře) | Reakce (věc) | Zvuk |
|---|---|---|---|
| Ťuknutí | poskočí, řekne jméno (`reward.label`, TTS) | poskočí, jméno | `Sfx.tap` + TTS |
| Tah prstem po těle (hlazení, ≥ 300 ms) | přimhouří oči, ❤️ srdíčka létají, „předení" | zableskne ✨ | nový sfx `purr` (syntéza, `tool/generate_sfx.dart`) |
| Rychlé poklepání 3× (šimrání) | zatřese se, 😂 | zatřese se | `babble`/smích |
| Dlouhý stisk | zvedne se, houpe v prstu, pustit = dopad s pružením | totéž | — |
| Drop dárku **jídlo** | „ňam": kousání (squash 3×), drobky 🟤 | odrazí se, ✨ | `crunch` (nový) |
| Drop dárku **pití** | pije: nakloní se k misce, bublinky 💧 | ✨ | `gulp` (nový) |
| Drop dárku **ostatní** (hračka, auto…) | hraje si: hračka poskakuje kolem, zvíře skáče | obě věci skáčou | `tap` |
| Noc (`WorldClockService.isNight`) / limit session | spí 💤, ťuknutí = pootevře oko, dárky „pšt" (odloží se vedle) | spí | ambient |

Všechny reakce jsou **transformace jedné nálepky** (squash & stretch,
poskok, naklonění, mrknutí přes overlay) + částice. Nečekají na nové
obrázky; pózy (§5) je jen vylepší.

### 2.4 Dárky = naučená slova

- Tácek ukazuje `wordBag(pack.id)` jako nálepky (`EmojiArt` hintu lekce,
  která má `vocab == id`). Prázdný batoh → tácek ukáže 3 „vždy dostupné"
  předměty ze `sentence.objects` s `unlockedBy: always` (🍎 🥛 🧸), ať je
  co dát hned po první nálepce.
- Druh dárku podle emoji: **jídlo** (🍌🍎🍇🥕🍕🍞🧀🥚🍪…), **pití**
  (🥛💧🧃🥤🍵), jinak **hračka**. Tabulka v `lib/pet/gift_kind.dart`
  (sada emoji, ne jazyk).
- **Podání dárku = mini-kolo** (tohle je trénink): ťuknutí na dlaždici
  tácku → spodní panel s kartou slova a klávesnicí (reuse `GameScreen`
  `practice:` s jednou lekcí, nebo lehčí `ChallengeCard`+`KeyboardWidget`
  přímo v panelu — rozhodne implementace, viz §4). Typ kola podle síly:
  - síla 0–1: `swype` s nápovědou (celé slovo vidět);
  - síla 2–3: `missingLetter` (jedno písmeno chybí);
  - síla 4–5: `pictureOnly` (jen obrázek, slovo si dítě vybaví).
  Úspěch = dlaždice „ožije" a dá se přetáhnout na zvíře; `recordAttempt`
  se zapíše normálně (síla roste). Chyba = slovo se odkryje, kolo pokračuje
  (nikdy neblokuje). Přeskočit lze vždy (✕) — dárek pak dítě prostě dá,
  jen bez „+1 síly".
- **Přání**: po vstupu a po každém dárku si zvíře s pravděpodobností 1/2
  něco přeje: bublina 💭 s obrázkem slova. Vybírá se z batohu, přednostně
  **slabá** slova (`weakestLearned`, síla ≤ 3), nikdy totéž dvakrát za
  sebou. Splněné přání = větší oslava (⭐ konfety, `fanfare` krátká) a
  počítá se do odznaku. Nesplněné nevadí; po dárku jiného druhu bublina
  zmizí (zvíře je spokojené i tak).

### 2.5 Věta po dárku (skládání věty)

Po dárku se nad zvířetem objeví bublina s větou a řádkem emoji:

- podmět = obyvatel: `SentencePart(text: reward.label, person: 3sg)`
  (nová data: `reward.subject` s tvary, viz §4.3; bez nich fallback na
  `label`);
- sloveso podle druhu dárku: jídlo `v2` (jí), pití `v3` (pije), hračka
  `v6` (hraje si) — ids `v1…v6` jsou **stejné ve všech 9 packech**;
  tvar 3. os. z `forms['3sg']`;
- předmět: dlaždice `sentence.objects` s `id == vocab` (má pády:
  `formFor(verb.frame)`), jinak `lesson.label` beze změny.

→ `ComposedSentence(subject, verb, object, joiner)` → `text` do bubliny,
`TtsService.speak`, 🔊 přečte znovu, ⭐ uloží do Mé knížky
(`addToBook(pack.id, text, emojis)`), stejně jako dnes `WordSentenceScreen`.

Zvíře, které dítě zná, se tak stane **podmětem**, kterého v builderu vět
zatím není (jen Já/Máma/Táta/Bába). Fáze 4 přidá zvířata jako podměty i
do `SentenceBuilderScreen` (`unlockedBy: "sticker"`).

### 2.6 Odznaky (achievementy)

Nové `GameBadge` (ARB v 9 jazycích; `GameBadgeL10n`):

| Odznak | Emoji | Podmínka |
|---|---|---|
| Hostitel | 🍽️ | 10 dárků celkem |
| Mazlík | 💕 | pohladil 5 různých zvířátek |
| Splněné přání | 🎁 | 10 splněných přání |
| Kamarád všech | 🏡 | každé získané zvířátko dostalo dárek (vyhodnocuje se, když je nálepek ≥ 5) |

Spouštěč `PetAction(kind)` v `AchievementService.check`; čip odznaku se
ukáže ve světě (`BadgeChip`, jako ve hře).

### 2.7 Nálepky, které reagují na dotyk — všude (ne jen ve světě)

Rozšíření `EmojiArt` o reakce, aby se co nejvíc obrázků hýbalo na dotyk a
na akci i mimo `PetScreen`:

- `EmojiArt(…, reaction: StickerReaction.bounce | wiggle | squash | spin |
  nod | shiver | hearts, onTap:)` — jedno ťuknutí = krátká reakce (≤ 600 ms)
  + volitelný zvuk/TTS. Implementace: `lib/ui/sticker_motion.dart`
  (transformace + částice přes `OverlayPortal`, žádný nový asset).
- `EmojiArt.action(StickerAction.eat | drink | play | sleep | happy)` —
  „akční" smyčky pro svět (kousání, pití, poskakování, 💤).
- Nasazení: karta (ťuknutí na hint = řekne slovo + wiggle), legenda ve
  hře (bounce), mapa (ikona lekce bounce, nálepka jednotky nod), Zvěřinec
  (všechny), dlaždice vět (pop), Má knížka (emoji řádku poskočí při čtení
  po slovech), výzdoba biotopů (sway při ťuknutí + ambient „šustění"),
  avatary profilů (wiggle), odznaky (spin).
- Při `disableAnimations` (přístupnost) se reakce zkrátí na změnu měřítka
  bez pohybu, jako dnes u průvodce.

## 3. Data a persistence

- `ProgressService` (per pack): `pet: {gifts: int, petted: [emoji],
  wishesDone: int, fedStickers: [emoji]}` v `_PackProgress` (JSON zpětně
  kompatibilní — chybějící = nuly).
- Odznaky globálně jako dnes (`sk.global`).
- Věty do knížky stávajícím API; limit 100 stran platí.
- Žádné nové klíče mimo profil (vše pod `sk.p{id}.…` jako ostatní postup).

## 4. Technický plán

### 4.1 Nové soubory

```
lib/pet/
├── pet_screen.dart        # obrazovka světa (lišta, scéna, bublina věty, tácek)
├── pet_stage.dart         # biotop (reuse BiomeBand styl) + obyvatelé + props + částice
├── resident.dart          # stav obyvatele: nálada (idle/eat/drink/play/sleep/love), reakce na gesta
├── gift_tray.dart         # tácek naučených slov; ťuknutí → mini-kolo; drag & drop na obyvatele
├── gift_kind.dart         # emoji → food / drink / toy
├── wish.dart              # výběr přání (slabá slova, bez opakování)
├── pet_sentence.dart      # dárek → ComposedSentence (3. os., pád), bublina + TTS + knížka
└── pet_service.dart       # statistiky, PetAction trigger pro odznaky
lib/ui/
├── sticker_motion.dart    # StickerReaction / StickerAction (transformace + částice)
└── reaction_particles.dart# ❤️ ✨ 🟤 💧 💤 částice (reuse principu StarCelebration)
test/
├── pet_screen_test.dart   # otevření ze Zvěřince, dárek (drop) → reakce + věta + knížka, noc = spí
├── gift_tray_test.dart    # tácek z batohu, fallback na always předměty, mini-kolo podle síly
├── wish_test.dart         # preferuje slabá slova, neopakuje
├── pet_sentence_test.dart # věty ve všech 9 jazycích (jí/pije/hraje si, pád předmětu)
└── sticker_motion_test.dart
```

### 4.2 Reuse, ne nový engine

- **Mini-kolo**: nejjednodušší je `Navigator.push(GameScreen(pack, practice:
  Unit(lessons: [lesson jako missingLetter/pictureOnly/swype])))` a po
  návratu zkontrolovat `strengthOf` (vzrostla = úspěch). Když to bude
  v UX rušivé (celá obrazovka kvůli jednomu slovu), udělat lehký
  `WordRoundSheet` (bottom sheet s `ChallengeCard` + `KeyboardWidget`,
  `onSwypeEnd` vyhodnotí přes stejnou logiku jako `GameScreen._onSwypeEnd`
  — tu logiku vytáhnout do `lib/game/round_judge.dart`, ať je jedna).
- **Lekce pro slovo**: `pack.allLessons.firstWhere((l) => l.vocab == id)`;
  typ kola přepsat podle síly (`Lesson.copyWith(type:, gap:)` — `copyWith`
  přidat, `gap` = náhodný index, pro `pictureOnly` bez změny).
- **Gesta**: hlazení = `GestureDetector.onPanUpdate` nad obyvatelem
  s měřením dráhy (≥ 60 px a ≥ 300 ms); šimrání = 3 taps do 700 ms
  (`onTap` + časovač); zvednutí = `onLongPressStart/MoveUpdate/End`.
  Drop dárku = `Draggable`/`DragTarget` (feedback = větší nálepka).
- **Noc / limit**: `WorldClockService.theme.isNight` nebo
  `SessionService.limitReached` → obyvatel spí; svět jde otevřít, ale
  dárky se jen odloží („pšt" bublina 💤). Limit jinak platí jako všude
  (čas se počítá, po vypršení pop na mapu).
- **Zvuky**: `tool/generate_sfx.dart` doplnit `purr`, `crunch`, `gulp`
  (syntéza; manifest `assets/audio/manifest.json`). Bez licencí.
- **Jazyk**: všechny texty přes ARB (`petTitle`, `petPlay`, `petShh`,
  názvy odznaků…); věty přes pack.

### 4.3 Změny packu (schéma v2, zpětně kompatibilní)

- `reward.subject` (volitelné): `{ "text": "Myška", "person": "3sg",
  "forms": {...} }` — tvar podmětu pro věty (cs: zdrobnělina, jak zvíře
  oslovujeme; zh/ja bez `forms`). Bez něj se použije `reward.label`.
- `sentence.subjects[*].unlockedBy: "sticker"` + `"sticker": "🐭"` — zvíře
  jako podmět v builderu po získání nálepky (fáze 4). Přidat
  `TileUnlock.sticker`; test `pack_loading_test` ověří, že `sticker`
  odpovídá nějaké `reward.emoji` packu.
- Nic ze stávajících lekcí se nemění (pravidlo: lekce do jednotky
  nepřidávat).

### 4.4 Pózy obyvatel (volitelné vylepšení, fáze 4)

`EmojiArt` dostane `pose:` (`eat`, `drink`, `happy`, `sleep`); asset
`assets/emoji/<cp>-<pose>.webp`, když existuje (`kEmojiArt` index rozšířit
o pózy: `tool/emoji_art/build.py` čte `emoji-<cp>-<pose>.png`). Když póza
chybí, zůstane základní nálepka s transformací — svět funguje bez nich.
Obrázky: §5.

## 5. Výtvarné podklady (SPARK, flux-schnell)

Všechno ostatní už je (294 nálepek, 4 průvodci × 10 póz, 🥣 💧 🛏️ 🍽️
existují). Chybí:

| Sada | Počet | K čemu | Kdy |
|---|---|---|---|
| Pózy zvířátek: `eat`, `happy`, `sleep` pro 34 zvířat (27 nálepek jednotek + 7 tajných) | 102 | §2.3, §4.4 | fáze 4 |
| Pozadí biotopů (12 × široký výjev bez postav) | 12 | scéna `PetStage` místo gradientu | fáze 2 (nice to have) |
| Props: miska s jídlem, miska s vodou, pelíšek (styl nálepek) | 3 | scéna | fáze 2 |

Zadání (`drafts/stickers/round4/prompts.json`) připraveno; běh podle
pravidel Directora (warm-up, concurrency 2, okno). Výstup do
`drafts/stickers/round4/out/` (gitignored), výřezy přes
`tool/emoji_art/build.py --poses`. Kontrola v galerii; vadné zůstanou na
transformacích.

## 6. Fáze (každá = PR, testy, release na TestFlight)

### Fáze 1 — „Nálepky reagují" (1–2 dny)
`StickerReaction`/`StickerAction` v `EmojiArt`, částice, nasazení na
karta/mapa/Zvěřinec/věty/knížka/biotopy/profily/odznaky (§2.7). Žádná
změna dat. **Hotovo znamená:** ťuknutí na libovolnou nálepku v appce něco
udělá (pohyb ≤ 600 ms, zvuk nebo jméno nahlas); `disableAnimations`
respektováno; testy na reakce.

### Fáze 2 — „Svět zvířátka" MVP (3–4 dny)
`PetScreen` ze Zvěřince + z `UnitCompleteScreen`; scéna s biotopem,
obyvatel (+ tajná nálepka), hlazení/šimrání/zvednutí/ťuknutí; tácek
z batohu (bez mini-kola), drop = reakce podle druhu + věta v bublině +
TTS + ⭐ do knížky; noc/limit = spí; průvodce na ploše; nové sfx.
**Hotovo:** test „ze Zvěřince do světa, dárek 🍌 → 'Myška jí banán.' →
v knížce"; věty správně v 9 jazycích (test nad packy).

### Fáze 3 — „Učení uvnitř" (2–3 dny)
Mini-kolo před podáním dárku podle síly (§2.4), přání ze slabých slov,
odznaky (§2.6) + ARB, statistiky v progressu, `PetAction` trigger.
**Hotovo:** síla slova po úspěšném mini-kole +1; přání preferuje slabá;
odznaky se udělí jednou; nic neblokuje (přeskočit vždy jde).

### Fáze 4 — „Zvířata mluví ve větách" (2–3 dny + obrázky)
`reward.subject` + `unlockedBy: "sticker"` podměty v 9 packech (cs, en
nejdřív, zbytek s poznámkou k revizi rodilým mluvčím), `TileUnlock.sticker`
v builderu, pózy obyvatel z round 4 + pozadí biotopů (když projdou
kontrolou). **Hotovo:** v builderu jde složit „Myška pije mléko" po získání
myšky; pózy se použijí tam, kde jsou, jinde transformace.

## 7. Rizika a rozhodnutí

| Riziko | Řešení |
|---|---|
| Mini-kolo před dárkem dítě otravuje | Přeskočitelné vždy; u síly 5 jen `pictureOnly` (2 s); rodič může v koutku vypnout („dárky bez psaní") — přepínač `SettingsService.petRounds` |
| Věty v jazycích s pády/rody (cs, de) špatně | `reward.subject.forms` + `objects.forms` už existují; test generuje všechny kombinace zvíře × sloveso × předmět a ukládá snapshot k revizi (`test/golden/pet_sentences_<lang>.txt`) |
| Příliš mnoho částic na slabém zařízení | Max 24 částic na scénu, `animate: false` v tácku, `RepaintBoundary` kolem scény |
| Pózy z AI nejsou konzistentní s nálepkou | Pózy jsou volitelné; po kontrole v galerii se vadné nepoužijí |
| Zvíře vs. věc (🍌 „jí jablko"?) | Věc nejí: pro věci sloveso vždy `v6` (hraje si) a reakce „hravé"; v §2.3 |
| Velikost appky | pózy ~1,5 MB (WebP 320 px), pozadí ~1 MB |

## 8. Co se nemění

Lineární mapa, hvězdy, nálepky za jednotky, builder vět a knížka zůstávají;
svět je další „místnost", kam dítě chodí dobrovolně. Žádné notifikace,
žádný hlad, žádné streaky. Soukromí: vše offline, bez nových oprávnění
(`docs/PRIVACY.md` platí beze změny).
