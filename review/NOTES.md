# Poznámky ke kontrole vět

## První strojový průchod (6. 10. 2026)

Všech 9 jazyků prošel Claude (Opus 5.5) v relaci jako korektor dětské
čítanky — ve zhuštěném pohledu: každá dvojice sloveso + předmět pro
1. a 3. osobu, všechny podměty, vlastní slovesa věcí a pojmenovací věty
(test T5 hlídá, že se věty se stejným slovesem a předmětem liší jen
podmětem). API klíč v prostředí nebyl, takže neběžel nástroj
`tool/sentences/llm_review.dart`; ten je připravený pro další kola
(`dart run tool/sentences/llm_review.dart`, klíč z `ANTHROPIC_API_KEY`).

Opraveno podle nálezů (data, ne výjimky):

| Jazyk | Nález | Oprava |
|---|---|---|
| en, es, it, pt | podmět bez členu („Dog wants milk", „Pato quiere") | „The dog", „El pato", „Il topo", „O leão" … |
| ja | „ママはりんごがほしいです" — „ほしい" jde říct jen o sobě | „chci" jen pro „わたしは" |
| de | „Mama geht ins Auto" (říká se „steigt") | kombinace zrušena |
| it | „gioco con un gioco" | „un giocattolo" |
| cs, pt | „spím ve škole" / „durmo na escola" | zrušeno |
| en | „plays with a bike" | zrušeno (kolo jde jen chtít) |
| cs | „chci fotbal", „Auto veze fotbal" | fotbal jde jen pojmenovat |

## Na co se zeptat rodilého mluvčího (stroj propustil, ale není si jistý)

- **ja** — slovo „こめ" (syrová rýže) ve větě „こめをたべます"; přirozenější
  je „ごはん", ale lekce učí „こめ".
- **ja** — „くるまにいきます", „おまるへいきます" (jít k autu / na nočník).
- **pt** — „Eu como sopa" (vs. „tomo sopa"); „Eu vou para fora" (vs. „lá
  fora"); „vou no peniquinho" (hovorové, brazilské).
- **es** — „Yo voy fuera" (Španělsko) vs. „afuera" (Latinská Amerika);
  dvě dlaždice 🍎 „una manzana" (základní a z batohu).
- **en** — „the cot" (britské; americky „crib"), „Mum"/„Granny".
- **it** — „Io voglio l'acqua" (vs. „dell'acqua").
- **de** — „Ich will …" (dětské; zdvořilejší „Ich möchte …").
- **zh** — „车车" (dětské slovo pro auto), „牛去上厕所" (zvíře + záchod).
- **všechny** — zvířata dělají lidské věci („Ryba jde do školy"); bereme
  jako hravé, ne jako chybu.

## Fáze 3a — dorovnání Ostrova písmenek (7. 10. 2026)

Nové jednotky ja u9–u15, zh u12–u15, pt u14–u15 přidaly 1 294 vět (ja 427,
zh 474, pt 393): nové podměty z batohu a ze Zvěřince × stávající slovesa,
nové předměty × stávající podměty. Prošel je Claude (Opus 5.5) v relaci
stejně jako v prvním průchodu — ve zhuštěném pohledu (každá nová dvojice
sloveso + předmět pro 1. a 3. osobu, každý nový podmět, věty světa
zvířátka, pojmenovací věty); nástroj `llm_review.dart` neběžel (bez klíče).

Opraveno podle nálezů: pt podměty „O peixe" / „A galinha" neměly osobu
(„O peixe quero leite") → `person: 3sg`.

Na co se zeptat rodilého mluvčího:

- **ja** — ヘボン式 v lekcích (SHI, CHI, TSU, FU, CHA, SHA) místo
  kunrei (SI, TI, TU, HU); dlouhé samohlásky jako BUDOU, ZOU, BOUSHI.
- **ja** — „でんしゃであそびます" (hrát si s vláčkem; jde číst i „vlakem"),
  „〜はおちゃをのみます" u zvířat, „やまへいきます".
- **zh** — „兔子吃肉" / „牛吃肉" / „马吃肉" (býložravec + maso; bereme jako
  hravé), „我要肉", holé „姐姐要气球".
- **zh** — lekce `letterHunt` má `display` „啊" (aby TTS řeklo hlásku a).
- **pt** — „suco" (brazilské; pack je pt-BR), „Eu durmo na praia",
  „quer a bicicleta" (určitý člen jako u „a bola").
