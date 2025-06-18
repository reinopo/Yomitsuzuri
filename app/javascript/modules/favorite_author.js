// ------------------
// 著者お気に入り登録
// ------------------
document.addEventListener("turbo:load", () => {
  const links = document.querySelectorAll(".c-fav-author-modal__open");
  const modal = document.querySelector(".c-fav-author-modal");
  const authorName = document.getElementById("authorName");
  const authorIdInput = document.getElementById("modalAuthorId");
  const closeBtn = document.querySelector(".c-fav-author-modal__close");

  if (!modal || !authorName || !authorIdInput) return;

  const showModal = (name, id) => {
    authorName.textContent = name;
    authorIdInput.value = id;
    modal.classList.remove("is-hidden");
    modal.classList.add("is-shown-flex");
  };

  const hideModal = () => {
    modal.classList.remove("is-shown-flex");
    modal.classList.add("is-hidden");
  };

  links.forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();
      showModal(link.dataset.authorName, link.dataset.authorId);
    });
  });

  closeBtn?.addEventListener("click", hideModal);

  modal.addEventListener("click", (e) => {
    if (e.target === modal) hideModal();
  });

  // 既に登録済みなら remove → add の順で class 操作
  if (!modal.dataset.listenerAdded) {
    document.addEventListener("keydown", (e) => {
      if (e.key === "Escape" && modal.classList.contains("is-shown-flex")) {
        hideModal();
      }
    });
    modal.dataset.listenerAdded = "true"; // 重複登録を防ぐ
  }
});