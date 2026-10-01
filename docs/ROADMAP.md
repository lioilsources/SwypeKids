# SwypeKids — Roadmap: hra, kterou děti milují a rodiče ocení

Stav: návrh (září 2026). Navazuje na `docs/GAMEPLAY.md` (herní smyčka,
content pack, typy kol) a nahrazuje jeho kapitolu 7 „Roadmapa".
Aktuální verze appky: 2.1.2.

---

## 0. Jak číst tento dokument

1. **Kap. 1–2** říkají, kam jdeme a kde jsme.
2. **Kap. 3** popisuje sedm pilířů — *co* budujeme a proč (postavičky,
   svět, zvuk, lekce, sbírka, slovíčka → věty, rodiče) plus „co chybělo".
3. **Kap. 4** je technický plán (Rive, audio, schéma packu v2, služby).
4. **Kap. 5** skládá pilíře do verzí v2.2 → v4.0, každá s cílem a
   „hotovo znamená".
5. **Kap. 6–8**: metriky, rizika, první týden.

---

## 1. Cíl a dva zákazníci

**Dítě (5–9 let) chce:** živý, roztomilý svět, kde se pořád něco hýbe,
kde ho někdo vítá, fandí mu a raduje se s ním; sbírat, odemykat,
objevovat; nikdy neprohrát.

**Rodič chce:** vidět, že dítě opravdu čte a píše; rozumět metodě;
mít kontrolu nad časem a soukromím; žádné reklamy ani nákupy v ruce
dítěte; appku, kterou nemusí vysvětlovat.

**Severní hvězda:** dítě se samo vrací, rodič to nechá zapnuté.

### Principy (platí pro každou fázi)

| Princip | V praxi |
|---|---|
| Vše se hýbe, nic neruší | Idle animace jsou pomalé a tiché; velké animace jen jako odměna |
| Žádný dead-end, žádný trest | Chyba = postavička povzbudí, nikdy ztráta postupu (viz GAMEPLAY §2) |
| Bez čtení ovládatelné | Každá obrazovka je použitelná pouze podle obrázků a hlasu |
| Odměna ≤ 2 s od akce | Zvuk a animace reagují okamžitě, oslavy nezdržují další kolo |
| Obsah je data | Postavičky, prostředí, zvuky i slovíčka jsou popsané v JSON, ne v Dartu |
| Rodič vždy vidí „proč" | Každá lekce má krátké didaktické vysvětlení pro rodiče |
| Offline-first, privacy-first | Vše funguje bez sítě; žádný tracking dětí |

---

## 2. Kde jsme dnes (audit v2.1.2)

| Oblast | Stav | Poznámka |
|---|---|---|
| Core swype + klávesnice | ✅ | Funguje na mobilu i desktopu, svítící trail |
| Mapa, jednotky, hvězdy, persistence | ✅ | Lineární odemykání, 1–3 ⭐ |
| Zvěřinec (nálepky) | ✅ základ | Statické emoji v mřížce, bez interakce |
| Typy kol | ✅ `swype`, `listen` | `missingLetter`, `pictureOnly`, `reviewMix` chybí |
| Obsah | ⚠️ tenký | cs: 7 jednotek / 26 lekcí; ostatní jazyky podobně |
| Sentence Builder | ⚠️ izolovaný | Vlastní data v `sentence_builder.dart`, nic společného s lekcemi |
| Animace | ⚠️ minimum | Pár `AnimatedContainer`, elastic scale na oslavě, blikání nových písmen |
| Zvuk | ❌ | Pouze TTS a haptika; žádné sfx, hudba, ambient |
| Postavičky / maskot | ❌ | Žádné; hint je jedno emoji |
| Prostředí, roční období, den/noc | ❌ | Jednobarevná pozadí |
| Achievementy | ❌ | Jen hvězdy a nálepky |
| Rodičovský koutek | ❌ | Žádné statistiky, limity, nastavení |
| Onboarding, profily dětí | ❌ | První start = výběr jazyka |
| i18n UI | ❌ | Chrome natvrdo česky |
| Přístupnost | ❌ | Neřešeno (kontrast, redukce pohybu, leváci) |
| Testy | ✅ základ | Validace packů + progress; žádné widget/golden testy |
| Screenshoty (GALLERY.md) | ❌ | Prázdné |

