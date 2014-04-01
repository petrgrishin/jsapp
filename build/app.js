(function() {
  var $, App, Area, Listener, Load, Queue, Response, Scope, Widget, global, _,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  global = null;

  $ = null;

  _ = null;

  App = (function() {
    function App(context, jquery, underscore) {
      this.viewFunctions = {};
      if (this.scope == null) {
        this.scope = new Scope();
      }
      global = context;
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
    function Load(response) {
      this.response = response;
    }

    Load.prototype.push = function(url) {
      this.url = url;
      this.params = {};
      if (this.response) {
        return this.response.apply(this.params);
      }
    };

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

    Scope.prototype.createAreaWidget = function(params) {
      return new Area(params);
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

    function Area(params) {
      this.params = params;
    }

    Area.prototype.load = function() {
      var load;
      load = new Load(this.response);
      return load.push("/");
    };

    Area.prototype.reload = function() {};

    return Area;

  })(Widget);

  if (typeof module !== "undefined" && module !== null) {
    module.exports = App;
  }

  if (typeof window !== "undefined" && window !== null) {
    window.App = new App(window, jQuery, _);
  }

}).call(this);
