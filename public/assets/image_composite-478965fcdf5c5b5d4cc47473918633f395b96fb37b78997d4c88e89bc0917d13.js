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
        preview.style.maxWidth = "100%";
        previewContainer.innerHTML = "";
        previewContainer.appendChild(preview);
      };
      reader.readAsDataURL(event.target.files[0]);
    });
    overlayOptions.addEventListener("change", function(event) {
      if (event.target.value === "heart_stamp") {
        overlayInput.value = "\u30CF\u30FC\u30C8\u306E\u30B9\u30BF\u30F3\u30D7\u306EURL\u307E\u305F\u306F\u8B58\u5225\u5B50";
        const previewImage = document.querySelector("#image-preview-container img");
        if (previewImage) {
          const heartStamp = document.createElement("img");
          heartStamp.src = "\u30CF\u30FC\u30C8\u306E\u30B9\u30BF\u30F3\u30D7\u306EURL";
          heartStamp.style.position = "absolute";
          heartStamp.style.left = "50%";
          heartStamp.style.top = "50%";
          heartStamp.style.transform = "translate(-50%, -50%)";
          previewImage.parentNode.appendChild(heartStamp);
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

