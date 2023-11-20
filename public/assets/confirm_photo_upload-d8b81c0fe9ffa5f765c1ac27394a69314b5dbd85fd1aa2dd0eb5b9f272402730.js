(() => {
  // app/javascript/confirm_photo_upload.js
  document.addEventListener("DOMContentLoaded", () => {
    const submitButton = document.querySelector('input[type="submit"]');
    const focusOnFacesField = document.getElementById("focus_on_faces");
    if (submitButton && focusOnFacesField) {
      submitButton.addEventListener("click", (event) => {
        event.preventDefault();
        const userChoice = confirm("\u9854\u306B\u30D5\u30A9\u30FC\u30AB\u30B9\u3057\u307E\u3059\u304B\uFF1F\u300COK\u300D\u3092\u9078\u629E\u3059\u308B\u3068\u30D5\u30A9\u30FC\u30AB\u30B9\u3057\u3001\u300C\u30AD\u30E3\u30F3\u30BB\u30EB\u300D\u3092\u9078\u629E\u3059\u308B\u3068\u30D5\u30A9\u30FC\u30AB\u30B9\u3057\u307E\u305B\u3093\u3002");
        focusOnFacesField.value = userChoice;
        event.target.form.submit();
      });
    } else {
      console.error("\u8981\u7D20\u304C\u898B\u3064\u304B\u308A\u307E\u305B\u3093");
    }
  });
})();

