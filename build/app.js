(function() {
  var App, Listener, Loader, Queue, Request, Response, Scope, Widget;

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
      if (params == null) {
        params = {};
      }
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

    Listener.prototype.clear = function(name) {
      this.subscribers[name] = [];
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
            if (response['content']) {
              self.response.setContent(response['content']);
            }
            if (response['responseParams']) {
              if (self.response) {
                self.response.apply(response['responseParams']);
              }
            } else {
              self.response.load();
            }
            params = response['params'] || [];
            dependents = response['dependents'] || [];
            if (response['name']) {
              context = window.App.run(response['name'], params, dependents);
              self.response.setContext(context);
              return self.response.triggerContext();
            }
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

    Response.prototype.getParams = function() {
      return this.params;
    };

    Response.prototype.bindLoad = function(callback) {
      return this.listener.subscribe("load", _.bind(callback, this));
    };

    Response.prototype.load = function() {
      return this.listener.trigger("load");
    };

    Response.prototype.bindApply = function(callback) {
      return this.listener.subscribe("apply", _.bind(callback, this));
    };

    Response.prototype.apply = function() {
      return this.listener.trigger("apply");
    };

    Response.prototype.bindContext = function(callback) {
      return this.listener.subscribe("context", _.bind(callback, this));
    };

    Response.prototype.triggerContext = function() {
      return this.listener.trigger("context");
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

    Response.prototype.clearApply = function() {
      return this.listener.clear("apply");
    };

    Response.prototype.clearLoad = function() {
      return this.listener.clear("load");
    };

    Response.prototype.clearContext = function() {
      return this.listener.clear("context");
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

    Scope.prototype.createLoader = function(response) {
      return new Loader(response);
    };

    Scope.prototype.$id = function(id) {
      return $(window.document.getElementById(id));
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

  if (typeof module !== "undefined" && module !== null) {
    module.exports = App;
  }

  if (typeof window !== "undefined" && window !== null) {
    window.App = new App(window);
  }

}).call(this);

//# sourceMappingURL=app.js.map
