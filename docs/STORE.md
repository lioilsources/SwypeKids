# SwypeKids — podklady pro odeslání do obchodů (App Store / Google Play)

Verze 2 (8. 10. 2026) pro první vydání **2.16.x**. Všechny texty prošly
kontrolou délek (název 30, podtitul 30, krátký popis 80, klíčová slova 100,
promo 170). Překlady de/es/pt/fr/it jsou strojové — před větší propagací
na daném trhu dát přečíst rodilému mluvčímu.

## 1. Společné údaje

| Pole | Hodnota |
|---|---|
| Bundle ID / applicationId | `com.ol1n.SwypeKids` |
| Primární jazyk | čeština |
| Kategorie | Vzdělávání (Education); sekundární Apple: Hry › Vzdělávací nebo žádná |
| Apple „Made for Kids“ | ano, věk **6–8** (nevratné po schválení) |
| Apple věkové hodnocení | 4+ (všechny otázky „None“; bez neomezeného webu, bez hazardu, bez soutěží) |
| Google cílové publikum | 5 a méně + 6–8; „apeluje na děti“ ano; program Designed for Families |
| Cena | zdarma; bez nákupů v aplikaci (obchod je v kódu vypnutý, `StoreConfig.enabled = false`) |
| Země | všechny kromě **Číny (pevninské)** a zatím **Japonska** (`docs/MONETIZATION.md` §9) |
| Zásady soukromí (URL) | `https://github.com/lioilsources/SwypeKids/blob/main/docs/PRIVACY.md` (cs + en) |
| Podpora (URL) | `https://olin.now/swypekids.html` |
| Marketing (URL, volitelné) | `https://olin.now/swypekids.html` |
| Copyright | © 2026 Oldřich Vořechovský |
| Kontakt (recenze, podpora) | oldrich.vorechovsky.jr@gmail.com |
| Šifrování | `ITSAppUsesNonExemptEncryption = false` je v Info.plist; žádný dotaz při odeslání |

### Apple — App Privacy („nutriční štítek“)

„Data Not Collected“ — aplikace nemá síťové volání, analytiku ani SDK třetích
stran (`docs/PRIVACY.md`). Tracking: ne.

### Google — Data safety

- Shromažďuje nebo sdílí aplikace data? **Ne.**
- Reklamy: **ne.** Přihlášení: ne. Odkazy ven dostupné dítěti: ne.
- Obsahové hodnocení (IARC): vzdělávací, bez násilí, bez komunikace mezi
  uživateli, bez sdílení polohy, bez nákupů.

### Poznámka pro recenzenta (Apple „App Review Information › Notes“)

```
SwypeKids is an offline reading game for children aged 5–9. It makes no
network requests, has no accounts, no ads, no analytics and no in-app
purchases. There are no external links anywhere in the child-facing UI.

Parent corner: open the drawer (top-left menu) and tap "Pro rodiče" /
"For parents". It is protected by a parental gate: a multiplication
question (e.g. 7 × 8) with three answers. Inside are only settings (sound,
time limit, sibling profiles, dyslexia font) and learning statistics; no
links, no purchases.

To change the language: the flag in the top bar of the map. All nine
languages are free. No login is needed to review the app.
```

## 2. Snímky obrazovek

`tool/store_screenshots.sh build/store/screenshots` (skutečná appka na
macOS, čeština, rozehraný profil). Pro obchody vzniknou:

