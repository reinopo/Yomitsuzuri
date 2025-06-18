// ------------------
// 著者お気に入り登録
// ------------------
document.addEventListener("turbo:load", () => {
  const links = document.querySelectorAll(".c-fav-author-modal__open");
  const modal = document.querySelector(".c-fav-author-modal");
  const authorName = document.getElementById("authorName");
  const authorIdInput = document.getElementById("modalAuthorId");

  links.forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      authorName.textContent = link.dataset.authorName;
      authorIdInput.value = link.dataset.authorId;
      modal.style.display = "flex";
    });
  });

  document.querySelector(".c-fav-author-modal__close")?.addEventListener("click", () => {
    modal.style.display = "none";
  });

  // モーダルの外側クリックでモーダルを閉じる
  if (modal) {
    modal.addEventListener("click", (e) => {
      if (e.target === modal) {
        modal.style.display = "none";
      }
    });
  }

  // Escキーでモーダルを閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && modal.style.display === "flex") {
      modal.style.display = "none";
    }
  });
});