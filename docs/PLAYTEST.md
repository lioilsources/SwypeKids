# SwypeKids — protokol testování s dětmi

Verze 1 (říjen 2026). Roadmapa P7: „5 dětí × 15 min po každé větší verzi".
Cíl není známkovat dítě, ale najít místa, kde hra váhá, nudí nebo mate.

---

## 1. Kdy a s kým

- Po každé verzi s novou mechanikou (v2.x, v3.0, v3.1…), před vydáním do
  obchodu; TestFlight build stačí.
- **5 dětí**, věk 5–9, ideálně mix: 1–2 předškoláci (neznají písmena),
  2 prvňáci (učí se číst), 1 starší (čte). Aspoň jedno dítě, které appku
  ještě nevidělo.
- Místo: doma u dítěte nebo známé prostředí; tablet i telefon (střídat).
- 15 minut hry + 5 minut povídání. Rodič je u toho, ale **nepomáhá**,
  dokud se dítě samo nezeptá.

## 2. Před sezením

- [ ] Čistá instalace (nebo smazaný profil) — vidíme onboarding.
- [ ] Zvuk zapnutý, jas na maximum, redukce pohybu vypnutá.
- [ ] Jazyk podle dítěte; u cizích jazyků nejdřív cs/en.
- [ ] Souhlas rodiče s pozorováním a zápisky (bez nahrávání obličeje;
  nahrávka obrazovky jen se souhlasem, bez zvuku dítěte).
- [ ] Tento protokol vytištěný, stopky.

## 3. Co sledujeme (zapisovat průběžně)

### První minuta (onboarding)

| Otázka | Zápis |
|---|---|
| Rozumí dítě, co má dělat, bez čtení? | ano / váhá / rodič musel vysvětlit |
| Pozná vlajku svého jazyka? | |
| Zasmálo se / zareagovalo na průvodce? | kdy, čemu |
| Kolik sekund do prvního ▶? | |

### Hra (mapa + kola)

| Otázka | Zápis |
|---|---|
| Najde samo, kam ťuknout (žlutý uzel)? | |
| První swype: chápe „přejet prstem", ne ťukat? | kolik pokusů |
| Rozumí chybě (karta zatřese, zvuk „bump")? Zkusí znovu samo? | |
| Co dělá při poslechovém kole 🔊? Klikne na reproduktor? | |
| Doplňovačka 🧩 / jen obrázek 🖼️: ví, co chybí? | |
| Oslava: dívá se na hvězdy, nebo hned swypuje dál? | |
| Slovo do věty: složí větu, nebo přeskočí ✕? Směje se větě? | |
| Nálepka: raduje se? Jde se podívat do Zvěřince? | |
| Mapa: všimne si mlhy, biotopu, počasí/částic? Komentuje? | |
| Kde se nudí (odkládá prst, dívá se jinam)? Čas: | |
| Kde se směje? Čas: | |
| Chce po jednotce pokračovat? („ještě jednu?") | |

### Technika

- Lagy, pády, špatně rozpoznaný swype (zapsat slovo a co se stalo).
- Zařízení, verze appky, orientace.

## 4. Povídání potom (5 min, otázky otevřené)

1. „Co se ti líbilo nejvíc?"
2. „Bylo něco těžké? Co?"
3. „Kdo je tohle?" (ukázat průvodce / zvířátko) — pozná, pojmenuje?
4. „Chtěl/a by sis to zahrát zítra?"
5. Rodič: „Rozuměl/a jste, co se dítě učí? Našel/našla jste poznámku
   pro rodiče (dlouhý stisk)?"

## 5. Vyhodnocení

Po všech pěti dětech sepsat do `docs/playtests/YYYY-MM-DD-vX.Y.md`:

- **Top 3 problémy** (kde ≥ 2 děti váhaly nebo potřebovaly pomoc) → issues.
- **Top 3 radosti** (co děti rozesmálo / chtěly opakovat) → nerušit, posílit.
- Metriky z roadmapy §6, pokud jdou odečíst: podíl kol na 1.–2. pokus,
  délka session, zda dítě chtělo pokračovat.
- Rozhodnutí: vydat / opravit a zopakovat.

## 6. Pravidla

- Nikdy neopravovat dítě během hry; zapsat, co udělalo, ne co „mělo".
- Žádné odměny za „správné" hraní; můžeme ocenit, že nám pomáhá.
- Jedna změna najednou: netestovat dva nové nápady ve stejném sezení.
- Děti nejsou data: žádná jména v repozitáři, jen věk a číslo (D1–D5).
