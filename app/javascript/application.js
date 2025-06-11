// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
// import "controllers"

// 作品登録用モーダル
document.addEventListener("turbo:load", () => {
  console.log("モーダルJS読み込まれた（turbo:load）");

  const registerModal = document.querySelector(".register-modal");
  const registerModalCloseBtn = document.querySelector(".register-modal__close");
  const registerModalOpenBtns = document.querySelectorAll(".register-modal__open");
  const bookIdInput = document.querySelector(".register-modal input[name='isbn']");

  registerModalOpenBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      const bookId = btn.dataset.bookId;
      console.log("登録ボタンが押された:", bookId);
      bookIdInput.value = bookId;
      registerModal.style.display = "flex";
    });
  });

  if (registerModalCloseBtn) {
    registerModalCloseBtn.addEventListener("click", () => {
      registerModal.style.display = "none";
    });
  }
});
