# SwypeKids — Gameplay & obsahový model

Koncepční dokument pro evoluci core gameplay, progrese a vícejazyčného obsahu.
Stav: iterace 1 implementována (v2.1.0).

## 1. Vize a herní smyčka

Dítě (5–9 let) se učí písmena a slabiky swypováním po emoji klávesnici.

**Původní smyčka (do v2.0):** karta → swype → hvězda → další lekce → konec seznamu.
Lineární, bez uložení postupu, bez důvodu se vracet.

**Nová smyčka (od v2.1):**

```
mapa lekcí → jednotka → lekce (kolo) → hvězdy ⭐ → … → odměna 🐭 → zpět na mapu
```

- Postup se ukládá (shared_preferences) — restart appky nic nemaže.
- Hvězdy 1–3 za lekci: napoprvé 3⭐, napodruhé 2⭐, jinak 1⭐. Chyba nikdy
  neblokuje postup — dítě to prostě zkouší, dokud neuspěje.
- Za dokončenou jednotku padá sběratelská nálepka do Zvěřince.

## 2. Srovnání s Duolingo (inspirace, žádná integrace)

Duolingo nemá veřejné API pro obsah ani účty — „propojení" tedy znamená
převzetí osvědčených smyček, ne technickou integraci.

**Přebíráme:**

| Mechanika | U nás |
|---|---|
| Cesta / path s uzly | Mapa lekcí, jednotky, lineární odemykání |
| Checkpoint na konci unitu | Poslední lekce jednotky = opakovací (`review`) |
| Okamžité odměny | Nálepky (Zvěřinec), hvězdy, oslava jednotky |
| Žádný trest za správný pokus | Chyba = zatřesení + retry, nikdy ztráta postupu |

**Vědomě vynecháváme (věk 5–9):**

- ❌ srdíčka/životy — frustrace, dítě nesmí „prohrát učení"
- ❌ ligy a žebříčky — sociální tlak nepatří do 5–9
- ❌ streak s tlakem a notifikační nagging — max. jemná „dnes jsi hrál/a"
  nálepka (fáze 2+)
- ❌ gemy, obchod, reklamy

## 3. Jednotky a mapa

