// ------------------
// 読書状況変更ボタン
// ------------------
document.addEventListener("turbo:load", () => {
  document.querySelectorAll("[data-modal-target]").forEach((btn) => {
    btn.addEventListener("click", () => {
      const targetId = btn.dataset.modalTarget;
      const modal = document.getElementById(targetId);
      modal.classList.remove("is-hidden");
      modal.classList.add("is-shown-flex");
    });
  });

  // 閉じる（overlay or close btn）
  document.querySelectorAll("[data-modal-close]").forEach((btn) => {
    btn.addEventListener("click", () => {
      btn.closest(".c-reading-status-modal").classList.remove("is-shown-flex");
      btn.closest(".c-reading-status-modal").classList.add("is-hidden");
    });
  });

  // モーダル外クリックで閉じる
  document.querySelectorAll(".c-reading-status-modal").forEach((modal) => {
    modal.addEventListener("click", (e) => {
      const content = modal.querySelector(".c-reading-status-modal__content");
      if (!content.contains(e.target)) {
        modal.classList.remove("is-shown-flex");
        modal.classList.add("is-hidden");
      }
    });
  });

  // Escキーでも閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      document.querySelectorAll(".c-reading-status-modal:not(.is-hidden)").forEach((modal) => {
        modal.classList.remove("is-shown-flex");
        modal.classList.add("is-hidden");
      });
    }
  });
});
