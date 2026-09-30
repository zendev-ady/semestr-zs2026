window.courseByCode = (code) => window.COURSES.find((c) => c.code === code);

/* Na stránce předmětu (<body data-course="KÓD">) nastaví akcentovou barvu. */
(function () {
    const code = document.body && document.body.dataset.course;
    const course = code && window.courseByCode(code);
    if (course) document.body.style.setProperty('--accent', course.color);
})();
