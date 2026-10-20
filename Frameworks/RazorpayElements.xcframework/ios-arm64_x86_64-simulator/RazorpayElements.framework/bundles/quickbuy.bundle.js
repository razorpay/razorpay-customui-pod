(function () {
"use strict";
// Tiny pub/sub store. Not instrument- or element-specific — any element that
// needs "some state + re-render on change" can reuse this instead of hand
// rolling closures over a mutable var (see quickbuy/view.js for the usage).
function createStore(initial) {
  var state = initial || {};
  var listeners = [];

  function getState() { return state; }

  function setState(patch) {
    for (var k in patch) { if (patch.hasOwnProperty(k)) state[k] = patch[k]; }
    for (var i = 0; i < listeners.length; i++) listeners[i](state);
  }

  function subscribe(fn) {
    listeners.push(fn);
    return function unsubscribe() {
      var idx = listeners.indexOf(fn);
      if (idx !== -1) listeners.splice(idx, 1);
    };
  }

  return { getState: getState, setState: setState, subscribe: subscribe };
}
// Generic expandable list over ui.* — not instrument-specific. Any element
// wanting "tap a row to reveal a list of choices, tap one to collapse and
// select" (quickbuy's instrument picker today) can reuse this instead of
// hand-rolling show/hide + rebuild logic.
//
// opts:
//   props    - extra props merged onto the wrapping ui.column (e.g. bg/border)
//   buildRow - function(item, select) -> viewId. Build whatever native row
//              you want for `item`; wire its onClick to call `select()`.
//   onSelect - function(item), called after a row calls `select()` and the
//              list has already collapsed.
//
// Returns { listId, toggle(), collapse(), setItems(items) }.
function buildExpandableList(opts) {
  var props = { width: "match", visible: false };
  for (var k in (opts.props || {})) { if (opts.props.hasOwnProperty(k)) props[k] = opts.props[k]; }

  var listId = ui.column(props);
  var expanded = false;
  var items = [];

  function render() {
    ui.clear(listId);
    for (var i = 0; i < items.length; i++) {
      (function (item) {
        var rowId = opts.buildRow(item, function select() {
          collapse();
          if (opts.onSelect) opts.onSelect(item);
        });
        ui.addChild(listId, rowId);
      })(items[i]);
    }
  }

  function collapse() {
    expanded = false;
    ui.setProps(listId, { visible: false });
  }

  function toggle() {
    expanded = !expanded;
    ui.setProps(listId, { visible: expanded });
  }

  function setItems(nextItems) {
    items = nextItems || [];
    render();
  }

  return { listId: listId, toggle: toggle, collapse: collapse, setItems: setItems };
}
// Shared quickbuy-local plumbing + config helpers. `cfg` is the config JSON
// RazorpayView hands to `main()`; every quickbuy fragment closes over the
// same `cfg` argument, never global state.
var R = window.RazorpayJS;
var ui = R.ui, api = R.api, log = R.log;

var API_BASE = "https://api.razorpay.com/v1";

// When keyId is still the placeholder we run a local mock so the loop is
// demonstrable today. Drop in a real rzp_test_ key + order to hit real APIs.
// Also gates the instruments call — see api.js#fetchInstruments.
function isMock(cfg) { return !cfg.keyId || cfg.keyId.indexOf("XXXX") !== -1; }

function authHeader(cfg) {
  // POC-only. In production the key secret NEVER ships to the client;
  // order creation + payment auth happen server-side. Here we assume a test
  // order was pre-created and we drive payment create against test APIs.
  return { "Content-Type": "application/json" };
}

// The checkout/activity request body has a fixed wire shape:
//   { action: "get_recommended_instruments", customer: {...}, device_details: {...} }
// `action` and `device_details` are constants — SDK-owned, hardcoded here —
// regardless of whatever the app passes in. The app is only responsible for
// the parts that vary per shopper (e.g. `customer`), via
// `cfg.instrumentsApi.body`; it must NOT contain the key — the key travels
// only in the Authorization header (see instrumentsAuthHeader below).
function instrumentsBody(cfg) {
  var appBody = (cfg.instrumentsApi && cfg.instrumentsApi.body) || {};
  var body = {};
  for (var k in appBody) { if (appBody.hasOwnProperty(k)) body[k] = appBody[k]; }
  body.action = "get_recommended_instruments";
  body.device_details = { platform: "sdk", os: "android" };
  return body;
}

// Minimal base64 encoder — don't assume `btoa` exists in the WebView JS
// context (this runtime otherwise assumes nothing beyond bare ES5+; see
// CLAUDE.md §6). Only needs to handle ASCII (key id + ":").
function base64Encode(str) {
  var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  var out = "", i = 0;
  while (i < str.length) {
    var c1 = str.charCodeAt(i++);
    var c2 = str.charCodeAt(i++);
    var c3 = str.charCodeAt(i++);
    var e1 = c1 >> 2;
    var e2 = ((c1 & 3) << 4) | (isNaN(c2) ? 0 : (c2 >> 4));
    var e3 = isNaN(c2) ? 64 : (((c2 & 15) << 2) | (isNaN(c3) ? 0 : (c3 >> 6)));
    var e4 = isNaN(c3) ? 64 : (c3 & 63);
    out += chars.charAt(e1) + chars.charAt(e2) + chars.charAt(e3) + chars.charAt(e4);
  }
  return out;
}

// checkout/activity auth: HTTP Basic with just the key id as username and an
// empty password (no secret — this is the client-safe key, not the secret).
function instrumentsAuthHeader(cfg) {
  return {
    "Content-Type": "application/json",
    "Authorization": "Basic " + base64Encode((cfg.keyId || "") + ":")
  };
}
// Payment steps (JS-orchestrated) — native only executes the HTTP calls JS
// asks for via HostBridge.httpRequest (see api.get/post in runtime.js).

var INSTRUMENTS_URL = "https://api.razorpay.com/pg_router/v1/checkout/activity";

// Mocked recommended-instruments response items — same raw shape the real
// `get_recommended_instruments` payload uses, so mock and real both flow
// through the same normalizeInstrument() below.
var MOCK_INSTRUMENT_ITEMS = [
  { method: "upi", upi: { flow: "intent", app: "googlepay",
    app_package: "com.google.android.apps.nbu.paisa.user",
    app_logo: "https://cdn.razorpay.com/app/googlepay.svg" } },
  { method: "upi", upi: { flow: "intent", app: "phonepe",
    app_package: "com.phonepe.app",
    app_logo: "https://cdn.razorpay.com/app/phonepe.svg" } },
  { method: "upi", upi: { flow: "intent", app: "paytm",
    app_package: "net.one97.paytm",
    app_logo: "https://cdn.razorpay.com/app/paytm.svg" } }
];

var APP_LABELS = {
  googlepay: "Google Pay", phonepe: "PhonePe", super_money: "Super Money",
  paytm: "Paytm", cred: "CRED", amazon: "Amazon Pay"
};

function appLabel(app) {
  if (APP_LABELS.hasOwnProperty(app)) return APP_LABELS[app];
  return app ? app.charAt(0).toUpperCase() + app.slice(1) : "UPI app";
}

function normalizeInstrument(raw, i) {
  var upi = raw.upi || {};
  return {
    id: upi.app || ("instrument_" + i),
    method: raw.method || "upi",
    label: appLabel(upi.app),
    instrument: "UPI",
    icon: upi.app_logo || "",
    app: upi.app || "",
    appPackage: upi.app_package || "",
    flow: upi.flow || ""
  };
}

// 1. Fetch the shopper's recommended payment instruments.
function fetchInstruments(cfg) {
  if (isMock(cfg)) return Promise.resolve(MOCK_INSTRUMENT_ITEMS.map(normalizeInstrument));
  // Real: URL + auth header are ours (instrumentsAuthHeader derives Basic
  // auth from cfg.keyId); only `body` is app-supplied, via
  // cfg.instrumentsApi.body (see config.js#instrumentsBody).
  return api.post(INSTRUMENTS_URL, instrumentsBody(cfg), instrumentsAuthHeader(cfg))
    .then(function (res) {
      var payload = res.body && res.body.get_recommended_instruments;
      var items = (payload && payload.items) || [];
      return items.map(normalizeInstrument);
    });
}

// 2. Create the payment (real test API) against the selected instrument, then poll status.
function pay(cfg, instrument) {
  if (isMock(cfg)) {
    // simulate a create + async success
    return new Promise(function (resolve) {
      setTimeout(function () { resolve({ status: "created", id: "pay_mock123" }); }, 600);
    }).then(function () {
      return new Promise(function (resolve) {
        setTimeout(function () { resolve({ status: "captured", id: "pay_mock123" }); }, 900);
      });
    });
  }
  // Real: create payment against the pre-created order using the selected method.
  var body = {
    amount: cfg.amount, currency: cfg.currency || "INR",
    order_id: cfg.orderId, method: instrument.method,
    email: cfg.email, contact: cfg.contact
  };
  // TODO(user): confirm the payment-create body shape for UPI intent flow —
  // this assumes the target app is identified by its package, not a VPA
  // (there's no VPA to collect for an app-recommendation instrument).
  if (instrument.method === "upi") body.app_package = instrument.appPackage;
  return api.post(API_BASE + "/payments/create/json", body, authHeader(cfg))
    .then(function (res) { return pollStatus(cfg, res.body && res.body.razorpay_payment_id); });
}

function pollStatus(cfg, paymentId, tries) {
  tries = tries || 0;
  if (!paymentId || tries > 10) return Promise.resolve({ status: "failed" });
  return api.get(API_BASE + "/payments/" + paymentId, authHeader(cfg)).then(function (res) {
    var st = res.body && res.body.status;
    if (st === "captured" || st === "authorized" || st === "failed") return { status: st, id: paymentId };
    return new Promise(function (r) { setTimeout(r, 1200); })
      .then(function () { return pollStatus(cfg, paymentId, tries + 1); });
  });
}
// Header theme registry for the quickbuy card. Picking a theme is pure JS —
// no native involvement — driven by cfg.theme.header (the merged global +
// per-element theme RazorpayView hands to every element). See QUICKBUY.md §1
// for what each theme looks like.
//
//   "default"    - "Pay ₹X" title + ••• / ✕, standalone CTA button below.
//   "no-header"  - header row omitted entirely; standalone CTA remains.
//   "app"        - price + a single "Pay with <App>" button that IS the CTA;
//                  no separate CTA below, and the instrument row is hidden
//                  (see view.js) since the app button owns the whole action.

function buildDefaultHeader(cfg, store, amountStr) {
  var payTitle = ui.text({
    text: "Pay " + amountStr,
    fontSize: 18, fontWeight: "bold", textColor: "#111827", weight: 1
  });
  var menuBtn = ui.text({
    text: "•••", fontSize: 18, textColor: "#9CA3AF", marginRight: 16,
    onClick: function () { log("menu tapped"); }
  });
  var closeBtn = ui.text({
    text: "✕", fontSize: 18, textColor: "#6B7280",
    onClick: function () { log("close tapped"); }
  });
  return { node: ui.row({
    gravity: "centerVertical", width: "match", marginBottom: 18
  }, [payTitle, menuBtn, closeBtn]), ctaId: null };
}

function appCtaLabel(selected) {
  return "Pay with " + (selected ? selected.label : "App");
}

function buildAppHeader(cfg, store, amountStr) {
  var priceText = ui.text({
    text: amountStr, fontSize: 18, fontWeight: "bold", textColor: "#111827",
    weight: 1, width: 0
  });
  var appCta = ui.button({
    text: appCtaLabel(store.getState().selected),
    textColor: "#FFFFFF", fontSize: 15, fontWeight: "bold",
    bg: "#0B1120", cornerRadius: 12,
    paddingTop: 12, paddingBottom: 12, textAlign: "center",
    weight: 3, width: 0,
    onClick: function () { onPay(cfg, store); }
  });
  return { node: ui.row({
    gravity: "centerVertical", width: "match", marginBottom: 18
  }, [priceText, appCta]), ctaId: appCta, hideInstrumentRow: true };
}

var HEADER_THEMES = {
  "default": buildDefaultHeader,
  "no-header": function () { return { node: null, ctaId: null }; },
  "app": buildAppHeader
};
// Assembles the whole quickbuy card: theme-driven header (headerThemes.js) +
// instrument row + the instrument picker (lib/list.js) + CTA + footer. Owns
// the store (lib/store.js) that tracks which instrument is currently
// selected, so onPay always reads the live selection rather than whatever
// was fetched first.
var els = {};

// Group an integer amount into the Indian numbering system: 456000 -> "₹4,560".
function inr(amountPaise) {
  var whole = String(Math.round(amountPaise / 100));
  var last3 = whole.slice(-3);
  var rest = whole.slice(0, -3);
  if (rest) last3 = "," + last3;
  rest = rest.replace(/\B(?=(\d\d)+(?!\d))/g, ",");
  return "₹" + rest + last3;
}

function instrumentLabel(item) {
  if (!item) return "No payment method available";
  return item.label + " • " + item.instrument;
}

// One row inside the instrument picker list.
function buildInstrumentRow(item, select) {
  var icon = ui.image({ src: item.icon, width: 24, height: 24, marginRight: 12 });
  var label = ui.text({
    text: item.label + " • " + item.instrument,
    fontSize: 15, textColor: "#111827", weight: 1
  });
  return ui.row({
    gravity: "centerVertical", width: "match",
    paddingTop: 12, paddingBottom: 12, onClick: select
  }, [icon, label]);
}

function buildCard(cfg, instruments) {
  var amountStr = inr(cfg.amount);
  var cfgTheme = cfg.theme || {};
  var themeName = HEADER_THEMES.hasOwnProperty(cfgTheme.header) ? cfgTheme.header : "default";

  var store = createStore({ items: instruments, selected: instruments[0] || null });

  var header = HEADER_THEMES[themeName](cfg, store, amountStr);

  var children = [];
  if (header.node) children.push(header.node);

  // Instrument row: [icon] label • instrument   Change
  // Skipped when the header theme already owns the whole payment action
  // (e.g. "app") — there's no separate instrument to show or change there.
  if (!header.hideInstrumentRow) {
    els.instrumentIcon = ui.image({ src: (store.getState().selected || {}).icon, width: 24, height: 24, marginRight: 12 });
    els.instrumentLabel = ui.text({
      text: instrumentLabel(store.getState().selected),
      fontSize: 15, textColor: "#111827", weight: 1
    });
    var change = ui.text({
      text: "Change", fontSize: 15, fontWeight: "bold", textColor: "#3B82F6",
      onClick: function () { instrumentList.toggle(); }
    });
    var methodRow = ui.row({
      gravity: "centerVertical", width: "match",
      paddingTop: 14, paddingBottom: 14
    }, [els.instrumentIcon, els.instrumentLabel, change]);

    var instrumentList = buildExpandableList({
      props: { bg: "#F9FAFB", cornerRadius: 12, marginBottom: 8 },
      buildRow: buildInstrumentRow,
      onSelect: function (item) { store.setState({ selected: item }); }
    });
    instrumentList.setItems(instruments);

    store.subscribe(function (state) {
      ui.setProps(els.instrumentIcon, { src: (state.selected || {}).icon });
      ui.setProps(els.instrumentLabel, { text: instrumentLabel(state.selected) });
    });

    var divider = ui.el("container", { bg: "#F3F4F6", height: 1, width: "match", marginBottom: 16 });

    children.push(methodRow, instrumentList.listId, divider);
  }

  // A theme's header may already contain the CTA (e.g. "app"); only build
  // the standalone dark pay button when no header CTA took its place.
  els.cta = header.ctaId || ui.button({
    text: "Pay " + amountStr,
    textColor: "#FFFFFF", fontSize: 16, fontWeight: "bold",
    bg: "#0B1120", cornerRadius: R.theme.shapeRadius(cfgTheme.shape, 14),
    paddingTop: 16, paddingBottom: 16, width: "match", textAlign: "center",
    onClick: function () { onPay(cfg, store); }
  });

  els.status = ui.text({ text: "", fontSize: 13, textColor: "#6B7280", marginTop: 10, textAlign: "center", visible: false });

  // Footer: "Secured by Razorpay"
  var footer = ui.text({
    text: "Secured by Razorpay", fontSize: 12, textColor: "#9CA3AF",
    textAlign: "center", marginTop: 16, width: "match"
  });

  if (!header.ctaId) children.push(els.cta);
  children.push(els.status, footer);

  els.card = ui.column({
    bg: cfgTheme.bg || "#FFFFFF", cornerRadius: R.theme.shapeRadius(cfgTheme.shape, 20),
    paddingTop: 12, paddingBottom: 12,
    paddingLeft: 20, paddingRight: 20, width: "match"
  }, children);

  ui.setRoot(els.card);
  ui.animate(els.card, "slideUp");
}

function status(msg, color) {
  ui.setProps(els.status, { text: msg, visible: true, textColor: color || "#6B7280" });
}

function onPay(cfg, store) {
  var instrument = store.getState().selected;
  if (!instrument) { status("No payment method selected", "#DC2626"); return; }
  ui.setProps(els.cta, { text: "Processing…", bg: "#374151" });
  status("Contacting bank…");
  pay(cfg, instrument).then(function (result) {
    if (result.status === "captured" || result.status === "authorized") {
      ui.setProps(els.cta, { text: "Paid ✓", bg: "#059669" });
      status("Payment successful (" + result.id + ")", "#059669");
      ui.animate(els.cta, "pulse");
    } else {
      ui.setProps(els.cta, { text: "Retry payment", bg: "#DC2626" });
      status("Payment failed", "#DC2626");
    }
  });
}
// Entrypoint: fetch the instruments list, then build the card. Boots when
// RazorpayView.configure(elementType = "quickbuy", ...) + .start() runs.
//
// `cfg` here only needs to carry what showing the card + fetching
// instruments requires (keyId, amount, instrumentsApi.body) — it does NOT
// need order/contact/email yet. Those arrive later, right before the user
// can actually pay, via RazorpayView.setPaymentConfig(...) on the native
// side -> window.RazorpayJS.setPaymentConfig(patch) here. We merge the
// patch straight into this same `cfg` object (by reference) so pay(), which
// closes over `cfg`, sees the merged fields without any rebuild.
window.registerElement(function (cfg) {
  log("quickbuy booting, mock=" + isMock(cfg));

  window.registerPaymentConfigHandler(function (patch) {
    for (var k in patch) { if (patch.hasOwnProperty(k)) cfg[k] = patch[k]; }
    log("quickbuy payment config received");
  });

  fetchInstruments(cfg)
    .then(function (instruments) { buildCard(cfg, instruments); })
    .catch(function (e) { log("quickbuy fetch failed: " + (e && e.message)); });
});
})();
