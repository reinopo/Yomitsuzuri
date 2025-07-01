function toggleHeaderElements(hidden) {
  const targets = document.querySelectorAll('.js-search-toggle-target');
  targets.forEach((el) => {
    el.classList.toggle('is-hidden', hidden);
  });
}

document.addEventListener("turbo:load", attachSearchValidation);
document.addEventListener("turbo:frame-load", attachSearchValidation);

function attachSearchValidation() {
  const forms = document.querySelectorAll(".c-search__form");

  forms.forEach((form) => {
    const input = form.querySelector(".c-search__text-field");
    const warning = form.querySelector(".c-search__warning");
    const closeBtn = form.querySelector(".js-search-close");
    const mode = form.dataset.mode;

    if (input && warning) {
      if (mode === "header") {
        form.dataset.isOpen = "false";
      }

      function isSpView() {
        return window.innerWidth <= 767;
      }

      form.addEventListener("submit", (e) => {
        const query = input.value.trim();

        if (mode === "header" && isSpView()) {
          const isOpen = form.dataset.isOpen === "true";

          if (!isOpen) {
            e.preventDefault();
            input.classList.remove("is-closed");
            closeBtn.classList.remove("is-hidden");
            document.querySelector('.header')?.classList.add('is-search-only');
            toggleHeaderElements(true);
            input.focus();
            form.dataset.isOpen = "true";
            return;
          }
        }

        const inlineMessage = form.querySelector(".c-search__inline-message");

        if (!query) {
          e.preventDefault();

          if (mode === "header" && isSpView()) {
            // ヘッダー（SP/TAB）用：input内に表示
            inlineMessage?.classList.remove("is-hidden");

            setTimeout(() => {
              inlineMessage?.classList.add("is-fading-out");
              setTimeout(() => inlineMessage?.remove(), 500);
            }, 3000);
          } else {
            // 通常：フォーム左側にメッセージ
            warning.classList.remove("is-hidden");

            setTimeout(() => {
              warning.classList.add("is-fading-out");
              setTimeout(() => warning.remove(), 500);
            }, 5000);
          }
        }
      });

      if (closeBtn) {
        closeBtn.addEventListener("click", () => {
          input.classList.add("is-closed");
          closeBtn.classList.add("is-hidden");
          document.querySelector('.header')?.classList.remove('is-search-only');
          toggleHeaderElements(false);
          form.dataset.isOpen = "false";
        });
      }
    }
  });

  // ① ESCキーで閉じる
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") {
      forms.forEach((form) => {
        if (form.dataset.mode === "header" && form.dataset.isOpen === "true") {
          const input = form.querySelector(".c-search__text-field");
          const closeBtn = form.querySelector(".js-search-close");

          input.classList.add("is-closed");
          closeBtn?.classList.add("is-hidden");
          document.querySelector('.header')?.classList.remove('is-search-only');
          toggleHeaderElements(false);
          form.dataset.isOpen = "false";
        }
      });
    }
  });

  // ② フォーム外クリックで閉じる
  document.addEventListener("click", (e) => {
    forms.forEach((form) => {
      if (form.dataset.mode === "header" && form.dataset.isOpen === "true") {
        if (!form.contains(e.target)) {
          const input = form.querySelector(".c-search__text-field");
          const closeBtn = form.querySelector(".js-search-close");

          input.classList.add("is-closed");
          closeBtn?.classList.add("is-hidden");
          document.querySelector('.header')?.classList.remove('is-search-only');
          toggleHeaderElements(false);
          form.dataset.isOpen = "false";
        }
      }
    });
  });
};