---

## 3. Pilíře

### P1 — Živý svět: postavičky, zvířátka, prostředí

**Postavičky.** Originální parta ve stylu „Pixar-kvality" (velké oči,
měkké tvary, squash & stretch). *Nepoužíváme skutečné Pixar IP* — licenčně
nemožné; cíl je stejná úroveň řemesla. Návrh party:

| Postava | Role | Kde |
|---|---|---|
| **Písmenko Pipi** (maskot, kulaté zvířátko, např. lišák nebo panda) | Průvodce: vítá, ukazuje, fandí, utěšuje | Mapa, hra, oslava, onboarding |
| **Zvířátka z klávesnice** (🐭 myška, 🐯 tygřík, 🐶 pejsek…) | Ožívají ze samotných klávesových emoji; po získání nálepky žijí ve Zvěřinci | Klávesy, Zvěřinec, mapa |
| **Rodina** (👩 máma, 👨 táta, 👵 bába, 👧 holčička) | Postavy z prvních slov (MÁMA, TÁTA…) — dítě „píše" těm, koho zná | Hint na kartě, sentence builder |

**Stavová animace každé postavy** (Rive state machine, vstupy z hry):

`idle` (dýchá, občas mrkne, rozhlíží se) → `wave` (mává při příchodu na
mapu / na kartu) → `wink` (po správném písmenu) → `cheer` (po správném
swype: výskok, tanec) → `oops` (po chybě: ouška dolů + úsměv, „zkus to
znovu") → `sleep` (v noci nebo po 20 s nečinnosti; probudí se dotykem) →
`turn` (otočí se, když se dítě podívá jinam = dlouhá nečinnost) →
`play` (idle variace: hraje si s míčem, jí, čte).

Postavy reagují i na dotyk mimo hru (pošimrání = smích). Na mapě se
zvířátka získaná do Zvěřince procházejí okolo cesty.

**Prostředí.** Mapa přestane být seznam a stane se **světem**: každá
jednotka má svůj biotop (louka → les → rybník → město → hory → pláž → noc
s hvězdami…). Definované v packu (`unit.scene`), ne v kódu.

- **Roční období**: jaro / léto / podzim / zima podle *reálného kalendáře*
  (default) nebo podle postupu (volba rodiče). Mění paletu, stromy,
  částice (květy, listí, sníh, světlušky), oblečení postav.
- **Den a noc**: podle reálných hodin (ráno / den / večer / noc), s jemným
  přechodem. V noci: hvězdy, měsíc, svítící okna, zvířátka usínají, hudba
  ztichne — rodič uvítá signál „už je čas spát".
- **Počasí** (volitelně, offline pseudo-náhodně): déšť, duha po dešti.
- **Parallax** na mapě (3 vrstvy) a drobné ambientní animace: motýl,
  mrak, kouř z komína, vlnky.
- **Odemčení jednotky** = rozsvícení nového kousku světa (mlha se rozplyne).

**Klávesnice a hra.**

- Klávesy jako „kamínky/kostky" ve stylu světa; emoji zůstává (rodič ho
  zná), ale klávesa se při přejetí nadskočí (scale bounce, viz README TODO)
  a její zvířátko mrkne.
- Swype trail = stopa světlušek / hvězdný prach, po úspěchu vyletí do
  karty a „napíše" slovo.
- Karta s cílem: hint emoji nahradí animovaná postava/objekt (MÁMA mává,
  KOLO se točí, PES vrtí ocasem).
- Hvězdy padají z nebe a cinknou; třetí hvězda spustí malé konfety.

### P2 — Zvuk: sfx, ambient, hudba, hlas

**Sfx katalog (v1):**

