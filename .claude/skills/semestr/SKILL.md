---
name: semestr
description: Studijní podklady k předmětům ZS 2026/27 (FFÚ VŠE) — zpracování sylabu, poznámky v courses/, otázky do quizu, termíny v harmonogramu. Použij vždy, když jde o předmět semestru (1BP403, 1BP404, 1BP440, 1MT461, 1BP441, 1BP461, 1BP443), sylabus, poznámky, otázky, test, zkoušku nebo harmonogram.
---

## Kontext

Podklady k předmětům ZS 2026/27 (FFÚ VŠE, bankovnictví a kapitálové trhy) pro průběžné testy a zkoušky. Statický web bez buildu: `index.html` (dashboard + harmonogram), `courses/<slug>.html` (poznámky), `quiz.html` (quiz).

**`courses.js` je jediný zdroj pravdy** — předměty, barvy, rozvrh, `grading`, `topics`, `events`. Dashboard, harmonogram, stránky i quiz se z něj generují. Obsah za `window.COURSES =` musí zůstat čistý JSON (čte ho `quiz.py`).

```
courses.js            # předměty: code, name, slug, color, schedule, grading, topics[], events[]
harmonogram.js        # rozvrh, týdny výuky, termíny
courses/<slug>.html   # poznámky k předmětu
quiz.py / quiz.db     # banka otázek → quiz-data.js (python3 quiz.py export)
shared.css            # design systém, akcent přes --accent
podklady/<KÓD>/       # sylabus.txt (z InSIS), studijni_plan.md, případně slidy
```

## Když chybí zadání

Pokud není jasné, na čem pracovat:
1. Ukaž stav: pro každý předmět, jestli má `sylabus.txt`, `studijni_plan.md`, kolik sekcí `topic-N` má stránka a kolik otázek (`python3 quiz.py topics`), plus nejbližší `events`
2. Zeptej se: **který předmět**, **co** (zpracovat sylabus / poznámky / otázky / termíny), **rozsah** (celý předmět, nebo konkrétní témata — např. látka na nejbližší test)

## 1. Zpracování sylabu

Vstup: `podklady/<KÓD>/sylabus.txt` (text zkopírovaný z InSIS — neměnit).

1. Napiš `podklady/<KÓD>/studijni_plan.md` podle vzoru `podklady/1MT461/studijni_plan.md`: přehled, hodnocení, tabulka témat (zkratka · text ze sylabu · klíčové pojmy), výsledky učení → témata, literatura, na co se zaměřit. Klíčové pojmy, které nejsou ze sylabu, označ jako návrh.
2. V `courses.js` doplň `grading` a `topics` (krátké názvy; index + 1 = týden výuky = `#topic-N` = `subtopic` v quizu; pokud sylabus týdny nepřiřazuje, platí téma N = týden N).
3. V `courses/<slug>.html` nahraď pod `<h1>` „zkouška“ textem z `grading`.
4. Na co sylabus neodpovídá (termíny testů, rozsah průběžného testu), napiš uživateli jako otevřené otázky.

## 2. Poznámky

Před psaním si přečti `studijni_plan.md`, stávající stránku a `shared.css`. Pracuj po tématech; každé téma = jedna sekce.

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

**Jazyk:** 1BP461 anglicky (český ekvivalent klíčových pojmů v závorce, `<html lang="en">`), ostatní česky; zavedené anglické pojmy (hedging, duration, cash pooling) ponech a vysvětli.

## 3. Otázky do quizu

Postupuj podle [otazky.md](otazky.md). Otázky jen k tématům, která už mají poznámky. Na konci `python3 quiz.py export`.

## 4. Termíny

Termíny testů, odevzdání a zkoušek → `events` v `courses.js`:
`{"date": "YYYY-MM-DD", "type": "test|zkouska|deadline|jine", "title": "..."}`.
Když je znám jen týden, datum = den výuky předmětu v tom týdnu (`SEMESTER.start` + rozvrh). U testu uveď do `title` rozsah látky, pokud je znám (např. „Průběžný test (témata 1–6)“).

## Kontrola na konci

- `courses.js` je pořád validní JSON: `python3 quiz.py topics` projde
- TOC odkazy odpovídají `id` sekcí, počet sekcí = `topics.length`
- shrň uživateli, co přibylo a co zůstává otevřené
