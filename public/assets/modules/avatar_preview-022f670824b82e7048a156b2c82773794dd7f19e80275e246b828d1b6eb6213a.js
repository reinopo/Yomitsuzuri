window.handleFileChange = function (event) {
  const fileInput = event.target;
  const file = fileInput.files[0];
  if (!file) return;

  const modal = document.querySelector(".avatar-preview-modal");
  const modalImage = document.querySelector(".avatar-preview-modal__img");
  const confirmBtn = document.querySelector(".avatar-preview-modal__button--confirm");
  const cancelBtn = document.querySelector(".avatar-preview-modal__button--cancel");

  modalImage.src = URL.createObjectURL(file);
  modal.classList.remove("is-hidden");

  confirmBtn.onclick = () => {
    modal.classList.add("is-hidden");
    fileInput.form.submit();
  };

  cancelBtn.onclick = () => {
    modal.classList.add("is-hidden");
    fileInput.value = "";
  };
};
