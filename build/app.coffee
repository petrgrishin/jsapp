class App
  constructor: (@window, @$, @_) ->
    @viewFunctions = {}
    @scope ?= new Scope()

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    @_.each @viewFunctions, (callback, name) ->
      callback {}, @scope, {}


class Listener
  subscribers = {}

  trigger: (name, params) ->
    if subscribers[name] then subscribers[name].forEach (callback) ->
      callback(params)
    this

  subscribe: (name, callback) ->
    subscribers[name] ?= []
    subscribers[name].push callback
    this

class Load


class Queue


class Response
  constructor: (@params) ->
    @listener = new Listener()

  bindApply: (callback) ->
    @listener.subscribe "apply", callback

  apply: (params) ->
    @listener.trigger "apply", params


# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

# for nodeunit
module.exports = App if module and module.exports