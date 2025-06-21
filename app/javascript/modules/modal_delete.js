document.addEventListener("turbo:load", () => {
  const openButtons = document.querySelectorAll(".c-delete-book-modal__open");
  const modal = document.querySelector(".c-delete-book-modal");
  const closeBtn = document.querySelector(".c-delete-book-modal__close");
  const form = document.querySelector(".c-delete-book-modal__form");

  openButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const id = btn.dataset.readingLogId;
      form.action = `/reading_logs/${id}`;
      modal.classList.remove("is-hidden");
    });
  });

  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      modal.classList.add("is-hidden");
    });
  }
});