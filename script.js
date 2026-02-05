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


document.querySelectorAll(".dropdown > a").forEach(trigger => {
    trigger.addEventListener("click", e => {
        const dropdown = trigger.parentElement;

        if (window.innerWidth <= 900) {
            e.preventDefault();

            document.querySelectorAll(".dropdown").forEach(d => {
                if (d !== dropdown) d.classList.remove("open");
            });

            dropdown.classList.toggle("open");
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
