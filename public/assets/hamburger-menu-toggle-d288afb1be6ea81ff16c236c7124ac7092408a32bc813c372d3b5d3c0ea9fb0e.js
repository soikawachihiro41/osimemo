(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("DOMContentLoaded", function() {
    const menuTrigger = document.querySelector(".menu-toggle");
    const menu = document.querySelector(".full-screen-menu");
    const swapOff = document.querySelector(".swap-off");
    const swapOn = document.querySelector(".swap-on");
    menuTrigger.addEventListener("change", function() {
      if (this.checked) {
        menu.style.transform = "translateY(0)";
        menu.classList.remove("hidden");
        swapOff.classList.add("hidden");
        swapOn.classList.remove("hidden");
      } else {
        menu.style.transform = "translateY(-100%)";
        swapOff.classList.remove("hidden");
        swapOn.classList.add("hidden");
      }
    });
  });
})();

