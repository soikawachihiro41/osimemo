(() => {
  // app/javascript/confirm_photo_upload.js
  var setupEventListeners = () => {
    const submitButton = document.querySelector('input[type="submit"]');
    const modal = document.getElementById("modal");
    const yesButton = document.getElementById("yesButton");
    const noButton = document.getElementById("noButton");
    const focusOnFacesField = document.getElementById("focus_on_faces");
    if (submitButton && modal && yesButton && noButton && focusOnFacesField) {
      submitButton.addEventListener("click", (event) => {
        event.preventDefault();
        modal.classList.remove("hidden");
      });
      yesButton.addEventListener("click", () => {
        focusOnFacesField.value = true;
        modal.classList.add("hidden");
        submitButton.form.submit();
      });
      noButton.addEventListener("click", () => {
        focusOnFacesField.value = false;
        modal.classList.add("hidden");
        submitButton.form.submit();
      });
    } else {
      console.error("\u8981\u7D20\u304C\u898B\u3064\u304B\u308A\u307E\u305B\u3093");
    }
  };
  document.addEventListener("DOMContentLoaded", setupEventListeners);
  document.addEventListener("turbo:load", setupEventListeners);
})();