| Událost | Zvuk |
|---|---|
| Dotyk klávesy během swype | Krátký tón; každé písmeno má výšku (xylofon), takže swype „zahraje melodii" |
| Správné písmeno v listen kole | Cinknutí + „ano!" |
| Správný swype | Krátká fanfára (3 varianty, střídají se) |
| Chyba | Měkké „bump" + hlas postavy („hmm, zkus to znovu"), nikdy bzučák |
| Hvězda | Cink ×1–3 se stoupající výškou |
| Nálepka | Odlepení + „wow" + potlesk |
| Odemčení jednotky | Rozsvícení, ptáci |
| UI (tap, zpět, drawer) | Tiché pop / whoosh |

**Ambient** podle prostředí a denní doby (louka den: ptáci; les: šumění;
noc: cvrčci, sova). Smyčky, nízká hlasitost.

**Hudba**: jedna hravá titulní melodie + adaptivní vrstvy (více vrstev
během hry, tišší v noci). Vždy samostatně ztlumitelná.

**Hlas**: nahraný dětský/přátelský hlas průvodce pro každou jazykovou
mutaci (start: cs + en; ostatní TTS). TTS zůstává jako fallback a pro
dynamický text (věty v builderu). Postavy mají „žvatlání" (Animal
Crossing style) místo řeči, takže nezávisí na jazyku.

**Fráze průvodce** (data v packu, `voice/` klíč → soubor): „Ahoj!",
„Přejeď prstem", „Super!", „Ještě jednou", „Máš novou nálepku!",
„Dobrou noc".

### P3 — Smysluplné lekce

**Kurikulum.** Dnes 26 lekcí (cs). Cíl ~150–200 lekcí na jazyk ve třech
pásmech, zarovnaných s tím, jak čtení učí česká škola (analyticko-syntetická
metoda; pro en SATPIN fonetika atd. — vlastnost packu):

| Pásmo | Věk | Obsah | Typy kol |
|---|---|---|---|
| A „Písmenka" | 5–6 | Hláska ↔ písmeno, otevřené slabiky (MA, TA, LE…) | `swype`, `listen`, `letterHunt` |
| B „Slova" | 6–7 | Dvouslabičná slova, zavřené slabiky (LES, PES), slova s dírou | `missingLetter`, `pictureOnly`, `reviewMix`, `syllableJoin` |
| C „Věty a pravopis" | 7–9 | Delší slova, diakritika, dy/di, ú/ů, slova do vět | `swype` s diakritikou, `wordToSentence`, `rhymePick` |

**Nové typy kol** (doplňují GAMEPLAY §6):

| Typ | Popis |
|---|---|
| `missingLetter` | Slovo s dírou (M_MA), swypuje se celé slovo |
| `pictureOnly` | Jen obrázek/postava, žádný text — aktivní vybavení |
| `reviewMix` | Náhodná směs targetů z dřívějších jednotek |
| `letterHunt` | Průvodce řekne hlásku, dítě ťukne na správnou klávesu (izolace hlásky, bez swype) |
| `syllableJoin` | Dvě slabiky přiletí, dítě je swypne za sebou (MÁ + MA) |
| `wordToSentence` | Naučené slovo se hned použije ve větě v builderu (viz P5) |
| `rhymePick` | Ze tří obrázků vyber, co se rýmuje (fonologické uvědomění) |

**Adaptivita bez frustrace:**

- **Spaced repetition lite**: každé slovo má „sílu" (0–5). Úspěch +1,
  chyba −1. Review uzly a `reviewMix` vybírají nejslabší. Denní
  „Dnešní procvičování" = 5 nejslabších slov (2–3 minuty).
- **Scaffolding v kole**: 1. chyba → zvýrazní se první písmeno, 2. chyba →
  rozsvítí se celá cesta „stín", 3. chyba → průvodce ukáže tah. Vždy se dá
  dohrát.
- **Délka session**: cíl 5–8 minut = 1 jednotka. Po jednotce postavička
  nabídne „ještě jednu?" nebo „pojď si hrát do Zvěřince".

