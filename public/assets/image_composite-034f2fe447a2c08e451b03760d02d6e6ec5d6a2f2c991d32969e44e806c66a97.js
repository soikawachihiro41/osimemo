(() => {
  // app/javascript/image_composite.js
  document.addEventListener("DOMContentLoaded", function() {
    const overlayInput = document.getElementById("overlay");
    const xOffsetInput = document.getElementById("x-offset");
    const yOffsetInput = document.getElementById("y-offset");
    const widthInput = document.getElementById("width");
    const heightInput = document.getElementById("height");
    const previewContainer = document.getElementById("image-preview-container");
    let heartStampAdded = false;
    function toggleHeartStamp() {
      const previewImage = document.querySelector("#image-preview-container img");
      if (!heartStampAdded && previewImage) {
        const heartStamp = document.createElement("img");
        heartStamp.classList.add("draggable");
        heartStamp.src = "https://asset.cloudinary.com/di6l3gth2/e0db1116784963db62d2629e510f119a";
        heartStamp.style.position = "absolute";
        heartStamp.style.left = "50%";
        heartStamp.style.top = "50%";
        heartStamp.style.transform = "translate(-50%, -50%)";
        heartStamp.id = "heart-stamp";
        previewImage.parentNode.appendChild(heartStamp);
        heartStampAdded = true;
        overlayInput.value = "https://asset.cloudinary.com/di6l3gth2/e0db1116784963db62d2629e510f119a";
        widthInput.value = 100;
        heightInput.value = 100;
      } else if (heartStampAdded) {
        const heartStamp = document.getElementById("heart-stamp");
        heartStamp.parentNode.removeChild(heartStamp);
        heartStampAdded = false;
        overlayInput.value = "";
      }
    }
    document.getElementById("toggle-heart-stamp").addEventListener("click", toggleHeartStamp);
    interact(".draggable").draggable({
      listeners: {
        move(event) {
          const target = event.target;
          const x = (parseFloat(target.getAttribute("data-x")) || 0) + event.dx;
          const y = (parseFloat(target.getAttribute("data-y")) || 0) + event.dy;
          target.style.transform = `translate(${x}px, ${y}px)`;
          target.setAttribute("data-x", x);
          target.setAttribute("data-y", y);
          xOffsetInput.value = x;
          yOffsetInput.value = y;
        }
      }
    });
  });
})();

