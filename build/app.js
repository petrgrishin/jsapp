(function() {
  var App, Area, Listener, Loader, Queue, Request, Response, Scope, Widget,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  App = (function() {
    function App() {
      this.assertPath = '/assets/scripts/';
      this.viewFunctions = {};
      this.registerScripts = {};
      if (this.scope == null) {
        this.scope = new Scope();
      }
    }

    App.prototype.register = function(name, func) {
      return this.viewFunctions[name] = func;
    };

    App.prototype.run = function(name, params, dependents) {
      var callback, dependentProcessor, dependentsResult;
      this.registerScriptFile(name);
      params = params || {};
      dependents = dependents || [];
      dependentsResult = [];
      dependentProcessor = function(_arg, dependentName) {
        var dependents, name, params;
        name = _arg.name, params = _arg.params, dependents = _arg.dependents;
        return dependentsResult[dependentName] = this.run(name, params, dependents);
      };
      _.each(dependents, dependentProcessor, this);
      callback = this.viewFunctions[name];
      return callback(params, this.scope, dependentsResult);
    };

    App.prototype.registerScriptFile = function(name) {
      var $script;
      if (this.registerScripts[name] != null) {
        return;
      }
      this.registerScripts[name] = this.assertPath + name + '.js';
      $script = $('<script>');
      $script.attr('src', this.registerScripts[name]);
      if (this.body == null) {
        this.body = $('body:first');
      }
      return this.body.append($script);
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

  Loader = (function() {
    function Loader(response) {
      this.response = response;
    }

    Loader.prototype.pull = function(url, options) {
      var self;
      if (options == null) {
        options = {};
      }
      self = this;
      return $.ajax({
        url: url,
        data: options['data'] || {},
        type: options['type'] || 'GET',
        dataType: 'json',
        success: function(response) {
          var context, dependents, params;
          if (response) {
            params = response['params'] || [];
            dependents = response['dependents'] || [];
            if (response['name']) {
              context = window.App.run(response['name'], params, dependents);
              self.response.setContext(context);
            }
            if (response['content']) {
              self.response.setContent(response['content']);
            }
            if (response['responseParams']) {
              if (self.response) {
                self.response.apply(response['responseParams']);
              }
            }
            return self.response.load();
          }
        }
      });
    };

    return Loader;

  })();

  Queue = (function() {
    function Queue() {}

    return Queue;

  })();

  Request = (function() {
    function Request() {}

    return Request;

  })();

  Response = (function() {
    function Response(params) {
      this.params = params;
      this.listener = new Listener();
    }

    Response.prototype.bindLoad = function(callback) {
      return this.listener.subscribe("load", callback);
    };

    Response.prototype.load = function() {
      return this.listener.trigger("load");
    };

    Response.prototype.bindApply = function(callback) {
      return this.listener.subscribe("apply", callback);
    };

    Response.prototype.apply = function(params) {
      return this.listener.trigger("apply", params);
    };

    Response.prototype.setContent = function(content) {
      this.content = content;
    };

    Response.prototype.getContent = function() {
      return this.content;
    };

    Response.prototype.setContext = function(context) {
      this.context = context;
    };

    Response.prototype.getContext = function() {
      return this.context;
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

    Scope.prototype.createAreaWidget = function(response) {
      return new Area(response);
    };

    Scope.prototype.createLoader = function(response) {
      return new Loader(response);
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

    function Area(response) {
      this.response = response;
    }

    Area.prototype.load = function() {
      var load;
      load = new Loader(this.response);
      return load.pull("/", {
        data: ""
      });
    };

    Area.prototype.reload = function() {};

    return Area;

  })(Widget);

  if (typeof module !== "undefined" && module !== null) {
    module.exports = App;
  }

  if (typeof window !== "undefined" && window !== null) {
    window.App = new App(window);
  }

}).call(this);

//# sourceMappingURL=app.js.map
