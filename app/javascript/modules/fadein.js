const setupObserver = () => {
  const targets = document.querySelectorAll(".home-about");

  if (targets.length === 0) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("home-about--active");
        }
      });
    },
    { threshold: 0.3 }
  );

  targets.forEach((target) => observer.observe(target));
};

// Turbo対応（通常のDOMContentLoadedに加えて、ページ遷移後も発火）
document.addEventListener("turbo:load", setupObserver);
document.addEventListener("DOMContentLoaded", setupObserver);