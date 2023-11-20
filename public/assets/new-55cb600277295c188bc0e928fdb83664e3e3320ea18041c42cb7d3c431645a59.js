(() => {
  // app/javascript/new.js
  document.addEventListener("turbo:load", () => {
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute("content");
    const LIFF_ID = gon.user_key;
    liff.init({
      liffId: LIFF_ID,
      withLoginOnExternalBrowser: true
    });
    liff.ready.then(() => {
      if (!liff.isLoggedIn()) {
        liff.login();
      } else {
        liff.getProfile().then((profile) => {
          const idToken = liff.getIDToken();
          const name = profile.displayName;
          const body = `idToken=${idToken}&name=${name}`;
          const request = new Request("/users", {
            headers: {
              "Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
              "X-CSRF-Token": token
            },
            method: "POST",
            body
          });
          fetch(request).then((response) => response.json()).then((data) => {
            data_id = data;
          }).then(() => {
            window.location = "/after_login";
          }).catch((error) => {
            console.error("\u30A8\u30E9\u30FC:", error);
          });
        });
      }
    });
  });
})();

