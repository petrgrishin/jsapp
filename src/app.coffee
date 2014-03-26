class App
  constructor: (@window, @$, @_) ->
    @viewFunctions = {}
    @scope ?= new Scope()

  f: (name, func) ->
    @viewFunctions[name] = func

  apply: () ->
    # todo: выполняем программу

# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

class Response
  constructor: (@params) ->
    @listener = new Listener()

  bindApply: (callback) ->
    @listener.subscribe "apply", callback

  apply: (params) ->
    @listener.trigger "apply", params

class Listener
  subscribers = {}

  trigger: (name, params) ->
    if subscribers[name] then subscribers[name].forEach (callback) ->
      callback(params)

  subscribe: (name, callback) ->
    subscribers[name] ?= []
    subscribers[name].push callback
    this

class Load

class Queue

# for nodeunit
module.exports = App if module and module.exports