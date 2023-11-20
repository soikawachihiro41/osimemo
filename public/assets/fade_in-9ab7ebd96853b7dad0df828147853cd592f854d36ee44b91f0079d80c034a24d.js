(() => {
  // app/javascript/fade_in.js
  function setUpFadeIn() {
    let targets = document.querySelectorAll(".scroll-fade-in");
    let fadeInObserver = new IntersectionObserver((entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.remove("opacity-0");
          entry.target.classList.add("opacity-100", "transition-opacity", "duration-1000", "ease-out");
          observer.unobserve(entry.target);
        }
      });
    });
    targets.forEach((target) => {
      fadeInObserver.observe(target);
    });
  }
  document.addEventListener("DOMContentLoaded", setUpFadeIn);
  document.addEventListener("turbolinks:load", setUpFadeIn);
})();

