window = null
$ = null
_ = null

class App
  constructor: (global, jquery, underscore) ->
    @viewFunctions = {}
    @scope ?= new Scope()
    window = global
    $ = jquery
    _ = underscore

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    _.each @viewFunctions, (callback, name) ->
      callback {}, @scope, {}
