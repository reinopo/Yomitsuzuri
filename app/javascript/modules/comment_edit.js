// --------------------
// コメント編集フォーム
// --------------------
document.addEventListener("turbo:load", () => {
  const editBtn = document.querySelector(".book-detail__edit-btn");
  const form = document.querySelector(".book-detail__comment-form");

  if (!editBtn || !form) return;

  const toggleForm = () => {
    form.classList.toggle("is-hidden");
    form.classList.toggle("is-shown-block");
  };

  const closeForm = () => {
    form.classList.remove("is-shown-block");
    form.classList.add("is-hidden");
  };

  // ボタンクリックで表示切り替え
  editBtn.addEventListener("click", (e) => {
    e.stopPropagation(); // 外側クリックのトリガー防止
    toggleForm();
  });

  // 外側クリックで非表示
  document.addEventListener("click", (e) => {
    if (
      form.classList.contains("is-shown-block") &&
      !form.contains(e.target) &&
      !editBtn.contains(e.target)
    ) {
      closeForm();
    }
  });

  // Escキーで非表示
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && form.classList.contains("is-shown-block")) {
      closeForm();
    }
  });
});