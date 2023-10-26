document.addEventListener("turbo:load", () => {
  const submitButton = document.querySelector('input[type="submit"]');
  const modal = document.getElementById("modal");
  const yesButton = document.getElementById("yesButton");
  const noButton = document.getElementById("noButton");
  const focusOnFacesField = document.getElementById("focus_on_faces");

  if (!submitButton || !modal || !yesButton || !noButton || !focusOnFacesField) {
    console.error("必要な要素が見つかりません");
    return;
  }

  submitButton.addEventListener("click", (event) => {
    event.preventDefault();
    modal.classList.remove("hidden");
  });

  yesButton.addEventListener("click", () => {
    focusOnFacesField.value = "true";
    modal.classList.add("hidden");
    submitButton.form.submit();
  });

  noButton.addEventListener("click", () => {
    focusOnFacesField.value = "false";
    modal.classList.add("hidden");
    submitButton.form.submit();
  });
});
