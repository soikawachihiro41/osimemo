document.addEventListener('DOMContentLoaded', function () {
  // 既存の要素の取得
  const overlayInput = document.getElementById('overlay');
  const xOffsetInput = document.getElementById('x-offset');
  const yOffsetInput = document.getElementById('y-offset');
  const widthInput = document.getElementById('width');
  const heightInput = document.getElementById('height');
  const previewContainer = document.getElementById('image-preview-container');
  let heartStampAdded = false;

  // ハートスタンプのパスを取得
  const heartStampPath = document.getElementById('image-container').dataset.heartStampPath;

  // ハートのスタンプを追加/削除する関数
  function toggleHeartStamp() {
    const previewImage = document.querySelector('#image-preview-container img');
    if (!heartStampAdded && previewImage) {
      // ハートのスタンプを追加
      const heartStamp = document.createElement('img');
      heartStamp.classList.add('draggable');
      heartStamp.src = heartStampPath; // 修正されたパス
      heartStamp.style.position = 'absolute';
      heartStamp.style.left = '50%';
      heartStamp.style.top = '50%';
      heartStamp.style.transform = 'translate(-50%, -50%)';
      heartStamp.id = 'heart-stamp';
      previewImage.parentNode.appendChild(heartStamp);
      heartStampAdded = true;

      // オーバーレイのURLを設定
      overlayInput.value = heartStampPath;
      widthInput.value = 50; // ハートのスタンプの幅
      heightInput.value = 50; // ハートのスタンプの高さ
    } else if (heartStampAdded) {
      // ハートのスタンプを削除
      const heartStamp = document.getElementById('heart-stamp');
      heartStamp.parentNode.removeChild(heartStamp);
      heartStampAdded = false;

      // オーバーレイのURLをクリア
      overlayInput.value = '';
    }
  }

  // ハートのスタンプ追加/削除ボタンのイベントリスナー
  document.getElementById('toggle-heart-stamp').addEventListener('click', toggleHeartStamp);

  // interact.jsを使用してハートのスタンプをドラッグ可能にする
  interact('.draggable').draggable({
    listeners: {
      move(event) {
        const target = event.target;
        const x = (parseFloat(target.getAttribute('data-x')) || 0) + event.dx;
        const y = (parseFloat(target.getAttribute('data-y')) || 0) + event.dy;

        target.style.transform = `translate(${x}px, ${y}px)`;

        target.setAttribute('data-x', x);
        target.setAttribute('data-y', y);

        xOffsetInput.value = x;
        yOffsetInput.value = y;
      }
    }
  });
});
