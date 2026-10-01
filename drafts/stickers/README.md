# Návrhy nálepek (tier 0)

Jednorázová dávka draftů pro v3.0 „Parta" (roadmapa P1) vygenerovaná na SPARKu
přes flux-schnell — jen pro inspiraci a výběr směru. Finální postavy a nálepky
dělá ilustrátor podle `docs/ILLUSTRATOR_BRIEF.md`; nic z `out/` nejde do
`assets/`.

- `prompts.json` — 70 promptů (16 póz kandidátů na maskota: lišák, panda, sova,
  kapybara; 35 zvířátek z klávesnic všech jazyků; 6 postav rodiny; 13 objektů
  a tajných nálepek), jednotný styl nálepky s bílým obrysem.
- `run_batch.py` — pošle dávku na gen-queue (souběžnost 2, 1024×1024, 4 kroky),
  čeká do 19:15 (`--now` spustí hned), ukládá PNG + JSON se seedem do `out/`
  (ignorováno gitem) a `out/log.txt`.
