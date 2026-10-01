---
name: semestr
description: Studijní podklady k předmětům ZS 2026/27 (FFÚ VŠE) — zpracování sylabu, poznámky v courses/, otázky do quizu, termíny v harmonogramu. Použij vždy, když jde o předmět semestru (1BP403, 1BP404, 1BP440, 1MT461, 1BP441, 1BP461, 1BP443), sylabus, poznámky, otázky, test, zkoušku nebo harmonogram.
---

## Kontext

Podklady k předmětům ZS 2026/27 (FFÚ VŠE, program Finance a technologie) pro průběžné testy a zkoušky. Statický web bez buildu: `index.html` (dashboard + harmonogram), `courses/<slug>.html` (poznámky), `quiz.html` (quiz).

**Zdrojem pravdy jsou JSON soubory v `data/`**: `courses.json` (předměty, barvy, rozvrh, `grading`, `topics`), `events.json` (termíny s vazbou `courseCode`) a `semester.json` (semestr a volna). Po změně spusť `python3 quiz.py export`. Web čte generovaný `study-data.js`, Python načítá JSON přes `study_data.py`. Podrobnosti viz `data/README.md`.

```
data/courses.json     # předměty: code, name, slug, color, schedule, grading, topics[]
data/events.json      # termíny: courseCode, date, type, title
data/semester.json    # semestr: name, start, weeks, holidays[]
study_data.py         # načítání, kontrola vazeb a export JSON
study-data.js         # generovaný export pro web; neupravovat ručně
courses.js            # pomocné funkce pro web
harmonogram.js        # rozvrh, týdny výuky, termíny
courses/<slug>.html   # poznámky k předmětu
quiz.py / quiz.db     # banka otázek → quiz-data.js (python3 quiz.py export)
plan.html             # zobrazí studijni_plan.md (?course=KÓD) z plans-data.js — taky z python3 quiz.py export
shared.css            # design systém, akcent přes --accent
podklady/<KÓD>/       # sylabus.txt (z InSIS), studijni_plan.md, případně slidy
```

## Když chybí zadání

Pokud není jasné, na čem pracovat:
1. Ukaž stav: pro každý předmět, jestli má `sylabus.txt`, `studijni_plan.md`, kolik sekcí `topic-N` má stránka a kolik otázek (`python3 quiz.py topics`), plus nejbližší `events`
2. Zeptej se: **který předmět**, **co** (zpracovat sylabus / poznámky / otázky / termíny), **rozsah** (celý předmět, nebo konkrétní témata — např. látka na nejbližší test)

## 1. Zpracování sylabu

Vstup: `podklady/<KÓD>/sylabus.txt` (text zkopírovaný z InSIS — neměnit), případně oficiální harmonogram od vyučujících (.doc/.pdf). **Harmonogram od vyučujících má přednost** před pořadím v InSIS. `.doc` převeď přes `soffice --headless --convert-to txt:Text --outdir <scratchpad> soubor.doc`.

1. Napiš `podklady/<KÓD>/studijni_plan.md` podle vzoru `podklady/1MT461/studijni_plan.md`: přehled, hodnocení, tabulka témat (zkratka · text ze sylabu · klíčové pojmy), výsledky učení → témata, literatura, na co se zaměřit. Klíčové pojmy, které nejsou ze sylabu, označ jako návrh. Pak `python3 quiz.py export`, aby se plán objevil na webu.
2. V `data/courses.json` doplň `grading` a `topics` (krátké názvy; index + 1 = `#topic-N` = `subtopic` v quizu). Pokud výuka odpadá (svátky, inovační týden), doplň `topicWeeks` = týden výuky pro každé téma; jinak platí téma N = týden N. Celoškolní volna patří do `holidays` v `data/semester.json`. Po změně JSON spusť `python3 quiz.py export`.
3. V `courses/<slug>.html` nahraď pod `<h1>` „zkouška“ textem z `grading`.
4. Na co sylabus neodpovídá (termíny testů, rozsah průběžného testu), napiš uživateli jako otevřené otázky.

## 2. Poznámky

Před psaním si přečti `studijni_plan.md`, stávající stránku a `shared.css`. Hlavní zdroj je prezentace z přednášky (`podklady/<KÓD>/*.pdf`); co v ní není a doplňuješ z literatury, výslovně označ. Pracuj po tématech; každé téma = jedna sekce, pod `<h3>` řádek „Přednáška datum · vyučující · zdroj“.

- do TOC přidej `<li><a class="nav-link py-1" href="#topic-N">N. Zkratka</a></li>`
- placeholder `alert` nahraď sekcemi; sekci Harmonogram ani skripty na konci stránky neměň
- kostru stránky nevytvářej ručně — všechny předměty ji v `courses/` mají

