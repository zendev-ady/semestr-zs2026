/* Zvýrazní aktivní odkaz v sidebar TOC při scrollování */
(function () {
    const links = document.querySelectorAll('.topic-nav .nav-link');
    const sections = Array.from(document.querySelectorAll('.topic-section'));

    if (!links.length || !sections.length) return;

    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    links.forEach((l) => l.classList.remove('active'));
                    const active = document.querySelector(
                        `.topic-nav a[href="#${entry.target.id}"]`
                    );
                    if (active) active.classList.add('active');
                }
            });
        },
        { rootMargin: '-56px 0px -60% 0px', threshold: 0 }
    );

    sections.forEach((s) => observer.observe(s));
})();
