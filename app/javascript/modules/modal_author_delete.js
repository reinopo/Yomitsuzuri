document.addEventListener("turbo:load", () => {
  const openButtons = document.querySelectorAll(".c-delete-modal__open--author");
  const modal = document.querySelector(".c-delete-modal--author");
  const closeBtn = document.querySelector(".c-delete-modal__close-btn--author");
  const form = document.querySelector(".c-delete-modal__form--author");

  // モーダルを開く
  openButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const id = btn.dataset.favoriteAuthorId;
      form.action = `/favorite_authors/${id}`;
      modal.classList.remove("is-hidden");
      modal.classList.add("is-shown-flex");
    });
  });

  // キャンセルボタンで閉じる
  if (closeBtn) {
    closeBtn.addEventListener("click", () => {
      modal.classList.remove("is-shown-flex");
      modal.classList.add("is-hidden");
    });
  }

  // モーダル外クリックで閉じる
  if (modal) {
    modal.addEventListener("click", (e) => {
      if (e.target === modal) {
        modal.classList.remove("is-shown-flex");
        modal.classList.add("is-hidden");
      }
    });
  }

  // ESCキーで閉じる
  if (modal && !modal.dataset.listenerAdded) {
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && modal.classList.contains("is-shown-flex")) {
        modal.classList.remove("is-shown-flex");
        modal.classList.add("is-hidden");
      }
    });
    modal.dataset.listenerAdded = "true";
  }
});
