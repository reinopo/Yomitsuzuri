// ------------------
// 読書状況変更ボタン
// ------------------
document.addEventListener("turbo:load", () => {
  const editBtn = document.querySelector(".c-status-edit__icon");
  const form = document.querySelector(".c-status-edit__form");

  if (editBtn && form) {
    // トグル開閉処理
    editBtn.addEventListener("click", () => {
      const isShown = form.classList.contains("is-shown-flex");
      form.classList.toggle("is-shown-flex", !isShown);
      form.classList.toggle("is-hidden", isShown);
    });

    // 外クリックで閉じる
    document.addEventListener("click", (e) => {
      if (
        form.classList.contains("is-shown-flex") &&
        !form.contains(e.target) &&
        !editBtn.contains(e.target)
      ) {
        form.classList.remove("is-shown-flex");
        form.classList.add("is-hidden");
      }
    });

    // Escキーで閉じる
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && form.classList.contains("is-shown-flex")) {
        form.classList.remove("is-shown-flex");
        form.classList.add("is-hidden");
      }
    });
  }
});