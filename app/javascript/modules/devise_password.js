document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".c-devise__toggle-password").forEach((btn) => {
    btn.addEventListener("click", () => {
      const targetId = btn.dataset.target;
      const input = document.getElementById(targetId);
      const eyeIcon = btn.querySelector(".c-devise__icon-eye");
      const eyeOffIcon = btn.querySelector(".c-devise__icon-eye-off");

      if (!input || !eyeIcon || !eyeOffIcon) return;

      if (input.type === "password") {
        input.type = "text";
        eyeIcon.classList.add("is-hidden");
        eyeOffIcon.classList.remove("is-hidden");
        btn.setAttribute("aria-label", "パスワードを非表示");
      } else {
        input.type = "password";
        eyeIcon.classList.remove("is-hidden");
        eyeOffIcon.classList.add("is-hidden");
        btn.setAttribute("aria-label", "パスワードを表示");
      }
    });
  });
});