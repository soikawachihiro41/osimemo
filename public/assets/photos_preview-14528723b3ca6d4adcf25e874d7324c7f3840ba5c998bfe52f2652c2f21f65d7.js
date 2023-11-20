(() => {
  // app/javascript/photos_preview.js
  function displayImagePreview(input) {
    const file = input.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(event) {
        const preview = document.getElementById("image-preview");
        preview.src = event.target.result;
        preview.style.display = "block";
      };
      reader.readAsDataURL(file);
    }
  }
  window.displayImagePreview = displayImagePreview;
})();

