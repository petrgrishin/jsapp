class App
  constructor: (@window, @$, @_) ->
    @viewFunctions = {}
    @scope ?= new Scope()

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    # todo: выполняем программу

class Response
  constructor: (@params) ->

  bindApply: (callback) ->

  apply: ->


# Singleton class
class Scope
  createListener: ->
    new Listener()

class Listener
  subscribers = {}

  trigger: (name, params) ->
    subscribers[name].reduce (f) ->
      f(params)

  subscribe: (name, callback) ->
    subscribers[name] ?= []
    subscribers[name].push callback
    this

class Load

class Queue

# for nodeunit
module.exports = App if module and module.exports