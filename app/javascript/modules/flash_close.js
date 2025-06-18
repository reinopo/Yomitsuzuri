// ----------------------
// フラッシュ閉じるボタン
// ----------------------
document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".c-flash__close").forEach((btn) => {
    btn.addEventListener("click", () => {
      btn.closest(".c-flash").remove();
    });
  });
});