# Otázky do quiz.db

Výstupem jsou `python3 quiz.py add` příkazy, na konci `python3 quiz.py export`.

## Formát

```bash
python3 quiz.py add '[
  {
    "topic": "1BP403",
    "subtopic": 3,
    "question": "Text otázky?",
    "option_a": "První možnost",
    "option_b": "Druhá možnost",
    "option_c": "Třetí možnost",
    "option_d": "Čtvrtá možnost",
    "correct": "B",
    "explanation": "Proč B a proč ne ostatní — max 2–3 věty."
  }
]'
```

- `topic` = kód předmětu z `data/courses.json` (jiný kód `quiz.py` odmítne)
- `subtopic` = číslo tématu = index v `topics` + 1 = sekce `#topic-N` na stránce předmětu
- `correct` = `"A"`–`"D"`, správnou pozici rovnoměrně střídej
- max ~10 otázek na jeden `add` (délka příkazu); apostrof v textu zapiš jako `’`
- 1BP461: otázky anglicky

## Zdroj otázek

Otázky vycházej z poznámek (`courses/<slug>.html`) a `studijni_plan.md` — netestuj nic, co v poznámkách není. Když při psaní otázky zjistíš mezeru v poznámkách, doplň ji tam.

Rozsah: cca 8–12 otázek na téma, víc u početních a klíčových témat.

## Typy otázek — střídej

1. **Pravdivé / nepravdivé tvrzení** — „Vyberte nepravdivé tvrzení o …“, tři pravdivá, jedno záludně špatné
2. **Identifikace** — „Mezi … patří:“
3. **Důsledek** — „Co se stane s …, když …?“
4. **Výpočet** — číselné možnosti, špatné odpovědi = typické chyby (záměna sazby, zapomenutá periodizace, znaménko)
5. **Aplikace pravidla / regulace** — konkrétní situace → co platí (Basel, MiFID, IFRS 17, Solvency II, MiCA …)
6. **Případ** (hlavně 1BP461, 1MT461) — krátký scénář → nejlepší postup/riziko

## Kvalita

- špatné možnosti plausibilní: vycházejí ze skutečných záměn pojmů, chyb v postupu nebo nesprávné aplikace pravidla; autor musí umět vysvětlit, proč je každá chybná
- všechny možnosti mají srovnatelnou míru konkrétnosti, podrobnosti a jazykový styl; správná nesmí být soustavně nejdelší, nejpřesněji formulovaná nebo jediná s podmínkami a odborným slovníkem
- společný kontext a podmínky přesuň do zadání otázky; podrobné zdůvodnění patří do `explanation`, ne pouze do správné možnosti
- délky nemusí být totožné: nepřidávej výplň do chybných možností ani nevynechávej podstatnou podmínku správné odpovědi jen kvůli délce
- žádné „všechny/žádná z uvedených“
- jedna otázka = jeden koncept
- záludnosti ze `warn-box` poznámek musí mít vlastní otázku
- vysvětlení odkazuje na pojem nebo vzorec z poznámek

## Kontrola před vložením

- Ověř, že právě jedna možnost je správná při podmínkách uvedených v zadání. Zkontroluj všechny možnosti i po jejich přeformulování.
- Projdi otázky i bez znalosti látky: lze správnou možnost poznat podle délky, konkrétnosti, gramatické návaznosti, opakování slov ze zadání nebo nápadně absurdních alternativ? Takové otázky přepracuj.
- Za každé téma i celou sadu spočítej úspěšnost strategie „vyber nejdelší možnost“ podle znaků a podle slov. Při shodě maxima započítej náhodný výběr mezi nejdelšími: je-li mezi nimi správná, příspěvek je `1 / počet shod`, jinak 0. Porovnej s náhodným hádáním 25 % a uveď počet otázek; malé sady mohou kolísat. Výraznou nebo soustavnou výhodu této strategie vyšetři a oprav před vložením.
- Zkontroluj rozložení správných pozic A–D bez předvídatelného opakujícího se pořadí. Samotné promíchání možností neřeší nápovědu délkou ani konkrétností.
- Číselná kontrola délky nenahrazuje obsahovou kontrolu: i stejně dlouhá správná možnost může jako jediná působit odborně a konkrétně.

Po vložení krátce shrň: kolik otázek, která témata, výstup `python3 quiz.py topics`, úspěšnost obou strategií podle délky a výsledek kontroly konkrétnosti možností.
