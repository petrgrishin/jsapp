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
  constructor: (@response) ->

  push: (@url) ->
    @params = {}
    @response.apply @params if @response

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

  createAreaWidget: (params) ->
    new Area(params)

class Widget
  apply: () ->
    @response.apply() if @response

  onApply: (response) ->
    throw "Not instance of Response" if not response instanceof Response
    @response = response

class Area extends Widget
  constructor: (@params) ->

  load: () ->
    load = new Load(@response)
    load.push "/"

  reload: () ->


# for nodeunit
module.exports = App if module?

# for production
window.App = new App(window, jQuery, _) if window?