document.addEventListener("turbo:load", () => {
  const flashMessages = document.querySelectorAll(".c-flash");

  flashMessages.forEach((flash) => {
    // 閉じるボタンで削除
    const closeBtn = flash.querySelector(".c-flash__close");
    if (closeBtn) {
      closeBtn.addEventListener("click", () => {
        flash.remove();
      });
    }

    // 自動フェードアウト（3秒後）
    setTimeout(() => {
      flash.classList.add("is-fading-out");
      setTimeout(() => flash.remove(), 500);
    }, 3000);
  });
});