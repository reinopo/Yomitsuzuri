// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
// import "controllers"

// ----------------
// 作品登録モーダル
// ----------------
document.addEventListener("turbo:load", () => {
  console.log("モーダルJSが読み込まれた");

  const registerModal = document.querySelector(".c-register-modal");
  const registerModalCloseBtn = document.querySelector(".c-register-modal__close");
  const registerModalOpenBtns = document.querySelectorAll(".c-register-modal__open");
  // モーダルフォーム内にある hidden field (name='book_google_id')
  const bookIdInput = document.querySelector(".c-register-modal input[name='book_google_id']");

  // モーダル内の要素（画像・タイトル・著者）のHTMLタグを取得
  const bookImageTag = document.querySelector(".c-register-modal__book-image");
  const bookTitleTag = document.querySelector(".c-register-modal__book-title");
  const bookAuthorsTag = document.querySelector(".c-register-modal__book-authors");

  registerModalOpenBtns.forEach(btn => {
    btn.addEventListener("click", () => {
      // ボタンに埋め込んだdata-book-google-idの値（選択された本のgoogle_id）をbookIdに代入
      const bookId = btn.dataset.bookGoogleId;
      console.log("登録ボタンが押された:", bookId);
      // モーダルフォーム内にある hidden field (name='book_google_id') に、上で取得した book_google_id を代入
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
      document.querySelector("input[name='book_google_id']").value = bookId;
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

// ------------------------
// コメント編集フォーム表示
// ------------------------
document.addEventListener("turbo:load", () => {
  const editBtn = document.querySelector(".book-detail__edit-btn");
  const form = document.querySelector(".book-detail__comment-form");

  if (editBtn && form) {
    editBtn.addEventListener("click", () => {
      form.style.display = form.style.display === "block" ? "none" : "block";
    });
  }
});

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