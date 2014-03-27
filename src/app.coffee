class App
  constructor: (@window, @$, @_) ->
    @viewFunctions = {}
    @scope ?= new Scope()

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    @_.each @viewFunctions, (callback, name) ->
      callback {}, @scope, {}