**Pro rodiče u každé lekce**: `parentNote` v packu — jedna věta, co se
procvičuje a proč (např. „Dítě spojuje hlásku M s písmenem; doma zkuste
hledat věci na M").

### P4 — Sběratelství a achievementy

**Zvěřinec 2.0.** Album se stane **domečkem/ostrovem**: každé zvířátko má
své místo v biotopu jednotky, kde žije (animované idle). Poklepání =
zvuk, jméno (nahlas + napsané, takže se dítě učí i to), krátká animace.
Zvířátka lze krmit/pohladit (drobná mini-interakce, žádná mechanika
péče s tlakem).

**Odznaky (achievementy)** — jednorázové, bez streaku s tlakem:

| Odznak | Podmínka |
|---|---|
| První tah | první správný swype |
| Bez chyby | jednotka na samé 3⭐ |
| Objevitel | první nálepka |
| Sběratel | polovina / celý Zvěřinec |
| Noční sova / Ranní ptáče | hrálo v noci / ráno (světové hodiny) |
| Čtyři roční období | hrálo v každém období |
| Slovíčkář | 10 / 25 / 50 slov v batohu (P5) |
| Básník | 10 vět v Mé knížce (P5) |
| Posluchač | 10 listen kol na 3⭐ |
| Vytrvalec | 7 hracích dnů celkem (ne v řadě) |

**Sběratelské vrstvy navíc:** dekorace světa (za odznaky dítě umístí na
ostrov houpačku, lampu, kytky), oblečení pro maskota (čepice, šála podle
období), **tajné nálepky** (skryté v mapě — vyžadují průzkum, ne výkon).

**Oslavy:** hvězdy → konfety → nálepka vyletí do Zvěřince (Hero animace)
→ odznak se objeví s cinknutím; vše do 3 s a přeskočitelné dotykem.

### P5 — Slovíčka ze swype se objevují v Builderu vět

**Batoh slov (Word Bag).** Každé *celé slovo* (ne izolovaná slabika), které
dítě správně swypne, přistane do batohu. Batoh je vidět na mapě (ikona s
počtem) a v builderu.

**Propojení dat.** Sentence Builder dnes drží vlastní seznam v
`lib/data/sentence_builder.dart`. Přesune se do packu (`pack.sentence`) a
lekce dostanou `vocab` odkaz:

```json
{
  "id": "cs-u6-l1",
  "type": "swype",
  "target": "MAMA",
  "display": "MÁMA",
  "vocab": "mama",
  "parentNote": "Celé dvouslabičné slovo; dítě už zná obě slabiky."
}
```

```json
"sentence": {
  "joiner": " ",
  "subjects": [{ "id": "mama", "emoji": "👩", "text": "Máma", "person": "3sg", "unlockedBy": "vocab" }],
  "verbs":    [{ "id": "jist", "emoji": "🍽️", "text": "jím", "forms": {"3sg": "jí"}, "frame": "acc", "unlockedBy": "always" }],
  "objects":  [{ "id": "kolo", "emoji": "🚲", "text": "kolo", "forms": {"instr": "s kolem"}, "unlockedBy": "vocab" }]
}
```

**Pravidla builderu:**

- Dlaždice s `unlockedBy: "vocab"` se objeví, až je slovo v batohu; do té
  doby je vidět jako siluetka „?" (motivace: „naučím se to ve hře").
- `always` = základní slovesa a zájmena, aby se věta dala složit od
  začátku.
- Nově získané slovo má v builderu 24 h štítek „nové" a poskočí.
- **Kolo `wordToSentence`**: hned po naučení slova ve hře se objeví
  mini-builder s tím slovem předvyplněným — dítě doplní zbytek a TTS větu
  přečte. Slovo tak dostane význam v kontextu.
- **Má knížka**: složené věty lze uložit (ikona knížky) i s obrázkovou
  řádkou; rodič si ji může nechat přečíst. Cíl pro odznak „Básník".
- Opačný směr: v builderu lze slovo „vzít do hry" → spustí `swype` kolo
  na to slovo (procvičování z kontextu).

### P6 — Rodičovský koutek

Za **rodičovskou bránou** (spočítej 7 × 3, nebo podrž 3 s), ne za PINem,
aby to rodič nemusel pamatovat. Obsah:

- **Přehled**: dnes / tento týden — minuty, lekce, slova v batohu.
- **Písmena**: mřížka abecedy: zelená = zvládnuté (síla ≥ 4), žlutá =
  procvičuje, šedá = ještě nepotkalo. Klik → která slova se pletou.
