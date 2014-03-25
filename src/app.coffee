class App
  constructor: (@window, @$, @_) ->
    @viewFunctions = {}

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    # todo: выполняем программу

class Response
  constructor: (@params) ->

  bindApply: (callback) ->

  apply: ->


class Scope

class Listener

class Load

class Queue

# for nodeunit
module.exports = App if module and module.exports