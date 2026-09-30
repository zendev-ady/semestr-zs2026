# Studijní data

Zdrojová data jsou čisté JSON soubory v UTF-8:

| Soubor | Obsah |
|---|---|
| `courses.json` | Katalog předmětů: kód, název, vzhled, kredity, jazyk, skupina, rozvrh, hodnocení a témata |
| `events.json` | Termíny všech předmětů; `courseCode` odkazuje na `code` v katalogu |
| `semester.json` | Název semestru, začátek výuky, počet týdnů a společná volna |

Pořadí předmětů v katalogu určuje pořadí na webu. Pořadí `topics` určuje čísla témat v poznámkách a quizu, proto je nepřehazuj bez aktualizace těchto vazeb. Volitelné `topicWeeks` přiřazuje každému tématu týden výuky (číslovaný od 1); více témat může být ve stejném týdnu.

Termín má `courseCode`, `date` ve formátu `YYYY-MM-DD`, `type` (`test`, `zkouska`, `deadline`, `jine`) a `title`. Datum bez času nepředpokládá konkrétní hodinu odevzdání.

Po úpravě dat nebo studijního plánu spusť z kořene repozitáře:

```sh
python3 quiz.py export
```

`study_data.py` načte JSON, zkontroluje duplicity kódů a slugů, vazby termínů, data a přiřazení týdnů. Export spojí termíny s předměty do `study-data.js`. Tento generovaný soubor neupravuj ručně; verzujeme ho, aby web fungoval i při přímém otevření HTML z disku bez serveru a načítání JSON přes `fetch`.

`courses.js` obsahuje pouze pomocné funkce pro web a načítá se až po `study-data.js`. Python čte přímo zdrojové JSON přes `study_data.py`, neparsuje JavaScript.

Studijní plány zůstávají v `podklady/<KÓD>/studijni_plan.md` a otázky v SQLite `quiz.db`. Stejný příkaz exportuje i `plans-data.js` a `quiz-data.js`; jde o odlišné zdroje obsahu, nikoli další kopie katalogu předmětů.
