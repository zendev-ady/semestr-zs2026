# Generátor otázek do quiz.db

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

- `topic` = kód předmětu z `courses.js` (jiný kód `quiz.py` odmítne)
- `subtopic` = číslo tématu = index v `topics` + 1 = sekce `#topic-N` na stránce předmětu
- `correct` = `"A"`–`"D"`, správnou pozici rovnoměrně střídej
- max ~10 otázek na jeden `add` (délka příkazu); apostrof v textu zapiš jako `’`
- 1BP461: otázky anglicky

## Zdroj otázek

Otázky vycházej z poznámek (`courses/<slug>.html`) a sylabu — netestuj nic, co v poznámkách není. Když při psaní otázky zjistíš mezeru v poznámkách, doplň ji tam.

Rozsah: cca 8–12 otázek na téma, víc u početních a klíčových témat.

## Typy otázek — střídej

1. **Pravdivé / nepravdivé tvrzení** — „Vyberte nepravdivé tvrzení o …“, tři pravdivá, jedno záludně špatné
2. **Identifikace** — „Mezi … patří:“
3. **Důsledek** — „Co se stane s …, když …?“
4. **Výpočet** — číselné možnosti, špatné odpovědi = typické chyby (záměna sazby, zapomenutá periodizace, znaménko)
5. **Aplikace pravidla / regulace** — konkrétní situace → co platí (Basel, MiFID, IFRS 17, Solvency II, MiCA …)
6. **Případ** (hlavně 1BP461, 1MT461) — krátký scénář → nejlepší postup/riziko

## Kvalita

- špatné možnosti plausibilní, podobně dlouhé jako správná
- žádné „všechny/žádná z uvedených“
- jedna otázka = jeden koncept
- záludnosti ze `warn-box` poznámek musí mít vlastní otázku
- vysvětlení odkazuje na pojem nebo vzorec z poznámek

Po vložení krátce shrň: kolik otázek, která témata, a výstup `python3 quiz.py topics`.