- **Jednotka** = skupina 1–8 lekcí se stejnou sadou odemčených písmen
  (odpovídá „fázím" didaktické metody). Příliš dlouhé fáze se dělí na
  přechodu slabiky → celá slova.
- Poslední lekce jednotky (pokud má jednotka víc než jednu) je `review: true`.
- **Mapa** (`LessonMapScreen`): svislá cesta, bloky jednotek s hlavičkou
  (ikona, název, odměna ❓/emoji), uzly lekcí hadovitě pod sebou.
- Stavy uzlu: 🔒 zamčeno / odemčeno (žlutý pulz na aktuálním) / hotovo
  (zeleně + ⭐×n). Odemykání je lineární: lekce N+1 po lekci N, jednotka
  po jednotce.

## 4. Zvěřinec (sbírka)

- Za dokončení jednotky dítě získá emoji nálepku (zvířátko/věc z klávesnice:
  🐭 🐯 🍌 🐘 …). Odměny v packu se neopakují.
- `CollectionScreen` = nálepkové album: mřížka, získané barevně se jménem,
  nezískané šedě ❓. Počítadlo X/Y v hlavičce.
- Motivace sbíráním, ne soutěžením.

## 5. Content pack model (JSON)

Lekce žijí v `assets/packs/{lang}.json` — jeden pack na jazyk (a v budoucnu
kulturní variantu). Přidání jazyka = přidání JSON souboru, žádný Dart.

```json
{
  "schemaVersion": 2,
  "id": "cs-CZ",
  "language": "cs",
  "culture": "CZ",
  "title": "Slabikář – Čeština",
  "method": "analyticko-syntetická (Hláskovice / Nová škola)",
  "units": [
    {
      "id": "cs-u1",
      "title": "M, A",
      "icon": "👩",
      "reward": { "emoji": "🐭", "name": "M" },
      "lessons": [
        {
          "id": "cs-u1-l1",
          "type": "swype",
          "unlocked": ["M", "A"],
          "target": "MA",
          "display": "MA",
          "hint": "👩",
          "label": "MÁ-MA",
          "info": "Přejeď: 🐭 → 🍎",
          "ipa": "maː"
        },
        {
          "id": "cs-u6-l1",
          "target": "MAMA",
          "display": "MÁMA",
          "vocab": "mama",
          "parentNote": "Celé slovo; dítě už zná obě slabiky."
        }
      ]
    }
  ],
  "sentence": {
    "joiner": " ",
    "subjects": [
      { "id": "s1", "emoji": "👶", "text": "Já", "person": "1sg", "unlockedBy": "always" },
      { "id": "mama", "emoji": "👩", "text": "Máma", "person": "3sg", "unlockedBy": "vocab" }
    ],
    "verbs": [
      { "id": "v2", "emoji": "🍽️", "text": "jím", "forms": { "3sg": "jí" }, "frame": "acc", "unlockedBy": "always" }
    ],
    "objects": [
      { "id": "kolo", "emoji": "🚲", "text": "kolo", "forms": { "instr": "s kolem", "loc": "u kola", "dir": "ke kolu" }, "unlockedBy": "vocab" }
    ]
  }
}
```

### Schéma v2: batoh slov a builder vět (v2.3)

- `sentence` — data módu „Skládej větu" (dřív `lib/data/sentence_builder.dart`).
  Slovesa se časují podle `person` podmětu, předměty skloňují podle `frame`
  slovesa (`acc` / `dir` / `loc` / `instr`) přes `forms`.
- `unlockedBy: "always"` = dlaždice je k dispozici hned (věta jde složit od
  začátku); `"vocab"` = objeví se, až dítě swypne lekci s `vocab == id`.
  Do té doby je v builderu siluetka „?", 24 h po získání má štítek „NOVÉ".
- **Slovo do věty** (wordToSentence): když správný swype přidá nové slovo do
  batohu a slovo má vocab dlaždici, po oslavě se otevře malý builder
  (`WordSentenceScreen`) se slovem předvyplněným. Dítě doplní zbylé dvě části
  (max. 4 možnosti, slova z batohu první), trumpeta větu přečte. Automaticky,
  bez zápisu v packu; vždy jde přeskočit ✕.
- **Má knížka**: hotovou větu z builderu jde uložit 📖, věty z „slova do
  věty" se ukládají samy. Knížka (menu 📖) je čte nahlas po ťuknutí; max. 100
  stránek, stejná věta jen jednou.
- **Vzít slovo do hry**: naučená slova mají v builderu 🎹 → jedno swype kolo
  s tím slovem (procvičovací režim, nezapisuje dokončení lekcí).
- `unit.scene` — `{ "biome": "forest" }`; biotop kousku světa na mapě
  (meadow, forest, pond, garden, farm, city, mountains, beach, orchard,
  snow, jungle, sky). Neznámé jméno → louka. Vzhled (barva země, dekorace)
  drží `Biome` v `lib/world/world_clock.dart`, pack jen jmenuje.
- **Svět na mapě** (v2.4): obloha podle denní doby × ročního období
  (kalendář, nebo ruční volba rodiče v menu), slunce/měsíc, hvězdy v noci,
  mraky s parallaxem, částice (jaro květy, letní večer světlušky, podzim
  listí, zima sníh). Zamčená jednotka je v mlze; po odemčení se mlha
  jednou rozplyne (`ProgressService.isUnitRevealed`). V noci mají získané
  nálepky 💤. Redukce pohybu: bez částic, mraků a třpytu.
- `lesson.vocab` — id slova do batohu. Jen celá slova (target > 2 písmena),
  slabiky do batohu nepatří.
- `lesson.parentNote` — jedna věta pro rodiče v jazyce packu; zatím se ukáže
  dlouhým stiskem uzlu na mapě, ve v3.1 v rodičovském koutku. Povinná u
  každé lekce všech jazyků (hlídá test).
- Validace (`test/pack_loading_test.dart`): každé `vocab` má vocab dlaždici,
  každou vocab dlaždici odemyká aspoň jedna lekce, id dlaždic jsou unikátní,
  každá kategorie má aspoň jednu `always` dlaždici.

Zásady:

- `target` = co se swypuje (velká latinka bez diakritiky), `display` = co se
  zobrazuje (diakritika, tóny, hiragana). Díky tomu fungují i zh/ja na
  latinské klávesnici.
- `type`: `swype` | `listen` | `missingLetter` | `pictureOnly`; neznámý typ
  padá na `swype` (starší appka přežije novější pack).
- **Síla slova** (0–5, podle `target`): úspěch +1, chyba −1
  (`ProgressService.recordAttempt`). Z ní vybírá `reviewMix` a „Procvičování"
  na mapě (5 nejslabších naučených slov, nabízí se od 3 naučených; nezapisuje
  dokončení lekcí ani nálepky).
- **Emoji v `hint` jen do Unicode 12** (Android 7–10 novější nevykreslí,
  z obrázkového kola by byl prázdný čtvereček). Obrázek u `pictureOnly` musí
  jednoznačně ukazovat to slovo.
- **Nové lekce jen do nových jednotek.** Jednotka je hotová, když má hotové
  všechny lekce — přidaná lekce by dětem, které ji dokončily, znovu zamkla
  další jednotky. Existující lekci lze změnit typ (id a postup zůstanou).
- Blok `keyboard.emoji` per pack — lokalizovaná emoji mnemotechnika kláves
  (zdroj: `kEmojiByLang` v `lib/data/keyboard_layout.dart`, do JSON ji zapisuje
  export tool). Každý pack definuje emoji pro všechna písmena; emoji odměn
  (nálepek) i info texty lekcí ji následují. UI čte přes
  `PackService.keyEmojiFor/keyColorFor` — zapojeno v klávesnici (KeyWidget),
  challenge kartě i legendě GameScreen. `keyboard.colors` zůstává volitelný
  override barev (zatím ho žádný pack nedefinuje).
- Didaktická metoda je vlastnost packu (`method`) — každý jazyk má svou
  (cs analyticko-syntetická, en SATPIN fonetika, es/it/pt sylabická, …).
- JSON packy jsou jediný zdroj pravdy (Dart lekce smazány ve v2.3). Když
  pack nejde načíst, `PackService` použije anglický; rozbitý pack ale
  neprojde `flutter test`.

### Kulturní varianty (výhled)

Varianta = nový pack se stejným `language`, jiným `culture` (např. `en-GB`
vs `en-US`): jiná slovní zásoba (lorry/truck), jiné emoji na klávesách.
Schéma to už umí, chybí jen UI výběru varianty.

## 6. Katalog typů kol

| Typ | Stav | Pravidla | UX |
|---|---|---|---|
| `swype` | ✅ v1 | Karta ukazuje hint + label + písmena; swype v pořadí | dnešní chování |
| `listen` | ✅ v1 | Text skrytý (`• • •`, dlaždice `?`), hraje TTS; 🔊 = přehrát znovu; trefená písmena se odkrývají | po prvním neúspěchu se text odkryje (scaffolding) — bez TTS (desktop) je hra pořád dohratelná |
| `missingLetter` | ✅ v2.3 | Label ukazuje slovo s dírou (MÁ?A); swypuje se celé slovo. `gap` = index díry (default prostřední písmeno); po chybě se odkryje | doplňovačka, trénink pravopisu |
| `pictureOnly` | ✅ v2.3 | Jen hint emoji, žádný label ani písmena; po chybě se odkryje | aktivní vybavení slova, těžší než listen |
| `reviewMix` | ✅ v2.3 | Za běhu se nahradí nejslabším dříve naučeným slovem z odemčených písmen (síla slova); id a postup zůstávají u reviewMix uzlu | spaced repetition lite |

Zásada pro všechny typy: **žádný dead-end** — každé kolo musí být dohratelné
i bez zvuku a po libovolném počtu chyb.

## 7. Roadmapa

Roadmapa se přesunula do [docs/ROADMAP.md](ROADMAP.md) (pilíře: postavičky,
svět s ročními obdobími a dnem/nocí, zvuk, lekce, sběratelství, propojení
slovíček do Sentence Builderu, rodičovský koutek; verze v2.2 → v4.0).

Iterace 1 (v2.1.0) je hotová: JSON content packy + fallback, jednotky +
mapa lekcí, persistence (hvězdy, nálepky, jazyk), Zvěřinec, oslava jednotky,
kolo `listen`, testy (pack loading, progress).
