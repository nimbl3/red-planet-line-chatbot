// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

window.onload = function (e) {
  liff.init(
      data => {
        // Now you can call LIFF API
        const userId = data.context.userId;

        console.log(userId);
      },
      err => {
        // LIFF initialization failed
      }
  );
};
