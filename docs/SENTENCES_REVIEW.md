# Kontrola vět — návod

Appka smí dítěti nabídnout jen větu, která prošla pravidly a kontrolou.
Proč a jak je to postavené: `docs/PLAN_VETY_KVALITA.md`. Tady je jen
postup.

## Co je kde

| Co | Kde |
|---|---|
| Všechny věty, které appka umí říct, a stav jejich kontroly | `review/sentences_<jazyk>.tsv` |
| Souhrn (kolik vět, kolik zkontrolováno) | `review/STATUS.md` |
| Poznámky a sporné body pro rodilé mluvčí | `review/NOTES.md` |
| Autorské tabulky tvarů a štítků pro všech 9 jazyků | `tool/sentences/migrate_rules.py` |
| Pravidla, co se smí skládat | `SentenceRules` v `lib/data/models/sentence.dart` |

Stav věty: `llm` = strojová korektura (`ok` / `flag`), `human` = rodilý
mluvčí (`pending` / `ok` / `fix` / `nonsense`). Člověk má poslední slovo.
Když se text věty změní, vrací se sama na „čeká" — nikdo nekontroluje
dvakrát totéž.

## Po každé změně vět (pack, tvary, pravidla)

```bash
python3 tool/sentences/migrate_rules.py              # když se měnily tabulky tvarů
UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart
flutter test                                         # hlídači T1–T8
dart run tool/sentences/llm_review.dart              # strojová korektura nových vět (klíč ANTHROPIC_API_KEY)
```

`flutter test` neprojde, dokud je v korpusu věta označená strojem (a
nepřehlasovaná člověkem) nebo člověkem jako `fix` / `nonsense`. Oprava se
dělá v datech, ne výjimkou.

## Kolo s rodilým mluvčím

```bash
dart run tool/sentences/export_review.dart --lang de     # build/review/de.html — jen to, co čeká
```

Stránku pošli korektorovi (funguje offline, v telefonu i v počítači).
Vidí desítky položek, ne stovky vět: každou dvojici sloveso + předmět
(pro „já" a pro třetí osobu), seznam podmětů a pár vět navíc. U každé
ťukne ✅ / ✏️ (napíše správně) / ❌ (nedává smysl) a dole stáhne TSV.

```bash
dart run tool/sentences/import_review.dart swypekids-review-de.tsv
```

Věta je `ok`, když jsou `ok` všechny její části. Co korektor označil,
oprav v `migrate_rules.py`, přegeneruj korpus a pošli mu znovu **jen
změněné** položky (`export_review.dart` je vybere sám). Při 100 % `ok`
zapiš do packu `"reviewed": "RRRR-MM-DD"` v `sentence`.

## Nový jazyk

1. Pack + řádky v `migrate_rules.py` (štítky, tvary, pojmenovací věta,
   druhy podmětů) → `flutter test` (T1 úplnost, T2 žádný tichý tvar, T7
   aspoň 2 věty na sloveso, T8 druh ↔ emoji).
2. `UPDATE_SENTENCES=1 flutter test test/sentence_corpus_test.dart`.
3. `llm_review.dart --lang xx` → opravy do 100 % `llm: ok`.
4. `export_review.dart --lang xx` rodilému mluvčímu → `import_review.dart`
   → opravy → znovu jen změněné položky.
5. `sentence.reviewed` a zmínka v `docs/STORE.md`.

## Jak psát tvary (zkušenosti z prvního kola)

- Předmět dostane tvar jen tam, kde věta dává smysl. „Spát na nočníku"
  nezakazuj pravidlem — prostě nočníku nedej tvar `loc`.
- `text` slovesa je nápis na dlaždici, `forms[osoba]` tvar ve větě
  („hraju si" → „si hraje": zvratné zájmeno patří na druhé místo).
- Rámec je volný klíč packu: japonské „ほしい" bere が (`ga`), ne を.
- Podmět musí obstát na začátku věty: „The dog", „El pato", „ねこは".
- Sloveso, které jde říct jen o sobě (ja „ほしいです"), má tvar jen pro
  1. osobu — pravidla ho pak u jiných podmětů nenabídnou.
