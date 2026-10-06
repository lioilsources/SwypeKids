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
