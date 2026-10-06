# Plán: věty, které jsou správně a dávají smysl — ve všech jazycích

Stav (6. 10. 2026): fáze 0 (v2.14.1), fáze 1 a 2 (v2.15.0) hotové —
korpus, pravidla a výslovné tvary ve všech 9 packech; z 1 200–2 100 vět na
jazyk (68–100 s tichým základním tvarem) zbylo 470–800 a žádný tichý tvar.
Odchylky: nástroje běží přes `flutter test` (datový model používá Flutter),
`deny`/`allow` zatím nebylo potřeba (stačí nedat předmětu tvar), stav
kontroly je i snímkem korpusu (T6). Aktuální čísla: `review/STATUS.md`.

Původně: zadání k implementaci (6. 10. 2026, od v2.14.0). Určeno jako zadání
po fázích; každá fáze je samostatný PR + release.

Podnět: ve světě zvířátka vznikly věty „Myš hraje s kolem." (gramaticky
špatně — má být „Myš **si hraje** s kolem") a „Oko hraje s kolem." (logický
nesmysl). Otázky zadavatele:

1. Jak podobné gramatické chyby odchytit ve všech jazycích?
2. Jaké věty jde v appce vůbec složit — aby se daly dát rodilým mluvčím,
   i opakovaně a i pro nový jazyk?
3. Jak zabránit nelogickým větám?

---

## 1. Kde se v appce skládají věty (inventura)

| Místo | Jak věta vzniká | Kdo vybírá |
|---|---|---|
| **Skládej větu** (`SentenceBuilderScreen`) | podmět × sloveso × předmět z `pack.sentence` + zvířátka ze Zvěřince jako podměty; trumpetka přečte i neúplnou větu | dítě, volně |
| **Věta po novém slově** (`WordSentenceScreen`) | totéž, nové slovo předvyplněné, 3 nabídky na slot | dítě, z nabídky |
| **Svět zvířátka** (`PetSentence.compose`) | nálepka jednotky (`reward.subject`) + sloveso podle druhu dárku (v2 jí / v3 pije / v6 hraje) + předmět | appka |
| Má knížka | jen ukládá hotové věty z míst výše | — |

Všechna tři místa stojí na jednom mechanismu (`ComposedSentence`): tvar
slovesa podle osoby podmětu (`forms['3sg']`), tvar předmětu podle rámce
slovesa (`forms['acc'|'dir'|'loc'|'instr']`).

### Kolik vět dnes jde složit

Jen plné věty ze Skládej větu (podměty × 6 sloves × předměty, bez zvířátek
ze Zvěřince a bez světa zvířátka):

| cs | en | de | es | it | fr | pt | zh | ja |
|---|---|---|---|---|---|---|---|---|
| 864 | 1368 | 780 | 780 | 810 | 924 | 1248 | 720 | 864 |

Celkem ≈ 8 400 vět; se zvířátky jako podměty a světem zvířátka přes 12 000.
**Většina z nich je špatně nebo nesmyslná** — nikdo je nikdy nečetl.

### Co je dnes špatně (ověřeno na datech v2.14.0)

| Třída chyby | Příklad | Příčina |
|---|---|---|
| A. Sloveso není celé / špatný slovosled | cs „Myš hraje s kolem" (má být „Myš **si hraje** s kolem" — a pozor, ne „Myš hraje si…": „si" patří na druhé místo ve větě) | zvratné „si/se", částice a jejich pozice nejsou v datech slovesa; model umí jen „podmět + tvar slovesa + předmět" |
| B. Chybí tvar předmětu → tichý fallback | en „Mum **sleeps milk**", „Mum **goes a toy**"; de „Mama schläft Milch"; fr „Maman va un jouet"; ja „ママはぎゅうにゅうねます" | `formFor(frame)` vrátí základní tvar, když tvar pro rámec chybí (v každém jazyce chybí 4–5 kombinací jen u prvních předmětů) |
| C. Tvar existuje, ale je to záplata | cs „Máma chce **venek**", „hraje **s venkem**", `les.instr = "v lese"` | tvary doplněné mechanicky, aby „něco bylo" |
| D. Logický nesmysl (gramaticky OK) | „Máma **jí nočník**", „Máma **pije jablko**", „Máma jí dům"; „**Oko** hraje s kolem" | žádné omezení, co se s čím smí kombinovat; věc jako podmět dostane sloveso „hraje" |
| E. Nepřirozené | „Máma spí u mléka" | kombinace sice projde, ale nikdo by to neřekl |

