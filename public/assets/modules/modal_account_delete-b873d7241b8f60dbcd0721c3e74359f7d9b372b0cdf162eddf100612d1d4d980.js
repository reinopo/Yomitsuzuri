document.addEventListener("turbo:load", () => {
  const openBtn = document.querySelector(".c-delete-modal__open--account");
  const modal = document.querySelector(".c-delete-modal--account");
  const closeBtn = document.querySelector(".c-delete-modal__close-btn--account");

  if (openBtn && modal) {
    openBtn.addEventListener("click", () => {
      modal.classList.remove("is-hidden");
      modal.classList.add("is-shown-flex");
    });
  }

  if (closeBtn && modal) {
    closeBtn.addEventListener("click", () => {
      modal.classList.remove("is-shown-flex");
      modal.classList.add("is-hidden");
    });
  }

  // 外側クリックで閉じる
  if (modal) {
    modal.addEventListener("click", (e) => {
      if (e.target === modal) {
        modal.classList.remove("is-shown-flex");
        modal.classList.add("is-hidden");
      }
    });
  }

  // Escキーで閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && modal.classList.contains("is-shown-flex")) {
      modal.classList.remove("is-shown-flex");
      modal.classList.add("is-hidden");
    }
  });
});
