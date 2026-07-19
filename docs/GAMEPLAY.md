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
  "schemaVersion": 1,
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
        }
      ]
    }
  ]
}
```

Zásady:

- `target` = co se swypuje (velká latinka bez diakritiky), `display` = co se
  zobrazuje (diakritika, tóny, hiragana). Díky tomu fungují i zh/ja na
  latinské klávesnici.
- `type`: `swype` | `listen`; neznámý typ padá na `swype` (starší appka
  přežije novější pack).
- Blok `keyboard.emoji` per pack — lokalizovaná emoji mnemotechnika kláves
  (zdroj: `kEmojiByLang` v `lib/data/keyboard_layout.dart`, do JSON ji zapisuje
  export tool). Každý pack definuje emoji pro všechna písmena; emoji odměn
  (nálepek) i info texty lekcí ji následují. UI čte přes
  `PackService.keyEmojiFor/keyColorFor` — zapojeno v klávesnici (KeyWidget),
  challenge kartě i legendě GameScreen. `keyboard.colors` zůstává volitelný
  override barev (zatím ho žádný pack nedefinuje).
- Didaktická metoda je vlastnost packu (`method`) — každý jazyk má svou
  (cs analyticko-syntetická, en SATPIN fonetika, es/it/pt sylabická, …).
- Fallback: když asset chybí/nejde parsovat, `PackService` syntetizuje pack
  z Dart lekcí (`lib/data/lessons/`). Dart soubory se smažou ve fázi 2;
  do té doby test hlídá shodu počtu lekcí.
- Regenerace packů: `dart run tool/export_lessons_to_json.dart`
  (pozor, přepíše ruční úpravy JSONů).

### Kulturní varianty (výhled)

Varianta = nový pack se stejným `language`, jiným `culture` (např. `en-GB`
vs `en-US`): jiná slovní zásoba (lorry/truck), jiné emoji na klávesách.
Schéma to už umí, chybí jen UI výběru varianty.

## 6. Katalog typů kol

| Typ | Stav | Pravidla | UX |
|---|---|---|---|
| `swype` | ✅ v1 | Karta ukazuje hint + label + písmena; swype v pořadí | dnešní chování |
| `listen` | ✅ v1 | Text skrytý (`• • •`, dlaždice `?`), hraje TTS; 🔊 = přehrát znovu; trefená písmena se odkrývají | po prvním neúspěchu se text odkryje (scaffolding) — bez TTS (desktop) je hra pořád dohratelná |
| `missingLetter` | 🔜 fáze 2 | Label ukazuje slovo s dírou (M_MA); swypuje se celé slovo | doplňovačka, trénink pravopisu |
| `pictureOnly` | 🔜 fáze 2 | Jen hint emoji, žádný label ani dlaždice | aktivní vybavení slova, těžší než listen |
| `reviewMix` | 🔜 fáze 2 | Náhodná směs dřívějších targetů jednotky/packu | základ pro spaced repetition |

Zásada pro všechny typy: **žádný dead-end** — každé kolo musí být dohratelné
i bez zvuku a po libovolném počtu chyb.

## 7. Roadmapa

**Iterace 1 (hotovo, v2.1.0)**
JSON content packy + fallback, jednotky + mapa lekcí, persistence
(hvězdy, nálepky, jazyk), Zvěřinec, oslava jednotky, kolo `listen`, testy
(pack loading, progress).

**Fáze 2**
Další typy kol (`missingLetter`, `pictureOnly`, `reviewMix`), spaced
repetition u review uzlů, zapojení keyboard overrides do klávesnice,
smazání Dart lesson souborů (JSON = jediný zdroj pravdy), zvuky/sfx.

**Fáze 3**
Kulturní varianty packů (en-GB…), i18n UI chrome (dnes česky natvrdo),
jemný streak bez tlaku, rodičovské statistiky, diakritika long-pressem.

**Fáze 4**
Stahovatelné packy (Firestore/CDN), komunitní tvorba obsahu (JSON schéma
je už teď oddělené od kódu).