| Soubory | Rozměr | Kam |
|---|---|---|
| `appstore-iphone-NN-*.png` (10 ks) | 1320×2868 | App Store iPhone 6,9"; Google Play telefon |
| `appstore-ipad-NN-*.png` (10 ks) | 2064×2752 | App Store iPad 13"; Google Play tablet 10" (a 7") |
| `assets/icon/playstore_512.png` | 512×512 | Google Play ikona |
| `build/store/feature-graphic.png` | 1024×500 | Google Play hlavní obrázek (`tool/store_feature_graphic.py`) |

Doporučené pořadí: mapa, hra, rýmy, nálepka, Zvěřinec, svět zvířátka,
skládej větu, Má knížka, průvodci, rodiče. Ostatní jazykové mutace záznamu
použijí české snímky (App Store je přebírá z primárního jazyka); anglické
snímky jsou další krok.

## 3. Co udělat ručně (účet vývojáře)

**App Store Connect**

1. Aplikace `com.ol1n.SwypeKids` → nová verze 2.16.x, vybrat poslední build
   z TestFlightu.
2. App Information: kategorie, věkové hodnocení (dotazník), „Made for
   Kids“ 6–8, Content Rights (vlastní obsah; nálepky a průvodci jsou
   generované a vlastněné autorem).
3. Pricing and Availability: zdarma; odškrtnout China mainland a Japan.
4. App Privacy: URL zásad + „Data Not Collected“.
5. Pro každý jazyk níže: název, podtitul, promo text, popis, klíčová slova,
   „Co je nového“, URL podpory. Snímky nahrát k češtině.
6. App Review Information: kontakt, poznámka výše; přihlášení není potřeba.
7. Submit for Review (ruční uvolnění po schválení doporučeno).

**Google Play Console**

1. Vytvořit aplikaci (zdarma, hra/aplikace: aplikace, kategorie Vzdělávání).
2. App content: zásady soukromí, reklamy ne, cílové publikum, Data safety,
   obsahové hodnocení, „Families“ dotazník.
3. Store listing pro každý jazyk; ikona, hlavní obrázek, snímky.
4. Nahrát `app-release.aab` z GitHub Release dané verze (workflow
   `release-android.yml` ho staví, do Play ho nenahrává).
5. **Pozor:** osobní vývojářský účet založený po 13. 11. 2023 musí před
   produkcí projít uzavřeným testem (12 testerů, 14 dní). Pak Play dnes do
   produkce nepůjde — začít uzavřeným testem.

## 4. Kontrolní seznam

- [x] Veřejná URL se zásadami soukromí (GitHub; hezčí stránka na olin.now
      je volitelná)
- [x] Texty cs, en, de, es, pt-BR, fr, it
- [x] Snímky iPhone 6,9" a iPad 13" (čeština)
- [x] Parental gate před rodičovským koutkem; žádné odkazy ani nákupy
- [x] Kontakt v zásadách soukromí (e-mail správce v `docs/PRIVACY.md`)
- [ ] Apple: dotazníky, země, odeslání k recenzi
- [ ] Google: založení záznamu, dotazníky, uzavřený test / produkce
- [ ] Playtest podle `docs/PLAYTEST.md` na verzi, která jde do obchodu
- [ ] ja: listing a vydání v Japonsku až po playtestu (§9 plánu)

---

## 5. Texty záznamu

### Česky (primární jazyk záznamu)

**Název (26/30):** SwypeKids – čtení pro děti

**Podtitul (25/30):** Písmenka a slabiky prstem

**Krátký popis, Google (71/80):** Hra, ve které se děti 5–9 let učí číst přejížděním prstem po obrázcích.

**Promo text, Apple (101/170):** Písmenka, slabiky a první věty prstem po obrázkové klávesnici. Bez reklam, bez nákupů, úplně offline.

**Klíčová slova, Apple (91/100):**

```
čtení,písmenka,slabiky,škola,slabikář,abeceda,první třída,učení,hra,předškolák,prvňák,slova
```

**Popis:**

```
Dítě přejíždí prstem po klávesnici s obrázky a skládá slabiky a slova — tak, jak je slyší. Žádné časomíry, žádné tresty: chyba se jen zatřese a napoví. Za každou jednotku dostane zvířátko do Zvěřince.

• Celý Ostrov písmenek zdarma: všechna písmena, slabiky, první slova a věty
• Metoda podle školy: čeština analyticko-synteticky, angličtina foneticky (SATPIN)
• Slabiky → slova → poslech bez textu → doplňovačky → rýmy → opakování toho, co jde nejhůř
• Naučená slova hned do věty (Skládej větu) a do Mé knížky
• Zvěřinec: každé zvířátko má svůj svět — nakrm ho a napoj slovy, která už umíš, pohlaď ho a přečti si, co dělá
• Čtyři průvodci na výběr: Pandička, Kapybárka, Žirafka a Gepardíček
• Stovky ilustrovaných nálepek, tajné nálepky, odznaky — bez streaků a tlaku
• Svět, který žije: roční období podle kalendáře, den a noc, zvuky lesa a rybníka
• Pro rodiče (za bránou): které písmeno dítěti nejde, tipy pro doma, časový limit, profily sourozenců, režim pro leváky, písmo pro dyslektiky
• 9 jazyků v jedné aplikaci: čeština, angličtina, němčina, španělština, italština, francouzština, portugalština, čínština (pinyin), japonština (hiragana)
• Funguje úplně offline, nesbírá žádná data, bez reklam a nákupů

Pro děti od 5 let, které se chystají do první třídy, i pro prvňáky, kteří potřebují číst v klidu a vlastním tempem.
```

**Co je nového:** První vydání v App Store: celý Ostrov písmenek v devíti jazycích, Zvěřinec se světem zvířátek, čtyři průvodci a rodičovský koutek.

### English (en-US, en-GB)

**Název (28/30):** SwypeKids – Reading for Kids

**Podtitul (28/30):** Letters & syllables by swipe

**Krátký popis, Google (68/80):** A game where kids aged 5–9 learn to read by swiping across pictures.

**Promo text, Apple (106/170):** Letters, syllables and first sentences by swiping a picture keyboard. No ads, no purchases, fully offline.

**Klíčová slova, Apple (93/100):**

```
reading,letters,syllables,phonics,alphabet,first grade,learn,preschool,spelling,words,offline
```

**Popis:**

```
Your child swipes across a picture keyboard to build syllables and words — in the order they hear them. No timers, no penalties: a mistake just shakes and hints. Every unit earns an animal for the Zoo.

• The whole Letter Island for free: every letter, syllables, first words and sentences
• Method matched to school: synthetic phonics (SATPIN) for English
• Syllables → words → listening without text → fill the gap → rhymes → review of the weakest words
• New words go straight into a sentence (sentence builder) and into My Book
• The Zoo: every animal has its own little world — feed it with words you already know, stroke it and read what it does
• Four guides to choose from: Pandy, Cappy, Raffie and Cheetie
• Hundreds of illustrated stickers, secret stickers and badges — no streaks, no pressure
• A living world: seasons by the calendar, day and night, sounds of the forest and the pond
• For parents (behind a gate): which letter needs work, tips for home, daily time limit, sibling profiles, left-handed mode, dyslexia-friendly font
• 9 languages in one app: English, Czech, German, Spanish, Italian, French, Portuguese, Chinese (pinyin), Japanese (hiragana)
• Works fully offline, collects no data, no ads, no purchases

For children from age 5 getting ready for school, and for first-graders who need calm reading practice at their own pace.
```

**Co je nového:** First App Store release: the whole Letter Island in nine languages, the Zoo with animal worlds, four guides and a parent corner.

### Deutsch (de-DE)

**Název (28/30):** SwypeKids – Lesen für Kinder

**Podtitul (27/30):** Buchstaben & Silben wischen

**Krátký popis, Google (79/80):** Ein Spiel, in dem Kinder von 5–9 Jahren durch Wischen über Bilder lesen lernen.

**Promo text, Apple (114/170):** Buchstaben, Silben und erste Sätze per Wisch über eine Bildertastatur. Ohne Werbung, ohne Käufe, komplett offline.

**Klíčová slova, Apple (94/100):**

```
lesen,buchstaben,silben,alphabet,schule,erste klasse,lernen,vorschule,wörter,fibel,abc,offline
```

**Popis:**

```
Dein Kind wischt mit dem Finger über eine Tastatur mit Bildern und setzt Silben und Wörter zusammen — so, wie es sie hört. Keine Zeitmessung, keine Strafen: Ein Fehler wackelt nur und gibt einen Tipp. Für jede Einheit gibt es ein Tier für den Zoo.

• Die ganze Buchstabeninsel kostenlos: alle Buchstaben, Silben, erste Wörter und Sätze
• Silben → Wörter → Hören ohne Text → Lückenwörter → Reime → Wiederholung der schwächsten Wörter
• Neue Wörter kommen sofort in einen Satz (Satzbaukasten) und in „Mein Buch“
• Der Zoo: Jedes Tier hat seine eigene kleine Welt — füttere es mit Wörtern, die du schon kannst, streichle es und lies, was es tut
• Vier Begleiter zur Auswahl: Pandi, Capy, Giraffchen und Gepardchen
• Hunderte illustrierte Sticker, geheime Sticker und Abzeichen — ohne Streaks und ohne Druck
• Eine lebendige Welt: Jahreszeiten nach dem Kalender, Tag und Nacht, Geräusche von Wald und Teich
• Für Eltern (hinter einer Sperre): welcher Buchstabe noch schwerfällt, Tipps für zu Hause, tägliches Zeitlimit, Geschwisterprofile, Linkshändermodus, Schrift für Legastheniker
• 9 Sprachen in einer App: Deutsch, Englisch, Tschechisch, Spanisch, Italienisch, Französisch, Portugiesisch, Chinesisch (Pinyin), Japanisch (Hiragana)
• Funktioniert komplett offline, sammelt keine Daten, keine Werbung, keine Käufe

Für Kinder ab 5 Jahren vor dem Schulstart und für Erstklässler, die in Ruhe und im eigenen Tempo lesen üben möchten.
```

**Co je nového:** Erste Version im App Store: die ganze Buchstabeninsel in neun Sprachen, der Zoo mit Tierwelten, vier Begleiter und eine Elternecke.

### Español (es-ES, es-MX)

**Název (27/30):** SwypeKids – Leer para niños

**Podtitul (28/30):** Letras y sílabas con el dedo

**Krátký popis, Google (78/80):** Un juego en el que los niños de 5 a 9 años aprenden a leer deslizando el dedo.

**Promo text, Apple (120/170):** Letras, sílabas y primeras frases deslizando el dedo por un teclado de dibujos. Sin anuncios, sin compras, sin conexión.

**Klíčová slova, Apple (93/100):**

```
leer,letras,sílabas,abecedario,colegio,primero,aprender,preescolar,palabras,lectura,silabario
```

**Popis:**

```
Tu hijo desliza el dedo por un teclado con dibujos y forma sílabas y palabras, tal como las oye. Sin cronómetros ni castigos: un error solo tiembla y da una pista. Por cada unidad gana un animal para el Zoo.

• Toda la Isla de las letras gratis: todas las letras, sílabas, primeras palabras y frases
• Sílabas → palabras → escuchar sin texto → letra que falta → rimas → repaso de las palabras más difíciles
• Las palabras nuevas pasan enseguida a una frase (Construye la frase) y a «Mi libro»
• El Zoo: cada animal tiene su pequeño mundo — dale de comer con palabras que ya sabes, acarícialo y lee lo que hace
• Cuatro guías para elegir: Pandita, Capibarita, Jirafita y Guepardito
• Cientos de pegatinas ilustradas, pegatinas secretas e insignias — sin rachas ni presión
• Un mundo vivo: estaciones según el calendario, día y noche, sonidos del bosque y del estanque
• Para madres y padres (tras una puerta): qué letra cuesta más, consejos para casa, límite de tiempo diario, perfiles de hermanos, modo para zurdos, letra para dislexia
• 9 idiomas en una sola app: español, inglés, checo, alemán, italiano, francés, portugués, chino (pinyin), japonés (hiragana)
• Funciona totalmente sin conexión, no recoge datos, sin anuncios, sin compras

Para niños a partir de 5 años que se preparan para el colegio y para los de primero que necesitan practicar la lectura con calma y a su ritmo.
```

**Co je nového:** Primera versión en App Store: toda la Isla de las letras en nueve idiomas, el Zoo con los mundos de los animales, cuatro guías y un rincón para padres.

### Português (pt-BR)

**Název (29/30):** SwypeKids – Ler para crianças

**Podtitul (27/30):** Letras e sílabas com o dedo

**Krátký popis, Google (71/80):** Um jogo em que crianças de 5 a 9 anos aprendem a ler deslizando o dedo.

**Promo text, Apple (123/170):** Letras, sílabas e primeiras frases deslizando o dedo num teclado de figuras. Sem anúncios, sem compras, totalmente offline.

**Klíčová slova, Apple (89/100):**

```
ler,letras,sílabas,alfabeto,escola,alfabetização,aprender,pré-escola,palavras,leitura,abc
```

**Popis:**

```
A criança desliza o dedo por um teclado com figuras e monta sílabas e palavras, do jeito que ouve. Sem cronômetro, sem punição: um erro só treme e dá uma dica. A cada unidade ela ganha um bichinho para o Zoológico.

• Toda a Ilha das letras grátis: todas as letras, sílabas, primeiras palavras e frases
• Sílabas → palavras → ouvir sem texto → letra que falta → rimas → revisão das palavras mais difíceis
• As palavras novas vão direto para uma frase (Monte a frase) e para «Meu livro»
• O Zoológico: cada bichinho tem o seu mundinho — dê comida com palavras que você já sabe, faça carinho e leia o que ele faz
• Quatro guias para escolher: Pandinha, Capivarinha, Girafinha e Guepardinho
• Centenas de figurinhas ilustradas, figurinhas secretas e medalhas — sem sequências, sem pressão
• Um mundo vivo: estações pelo calendário, dia e noite, sons da floresta e do lago
• Para os pais (atrás de um portão): qual letra está difícil, dicas para casa, limite de tempo diário, perfis de irmãos, modo para canhotos, fonte para dislexia
• 9 idiomas em um só app: português, inglês, tcheco, alemão, espanhol, italiano, francês, chinês (pinyin), japonês (hiragana)
• Funciona totalmente offline, não coleta dados, sem anúncios, sem compras

Para crianças a partir de 5 anos que se preparam para a escola e para as do primeiro ano que precisam praticar a leitura com calma e no próprio ritmo.
```

**Co je nového:** Primeira versão na App Store: toda a Ilha das letras em nove idiomas, o Zoológico com os mundos dos bichinhos, quatro guias e um cantinho dos pais.

### Français (fr-FR, fr-CA)

**Název (29/30):** SwypeKids – Lire pour enfants

**Podtitul (28/30):** Lettres et syllabes au doigt

**Krátký popis, Google (74/80):** Un jeu où les enfants de 5 à 9 ans apprennent à lire en glissant le doigt.

**Promo text, Apple (119/170):** Lettres, syllabes et premières phrases en glissant le doigt sur un clavier d’images. Sans pub, sans achats, hors ligne.

**Klíčová slova, Apple (88/100):**

```
lire,lettres,syllabes,alphabet,école,cp,apprendre,maternelle,mots,lecture,abc,hors ligne
```

**Popis:**

```
Votre enfant glisse le doigt sur un clavier d’images et assemble des syllabes et des mots, comme il les entend. Pas de chrono, pas de punition : une erreur tremble simplement et donne un indice. Chaque unité offre un animal pour le Zoo.

• Toute l’Île des lettres gratuite : toutes les lettres, les syllabes, les premiers mots et phrases
• Syllabes → mots → écoute sans texte → lettre manquante → rimes → révision des mots les plus difficiles
• Les mots appris passent aussitôt dans une phrase (Construis la phrase) et dans « Mon livre »
• Le Zoo : chaque animal a son petit monde — nourris-le avec les mots que tu connais, caresse-le et lis ce qu’il fait
• Quatre guides au choix : Pandou, Capybarette, Girafon et Guépardeau
• Des centaines d’autocollants illustrés, des autocollants secrets et des badges — sans séries ni pression
• Un monde vivant : saisons selon le calendrier, jour et nuit, bruits de la forêt et de l’étang
• Pour les parents (derrière un portail) : quelle lettre pose problème, conseils pour la maison, limite de temps quotidienne, profils des frères et sœurs, mode gaucher, police pour la dyslexie
• 9 langues dans une seule appli : français, anglais, tchèque, allemand, espagnol, italien, portugais, chinois (pinyin), japonais (hiragana)
• Fonctionne entièrement hors ligne, ne collecte aucune donnée, sans publicité, sans achats

Pour les enfants dès 5 ans qui se préparent à l’école et pour les élèves de CP qui ont besoin de s’exercer à lire au calme, à leur rythme.
```

**Co je nového:** Première version sur l’App Store : toute l’Île des lettres en neuf langues, le Zoo et les mondes des animaux, quatre guides et un coin parents.

### Italiano (it-IT)

**Název (29/30):** SwypeKids – Leggere per bimbi

**Podtitul (26/30):** Lettere e sillabe col dito

**Krátký popis, Google (79/80):** Un gioco in cui i bambini dai 5 ai 9 anni imparano a leggere scorrendo il dito.

**Promo text, Apple (118/170):** Lettere, sillabe e prime frasi scorrendo il dito su una tastiera di figure. Senza pubblicità, senza acquisti, offline.

**Klíčová slova, Apple (93/100):**

```
leggere,lettere,sillabe,alfabeto,scuola,prima elementare,imparare,infanzia,parole,lettura,abc
```

**Popis:**

```
Il bambino scorre il dito su una tastiera di figure e compone sillabe e parole, così come le sente. Niente cronometri, niente punizioni: un errore trema soltanto e dà un aiuto. Per ogni unità riceve un animale per lo Zoo.

• Tutta l’Isola delle lettere gratis: tutte le lettere, le sillabe, le prime parole e frasi
• Sillabe → parole → ascolto senza testo → lettera mancante → rime → ripasso delle parole più difficili
• Le parole nuove finiscono subito in una frase (Componi la frase) e in «Il mio libro»
• Lo Zoo: ogni animale ha il suo piccolo mondo — dagli da mangiare con le parole che sai già, accarezzalo e leggi che cosa fa
• Quattro guide tra cui scegliere: Pandina, Capibarina, Giraffina e Ghepardino
• Centinaia di adesivi illustrati, adesivi segreti e distintivi — senza serie, senza pressione
• Un mondo vivo: stagioni secondo il calendario, giorno e notte, suoni del bosco e dello stagno
• Per i genitori (dietro un cancello): quale lettera è ancora difficile, consigli per casa, limite di tempo giornaliero, profili dei fratelli, modalità per mancini, carattere per la dislessia
• 9 lingue in una sola app: italiano, inglese, ceco, tedesco, spagnolo, francese, portoghese, cinese (pinyin), giapponese (hiragana)
• Funziona completamente offline, non raccoglie dati, niente pubblicità, niente acquisti

Per i bambini dai 5 anni che si preparano alla scuola e per quelli di prima che hanno bisogno di esercitarsi a leggere con calma, al proprio ritmo.
```

**Co je nového:** Prima versione su App Store: tutta l’Isola delle lettere in nove lingue, lo Zoo con i mondi degli animali, quattro guide e un angolo dei genitori.
