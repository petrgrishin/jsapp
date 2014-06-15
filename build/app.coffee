class App
  constructor: () ->
    @viewFunctions = {}
    @scope ?= new Scope()

  register: (name, func) ->
    @viewFunctions[name] = func

  run: (name, params, dependents) ->
    params = params || {}
    dependents = dependents || []
    dependentsResult = []
    dependentProcessor = ({name, params, dependents}, dependentName) ->
      dependentsResult[dependentName] = this.run(name, params, dependents)
    _.each dependents, dependentProcessor, this
    callback = @viewFunctions[name]
    return callback params, @scope, dependentsResult
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
class Loader
  constructor: (@response) ->

  pull: (url, options) ->
    $.ajax
      url: url
      data: options['data'] || []
      type: options['type'] || 'GET'
      dataType: 'json'
      success: (response) ->
        if response
          responseParams = response['responseParams'] || []
          @response.apply responseParams if @response
class Queue

class Request

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

  createAreaWidget: (response) ->
    new Area(response)

  createLoader: (response) ->
    new Loader(response)
class Widget
  apply: () ->
    @response.apply() if @response

  onApply: (response) ->
    throw "Not instance of Response" if not response instanceof Response
    @response = response
class Area extends Widget
  constructor: (@response) ->

  load: () ->
    load = new Loader(@response)
    load.pull "/", {data: ""}

  reload: () ->

# for nodeunit
module.exports = App if module?
# for production
window.App = new App(window) if window?