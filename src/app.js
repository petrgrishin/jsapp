// Generated by CoffeeScript 1.7.1
(function() {
  var App;

  App = (function() {
    function App(window, jQuery, underscore) {
      this.window = window;
      this.$ = jQuery;
      this._ = underscore;
      this.viewFunctions = {};
    }

    App.prototype.f = function(name, func) {
      this.viewFunctions[name] = func;
      return this.pullTurnScripts();
    };

    App.prototype.pullTurnScripts = function() {
      return true;
    };

    App.prototype.load = function(params, loader) {
      return true;
    };

    return App;

  })();

  if (typeof global !== "undefined" && global !== null) {
    global.App = App;
  }

}).call(this);

//# sourceMappingURL=app.map
