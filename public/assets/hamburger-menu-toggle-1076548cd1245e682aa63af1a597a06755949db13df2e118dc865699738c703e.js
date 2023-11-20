(() => {
  // app/javascript/hamburger-menu-toggle.js
  document.addEventListener("turbo:load", function() {
    const menuToggle = document.querySelector(".menu-toggle");
    const menu = document.querySelector(".full-screen-menu");
    const swapOff = document.querySelector(".swap-off");
    const swapOn = document.querySelector(".swap-on");
    menuToggle.addEventListener("change", function() {
      if (this.checked) {
        menu.classList.remove("hidden");
        menu.classList.add("z-10000");
        setTimeout(() => menu.style.transform = "translateY(0)", 10);
        swapOff.classList.add("hidden");
        swapOn.classList.remove("hidden");
        document.body.classList.add("overflow-hidden");
      } else {
        menu.style.transform = "translateY(-100%)";
        setTimeout(() => {
          menu.classList.add("hidden");
          menu.classList.remove("z-10000");
        }, 500);
        swapOff.classList.remove("hidden");
        swapOn.classList.add("hidden");
        document.body.classList.remove("overflow-hidden");
      }
    });
  });
})();

