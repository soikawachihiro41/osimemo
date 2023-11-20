(() => {
  // app/javascript/image_upload.js
  document.addEventListener("DOMContentLoaded", function() {
    const imageInput = document.getElementById("profile_image_input");
    const imagePreview = document.getElementById("profile_image_preview");
    if (imageInput && imagePreview) {
      imageInput.addEventListener("change", function() {
        const file = this.files[0];
        if (file) {
          const reader = new FileReader();
          reader.addEventListener("load", function() {
            imagePreview.setAttribute("src", this.result);
          });
          reader.readAsDataURL(file);
        }
      });
    } else {
      console.error("Required elements are not found in the DOM.");
    }
  });
})();

