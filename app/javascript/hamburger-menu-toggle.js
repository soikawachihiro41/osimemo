document.addEventListener("turbo:load", function () {
  const menuToggle = document.querySelector('.menu-toggle');
  const menu = document.querySelector('.full-screen-menu');
  const swapOff = document.querySelector('.swap-off');
  const swapOn = document.querySelector('.swap-on');

  menuToggle.addEventListener('change', function () {
    if (this.checked) {
      menu.classList.remove('hidden');
      setTimeout(() => menu.style.transform = 'translateY(0)', 10); // 一瞬の遅延を設ける
      swapOff.classList.add('hidden');
      swapOn.classList.remove('hidden');

      // 背景のスクロールを無効にする
      document.body.classList.add('overflow-hidden');
    } else {
      menu.style.transform = 'translateY(-100%)';
      setTimeout(() => menu.classList.add('hidden'), 500); // アニメーションの時間に合わせて非表示
      swapOff.classList.remove('hidden');
      swapOn.classList.add('hidden');

      // 背景のスクロールを有効にする
      document.body.classList.remove('overflow-hidden');
    }
  });
});
