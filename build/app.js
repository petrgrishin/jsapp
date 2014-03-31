(function() {
  var $, App, Area, Listener, Load, Queue, Response, Scope, Widget, window, _,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window = null;

  $ = null;

  _ = null;

  App = (function() {
    function App(global, jquery, underscore) {
      this.viewFunctions = {};
      if (this.scope == null) {
        this.scope = new Scope();
      }
      window = global;
      $ = jquery;
      _ = underscore;
    }

    App.prototype.f = function(name, func) {
      return this.viewFunctions[name] = func;
    };

    App.prototype.apply = function() {
      return _.each(this.viewFunctions, function(callback, name) {
        return callback({}, this.scope, {});
      });
    };

    return App;

  })();

  if (module && module.exports) {
    module.exports = App;
  }

  Listener = (function() {
    function Listener() {
      this.subscribers = {};
    }

    Listener.prototype.trigger = function(name, params) {
      if (this.subscribers[name]) {
        _.each(this.subscribers[name], function(callback) {
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

  Widget = (function() {
    function Widget() {}

    Widget.prototype.apply = function() {
      if (this.response) {
        return this.response.apply();
      }
    };

    Widget.prototype.onApply = function(response) {
      if (!response instanceof Response) {
        throw "Not instance of Response";
      }
      return this.response = response;
    };

    return Widget;

  })();

  Area = (function(_super) {
    __extends(Area, _super);

    function Area() {}

    Area.prototype.load = function() {};

    Area.prototype.reload = function() {};

    return Area;

  })(Widget);

}).call(this);
