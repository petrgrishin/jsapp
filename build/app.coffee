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


class Listener
  constructor: () ->
    @subscribers = {}

  trigger: (name, params) ->
    if @subscribers[name] then _.each @subscribers[name], (callback) ->
      callback(params)
    this

  subscribe: (name, callback) ->
    @subscribers[name] ?= []
    @subscribers[name].push callback
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