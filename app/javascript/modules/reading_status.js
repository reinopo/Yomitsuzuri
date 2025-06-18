// ------------------
// 読書状況変更ボタン
// ------------------
document.addEventListener("turbo:load", () => {
  const editBtn = document.querySelector(".book-detail__edit-icon");
  const form = document.querySelector(".book-detail__status-form");

  if (editBtn && form) {
    editBtn.addEventListener("click", () => {
      form.classList.toggle("book-detail__status-form--shown");
    });
  }
});