// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
Rails.start()

import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("DOMContentLoaded", () => {
  const modal = document.getElementById("register-modal");
  const closeBtn = document.getElementById("close-register-modal");
  const openButtons = document.querySelectorAll(".open-register-modal");
  const bookIdInput = document.querySelector("#register-modal input[name='book_id']");

  openButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const bookId = btn.dataset.bookId;
      bookIdInput.value = bookId;
      modal.style.display = "block";
    });
  });

  closeBtn.addEventListener("click", () => {
    modal.style.display = "none";
  });
});
