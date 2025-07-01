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
      registerModal.classList.remove("is-hidden");
      registerModal.classList.add("is-shown-flex");

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
      registerModal.classList.remove("is-shown-flex");
      registerModal.classList.add("is-hidden");
    });
  }

  // モーダルの外側クリックで閉じる
  if (registerModal) {
    registerModal.addEventListener("click", (e) => {
      if (e.target === registerModal) {
        registerModal.classList.remove("is-shown-flex");
        registerModal.classList.add("is-hidden");
      }
    });
  }

  // Escキーで閉じる
  if (registerModal && !registerModal.dataset.listenerAdded) {
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && registerModal.classList.contains("is-shown-flex")) {
        registerModal.classList.remove("is-shown-flex");
        registerModal.classList.add("is-hidden");
      }
    });
    registerModal.dataset.listenerAdded = "true";
  }
});
