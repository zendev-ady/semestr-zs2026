# Semestr ZS 2026/27 — studijní podklady

Statický web (bez buildu) s poznámkami a quizem k předmětům semestru. Otevírá se přímo `index.html` v prohlížeči.

- Práce na předmětech (sylabus, poznámky, otázky, termíny): skill `semestr` v `.claude/skills/semestr/`
- Předměty, rozvrh, témata a termíny se mění jen v `courses.js`; dashboard, quiz, harmonogram i barvy se z něj generují
- Po každé změně otázek nebo `studijni_plan.md` spusť `python3 quiz.py export` (web čte `quiz-data.js` a `plans-data.js`, ne `quiz.db` a `.md`; plán zobrazuje `plan.html?course=KÓD`)
- Obsah poznámek je česky (u 1BP461 s anglickými pojmy v závorce); otázky česky, kromě 1BP461 — anglicky
