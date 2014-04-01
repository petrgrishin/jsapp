global = null
$ = null
_ = null

class App
  constructor: (context, jquery, underscore) ->
    @viewFunctions = {}
    @scope ?= new Scope()

    # Todo
    global = context
    $ = jquery
    _ = underscore

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    _.each @viewFunctions, (callback, name) ->
      callback {}, @scope, {}
