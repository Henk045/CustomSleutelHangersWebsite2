const reveals = document.querySelectorAll(".reveal");

function revealOnScroll() {
    const windowHeight = window.innerHeight;
    reveals.forEach(el => {
        const top = el.getBoundingClientRect().top;
        if (top < windowHeight - 100) {
            el.classList.add("active");
        } else {
            el.classList.remove("active");
        }
    });
}

window.addEventListener("scroll", revealOnScroll);
revealOnScroll();


document.querySelectorAll(".dropdown").forEach(dropdown => {
    const trigger = dropdown.querySelector("a");
    const submenu = dropdown.querySelector(".dropdown-content");

    // Geen submenu? Dan GEEN dropdown-gedrag
    if (!submenu) return;

    trigger.addEventListener("click", e => {
        if (window.innerWidth <= 900) {

            // eerste klik → openen
            if (!dropdown.classList.contains("open")) {
                e.preventDefault();

                document.querySelectorAll(".dropdown.open").forEach(d => {
                    if (d !== dropdown) d.classList.remove("open");
                });

                dropdown.classList.add("open");
            }
            // tweede klik → normale navigatie
        }
    });
});

document.addEventListener("click", e => {
    if (!e.target.closest(".dropdown")) {
        document.querySelectorAll(".dropdown").forEach(d => {
            d.classList.remove("open");
        });
    }
});

