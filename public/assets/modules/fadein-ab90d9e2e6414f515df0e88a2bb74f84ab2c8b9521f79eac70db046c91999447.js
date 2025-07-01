const setupObserver = () => {
  const targets = document.querySelectorAll(".js-fade-in");

  if (targets.length === 0) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-active");
        }
      });
    },
    { threshold: 0.3 }
  );

  targets.forEach((target) => observer.observe(target));
};

document.addEventListener("turbo:load", setupObserver);
document.addEventListener("DOMContentLoaded", setupObserver);
