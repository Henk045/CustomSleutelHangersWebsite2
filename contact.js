function showContactPopup(message, isSuccess) {
    const existingPopup = document.querySelector('.contact-popup-overlay');
    if (existingPopup) {
        existingPopup.remove();
    }

    const overlay = document.createElement('div');
    overlay.className = 'contact-popup-overlay';

    const popup = document.createElement('div');
    popup.className = 'contact-popup';
    popup.setAttribute('role', 'dialog');
    popup.setAttribute('aria-modal', 'true');
    popup.setAttribute('aria-live', 'polite');

    const icon = isSuccess ? '✅' : '⚠️';
    const title = isSuccess ? 'Bericht verzonden' : 'Er ging iets mis';

    popup.innerHTML = `
        <div class="contact-popup-icon">${icon}</div>
        <h3>${title}</h3>
        <p>${message}</p>
        <button type="button" class="contact-popup-close">Sluiten</button>
    `;

    overlay.appendChild(popup);
    document.body.appendChild(overlay);
    document.body.classList.add('modal-open');

    const closePopup = () => {
        overlay.remove();
        document.body.classList.remove('modal-open');
    };

    overlay.addEventListener('click', (event) => {
        if (event.target === overlay) {
            closePopup();
        }
    });

    popup.querySelector('.contact-popup-close').addEventListener('click', closePopup);

    document.addEventListener('keydown', function handleEscape(event) {
        if (event.key === 'Escape') {
            closePopup();
            document.removeEventListener('keydown', handleEscape);
        }
    });
}

document.getElementById("contactForm").addEventListener("submit", async function (e) {
    e.preventDefault();

    const status = document.getElementById("statusMessage");
    const button = document.getElementById("buttonText");

    button.textContent = "Versturen...";
    status.innerHTML = "";

    const formData = {
        access_key: document.getElementById("access_key").value,
        name: document.getElementById("name").value,
        email: document.getElementById("email").value,
        subject: document.getElementById("subject").value,
        message: document.getElementById("message").value
    };

    try {
        const response = await fetch("https://api.web3forms.com/submit", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Accept: "application/json"
            },
            body: JSON.stringify(formData)
        });

        const result = await response.json();

        if (result.success) {
            showContactPopup('Uw bericht is succesvol verzonden. We nemen zo snel mogelijk contact met u op.', true);
            document.getElementById("contactForm").reset();
        } else {
            showContactPopup('Er is iets misgegaan. Probeer het later opnieuw of neem rechtstreeks contact met ons op.', false);
        }

    } catch (error) {
        showContactPopup('Kon geen verbinding maken met de server. Controleer uw internetverbinding en probeer het opnieuw.', false);
    }

    button.textContent = "Verstuur";
});