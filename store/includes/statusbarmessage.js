
<!--   hide this script from non-javascript-enabled browsers
// function that displays status bar message
var showMsg = navigator.userAgent != "Mozilla/4.0 (compatible; MSIE 4.0; Mac_PowerPC)";
function dmim(msgStr) {
  document.returnValue = false;
  if (showMsg) { 
    window.status = msgStr;
    document.returnValue = true;
  }
}
// stop hiding -->
