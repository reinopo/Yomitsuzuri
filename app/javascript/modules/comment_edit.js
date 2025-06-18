// --------------------
// コメント編集フォーム
// --------------------
document.addEventListener("turbo:load", () => {
  const editBtn = document.querySelector(".book-detail__edit-btn");
  const form = document.querySelector(".book-detail__comment-form");

  if (editBtn && form) {
    editBtn.addEventListener("click", () => {
      form.style.display = form.style.display === "block" ? "none" : "block";
    });

    // フォームの外側をクリックで閉じる
    document.addEventListener("click", (e) => {
      if (
        form.style.display === "block" &&
        !form.contains(e.target) &&
        !editBtn.contains(e.target)
      ) {
        form.style.display = "none";
      }
    });

    // Escキーで閉じる
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && form.style.display === "block") {
        form.style.display = "none";
      }
    });
  }
});