- **Doporučení pro doma**: 1–2 věty generované z nejslabších položek
  („Zkuste doma hledat věci na P").
- **Metoda**: stránka „Jak appka učí" per jazyk (z `pack.method`).
- **Nastavení**: hudba / sfx / hlas, TTS on/off, roční období (reálné vs.
  podle postupu), noční režim, časový limit session (10/15/20 min → po
  limitu maskot jde spát, dá se prodloužit jen z koutku), levák (zrcadlená
  klávesnice/ovládání), redukce pohybu, velikost kláves.
- **Profily dětí**: více sourozenců, každý má svůj postup, avatara a
  jméno (jméno průvodce oslovuje — hlasem přes TTS, textem na mapě).
- **Export / reset**: export postupu jako JSON, smazání profilu.
- Žádné notifikace ve výchozím stavu; volitelně jedna denní tichá
  „připomínka pro rodiče" (nikdy pro dítě).

### P7 — Doplněno: co v zadání chybělo

| Chybějící část | Proč je nutná | Kde v plánu |
|---|---|---|
| **Onboarding bez čtení** | První minuta rozhodne; dnes začíná výběrem jazyka | v3.0 |
| **Profily dětí** | Sourozenci na jednom tabletu si mažou postup | v3.0 |
| **i18n UI chrome** | 9 jazyků obsahu, ale české tlačítka | v3.1 |
| **Přístupnost** | Kontrast, velké dotykové cíle (≥ 64 px), redukce pohybu, font pro dyslexii (OpenDyslexic jako volba), levák | v3.1 |
| **Tablet & desktop layout** | Většina dětí hraje na tabletu; landscape mapa | v2.4 |
| **Soukromí a compliance** | Kategorie Kids v obchodech (COPPA, GDPR-K, Google Families): žádné reklamy, žádný tracking, žádné externí odkazy bez brány → `docs/PRIVACY.md` | v3.1 |
| **Monetizace bez tlaku na dítě** | Jednorázová koupě / rodinný balíček; žádné IAP ve hře, žádné „gemy" → návrh v `docs/MONETIZATION.md` | v3.1 (rozhodnutí), v4.0 (implementace) |
| **Analytika privacy-first** | Lokální events log (základ pro statistiky rodičů); volitelný anonymní opt-in agregát | v3.1 |
| **Testování s dětmi** | 5 dětí × 15 min po každé větší verzi; protokol v `docs/PLAYTEST.md` (hotovo) | průběžně od v2.2 |
| **Kvalita**: widget testy, golden testy obrazovek, CI na `flutter test`, crash reporting bez PII | v2.2+ |
| **Asset pipeline** | Rive soubory, audio v `.ogg`/`.m4a`, rozpočet velikosti (< 60 MB), lazy loading per jazyk | v2.2 |
| **Autorské nástroje obsahu** | Validátor packu (rozšířit test), schéma JSON (`docs/pack.schema.json`), skript pro kontrolu, že každé `vocab` existuje v `sentence` | v2.3 |
| **Výkon** | 60 fps na low-end Androidu (API 21+); rozpočet animací; test na starém tabletu | průběžně |
| **Screenshots/GALLERY** | Prázdné; potřeba pro store i pro repo | v2.2 |
| **Smazání Dart lekcí** | Dva zdroje pravdy (GAMEPLAY fáze 2) | v2.3 |
| **Diakritika** | Long-press / druhá vrstva (README TODO) | v4.0 pásmo C |

---

## 4. Technický plán

### 4.1 Animace: Rive

- **Rive** (`rive` package) pro postavy a nálepky: jeden `.riv` na postavu
  se state machine a vstupy (`mood`, `wave`, `cheer`, `oops`, `sleep`,
  `season`). Vektorové, malé, runtime řízené — přesně to, co potřebuje
  stavová postava. Lottie jen pro jednorázové efekty (konfety), pokud
  vůbec.
- Prostředí: vrstvené `.riv` scény nebo statické SVG/PNG vrstvy +
  `CustomPainter` částice (sníh, listí, světlušky). Bez herního enginu
  (Flame) — zůstáváme v čistém Flutteru, mapa je pořád scrollovatelný
  widget.
- `WorldClockService`: roční období + denní doba (reálné hodiny, override
  z rodičovského koutku, testovatelné injekcí času). Vrací `WorldTheme`
  (paleta, částice, hudební vrstva, stav postav).
- Rozpočet: postava ≤ 300 KB, scéna ≤ 500 KB; vše lazy.
- Respekt k `MediaQuery.disableAnimations` (redukce pohybu: idle animace
  zůstávají, oslavy zkrácené).

### 4.2 Audio

- `flutter_soloud` (nízká latence pro xylofonové tóny swype) nebo
  `audioplayers` pro sfx + `just_audio` pro hudbu/ambient. Rozhodnout
  prototypem v v2.2 (kritérium: latence tónu při swype < 30 ms).
- `AudioService` s kanály `sfx`, `voice`, `music`, `ambient`; ducking
  hudby při hlasu; vše řízené z nastavení.
- Formát `.ogg` (Android/desktop) + `.m4a` (iOS) nebo jednotné `.mp3`;
  soubory v `assets/audio/{sfx,voice/{lang},music,ambient}`.
- Sfx katalog v JSON (`assets/audio/manifest.json`), aby packy mohly
  odkazovat na hlasové soubory jménem.

### 4.3 Schéma packu v2

Rozšíření `schemaVersion: 2` (v1 zůstává čitelné):

```
pack.sentence            # subjects/verbs/objects (přesun z Dartu), unlockedBy
pack.characters[]        # id, riv, jméno per jazyk, kde se objevuje
unit.scene               # { biome, riv|layers, ambient }
unit.reward.riv          # animovaná nálepka (fallback: emoji)
lesson.vocab             # id slova do batohu / builderu
lesson.parentNote        # věta pro rodiče
lesson.voice             # klíč fráze pro nahraný hlas (fallback: TTS display)
lesson.scaffold          # volitelný override kroků nápovědy
```

Nové typy kol podle P3. Validátor (`test/pack_loading_test.dart`) rozšířit:
každé `vocab` existuje v `sentence`, každé `scene`/`riv` má soubor, žádná
lekce pásma A nemá `vocab` (slabiky do batohu nepatří).

### 4.4 Progress v2 a služby

- `ProgressService` → přidat `wordStrength` (spaced repetition),
  `wordBag`, `badges`, `sentences` (Má knížka), `sessions[]` (události pro
  statistiky: start, konec, lekce, pokusy). Migrace z v1 formátu s testem.
- `ProfileService`: více profilů; klíče prefixované `sk.p{n}.`.
- `AchievementService`: čistá pravidla nad progress + world clock.
- `WordBagService`: most mezi hrou a builderem.
- Nová struktura:

```
lib/
├── audio/        # AudioService, manifest
├── world/        # WorldClockService, WorldTheme, scény, částice
├── characters/   # Rive wrappery, CharacterController (stavy)
├── parent/       # rodičovská brána, přehledy, nastavení
└── vocab/        # WordBagService, spaced repetition
```

---

## 5. Fáze a verze

Každá verze je hratelná a vydatelná. Odhady jsou pro jednoho vývojáře
plus externí ilustrátor/animátor a zvukař.

### v2.2 „Živá klávesnice" — rychlé výhry (4–6 týdnů)

Cíl: appka okamžitě působí živě a zní, bez čekání na postavy.

- Sfx katalog v1 + `AudioService`, výběr audio knihovny prototypem.
- Xylofonové tóny při swype; fanfára, chyba, hvězdy, nálepka.
- Klávesy bounce při přejetí; trail světlušek; hvězdy padají; konfety.
- Hero animace nálepky do Zvěřince.
- Den/noc jako barevný přechod pozadí mapy (základ `WorldClockService`).
- Nastavení zvuku (zatím jednoduché, v drawer).
- Screenshoty do `GALLERY.md`, CI `flutter test` + `analyze`, první
  widget testy.
- **Hotovo znamená**: každá akce dítěte má zvuk a pohyb ≤ 100 ms; hra
  funguje beze zvuku; 60 fps na testovacím low-end zařízení.

### v2.3 „Batoh slov" — smysl a propojení (4–6 týdnů)

Cíl: co se naučím ve hře, použiju ve větě.

- Schéma v2: `pack.sentence`, `lesson.vocab`, `parentNote`; export tool
  a validátor; smazání Dart lekcí (JSON jediný zdroj pravdy).
- `WordBagService`, ikona batohu na mapě, siluetky „?" v builderu,
  štítek „nové".
- Kolo `wordToSentence`, „vzít slovo do hry" z builderu, Má knížka (v1:
  uložit + přečíst).