Závěr: nestačí opravit dvě věty. Chybí **(1) pravidla, co se smí
skládat, (2) kompletní a poctivé tvary, (3) seznam všeho, co appka umí
říct, a (4) proces kontroly, který jde opakovat.**

---

## 2. Princip řešení

> **Appka smí nabídnout jen větu, která prošla pravidly — a pravidla
> i výsledné věty jsou data, která umí zkontrolovat stroj i člověk.**

Čtyři vrstvy, od nejlevnější po nejdražší:

| Vrstva | Co chytí | Kdo / kdy |
|---|---|---|
| **V1 Strukturální lint** | třídy B, část A a C: chybějící tvary, fallbacky, prázdné texty, duplicity | `flutter test`, při každém commitu |
| **V2 Smysluplnost pravidly** | třída D: kdo co může dělat s čím (štítky) | data v packu + `flutter test` |
| **V3 Strojová korektura (LLM)** | A, C, E + zbytek D: gramatika, přirozenost, vhodnost pro dítě | nástroj na vývojářském stroji, před každou změnou vět |
| **V4 Rodilý mluvčí** | vše, co zbylo; konečná autorita | exportovaný seznam, jen **nové a změněné** řádky |

Důležité: díky V2 se prostor zmenší z ~1 000 vět na jazyk na **řádově
30–60 dvojic sloveso + předmět** (krát 2 osoby) a seznam podmětů. To je
pro rodilého mluvčího práce na 20–30 minut, ne na den.

---

## 3. Návrh

### 3.1 Pravidla smysluplnosti v packu (V2)

Rozšíření `pack.sentence` (schéma v2, zpětně kompatibilní — bez štítků
se dlaždice chová jako dnes, ale lint to u dodávaných packů zakáže):

```jsonc
"subjects": [
  { "id": "mama", "text": "Máma", "person": "3sg", "kind": "person" }
],
"verbs": [
  { "id": "v2", "text": "jím", "forms": {"3sg": "jí"},
    "frame": "acc",
    "subject": ["person", "animal"],      // kdo to může dělat
    "object":  ["food"] },                // s čím
  { "id": "v6", "text": "hraju si",              // nápis na dlaždici (sloveso samotné)
    "forms": {"1sg": "si hraju", "3sg": "si hraje"},  // tvar ve větě za podmětem
    "frame": "instr",
    "subject": ["person", "animal"],
    "object":  ["toy", "vehicle"] }
],
"objects": [
  { "id": "o2", "text": "jablko", "tags": ["food"],
    "forms": {"nom": "jablko", "acc": "jablko", "instr": "s jablkem"} },
  { "id": "o8", "text": "nočník", "tags": ["place"],
    "forms": {"nom": "nočník", "dir": "na nočník", "loc": "na nočníku"} }
],
"deny":  ["v4+o8"],            // výjimky: „spí na nočníku" ne
"allow": []                    // výjimky opačně
```

- **Druhy podmětu** (`kind`): `person`, `animal`, `thing`. Nálepky jednotek
  dostanou `reward.kind` (dnes se odhaduje z emoji přes `StickerKind` —
  nahradit daty, emoji tabulka zůstane jen jako výchozí hodnota + test,
  že s daty souhlasí).
- **Štítky předmětu** (`tags`): `food`, `drink`, `toy`, `vehicle`, `place`,
  `thing`. Malá uzavřená sada; nový štítek = změna schématu + lintu.
- **Sloveso** říká, jaké podměty a předměty bere. Výchozí tabulka (platí
  pro všech 9 jazyků, ids `v1…v6` jsou společná):

  | Sloveso | Podmět | Předmět | Rámec |
  |---|---|---|---|
  | v1 chci | person, animal | food, drink, toy, vehicle | acc |
  | v2 jím | person, animal | food | acc |
  | v3 piju | person, animal | drink | acc |
  | v4 spím | person, animal | place | loc |
  | v5 jdu | person, animal | place | dir |
  | v6 hraju si | person, animal | toy, vehicle | instr |

