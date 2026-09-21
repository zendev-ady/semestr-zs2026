---
name: semestr-notes
description: Tvorba a rozšiřování studijních poznámek k předmětům ZS 2026/27 (FFÚ VŠE) — HTML stránky v courses/ podle sylabu, se sdíleným design systémem, harmonogramem a vazbou na quiz.
user-invocable: true
---

## Kontext

Poznámky k předmětům semestru ZS 2026/27 (FFÚ VŠE, obor bankovnictví a kapitálové trhy) jako podklad pro průběžné testy a zkoušky. Předměty, barvy, rozvrh, témata a termíny jsou v **`courses.js`** — jediný zdroj pravdy.

Vždy si přečti:
1. `podklady/<KÓD>/` — sylabus (a případně slidy) daného předmětu
2. `podklady/<KÓD>/studijni_plan.md` — pokud už existuje
3. existující `courses/<slug>.html`
4. `shared.css` — dostupné komponenty

## Struktura

```
semestr-zs2026/
├── courses.js          # předměty: kód, název, barva, rozvrh, topics[], events[]
├── harmonogram.js      # rozvrh, týdny výuky, termíny (dashboard + stránky předmětů)
├── index.html          # dashboard: harmonogram + karty předmětů (generováno z courses.js)
├── quiz.html           # quiz: filtr předmět → téma (quiz.html?course=KÓD&topic=N)
├── quiz.py / quiz.db   # banka otázek (viz generator-prompt.md)
├── shared.css          # design systém, akcent přes --accent
├── subjects-nav.js     # aktivní odkaz v TOC
├── courses/<slug>.html # poznámky k předmětu
└── podklady/<KÓD>/     # sylaby, slidy, studijni_plan.md
```

## Postup pro nový předmět (po nahrání sylabu)

1. Přečti sylabus a zapiš `podklady/<KÓD>/studijni_plan.md`: cíle, témata po týdnech, způsob hodnocení (váhy, body, minimum), termíny testů/odevzdání, literatura.
2. Do `courses.js` u předmětu doplň:
   - `topics` — krátké názvy témat v pořadí sylabu (index + 1 = týden výuky = `#topic-N` = `subtopic` v quizu)
   - `events` — `{"date": "YYYY-MM-DD", "type": "test|zkouska|deadline|jine", "title": "..."}`; pokud sylabus uvádí jen týden, datum = den výuky v tom týdnu
   - obsah za `window.COURSES =` musí zůstat čistý JSON (čte ho `quiz.py`)
3. Do `courses/<slug>.html`:
   - pod `<h1>` doplň řádek s hodnocením (např. „Průběžný test 30 b · Seminárka 20 b · Zkouška 50 b“)
   - do TOC přidej odkaz na každé téma, nahraď placeholder `alert` sekcemi `topic-1` … `topic-N`
   - sekce Harmonogram se generuje sama z `courses.js`, needituj ji ručně
4. Vygeneruj otázky podle `generator-prompt.md`, pak `python3 quiz.py export`.

## Kostra stránky

Nové stránky nevytvářej ručně — kostru mají všechny předměty v `courses/`. Klíčové prvky:
- `<body data-course="KÓD">` a hned za ním `<script src="../courses.js">` → nastaví akcentovou barvu
- na konci `harmonogram.js`, volání `Harmonogram.renderCourseHarmonogram(...)` a `subjects-nav.js`

## Komponenty (shared.css)

```html
<section class="topic-section" id="topic-1">
    <h3>1. Název tématu</h3>
    <h4>Podnadpis</h4>

    <div class="def-box"><strong>Definice:</strong> ...</div>        <!-- barva předmětu -->
    <div class="thm-box"><strong>Klíčový vztah:</strong> ...</div>   <!-- zelená -->
    <div class="ex-box"><strong>Příklad:</strong> ...</div>          <!-- cyan -->
    <div class="warn-box"><strong>⚠️ Pozor:</strong> ...</div>       <!-- žlutá: typické chyby v testu -->
    <div class="insight-box"><strong>Intuice:</strong> ...</div>     <!-- fialová -->
    <div class="formula-block">$$NPV = \sum_{t=0}^{n} \frac{CF_t}{(1+r)^t}$$</div>
    <table class="table table-bordered summary-table">...</table>

    <div class="summary-box"><strong>Shrnutí:</strong>
        <ul><li>...</li></ul>
    </div>
    <p class="mb-0"><a href="../quiz.html?course=KÓD&topic=1"><i class="fas fa-question-circle me-1"></i>Procvičit téma</a></p>
</section>
```

MathJax: inline `$...$`, blokově `$$...$$`.

## Filozofie poznámek

Podklad pro test a zkoušku, ne učebnice:
- ke každému tématu: **co to je**, **proč to tak funguje**, **jak se na to ptají v testu**
- pojmy a definice přesně podle sylabu a přednášek; když se zdroje liší, přednost má přednášející
- výpočty vždy s řešeným příkladem (`ex-box`) krok za krokem
- záludnosti do `warn-box`, intuice do `insight-box`
- každá sekce končí `summary-box` a odkazem „Procvičit téma“
- aktuální data (sazby, regulace, tržní čísla) označ rokem, ke kterému platí

## Jazyk

- 1BP461 (Případové studie, anglicky): poznámky anglicky, u klíčových pojmů český ekvivalent v závorce; `<html lang="en">`
- ostatní předměty česky; zavedené anglické pojmy (duration, hedging, tokenizace) ponech a vysvětli
