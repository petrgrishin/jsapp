(function() {
  var App, Listener, Load, Queue, Response, Scope;

  App = (function() {
    function App(window, $, _) {
      this.window = window;
      this.$ = $;
      this._ = _;
      this.viewFunctions = {};
      if (this.scope == null) {
        this.scope = new Scope();
      }
    }

    App.prototype.f = function(name, func) {
      return this.viewFunctions[name] = func;
    };

    App.prototype.apply = function() {
      return this._.each(this.viewFunctions, function(callback, name) {
        return callback({}, this.scope, {});
      });
    };

    return App;

  })();

  Listener = (function() {
    function Listener() {
      this.subscribers = {};
    }

    Listener.prototype.trigger = function(name, params) {
      if (this.subscribers[name]) {
        this.subscribers[name].forEach(function(callback) {
          return callback(params);
        });
      }
      return this;
    };

    Listener.prototype.subscribe = function(name, callback) {
      var _base;
      if ((_base = this.subscribers)[name] == null) {
        _base[name] = [];
      }
      this.subscribers[name].push(callback);
      return this;
    };

    return Listener;

  })();

  Load = (function() {
    function Load() {}

    return Load;

  })();

  Queue = (function() {
    function Queue() {}

    return Queue;

  })();

  Response = (function() {
    function Response(params) {
      this.params = params;
      this.listener = new Listener();
    }

    Response.prototype.bindApply = function(callback) {
      return this.listener.subscribe("apply", callback);
    };

    Response.prototype.apply = function(params) {
      return this.listener.trigger("apply", params);
    };

    return Response;

  })();

  Scope = (function() {
    function Scope() {}

    Scope.prototype.createListener = function() {
      return new Listener();
    };

    Scope.prototype.createResponse = function() {
      return new Response();
    };

    return Scope;

  })();

  if (module && module.exports) {
    module.exports = App;
  }

}).call(this);