- **Žádný tichý fallback:** kombinace je platná jen tehdy, když předmět má
  tvar pro rámec slovesa **výslovně** v `forms` (i `acc`, i když je stejný
  jako základ). `formFor()` už nesmí vracet základní tvar potichu — vrací
  `null` a věta se nenabídne. Tím zmizí celá třída B a z třídy C zmizí
  důvod vyrábět záplaty („venek", „s venkem" se prostě smažou).
- **Dlaždice ≠ tvar ve větě:** `text` slovesa je nápis na dlaždici
  („hraju si"), `forms[osoba]` je tvar **ve větě za podmětem** („Já si
  hraju", „Myš si hraje"). Dnes se pro 1. osobu bere `text` — nově musí
  mít sloveso výslovný tvar pro každou osobu, kterou podměty packu
  používají. Stejný mechanismus pokryje německá odlučitelná slovesa
  nebo japonské částice, kdyby přibyla; co nepokryje (část slovesa až za
  předmětem), přidat až s konkrétním slovesem jako `suffix`.
- **Jedno místo rozhodování:** `SentenceRules.allows(subject, verb, object)`
  v `lib/data/models/sentence.dart`; používají ho všechna tři místa.

### 3.2 Věci jako podmět (třída D ve světě zvířátka)

Věc (oko, auto, slunce, banán) nejí, nepije a „nehraje si". Tři stupně:

1. **Vlastní sloveso nálepky** (volitelné, autorované): `reward.verb`
   ```jsonc
   "reward": { "emoji": "👁️", "label": "oko", "subject": "Oko", "kind": "thing",
               "verb": { "text": "se dívá na", "frame": "acc", "emoji": "👀",
                         "object": ["food","drink","toy","vehicle","thing"] } }
   ```
   → „Oko se dívá na kolo." Kandidáti: oko → dívá se na, ucho → slyší,
   nos → cítí, slunce → svítí na, auto/vlak → veze. Jen tam, kde to zní
   přirozeně ve všech jazycích packu; každé takové sloveso projde V3 a V4.
2. **Pojmenovací věta** (výchozí pro věc bez vlastního slovesa):
   `sentence.naming` = šablona na jazyk, např. cs „To je {nom}.", en
   „This is {nom}.", ja „{nom}です。". Vždy gramaticky i logicky správně
   a pořád je to čtení slova, které dítě zná. Potřebuje `forms.nom`
   (de „einen Apfel" je 4. pád — „Das ist ein Apfel." chce 1. pád).
3. **Žádná věta** — když chybí i `nom`; dárek jen zajiskří (jako dnes
   jídlo u věci).

Zvířata a lidé: beze změny (jí / pije / hraje si), ale přes
`SentenceRules` — „Myš si hraje s kolem" projde jen když kolo má `toy`
nebo `vehicle` a tvar `instr`.

### 3.3 Jak se to projeví dítěti (UI)

- **Skládej větu:** po výběru slovesa zůstanou „rozsvícené" jen předměty
  a podměty, které k němu patří; ostatní zešednou a po ťuknutí se jen
  zavrtí (žádná chybová hláška, žádné čtení). Když dítě změní sloveso
  a vybraný předmět už nepasuje, předmět se sám uvolní. Trumpetka
  a ⭐ fungují jen pro platnou větu (nebo platnou část).
- **Věta po novém slově:** nabídka 3 dlaždic se filtruje stejným pravidlem
  — nikdy nenabídne kombinaci, která by nešla dokončit.
- **Svět zvířátka:** věta jen když ji pravidla dovolí; jinak pojmenovací
  věta (3.2/2). Tácek dárků už je omezený na jídlo/pití/hračky.
- **Má knížka:** staré uložené věty nemazat (jsou dítěte). Jen nové věty
  procházejí pravidly.

### 3.4 Seznam všeho, co appka umí říct („korpus")

Nástroj `tool/sentences/export.dart` (čistý Dart, bez Flutteru; používá
stejné `SentenceRules` a `ComposedSentence` jako appka — žádná druhá
implementace) vypíše pro každý jazyk **všechny věty, které appka může
nabídnout**:

