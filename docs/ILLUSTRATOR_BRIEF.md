# SwypeKids — brief pro ilustrátora / animátora

Verze 1 (říjen 2026). Navazuje na `docs/ROADMAP.md` (pilíř P1, verze v3.0
„Parta") a `docs/GAMEPLAY.md`. Odpovědi na otázky a dodávky prosím do
repozitáře (složka `assets/rive/`), ne e-mailem.

---

## 1. Co je SwypeKids

Hra pro děti 5–9 let, které se učí číst a psát. Dítě přejíždí prstem po
klávesnici s obrázky (emoji) a skládá slabiky a slova; za jednotku dostane
nálepku zvířátka do „Zvěřince". Mapa je svět s biotopy (louka, les, rybník,
město, hory, pláž…), mění se podle ročního období a denní doby. Hra je
tichá a laskavá: žádný trest, žádný časovač, chyba = povzbuzení.

Dnes jsou všechny postavy a objekty **emoji**. Chceme je nahradit vlastní
partou postaviček a animovanými nálepkami, ve stejné „Pixar-kvalitě"
řemesla (velké oči, měkké tvary, squash & stretch) — **bez použití
cizího IP** (žádné skutečné postavy z filmů, her, knih).

## 2. Co potřebujeme (v pořadí priorit)

### 2.1 Maskot — průvodce (pracovní jméno „Pipi")

Jedna postava, která dítě vítá, ukazuje tah, fandí a utěšuje. Kulaté
zvířátko, pohlavně neutrální, cca 3 hlavy vysoké. Návrh druhu je na vás —
dva až tři návrhy (např. lišák, panda, sova, kapybara), vybereme jeden.

**Užší výběr zadavatele (2. 10. 2026)** po prvním kole AI draftů
(`drafts/stickers/`, galerie mimo repo): **panda, kapybara, žirafa, gepardice**.
Nejvíc se líbí stav **jásot** (`cheer`) — energie výskoku a radosti je pro
maskota klíčová, ostatní stavy ať z něj vycházejí. Druhé kolo draftů (4 druhy ×
10 póz, `drafts/stickers/round2/`) slouží jen jako inspirace; prosíme o vlastní
návrhy všech čtyř druhů, z nichž vybereme jeden.

Musí fungovat:
- ve velikosti 48 px (ikona na mapě) i 300 px (onboarding, oslava),
- na tmavém pozadí (noční obloha `#1A1A2E`) i na světlém (zimní den),
- jako silueta (poznatelný obrys).

**Stavy (Rive state machine, názvy vstupů přesně takto):**

| Vstup | Typ | Stav / animace |
|---|---|---|
| — | default | `idle`: dýchá, občas mrkne, rozhlíží se (smyčka 4–6 s, 2–3 variace) |
| `wave` | trigger | zamává (příchod na mapu / na kartu), ~1 s, zpět do idle |
| `wink` | trigger | mrkne (po správném písmenu), ~0,4 s |
| `cheer` | trigger | výskok, tanec (po správném slově), 1,2–1,6 s, zpět do idle |
| `oops` | trigger | ouška dolů + úsměv, „zkus to znovu" — nikdy smutek, 0,8 s |
| `sleep` | bool | spí (v noci / po 20 s nečinnosti), zzz; při `false` se protáhne a probudí |
| `tickle` | trigger | zasmání po dotyku prstem |
| `play` | trigger | idle variace: hraje si s míčem / čte / jí (3–5 s) |
| `season` | number 0–3 | 0 jaro, 1 léto, 2 podzim, 3 zima — doplněk: kytka, sluneční brýle, šála, čepice |

### 2.2 Zvířátka z klávesnice — prvních 8 nálepek

Zvířátka ožívají z emoji na klávesách; po získání nálepky žijí ve Zvěřinci.
Začínáme českými jednotkami, zbytek dostane emoji fallback:

| # | Zvíře | Písmeno (cs) | Dnešní emoji |
|---|---|---|---|
| 1 | myška | M | 🐭 |
| 2 | tygřík | T | 🐯 |
| 3 | kočka | K | 🐱 |
| 4 | lev | L | 🦁 |
| 5 | vlk | V | 🐺 |
| 6 | rybka | R | 🐟 |
| 7 | zebra | Z | 🦓 |
| 8 | sova | — (Zvěřinec) | 🦉 |

Každé zvíře: stejný styl jako maskot, menší rozsah stavů:

| Vstup | Typ | Stav |
|---|---|---|
| — | default | `idle` (dýchá, mrkne) |
| `tap` | trigger | zvuk + krátká animace (myška zapiští a poskočí, lev zařve, sova zahouká) |
| `sleep` | bool | spí (v noci na mapě) |
| `walk` | bool | chůze na místě (zvířátka chodí po mapě kolem cesty) |

Nálepka má i **statickou podobu** (PNG 512×512, průhledné pozadí) pro
album a Hero animaci „nálepka letí do Zvěřince".

### 2.3 Rodina — hinty prvních slov

