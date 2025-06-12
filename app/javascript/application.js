// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
// import "controllers"

// ------------------
// 作品登録用モーダル
// ------------------
document.addEventListener("turbo:load", () => {
  console.log("モーダルJS読み込まれた（turbo:load）");

  const registerModal = document.querySelector(".register-modal");
  const registerModalCloseBtn = document.querySelector(".register-modal__close");
  const registerModalOpenBtns = document.querySelectorAll(".register-modal__open");
  const bookIdInput = document.querySelector(".register-modal input[name='isbn']");

  // モーダル内の表示要素
  const bookImageTag = document.querySelector(".register-modal__book-image");
  const bookTitleTag = document.querySelector(".register-modal__book-title");
  const bookAuthorsTag = document.querySelector(".register-modal__book-authors");

  registerModalOpenBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      const bookId = btn.dataset.bookId;
      console.log("登録ボタンが押された:", bookId);
      bookIdInput.value = bookId;
      registerModal.style.display = "flex";

      // data属性から本の情報を取得してモーダルに反映
      const bookTitle = btn.dataset.bookTitle;
      const bookAuthors = btn.dataset.bookAuthors;
      const bookImage = btn.dataset.bookImage;

      if (bookImageTag && bookTitleTag && bookAuthorsTag) {
        bookImageTag.src = bookImage;
        bookTitleTag.textContent = bookTitle;
        bookAuthorsTag.textContent = bookAuthors;
      }
    });
  });

  if (registerModalCloseBtn) {
    registerModalCloseBtn.addEventListener("click", () => {
      registerModal.style.display = "none";
    });
  }

  // モーダルの外側クリックで閉じる
  registerModal.addEventListener("click", (e) => {
    if (e.target === registerModal) {
      registerModal.style.display = "none";
    }
  });

  // Escキーで閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && registerModal.style.display === "flex") {
      registerModal.style.display = "none";
    }
  });
});