```
id                      zdroj    obrázky      věta                     části
cs:b:mama.v2.o2         builder  👩 🍽️ 🍎    Máma jí jablko.          mama|v2:3sg|o2:acc
cs:b:s1.v6.kolo         builder  👶 🎲 🚲    Já si hraju s kolem.     s1|v6:1sg|kolo:instr
cs:p:🐭.v3.mleko        pet      🐭 🥛 🥛    Myš pije mléko.          reward:🐭|v3:3sg|mleko:acc
cs:p:👁️.verb.kolo       pet      👁️ 👀 🚲    Oko se dívá na kolo.     reward:👁️|verb|kolo:acc
cs:n:kolo               naming   🚲           To je kolo.              naming|kolo:nom
```

- **Stabilní id** = zdroj + id dlaždic. Text se může měnit, id ne.
- Výstupy: `review/sentences_<lang>.tsv` (v repu, zdroj pravdy o stavu
  kontroly) a `build/review/<lang>.html` / `.csv` (pro sdílení — stránka
  s obrázky, větou, tlačítky ✅ / ✏️ oprava / ❌ nesmysl; viz 3.6).
- **Zhuštěný pohled pro korektora** (hlavní): místo všech kombinací
  podmět × sloveso × předmět se kontroluje
  1. tabulka **sloveso × předmět** pro každou osobu (1. a 3. os. j. č.) —
     to jsou ty řádově desítky řádků;
  2. seznam **podmětů** (jak stojí na začátku věty: „Die Maus", „ねこは");
  3. vlastní slovesa věcí a pojmenovací věty.
  Platí, dokud věty nemají shodu podmětu s předmětem ani rod (přítomný
  čas ve všech 9 jazycích). Až přibude minulý čas nebo množné číslo,
  export musí přejít na plný výpis — hlídá to test (viz 4, T5).
- Úplný výpis (všechny věty) zůstává k dispozici pro strojovou korekturu
  a namátkovou kontrolu.

### 3.5 Stav kontroly a opakovatelnost

`review/sentences_<lang>.tsv`, jeden řádek na id:

```
id  text  hash  llm  llm_note  human  human_note  reviewer  date
```

- `hash` = otisk textu věty. Když se text změní (oprava tvaru, nové
  sloveso), řádek spadne zpět na `human: pending` — **korektor dostane
  jen nové a změněné řádky**, ne všechno znovu.
- Stavy `human`: `ok` | `fix` (s návrhem v `human_note`) | `nonsense` |
  `pending`. Stavy `llm`: `ok` | `flag` (+ důvod).
- **Brána v testech** (`test/sentence_review_test.dart`):
  - žádná věta v korpusu nesmí mít `human: fix|nonsense` ani `llm: flag`
    bez `human: ok` (člověk může stroj přehlasovat, obráceně ne);
  - věta, která zmizela z korpusu, zmizí i z TSV (žádné sirotky);
  - pro každý jazyk se vypíše pokrytí (% `human: ok`).
- **Politika vydání:** jazyk má v packu `sentence.reviewed: "2026-10-20"`
  jen při 100 % `human: ok`. Jazyk bez toho se smí vydat, pokud je
  100 % `llm: ok` — v `docs/STORE.md` a rodičovském koutku pak není
  uveden jako „zkontrolováno rodilým mluvčím". (Rozhodnutí zadavatele:
  lze zpřísnit na „bez `reviewed` se Skládej větu v jazyce nezobrazí".)

### 3.6 Strojová korektura (V3)

Nástroj `tool/sentences/llm_review.dart` (běží jen na vývojářském stroji;
appka zůstává offline — `docs/PRIVACY.md` se nemění):

- vezme řádky s `llm` prázdným nebo se změněným `hash`, po dávkách je
  pošle modelu Claude s instrukcí pro daný jazyk: *jsi korektor dětské
  čítanky; u každé věty řekni, zda je gramaticky správně, přirozená
  a dává smysl pro dítě 5–9 let; když ne, navrhni opravu* — strukturovaný
  výstup (id, verdikt, důvod, návrh);
- zapíše `llm` / `llm_note`; nic neopravuje sám;
- před implementací načíst skill `claude-api` (model, strukturovaný
  výstup, dávky); klíč jen z prostředí, nikdy do repa.