Statické ilustrace (SVG nebo PNG 512 px, 2 varianty: neutrální a „mává")
pro karty MÁMA, TÁTA, BÁBA, DĚDA, holčička (EMA), chlapeček. Etnicky
neutrální/různorodé, bez stereotypů (máma nemusí mít zástěru). Stejný
styl jako maskot; nemusí být animované (později možná `wave`).

### 2.4 Výhled (ne teď, ale myslet na to)

- Prostředí biotopů (louka, les, rybník, zahrada, farma, město, hory, pláž,
  sad, sníh, džungle, nebe): vrstvené pozadí pro parallax (3 vrstvy), varianty
  pro 4 období a den/noc. Dnes jsou to barvy + emoji dekorace.
- Dekorace Zvěřince (houpačka, lampa, kytky) a oblečení maskota — odměny za odznaky.
- Dalších ~30 zvířátek pro ostatní jazyky (viz emoji v `assets/packs/*.json`,
  klíč `keyboard.emoji` a `units[].reward`).

## 3. Styl

- **Tvary:** měkké, kulaté, velké oči s odleskem, krátké končetiny; squash &
  stretch v animaci. Žádné ostré hrany, žádné realistické proporce.
- **Linka:** buď bez obrysu (flat s měkkým stínem), nebo jednotná tmavá linka
  — rozhodneme podle style sheetu, pak jednotně pro vše.
- **Paleta:** teplá, sytá, ale ne křiklavá. Appka používá
  zlatou `#FFD200`, mint `#1DD1A1`, modrou `#54A0FF`, korálovou `#FF6B6B`,
  noční `#1A1A2E` / `#0F3460`. Postavy musí vyniknout na tmavé obloze i na
  zimní bílé.
- **Výraz:** vždy laskavý. Ani `oops` není smutné — spíš „ups, zkusíme to znovu".
- **Čitelnost bez textu:** dítě nečte; emoce a akce musí být jasné z pózy.

## 4. Technika

- **Formát:** Rive (`.riv`), jeden soubor na postavu, state machine
  pojmenovaný `main` se vstupy z tabulek výše. Vektorově; žádné rastrové
  textury větší než 256 px uvnitř souboru.
- **Rozpočet velikosti:** postava ≤ 300 KB, zvíře ≤ 150 KB (appka má limit
  60 MB a 9 jazyků).
- **Výkon:** cílíme 60 fps na starém Androidu (API 21). Max. ~60 kostí a
  ~400 vektorových bodů na postavu; žádné raster blur efekty.
- **Artboard:** čtvercový, postava vycentrovaná, 10 % okraj pro animace
  (výskok nesmí být oříznutý).
- **Redukce pohybu:** každá animace musí mít smysl i zastavená na prvním
  snímku (systémové nastavení „omezit pohyb").
- **Pojmenování souborů:** `assets/rive/mascot.riv`, `assets/rive/animals/mouse.riv`,
  `tiger.riv`, `cat.riv`, `lion.riv`, `wolf.riv`, `fish.riv`, `zebra.riv`,
  `owl.riv`; statika `assets/stickers/mouse.png` atd.; rodina
  `assets/family/mum.svg`, `dad.svg`, `grandma.svg`, `grandpa.svg`, `girl.svg`, `boy.svg`.
- **Licence:** převod práv k užití v appce (všechny platformy, store
  materiály, web), autor uveden v „O aplikaci".

## 5. Postup a milníky

1. **Style sheet** (1–2 týdny): 2–3 návrhy maskota, 1 zvíře ve stejném
   stylu, paleta, ukázka linky. Vybereme směr.
2. **Maskot** (2–3 týdny): turnaround, expression sheet (idle, wave, cheer,
   oops, sleep), pak `.riv` se state machine. Testujeme v appce na
   telefonu a tabletu.
3. **8 zvířátek** (3–4 týdny): po dávkách 2–3, každé i jako PNG nálepka.
4. **Rodina** (1 týden): 6 statických ilustrací.

Po každém milníku krátký playtest s dětmi (5 dětí × 15 min): sledujeme,
jestli postavu poznají, co jim přijde vtipné a zda chápou `oops`.

## 6. Otázky k vyjasnění

- Preferujete flat bez obrysu, nebo linku? (Pošlete prosím obě ve style sheetu.)
- Umíte Rive přímo, nebo dodáte vektory (SVG/AI) a rigging uděláme my?
- Odhad ceny a času za milníky 1–4.
- Jsou pro vás OK „zvířata z emoji" jako zadání druhu, nebo chcete volnost
  (např. myš → křeček)? Písmeno musí sedět v daném jazyce (M = myš).

## 7. Reference v repozitáři

- `docs/ROADMAP.md` §3 P1 (postavy a svět), §4.1 (Rive), §7 (rizika).
- `docs/GAMEPLAY.md` §2–4 (herní smyčka, hvězdy, nálepky).
- `lib/world/world_clock.dart` — biotopy, období, denní doba (co postavy obklopuje).
- `GALLERY.md` — screenshoty aktuálního stavu (emoji verze).
