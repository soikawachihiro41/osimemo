(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("DOMContentLoaded", function() {
    const menuTrigger = document.querySelector('.menu-trigger input[type="checkbox"]');
    const menu = document.querySelector(".full-screen-menu");
    menuTrigger.addEventListener("change", function() {
      if (this.checked) {
        menu.style.transform = "translateY(0)";
        menu.classList.remove("hidden");
      } else {
        menu.style.transform = "translateY(-100%)";
      }
    });
  });
})();

