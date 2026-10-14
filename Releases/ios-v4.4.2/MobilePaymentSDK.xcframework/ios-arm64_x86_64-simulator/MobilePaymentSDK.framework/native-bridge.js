// Click to Pay - Native Bridge (Android/iOS).
// Wraps Mastercard Click2Pay JS calls and relays results to native.
// This file is shared verbatim between iOS and Android — keep both copies
// in sync. The same `platform` argument selects the right native bridge at
// runtime (window.webkit on iOS, JSBridge on Android).
// Verbose request/response logging is gated by window.CTP_DEBUG, which the
// native host injects via index.html (Android: BuildConfig.DEBUG_MODE;
// iOS: SDKRuntime.configuration.debugLoggingEnabled). Release builds set
// it to false so PAN-derived fields, encrypted card data, and consumer
// identity don't land in logs.

var click2payInstance = null;
var lastNativePlatform = 'android';

function ctpLog(msg) {
  if (window.CTP_DEBUG) console.log('[CTP] ' + msg);
}

function ensureInstance() {
  if (click2payInstance) return click2payInstance;
  if (typeof Click2Pay === 'undefined') {
    throw new Error('Click2Pay library not loaded');
  }
  click2payInstance = new Click2Pay();
  return click2payInstance;
}

function sendMessageToNative(platform, payload, methodName) {
  var json = typeof payload === 'string' ? payload : JSON.stringify(payload);
  if (platform === 'ios') {
    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.jsMessageHandler) {
      window.webkit.messageHandlers.jsMessageHandler.postMessage(JSON.stringify({ method: methodName, response: json }));
    }
  } else {
    if (typeof JSBridge !== 'undefined' && JSBridge.showMessageInNative) {
      JSBridge.showMessageInNative(json, methodName);
    }
  }
}

// Wires the Mastercard SRC promise result back to native, scrubbing payloads.
function relay(platform, methodName, promise, withDcf) {
  promise.then(
    function (value) {
      ctpLog(methodName + ' response: ' + JSON.stringify(value));
      if (withDcf) closeDcfWindow();
      sendMessageToNative(platform, { status: 'success', data: value }, methodName);
    },
    function (error) {
      ctpLog(methodName + ' error: ' + JSON.stringify(serializeError(error)));
      if (withDcf) closeDcfWindow();
      sendMessageToNative(platform, { status: 'error', data: serializeError(error) }, methodName);
    }
  );
}

// Shows the DCF iframe (used by authenticate / checkoutWithCard / checkoutWithNewCard)
// and notifies native once it has navigated past about:blank. The SRC library
// renders any required challenge (3DS, OTP, consent) inside this iframe.
function attachDcf(platform, request) {
  var dcf = document.getElementById('dcfLaunch');
  if (!dcf) return;
  var visibleSent = false;
  dcf.onload = function () {
    if (visibleSent) return;
    var navigated = false;
    try {
      var href = dcf.contentWindow && dcf.contentWindow.location
        ? dcf.contentWindow.location.href
        : '';
      navigated = !!href && href !== 'about:blank';
    } catch (e) {
      // Cross-origin: DCF content has navigated and become interactive.
      navigated = true;
    }
    if (navigated) {
      visibleSent = true;
      sendMessageToNative(lastNativePlatform, { visible: true }, 'dcfShown');
    }
  };
  dcf.style.display = 'block';
  request.windowRef = dcf.contentWindow;
}

function callSrc(platform, methodName, reqString, opts) {
  var withDcf = !!(opts && opts.withDcf);
  try {
    ctpLog(methodName + ' request: ' + (reqString || '{}'));
    lastNativePlatform = platform || 'android';
    var request = reqString ? JSON.parse(reqString) : {};
    if (withDcf) attachDcf(platform, request);
    var instance = ensureInstance();
    relay(platform, methodName, instance[methodName](request), withDcf);
  } catch (e) {
    ctpLog(methodName + ' threw: ' + JSON.stringify(serializeError(e)));
    if (withDcf) closeDcfWindow();
    sendMessageToNative(platform, { status: 'error', data: serializeError(e) }, methodName);
  }
}

function initSdk(platform, reqString) {
  callSrc(platform, 'init', reqString, { withDcf: false });
}

function authenticate(platform, reqString) {
  callSrc(platform, 'authenticate', reqString, { withDcf: true });
}

function checkoutWithCard(platform, reqString) {
  callSrc(platform, 'checkoutWithCard', reqString, { withDcf: true });
}

function checkoutWithNewCard(platform, reqString) {
  callSrc(platform, 'checkoutWithNewCard', reqString, { withDcf: true });
}

function encryptCard(platform, reqString) {
  callSrc(platform, 'encryptCard', reqString, { withDcf: false });
}

function getCards(platform) {
  try {
    ctpLog('getCards request');
    var instance = ensureInstance();
    relay(platform, 'getCards', instance.getCards(), false);
  } catch (e) {
    ctpLog('getCards threw: ' + JSON.stringify(serializeError(e)));
    sendMessageToNative(platform, { status: 'error', data: serializeError(e) }, 'getCards');
  }
}

function signOut(platform) {
  try {
    ctpLog('signOut request');
    var instance = ensureInstance();
    relay(platform, 'signOut', instance.signOut(), false);
  } catch (e) {
    ctpLog('signOut threw: ' + JSON.stringify(serializeError(e)));
    sendMessageToNative(platform, { status: 'error', data: serializeError(e) }, 'signOut');
  }
}

function closeDcfWindow() {
  var dcf = document.getElementById('dcfLaunch');
  if (dcf) {
    dcf.onload = null;
    dcf.style.display = 'none';
    dcf.src = 'about:blank';
    sendMessageToNative(lastNativePlatform, { visible: false }, 'dcfHidden');
  }
}

function serializeError(err) {
  if (!err) return { message: 'unknown' };
  if (typeof err === 'string') return { message: err };
  return {
    message: err.message || String(err),
    name: err.name,
    reason: err.reason,
    code: err.code,
    details: err.details
  };
}
