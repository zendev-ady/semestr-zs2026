/* Harmonogram — rozvrh, týdny výuky a termíny. Vyžaduje courses.js. */
(function () {
    const DAYS = ['Po', 'Út', 'St', 'Čt', 'Pá'];
    const TYPE_LABELS = { test: 'Test', zkouska: 'Zkouška', deadline: 'Deadline', jine: 'Termín' };
    const DAY_MS = 86400000;

    function parseDate(iso) {
        const [y, m, d] = iso.split('-').map(Number);
        return new Date(y, m - 1, d);
    }

    function today() {
        const t = new Date();
        return new Date(t.getFullYear(), t.getMonth(), t.getDate());
    }

    function fmtDate(date, withWeekday) {
        const opts = { day: 'numeric', month: 'numeric' };
        if (withWeekday) opts.weekday = 'short';
        return date.toLocaleDateString('cs-CZ', opts);
    }

    /* 1-based týden výuky; <1 před semestrem, >weeks po výuce */
    function weekOf(date) {
        const start = parseDate(window.SEMESTER.start);
        return Math.floor((date - start) / (7 * DAY_MS)) + 1;
    }

    function weekStart(week) {
        return new Date(parseDate(window.SEMESTER.start).getTime() + (week - 1) * 7 * DAY_MS);
    }

    /* "Př St 16:15–19:30 NB A (L)" → {kind, day, from, to, room, parity} */
    function parseSlot(str) {
        const m = str.match(/^(\S+)\s+(\S+)\s+(\d{1,2}:\d{2})[–-](\d{1,2}:\d{2})\s*(.*?)\s*(?:\((L|S)\))?$/);
        if (!m) return null;
        return {
            kind: m[1] === 'Př' ? 'Přednáška' : 'Cvičení',
            day: DAYS.indexOf(m[2]),
            from: m[3],
            to: m[4],
            room: m[5],
            parity: m[6] || null, // L = lichý týden, S = sudý týden
        };
    }

    function slotRunsInWeek(slot, week) {
        if (!slot.parity) return true;
        return slot.parity === 'L' ? week % 2 === 1 : week % 2 === 0;
    }

    function allEvents(courses) {
        const list = [];
        courses.forEach((c) => (c.events || []).forEach((e) => list.push({ ...e, course: c, dateObj: parseDate(e.date) })));
        return list.sort((a, b) => a.dateObj - b.dateObj);
    }

    function weekLabel(week) {
        const { weeks } = window.SEMESTER;
        if (week < 1) return `Před začátkem výuky (${1 - week} týd.)`;
        if (week > weeks) return 'Zkouškové období';
        return `${week}. týden výuky · ${week % 2 ? 'lichý' : 'sudý'}`;
    }

    function coursePath(course, base) {
        return `${base}courses/${course.slug}.html`;
    }

    function eventHtml(e, showCourse, base) {
        const past = e.dateObj < today();
        const course = showCourse
            ? `<a href="${coursePath(e.course, base)}" class="text-muted text-decoration-none">${e.course.name}</a> · `
            : '';
        return `<div class="event-item${past ? ' past' : ''}" style="--c:${e.course.color}">
            <span class="event-dot"></span>
            <span class="event-date">${fmtDate(e.dateObj, true)}</span>
            <span class="flex-grow-1">${course}${e.title}</span>
            <span class="event-type ${e.type}">${TYPE_LABELS[e.type] || e.type}</span>
        </div>`;
    }

    /* Dashboard: týdenní rozvrh (Po–Pá) */
    function renderTimetable(el, courses, base = '') {
        const now = today();
        const week = weekOf(now);
        const todayIdx = now.getDay() - 1;
        const cols = DAYS.map(() => []);
        courses.forEach((c) =>
            c.schedule.forEach((s) => {
                const slot = parseSlot(s);
                if (slot && slot.day >= 0) cols[slot.day].push({ slot, course: c });
            })
        );
        el.innerHTML = cols
            .map((items, i) => {
                items.sort((a, b) => a.slot.from.localeCompare(b.slot.from, 'cs', { numeric: true }));
                const slots = items
                    .map(({ slot, course }) => {
                        const off = week >= 1 && week <= window.SEMESTER.weeks && !slotRunsInWeek(slot, week);
                        const parity = slot.parity ? ` · ${slot.parity === 'L' ? 'liché' : 'sudé'} týdny` : '';
                        return `<a class="slot" href="${coursePath(course, base)}" style="--c:${course.color}${off ? ';opacity:.4' : ''}"
                                   title="${course.code}${off ? ' — tento týden neprobíhá' : ''}">
                            <div class="slot-time">${slot.from}–${slot.to}</div>
                            <div>${course.name}</div>
                            <div class="slot-room">${slot.kind} · ${slot.room}${parity}</div>
                        </a>`;
                    })
                    .join('');
                return `<div class="day-col${i === todayIdx ? ' today' : ''}"><h6>${DAYS[i]}</h6>${slots || '<div class="text-muted small">—</div>'}</div>`;
            })
            .join('');
    }

    /* Dashboard: termíny všech předmětů */
    function renderEvents(el, courses, base = '') {
        const events = allEvents(courses);
        el.innerHTML = events.length
            ? events.map((e) => eventHtml(e, true, base)).join('')
            : '<p class="text-muted small mb-0">Zatím žádné termíny — doplní se ze sylabů (<code>events</code> v courses.js).</p>';
    }

    /* Stránka předmětu: rozvrh + tabulka týdnů s tématy a termíny */
    function renderCourseHarmonogram(el, course) {
        const { weeks } = window.SEMESTER;
        const current = weekOf(today());
        const events = allEvents([course]);
        const rows = [];
        for (let w = 1; w <= weeks; w++) {
            const from = weekStart(w);
            const to = new Date(from.getTime() + 6 * DAY_MS);
            const topic = course.topics[w - 1];
            const topicCell = topic ? `<a href="#topic-${w}">${topic}</a>` : '<span class="text-muted">—</span>';
            const wEvents = events
                .filter((e) => e.dateObj >= from && e.dateObj <= to)
                .map((e) => `<span class="event-type ${e.type}">${TYPE_LABELS[e.type] || e.type}</span> ${e.title} (${fmtDate(e.dateObj)})`)
                .join('<br>');
            rows.push(`<tr class="week-row${w === current ? ' current' : ''}">
                <td>${w}.</td><td class="text-nowrap">${fmtDate(from)}–${fmtDate(to)}</td><td>${topicCell}</td><td>${wEvents}</td>
            </tr>`);
        }
        const after = events.filter((e) => weekOf(e.dateObj) > weeks).map((e) => eventHtml(e, false, ''));
        const slots = course.schedule.map((s) => `<li>${s.replace('(L)', '(liché týdny)').replace('(S)', '(sudé týdny)')}</li>`).join('');

        el.innerHTML = `
            <ul class="mb-3">${slots}</ul>
            <table class="table table-bordered summary-table mb-2">
                <thead><tr><th>Týden</th><th>Datum</th><th>Téma</th><th>Termíny</th></tr></thead>
                <tbody>${rows.join('')}</tbody>
            </table>
            ${after.length ? `<h4>Zkouškové období</h4>${after.join('')}` : ''}
            ${course.topics.length ? '' : '<p class="text-muted small mb-0">Témata a termíny se doplní ze sylabu.</p>'}`;
    }

    window.Harmonogram = { weekOf, weekLabel, renderTimetable, renderEvents, renderCourseHarmonogram };
})();