Volitelná další vrstva: LanguageTool (offline, umí cs/de/en/es/fr/it/pt)
jako druhý názor na gramatiku; pro zh/ja nemá smysl. Rozhodnout až podle
toho, kolik chyb V3 propustí při prvním kole s rodilými mluvčími.

### 3.7 Balíček pro rodilého mluvčího

`dart run tool/sentences/export.dart --lang de --pending --html` vyrobí
jednu HTML stránku (funguje offline, jde poslat e-mailem nebo publikovat
jako Artifact):

- nahoře 5 vět návodu v daném jazyce + česky/anglicky: co je ✅, kdy ✏️
  (napiš správně), kdy ❌ (nedává smysl / dítěti by se to neřeklo);
- tabulka sloveso × předmět s obrázky (nálepky), pod ní podměty, vlastní
  slovesa věcí, pojmenovací věty; strojem označené řádky zvýrazněné;
- export odpovědí jako TSV (tlačítko „Stáhnout") → `dart run
  tool/sentences/import_review.dart odpovědi.tsv` je zapíše do
  `review/sentences_<lang>.tsv` s jménem korektora a datem.

Návod pro zadavatele a korektory: `docs/SENTENCES_REVIEW.md`.

---

## 4. Testy (co má hlídat stroj)

| # | Test | Chytí |
|---|---|---|
| T1 | Každý podmět má `kind`, každý předmět `tags` a `forms.nom`, každé sloveso `subject`/`object`/`frame` (všech 9 packů) | nedodělaná data |
| T2 | Pro každou dvojici sloveso × předmět, kterou pravidla dovolí, existuje výslovný tvar pro rámec; pro každou osobu podmětu tvar slovesa | třída B (fallback) |
| T3 | `SentenceRules.allows` = jediný zdroj: builder, word-sentence i svět zvířátka nabídnou jen věty z korpusu (property test: náhodné klikání → výsledek ∈ korpus) | obcházení pravidel v UI |
| T4 | Korpus ↔ review TSV: žádné `fix`/`nonsense`/nepřehlasovaný `flag`, žádní sirotci, hash sedí | regresní chyby po úpravě dat |
| T5 | „Zhuštěný pohled platí": pro každý jazyk se věta se stejným slovesem, osobou a předmětem liší jen podmětem (jinak export přepne na plný výpis a test to oznámí) | tiché rozbití předpokladu z 3.4 |
| T6 | Snímek korpusu `test/golden/sentences_<lang>.txt` (nahradí dnešní `pet_sentences_<lang>.txt`) | nechtěná změna vět |
| T7 | Každý jazyk má aspoň N platných vět na sloveso (např. ≥ 2) a každé slovo z batohu, které je předmětem, jde použít aspoň v jedné větě | pravidla tak přísná, že není co skládat |
| T8 | `reward.kind` souhlasí s `StickerKind.of(emoji)` nebo je rozdíl uveden ve výjimkách | rozjezd dat a tabulky emoji |

---

## 5. Fáze

### Fáze 0 — Rychlá oprava toho, co je vidět (půl dne)
Bez změny schématu: cs `v6` → dlaždice „hraju si", tvar ve větě
`3sg: "si hraje"`; pro 1. osobu („Já si hraju") přidat do `ComposedSentence`
čtení `forms['1sg']`, když existuje (malá změna kódu, ostatní jazyky se
nemění). Ostatní jazyky u v6 zvratné zájmeno nemají (de „spielt", fr
„joue", es „juega", it „gioca", pt „brinca", en „plays") — potvrdit ve V3;
ve světě zvířátka věc jako obyvatel **nedostane větu „X hraje…"** (jen
zajiskření, dokud nebude 3.2); `PetSentence` přestane používat předmět,
který nemá výslovný tvar pro rámec. **Hotovo:** „Myš si hraje s kolem.",
„Já si hraju s autem." a žádné „Oko hraje…".

### Fáze 1 — Korpus a lint (1–2 dny)
`tool/sentences/export.dart`, stabilní id, `review/sentences_<lang>.tsv`
(vše `pending`), T2 jako **varování** s počty (zatím nefailuje), T6.
Zpráva o stavu: kolik vět na jazyk, kolik fallbacků (třída B).
**Hotovo:** zadavatel má seznam všech vět ve všech 9 jazycích a číslo,
kolik z nich je strukturálně špatně.

### Fáze 2 — Pravidla a tvary (3–4 dny)
Schéma 3.1 (`kind`, `tags`, `subject`/`object`, `deny`/`allow`,
`forms.nom`), `SentenceRules`, konec tichého fallbacku, UI 3.3, svět
zvířátka přes pravidla + pojmenovací věta + `reward.verb` pro pár
jasných věcí (oko, ucho, nos, slunce, auto). Data ve všech 9 packech;
smazat záplatové tvary. T1–T3, T5, T7, T8 ostře.
**Hotovo:** „Máma jí nočník" ani „Mum sleeps milk" nejde složit; korpus
se zmenší na stovky vět na jazyk; „Oko se dívá na kolo."

### Fáze 3 — Strojová korektura (1–2 dny)
`llm_review.dart`, první průchod všech 9 jazyků, opravy dat podle
nálezů (každá oprava = změna hash → znovu V3), T4 ostře pro `llm`.
**Hotovo:** 100 % `llm: ok` ve všech jazycích; seznam sporných řádků
pro rodilé mluvčí.

### Fáze 4 — Rodilí mluvčí (průběžně, podle lidí)
HTML balíček 3.7 + `import_review.dart` + `docs/SENTENCES_REVIEW.md`;
čeština hned (zadavatel), ostatní jazyky jak budou korektoři. Po 100 %
`human: ok` zapsat `sentence.reviewed`. **Hotovo:** pro každý jazyk je
vidět datum a jméno poslední kontroly a počet čekajících řádků = 0.

### Nový jazyk (kontrolní seznam, do `docs/SENTENCES_REVIEW.md`)
1. Pack se štítky, tvary a `naming` → `flutter test` (T1, T2, T7, T8).
2. `export.dart --lang xx` → `llm_review.dart --lang xx` → opravy do 100 %.
3. HTML balíček rodilému mluvčímu → `import_review.dart` → opravy →
   znovu jen změněné řádky.
4. `sentence.reviewed` a zmínka v obchodě.

---

## 6. Rozhodnutí pro zadavatele

| # | Otázka | Doporučení |
|---|---|---|
| R1 | Smí se vydat jazyk bez kontroly rodilým mluvčím? | Ano při 100 % `llm: ok`, bez nálepky „zkontrolováno"; zpřísnit později |
| R2 | Jak ukázat dítěti, že kombinace nejde? | Zešednout + zavrtět, bez hlášky (3.3) |
| R3 | Vlastní slovesa věcí (oko se dívá…) — kolik? | Začít pěti jasnými; zbytek pojmenovací věta |
| R4 | Staré věty v Mé knížce | Nechat být |
| R5 | LanguageTool jako další vrstva | Až po prvním kole s rodilými mluvčími, podle počtu propuštěných chyb |
| R6 | Má Skládej větu zůstat „volné hřiště" i s nesmysly (dětem se „Máma jí nočník" líbí)? | Ne ve výchozím stavu — appka učí číst správné věty; případný „bláznivý režim" jako samostatný, jasně odlišený mód později |

## 7. Rizika

| Riziko | Řešení |
|---|---|
| Pravidla zmenší builder tak, že je nudný | T7 hlídá minimum; přidávat předměty a slovesa je teď bezpečné, protože každá nová věta projde V1–V4 |
| Štítky nestačí na jemné případy („spí na nočníku") | `deny`/`allow` po dvojicích; nálezy z V3/V4 se zapisují tam, ne do kódu |
| Stroj (LLM) označí správnou větu, nebo propustí špatnou | Člověk má poslední slovo (`human: ok` přehlasuje `flag`); V4 zůstává konečná autorita |
| Korektor dostane příliš dlouhý seznam | Zhuštěný pohled (desítky řádků), jen `pending`, zvýrazněné strojové nálezy |
| Změna dat rozbije uložený postup | Id dlaždic se nemění; mění se jen texty, tvary a štítky |
| Druhá implementace skládání v nástroji se rozejde s appkou | Nástroj importuje `lib/data/models/sentence.dart` (čistý Dart); T3 a T6 hlídají shodu |