- Typy kol `missingLetter`, `pictureOnly`, `reviewMix`; síla slova +
  „Dnešní procvičování".
- Obsah cs: pásmo A kompletní (~50 lekcí), pásmo B začátek; en podobně.
- **Hotovo znamená**: dítě po jednotce „Celá slova" složí větu se slovem,
  které právě swyplo; rodič v packu vidí u každé lekce `parentNote`.

### v2.4 „Svět" — prostředí, roční období, tablet (6–8 týdnů)

Cíl: mapa je místo, kam se chce dítě vracet.

- Biotopy per jednotka (`unit.scene`), parallax, ambientní animace,
  částice; roční období podle kalendáře; plný den/noc cyklus s měsícem,
  hvězdami, usínáním.
- Ambient zvuk per scéna/denní doba; první hudební smyčka.
- Odemčení jednotky = rozplynutí mlhy.
- Tablet/landscape layout mapy a hry; desktop stejný kód.
- Redukce pohybu respektována.
- **Hotovo znamená**: stejná mapa vypadá jinak ráno v zimě a večer v létě;
  rodič může období přepnout ručně.

### v3.0 „Parta" — postavičky, Zvěřinec 2.0, onboarding, profily (8–12 týdnů)

Cíl: dítě má kamaráda, který ho vítá a fandí mu.

