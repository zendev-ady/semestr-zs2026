# Semestr ZS 2026/27 — studijní podklady

Statický web (bez buildu) s poznámkami a quizem k předmětům semestru. Otevírá se přímo `index.html` v prohlížeči.

- Práce na předmětech (sylabus, poznámky, otázky, termíny): skill `semestr` v `.claude/skills/semestr/`
- Předměty, rozvrh a témata se mění v `data/courses.json`, termíny v `data/events.json`, semestr a volna v `data/semester.json`; struktura viz `data/README.md`
- Po změně JSON spusť `python3 quiz.py export`; web čte generovaný `study-data.js`, Python načítá JSON přes `study_data.py`. `courses.js` obsahuje pouze pomocné funkce pro web
- Po každé změně otázek nebo `studijni_plan.md` spusť `python3 quiz.py export` (web čte `quiz-data.js` a `plans-data.js`, ne `quiz.db` a `.md`; plán zobrazuje `plan.html?course=KÓD`)
- Obsah poznámek je česky (u 1BP461 s anglickými pojmy v závorce); otázky česky, kromě 1BP461 — anglicky
