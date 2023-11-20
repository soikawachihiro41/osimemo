(() => {
  // app/javascript/image_composite.js
  document.addEventListener("DOMContentLoaded", function() {
    const imageUpload = document.getElementById("image-upload");
    const overlayOptions = document.getElementById("overlay-options");
    const overlayInput = document.getElementById("overlay");
    const xOffsetInput = document.getElementById("x-offset");
    const yOffsetInput = document.getElementById("y-offset");
    const widthInput = document.getElementById("width");
    const heightInput = document.getElementById("height");
    const previewContainer = document.getElementById("image-preview-container");
    imageUpload.addEventListener("change", function(event) {
      const reader = new FileReader();
      reader.onload = function(e) {
        const preview = document.createElement("img");
        preview.src = e.target.result;
        preview.style.width = "800px";
        preview.style.height = "800px";
        previewContainer.innerHTML = "";
        previewContainer.appendChild(preview);
      };
      reader.readAsDataURL(event.target.files[0]);
    });
    let heartStampAdded = false;
    overlayOptions.addEventListener("change", function(event) {
      const previewImage = document.querySelector("#image-preview-container img");
      if (event.target.value === "heart_stamp") {
        if (!heartStampAdded && previewImage) {
          const heartStamp = document.createElement("img");
          heartStamp.src = "https://res.cloudinary.com/di6l3gth2/image/upload/v1700377582/bdae9b71a0f463997c342fb282c57426_t_utgw9l-%E3%83%8F%E3%83%BC%E3%83%88_fupvnh.png";
          heartStamp.style.position = "absolute";
          heartStamp.style.left = "50%";
          heartStamp.style.top = "50%";
          heartStamp.style.transform = "translate(-50%, -50%)";
          heartStamp.id = "heart-stamp";
          previewImage.parentNode.appendChild(heartStamp);
          heartStampAdded = true;
        } else if (heartStampAdded) {
          const heartStamp = document.getElementById("heart-stamp");
          if (heartStamp) {
            heartStamp.parentNode.removeChild(heartStamp);
          }
          heartStampAdded = false;
        }
      }
    });
    interact(".draggable").draggable({
      listeners: {
        move(event) {
          const target = event.target;
          const x = (parseFloat(target.getAttribute("data-x")) || 0) + event.dx;
          const y = (parseFloat(target.getAttribute("data-y")) || 0) + event.dy;
          target.style.transform = `translate(${x}px, ${y}px)`;
          target.setAttribute("data-x", x);
          target.setAttribute("data-y", y);
        }
      }
    });
    interact(".resizable").resizable({
      edges: { left: true, right: true, bottom: true, top: true },
      listeners: {
        move(event) {
          let { x, y } = event.target.dataset;
          x = (parseFloat(x) || 0) + event.deltaRect.left;
          y = (parseFloat(y) || 0) + event.deltaRect.top;
          Object.assign(event.target.style, {
            width: `${event.rect.width}px`,
            height: `${event.rect.height}px`,
            transform: `translate(${x}px, ${y}px)`
          });
          Object.assign(event.target.dataset, { x, y });
        }
      }
    });
  });
})();