- Maskot v Rive se všemi stavy (idle, wave, wink, cheer, oops, sleep, turn,
  play); reakce na dotyk; oslovuje jménem.
- Zvířátka z klávesnice: první 8 animovaných nálepek (cs jednotky), zbytek
  emoji fallback; zvířátka chodí po mapě.
- Animované hinty na kartě pro nejčastější slova (MÁMA, TÁTA, KOLO, PES…).
- Zvěřinec jako ostrov: biotopy, poklepání = jméno + zvuk; dekorace a
  oblečení maskota.
- Odznaky (10 z P4), tajné nálepky.
- Onboarding: maskot mluví (nahraný hlas cs/en, TTS jinde), výběr avatara
  a jména, jazyk podle obrázku vlajky.
- Profily dětí.
- Playtest s dětmi před vydáním.
- **Hotovo znamená**: dítě 5 let projde onboarding a první jednotku bez
  pomoci rodiče; maskot zareaguje na každý výsledek kola.

### v3.1 „Pro rodiče" — koutek, i18n, přístupnost, soukromí (6–8 týdnů)

- Rodičovská brána, přehled, mřížka písmen, doporučení pro doma, stránka
  metody.
- Nastavení: zvuk, TTS, období, noční režim, časový limit, levák, velikost
  kláves, dyslexie font.
- Lokalizace UI chrome (ARB, 9 jazyků) + obsah nápověd.
- Kontrast a dotykové cíle podle WCAG pro děti; screen reader alespoň
  pro rodičovský koutek.
- Privacy policy, Kids kategorie, žádné externí odkazy bez brány; lokální
  events log; volitelný anonymní opt-in agregát.
- Rozhodnutí o monetizaci (doporučení: jednorázová koupě, rodinný balíček;
  první jazyk zdarma, další jazyky součást balíčku).
- **Hotovo znamená**: rodič bez vysvětlení najde, jak dítěti nastavit
  limit, a pochopí, které písmeno dítěti nejde.

### v3.2 „Hlas a hudba" (4–6 týdnů, souběžně s v3.1)

