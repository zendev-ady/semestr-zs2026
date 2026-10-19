# Poznámky ze slajdů (zadání pro agenta na jedno téma)

Pro předměty, které stojí na prezentacích. Jeden agent zpracuje jedno téma. Hlavní agent předem připraví slajdy a potom sloučí výstupy. **Stránku `courses/<slug>.html`, `quiz.db` ani exporty agent nemění**, protože víc agentů paralelně by si navzájem přepisovalo změny.

## Příprava (hlavní agent)

```bash
# pptx/doc → pdf, potom každý slajd jako JPG a text po slajdech
soffice --headless --convert-to pdf --outdir $S/pdf podklad.pptx
pdftoppm -jpeg -r 100 -jpegopt quality=80 $S/pdf/<deck>.pdf $S/slides/<deck>/s
for i in $(seq 1 $N); do echo "=== SLIDE $i"; pdftotext -layout -f $i -l $i <deck>.pdf -; done > $S/slides/<deck>/text.txt
```

`$S` = scratchpad. Číslo slajdu = číslo stránky v PDF (`s-007.jpg` = slajd 7).

## Vstupy pro agenta

- `$S/slides/<deck>/text.txt`: text slajdů. Na grafy, tabulky a schémata se dívej přímo na obrázek `s-NNN.jpg` (nástroj Read). Projdi **všechny** slajdy, text nestačí.
- `podklady/<KÓD>/studijni_plan.md`: harmonogram, značení, struktura testu
- `courses/<slug>.html`: hotová sekce `topic-1` je **stylový vzor** (délka vět, typy boxů, shrnutí)
- `.claude/skills/semestr/SKILL.md` (sekce 2 Poznámky) a `otazky.md`

## Poznámky

- **Struktura podle prezentace**: pořadí a podnadpisy `<h4>` ber z prezentace. Co přednášející zdůrazňuje (tučně, opakovaně, souhrnný slajd), musí být v poznámkách.
- **Výpisky, ne přepis**: text ze slajdů převeď na krátké věty a vysvětli každý pojem. Za tvrzení přidej číslo slajdu v závorce: `(s. 23)`.
- **Doplňky**: co na slajdech není, označ `<em>doplněk</em>` a uveď zdroj podle SKILL.md. Doplňuj jen tam, kde bez toho slajdy nejsou srozumitelné.
- **Značení** drž podle přednášky, i když se liší od literatury. Rozdíl uveď ve `warn-box`.
- **Výpočty**: každý příklad ze slajdů a z „zadání příkladů“ vyřeš krok za krokem v `ex-box` se vzorcem v MathJaxu a čísly. Výsledek přepočítej (`python3 -c`). Když je na slajdech řešení, musí ti vyjít stejně. Pokud ne, napiš to.
- Pod `<h3>` dej řádek `<p class="text-muted small">Přednáška <datum> · <vyučující> · zdroj: <em>Název prezentace</em> (<code>soubor</code>, čísla slajdů v závorkách)</p>`.
- Sekce končí `summary-box` a odkazem „Procvičit téma“ (`../quiz.html?course=KÓD&topic=N`).

### Vložené slajdy

Slajd vlož jako obrázek, jen když nese informaci, kterou text nepředá: graf, payoff diagram, časovou osu, schéma toku peněz, tabulku dat nebo zadání příkladu s tabulkou. Čistě textové slajdy nevkládej. Typicky 5–15 slajdů na téma. Obrázek vždy doplň vlastním výkladem: co na něm je a co si z něj odnést.

```bash
mkdir -p courses/img/<KÓD>
convert $S/slides/<deck>/s-023.jpg -resize '1100x>' -quality 80 courses/img/<KÓD>/<deck>-23.jpg
```

```html
<figure class="slide-fig">
    <img src="img/<KÓD>/<deck>-23.jpg" loading="lazy" alt="Payoff dlouhé put opce">
    <figcaption>Slajd 23 (Šíma, Opce): payoff dlouhé put opce. Zisk roste, když spot klesne pod strike.</figcaption>
</figure>
```

Cesta `img/...` je relativní ke `courses/`.

## Otázky

Podle `otazky.md` (jazyk předmětu, 8–12 na téma, u početních témat víc), jen z toho, co je v tvých poznámkách. Spusť kontrolu „vyber nejdelší možnost“ (znaky i slova) a vyrovnej pozice A–D.

## Výstup

1. `$S/out/topic-N.html`: jen `<section class="topic-section" id="topic-N">…</section>`, odsazení 16 mezer jako na stránce
2. `$S/out/topic-N-questions.json`: pole objektů ve formátu `quiz.py add` (`topic`, `subtopic`, `question`, `option_a`–`d`, `correct`, `explanation`)
3. obrázky v `courses/img/<KÓD>/`

Pomocné skripty a mezivýsledky pojmenovávej s číslem tématu (`$S/work-topic-N/…`), protože scratchpad sdílí víc agentů naráz.

Závěrečná zpráva (krátce): seznam vložených slajdů, které příklady jsi řešil a jestli sedí s řešením na slajdech, co je *doplněk*, nejasnosti a chybějící podklady, výsledek kontroly otázek (počet, pozice A–D, úspěšnost strategie nejdelší možnosti).
