// ----------------------
// 出版年バリデーション
// ----------------------
document.addEventListener("turbo:load", () => {
  const form = document.querySelector(".book-detail__published-date-form");
  if (!form) return;

  form.addEventListener("submit", (e) => {
    const year = document.querySelector("select[name='published_date_year']").value;
    const month = document.querySelector("select[name='published_date_month']").value;

    if (!year || !month) {
      e.preventDefault();
      alert("出版年と月は必須です");
    }
  });
});