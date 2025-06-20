document.addEventListener("turbo:load", attachSearchValidation);
document.addEventListener("turbo:frame-load", attachSearchValidation);

function attachSearchValidation() {
  const forms = document.querySelectorAll(".c-search__form");

  forms.forEach((form) => {
    const input = form.querySelector(".c-search__text-field");
    const warning = form.querySelector(".c-search__warning");

    if (input && warning) {
      form.addEventListener("submit", (e) => {
        const query = input.value.trim();
        if (!query) {
          e.preventDefault();
          warning.classList.remove("is-hidden");

          setTimeout(() => {
            warning.classList.add("is-fading-out");
            setTimeout(() => warning.remove(), 500);
          }, 5000);
        } else {
          warning.classList.add("is-hidden");
        }
      });
    }
  });
}
