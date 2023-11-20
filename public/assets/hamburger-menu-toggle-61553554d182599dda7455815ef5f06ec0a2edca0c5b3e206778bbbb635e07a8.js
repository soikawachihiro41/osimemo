(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("DOMContentLoaded", function() {
    const menuTrigger = document.querySelector('.menu-trigger input[type="checkbox"]');
    const menu = document.querySelector(".full-screen-menu");
    const swapOff = document.querySelector(".swap-off");
    const swapOn = document.querySelector(".swap-on");
    menuTrigger.addEventListener("change", function() {
      if (this.checked) {
        menu.style.transform = "translateY(0)";
        menu.classList.remove("hidden");
        swapOff.style.display = "none";
        swapOn.style.display = "block";
      } else {
        menu.style.transform = "translateY(-100%)";
        swapOff.style.display = "block";
        swapOn.style.display = "none";
      }
    });
  });
})();

