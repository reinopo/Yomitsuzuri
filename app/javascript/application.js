// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
// import "controllers"

// ----------------
// 作品登録モーダル
// ----------------
document.addEventListener("turbo:load", () => {
  console.log("モーダルJSが読み込まれた");

  const registerModal = document.querySelector(".register-modal");
  const registerModalCloseBtn = document.querySelector(".register-modal__close");
  const registerModalOpenBtns = document.querySelectorAll(".register-modal__open");
  // モーダルフォーム内にある hidden field (name='isbn')
  const bookIdInput = document.querySelector(".register-modal input[name='isbn']");

  // モーダル内の要素（画像・タイトル・著者）のHTMLタグを取得
  const bookImageTag = document.querySelector(".register-modal__book-image");
  const bookTitleTag = document.querySelector(".register-modal__book-title");
  const bookAuthorsTag = document.querySelector(".register-modal__book-authors");

  registerModalOpenBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      // ボタンに埋め込んだdata-book-idの値（選択された本のisbn）をbookIdに代入
      const bookId = btn.dataset.bookId;
      console.log("登録ボタンが押された:", bookId);
      // モーダルフォーム内にある hidden field (name='isbn') に、上で取得した isbn を代入
      bookIdInput.value = bookId;
      registerModal.style.display = "flex";

      // ボタンに埋め込んだ本の情報（data属性）を取得
      const bookTitle = btn.dataset.bookTitle;
      const bookAuthors = btn.dataset.bookAuthors;
      const bookImage = btn.dataset.bookImage;

      // 各要素が全て存在する場合のみ、内容をモーダルに反映
      if (bookImageTag && bookTitleTag && bookAuthorsTag) {
        bookImageTag.src = bookImage;
        bookTitleTag.textContent = bookTitle;
        bookAuthorsTag.textContent = bookAuthors;
      }

      // hidden_field にも本の情報をセット
      document.querySelector("input[name='book_title']").value = bookTitle;
      document.querySelector("input[name='book_authors']").value = bookAuthors;
      document.querySelector("input[name='book_image_url']").value = bookImage;
      document.querySelector("input[name='book_google_id']").value = btn.dataset.bookGoogleId || "";
      document.querySelector("input[name='book_published_date']").value = btn.dataset.bookPublishedDate || "";
      document.querySelector("input[name='book_description']").value = btn.dataset.bookDescription || "";
    });
  });

  if (registerModalCloseBtn) {
    registerModalCloseBtn.addEventListener("click", () => {
      registerModal.style.display = "none";
    });
  }

  // モーダルの外側クリックでモーダルを閉じる
  if (registerModal) {
    registerModal.addEventListener("click", (e) => {
      if (e.target === registerModal) {
        registerModal.style.display = "none";
      }
    });
  }

  // Escキーでモーダルを閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && registerModal.style.display === "flex") {
      registerModal.style.display = "none";
    }
  });
});