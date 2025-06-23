document.addEventListener("turbo:load", () => {
  // // フラッシュ閉じる
  // document.querySelectorAll(".c-flash").forEach((flash) => {
  //   const closeBtn = flash.querySelector(".c-flash__close");
  //   if (closeBtn) {
  //     closeBtn.addEventListener("click", () => flash.remove());
  //   }

  //   setTimeout(() => {
  //     flash.classList.add("is-fading-out");
  //     setTimeout(() => flash.remove(), 500);
  //   }, 3000);
  // });

  // プロフィール更新のフラッシュ
  const profileFlash = document.querySelector(".c-flash");
  if (profileFlash) {
    setTimeout(() => {
      profileFlash.classList.add("is-fading-out");
      setTimeout(() => profileFlash.remove(), 500);
    }, 3000);
  }
});