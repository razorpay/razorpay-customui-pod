// Shared JS runtime for all Razorpay elements.
// Provides: window.RazorpayJS (native entrypoints), ui (imperative view builder),
// api (Promise wrapper over HostBridge.httpRequest). Element bundles build on top.
(function () {
  "use strict";

  var log = function (m) {
    try { HostBridge.log(typeof m === "string" ? m : JSON.stringify(m)); } catch (e) {}
  };

  // ---- id generation (no Math.random dependency; monotonic counter) ----
  var _idc = 0;
  function nextId(prefix) { _idc += 1; return (prefix || "v") + _idc; }

  // ---- click handler registry: id -> fn ----
  var clickHandlers = {};

  // ---- input handler registry: id -> fn(value) ----
  var inputHandlers = {};

  // ---- pending HTTP requests: reqId -> {resolve, reject} ----
  var pending = {};
  var _reqc = 0;

  // ============ ui: imperative view builder ============
  // el("button", {text, bg, ...}, [children]) -> id
  function el(type, props, children) {
    var id = nextId(type);
    switch (type) {
      case "container":
      case "row":
      case "column":
        UiBridge.createContainer(id, type === "row" ? "horizontal" : "vertical");
        break;
      case "text":   UiBridge.createText(id); break;
      case "button": UiBridge.createButton(id); break;
      case "image":  UiBridge.createImage(id); break;
      case "input":  UiBridge.createInput(id); break;
      default: UiBridge.createContainer(id, "vertical");
    }

    if (props) {
      var onClick = props.onClick;
      var onInput = props.onInput;
      if (onClick) { delete props.onClick; }
      if (onInput) { delete props.onInput; }
      UiBridge.setProps(id, JSON.stringify(props));
      if (onClick) {
        clickHandlers[id] = onClick;
        UiBridge.onClick(id);
      }
      if (onInput) {
        inputHandlers[id] = onInput;
      }
    }

    if (children) {
      for (var i = 0; i < children.length; i++) {
        if (children[i]) UiBridge.addChild(id, children[i]);
      }
    }
    return id;
  }

  function setProps(id, props) { UiBridge.setProps(id, JSON.stringify(props)); }
  function setRoot(id) { UiBridge.setRoot(id); }
  function clear(id) { UiBridge.clearChildren(id); }
  function animate(id, type) { UiBridge.animate(id, type); }
  function addChild(parentId, childId) { UiBridge.addChild(parentId, childId); }

  var ui = {
    el: el,
    row: function (p, c) { return el("row", p, c); },
    column: function (p, c) { return el("column", p, c); },
    text: function (p) { return el("text", p); },
    button: function (p) { return el("button", p); },
    image: function (p) { return el("image", p); },
    input: function (p) { return el("input", p); },
    setProps: setProps,
    setRoot: setRoot,
    clear: clear,
    // For containers built once, then repopulated later (e.g. a rebuilt
    // list) — el()'s own `children` param only handles children known at
    // creation time.
    addChild: addChild,
    animate: animate,
    // Synchronous read of an input's current text.
    getValue: function (id) {
      try { return UiBridge.getValue(id); } catch (e) { return ""; }
    }
  };

  // ============ theme: generic helpers over config.theme ============
  // Theme keys themselves (bg, shape, header, ...) are opaque to native and
  // to this runtime — only element bundles interpret them. This just holds
  // helpers generic enough to be shared across any element, e.g. mapping a
  // "rounded"/"square" shape name to an actual corner-radius dp value.
  var theme = {
    shapeRadius: function (shape, fallback) {
      if (shape === "square") return 4;
      if (shape === "rounded") return 20;
      return fallback != null ? fallback : 20;
    }
  };

  // ============ api: Promise over native http ============
  function request(method, url, headers, body) {
    return new Promise(function (resolve, reject) {
      _reqc += 1;
      var reqId = "req" + _reqc;
      pending[reqId] = { resolve: resolve, reject: reject };
      HostBridge.httpRequest(
        reqId, method, url,
        JSON.stringify(headers || {}),
        body ? (typeof body === "string" ? body : JSON.stringify(body)) : ""
      );
    });
  }
  var api = {
    get: function (u, h) { return request("GET", u, h); },
    post: function (u, b, h) { return request("POST", u, h, b); }
  };

  // ============ native -> JS entrypoints ============
  window.RazorpayJS = {
    ui: ui,
    api: api,
    log: log,
    theme: theme,

    // native calls this to boot the element bundle
    main: function (config) {
      if (typeof window.__elementMain === "function") {
        try { window.__elementMain(config); }
        catch (e) { log("element main error: " + (e && e.message)); }
      } else {
        log("no element registered");
      }
    },

    // native calls this to hand over payment-specific config (orderId,
    // contact, email, ...) after the element already booted on UI-only
    // config. Elements that care register a handler via
    // registerPaymentConfigHandler; others simply ignore it.
    setPaymentConfig: function (patch) {
      if (typeof window.__onPaymentConfig === "function") {
        try { window.__onPaymentConfig(patch); }
        catch (e) { log("setPaymentConfig handler error: " + (e && e.message)); }
      } else {
        log("setPaymentConfig: no handler registered");
      }
    },

    // native calls this on a view event (click, or input with a value)
    dispatchEvent: function (kind, id, value) {
      if (kind === "click" && clickHandlers[id]) {
        try { clickHandlers[id](); } catch (e) { log("click handler error: " + (e && e.message)); }
      } else if (kind === "input" && inputHandlers[id]) {
        try { inputHandlers[id](value); } catch (e) { log("input handler error: " + (e && e.message)); }
      }
    },

    // native calls this to resolve an http request
    resolveHttp: function (reqId, status, bodyStr) {
      var p = pending[reqId];
      if (!p) return;
      delete pending[reqId];
      var body;
      try { body = bodyStr ? JSON.parse(bodyStr) : null; }
      catch (e) { body = bodyStr; } // non-JSON response, hand back raw
      p.resolve({ status: status, body: body });
    }
  };

  // Elements register their entrypoint via this.
  window.registerElement = function (fn) { window.__elementMain = fn; };

  // Elements that boot on UI-only config and expect payment details later
  // (see setPaymentConfig above) register a handler via this.
  window.registerPaymentConfigHandler = function (fn) { window.__onPaymentConfig = fn; };
})();