- Nahraný hlas průvodce cs + en (fráze z manifestu), žvatlání postav.
- Adaptivní hudba (vrstvy), noční ztišení, ducking.
- Hlasový „přečti mi to" u Mé knížky a rodičovských poznámek.

### v4.0 „Obsah" — kurikulum, opakování, stahovatelné packy (průběžně)

- Pásma A–C kompletní pro cs a en (~150–200 lekcí), ostatní jazyky pásmo
  A–B; typy `letterHunt`, `syllableJoin`, `rhymePick`; diakritika
  long-pressem.
- Spaced repetition naplno (review uzly z nejslabších slov, týdenní
  „výprava za opakováním" jako speciální uzel na mapě).
- Stahovatelné packy a animované nálepky (CDN), kulturní varianty (en-GB).
- Sezónní events (např. zimní jednotka jen v zimě — tajné nálepky).
- Editor packu (web) pro autory obsahu.

---

## 6. Metriky: co znamená „milují" a „ocení"

Vše měřeno lokálně, agregát jen s opt-in.

| Otázka | Metrika | Cíl |
|---|---|---|
| Vrací se dítě samo? | Hrací dny za 14 dní po instalaci | ≥ 6 |
| Je session akorát? | Medián délky session | 5–10 min |
| Není to frustrující? | Podíl kol dohraných na 1.–2. pokus | ≥ 75 % |
| Učí se? | Slova se silou ≥ 4 po 30 dnech | ≥ 30 (cs pásmo A+B) |
| Má propojení smysl? | Podíl dětí, které složí větu s novým slovem do 24 h | ≥ 50 % |
| Ocení rodič? | Návštěva rodičovského koutku v prvním týdnu | ≥ 60 % rodičů |
| Store | Hodnocení / recenze zmiňující „dítě si o to říká" | ≥ 4,6 |

Playtest po každé verzi (5 dětí): sledujeme první minutu, kde dítě váhá,
kde se směje, a zda po dohrání jednotky chce pokračovat.

---

## 7. Rizika a rozhodnutí k potvrzení

| Riziko / rozhodnutí | Doporučení |
|---|---|
| „Pixar postavičky" = licencované IP | Originální postavy v Pixar-kvalitě; jeden ilustrátor definuje style guide (v3.0 začíná návrhem maskota) |
| Náklady na animaci a hlas | Rive místo framu-po-framu; hlas cs/en nejdřív, ostatní TTS; nálepky po dávkách |
| Velikost appky | Rozpočet 60 MB base, lazy jazyky a scény |
| Výkon na starém Androidu | Rozpočet animací, test zařízení API 21, redukce pohybu = i výkonový režim |
| Přeplácanost: „vše se hýbe" ruší při učení | Během kola je živý jen maskot a karta; svět ožívá na mapě a v oslavě |
| Reálný kalendář vs. postup pro období | Default reálný (děti vidí venku sníh), rodič může přepnout |
| Audio knihovna | Rozhodnout prototypem latence v prvním týdnu v2.2 |
| Dva zdroje obsahu (Dart + JSON) | Smazat Dart v v2.3, dřív než přibude schéma v2 |
| Monetizace | Nikdy IAP dostupné dítěti; rozhodnutí nejpozději ve v3.1 |

---

## 8. První týden (start v2.2)

1. Prototyp audio latence: `flutter_soloud` vs `audioplayers`, xylofon při
   swype na Androidu API 21 zařízení.
2. Bounce klávesy + trail světlušek + padající hvězdy v `GameScreen`.
3. `AudioService` + prvních 6 sfx (tón, úspěch, chyba, hvězda, nálepka,
   tap) — dočasně volné CC0 zvuky, později vlastní.
4. `WorldClockService` s injekcí času + test; pozadí mapy podle denní doby.
5. CI: `flutter analyze` + `flutter test` na PR; první widget test
   `GameScreen` (úspěch → hvězdy → další lekce).
6. Screenshoty současného stavu do `GALLERY.md` (baseline před změnou).
7. Brief pro ilustrátora: maskot, 8 zvířátek, style guide (aby v3.0 mohl
   začít hned po v2.4). → `docs/ILLUSTRATOR_BRIEF.md`
