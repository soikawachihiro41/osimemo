(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("DOMContentLoaded", function() {
    const menuToggle = document.querySelector(".menu-toggle");
    const menu = document.querySelector(".full-screen-menu");
    const swapOff = document.querySelector(".swap-off");
    const swapOn = document.querySelector(".swap-on");
    menuToggle.addEventListener("change", function() {
      if (this.checked) {
        menu.classList.remove("hidden");
        setTimeout(() => menu.style.transform = "translateY(0)", 10);
        swapOff.classList.add("hidden");
        swapOn.classList.remove("hidden");
      } else {
        menu.style.transform = "translateY(-100%)";
        setTimeout(() => menu.classList.add("hidden"), 500);
        swapOff.classList.remove("hidden");
        swapOn.classList.add("hidden");
      }
    });
  });
})();

