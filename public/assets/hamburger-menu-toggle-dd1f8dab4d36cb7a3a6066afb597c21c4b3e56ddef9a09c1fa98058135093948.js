(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("DOMContentLoaded", function() {
    const menuTrigger = document.querySelector(".menu-trigger");
    const fullScreenMenu = document.querySelector(".full-screen-menu");
    menuTrigger.addEventListener("click", function() {
      fullScreenMenu.classList.toggle("hidden");
    });
  });
})();