```html
<section class="topic-section" id="topic-1">
    <h3>1. Název tématu</h3>
    <h4>Podnadpis</h4>

    <div class="def-box"><strong>Definice:</strong> ...</div>        <!-- barva předmětu -->
    <div class="thm-box"><strong>Klíčový vztah:</strong> ...</div>   <!-- zelená -->
    <div class="ex-box"><strong>Příklad:</strong> ...</div>          <!-- cyan: řešený příklad -->
    <div class="warn-box"><strong>⚠️ Pozor:</strong> ...</div>       <!-- žlutá: typická chyba v testu -->
    <div class="insight-box"><strong>Intuice:</strong> ...</div>     <!-- fialová -->
    <div class="formula-block">$$F = S \cdot \frac{1 + i_{CZK} \cdot t}{1 + i_{EUR} \cdot t}$$</div>
    <table class="table table-bordered summary-table">...</table>

    <div class="summary-box"><strong>Shrnutí:</strong>
        <ul><li>...</li></ul>
    </div>
    <p class="mb-0"><a href="../quiz.html?course=KÓD&topic=1"><i class="fas fa-question-circle me-1"></i>Procvičit téma</a></p>
</section>
```

MathJax: inline `$...$`, blokově `$$...$$`.

**Filozofie** — podklad pro test a zkoušku, ne učebnice:
- ke každému tématu: **co to je**, **proč to tak funguje**, **jak se na to ptají v testu**
- terminologie podle základní literatury ze sylabu; když se liší přednáška, přednost má přednášející
- každý výpočet má řešený příklad krok za krokem (`ex-box`)
- záludnosti do `warn-box`, intuice do `insight-box`
- každá sekce končí `summary-box` a odkazem „Procvičit téma“
- aktuální data (sazby, regulace, tržní čísla) označ rokem, ke kterému platí

**Jazyk:** poznámky česky, srozumitelně (krátké věty, každý pojem vysvětlit). U 1BP461 (výuka i test anglicky) dávej ke klíčovým pojmům anglický název do závorky; zavedené anglické pojmy (hedging, duration, cash pooling) ponech a vysvětli.

### Zdroje a ověřování

- Rozsah učiva určují sylabus a materiály vyučujícího. Externí zdroje používej k vysvětlení a doplnění; návrhy ve studijním plánu nevydávej za potvrzené požadavky předmětu.
- Chybějící výklad dohledávej přednostně v materiálech VŠE (skripta, přednášky, publikace vyučujících) a předepsané literatuře. Dále používej oficiální výukové materiály a odborné publikace renomovaných univerzit, například MIT, LSE nebo Stanfordu. Samotná univerzitní doména nestačí — ověř autora, povahu dokumentu a jeho relevanci; studentská práce nemá stejnou váhu jako výukový materiál vyučujícího.
- Regulaci a aktuální data ověřuj v primárních zdrojích: ČNB, ECB, BIS, EBA, ESMA, EIOPA, Eurostat nebo oficiální znění legislativy. Rozlišuj datum publikace, období dat a účinnost předpisu. Pokud se starší studijní podklad liší od aktuálního stavu, rozdíl výslovně označ.
- Před použitím zdroj otevři a ověř, že podporuje dané tvrzení; nestačí úryvek z vyhledávače. Necituj knihu jako použitý zdroj, pokud máš jen bibliografický záznam. Nedostupný podklad nebo neověřenou informaci přiznej, nic nedomýšlej.
- U každého tématu uveď konkrétní použité zdroje: název, autora nebo instituci, rok a odkaz či cestu k místnímu podkladu; u delších dokumentů podle možnosti stránku nebo kapitolu. U konkrétních dat a regulatorních tvrzení připoj odkaz přímo k tvrzení, aby byla vazba dohledatelná.
- Odlišuj obsah přednášek, externí doplnění a vlastní modelové příklady. U témat připravených dopředu nepřipisuj externí výklad konkrétní přednášce nebo vyučujícímu bez podkladu.

## 3. Otázky do quizu

Postupuj podle [otazky.md](otazky.md). Otázky jen k tématům, která už mají poznámky. Na konci `python3 quiz.py export`.

## 4. Termíny

Termíny testů, odevzdání a zkoušek → `data/events.json`; pak `python3 quiz.py export`:
`{"courseCode": "1BP440", "date": "YYYY-MM-DD", "type": "test|zkouska|deadline|jine", "title": "..."}`.
Když je znám jen týden, datum = den výuky předmětu v tom týdnu (`start` v `data/semester.json` + rozvrh předmětu). U testu uveď do `title` rozsah látky, pokud je znám (např. „Průběžný test (témata 1–6)“).

## Kontrola na konci

- JSON a vazby jsou validní: `python3 quiz.py topics` a `python3 quiz.py export` projdou
- TOC odkazy odpovídají `id` sekcí, počet sekcí = `topics.length`
- shrň uživateli, co přibylo a co zůstává otevřené
