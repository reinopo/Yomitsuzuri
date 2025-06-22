document.addEventListener("turbo:load", () => {
  const openButtons = document.querySelectorAll(".c-delete-book-modal__open");
  const modal = document.querySelector(".c-delete-book-modal");
  const closeBtn = document.querySelector(".c-delete-book-modal__btn--close");
  const form = document.querySelector(".c-delete-book-modal__form");

  const closeModal = () => {
    modal.classList.remove("is-shown-flex");
    modal.classList.add("is-hidden");
  };

  openButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const id = btn.dataset.readingLogId;
      form.action = `/reading_logs/${id}`;
      modal.classList.remove("is-hidden");
      modal.classList.add("is-shown-flex");
    });
  });

  if (closeBtn) {
    closeBtn.addEventListener("click", closeModal);
  }

  // モーダルの外側クリックで閉じる
  if (modal) {
    modal.addEventListener("click", (e) => {
      if (e.target === modal) closeModal();
    });
  }

  // Escキーで閉じる
  if (!modal.dataset.listenerAdded) {
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && modal.classList.contains("is-shown-flex")) {
        closeModal();
      }
    });
    modal.dataset.listenerAdded = "true";
  }
});