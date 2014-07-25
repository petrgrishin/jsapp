class App
  constructor: () ->
    @assertPath = '/assets/scripts/'
    @viewFunctions = {}
    @registerScripts = {}
    @scope ?= new Scope()

  register: (name, func) ->
    @viewFunctions[name] = func

  run: (name, params, dependents) ->
    this.registerScriptFile name
    params = params || {}
    dependents = dependents || []
    dependentsResult = []
    dependentProcessor = ({name, params, dependents}, dependentName) ->
      dependentsResult[dependentName] = this.run(name, params, dependents)
    _.each dependents, dependentProcessor, this
    callback = @viewFunctions[name]
    return callback params, @scope, dependentsResult

  registerScriptFile: (name) ->
    return if @registerScripts[name]?
    @registerScripts[name] = @assertPath + name + '.js'
    $script = $ '<script>'
    $script.attr 'src', @registerScripts[name]
    @body ?= $ 'body:first'
    @body.append $script

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

  pull: (url, options = {}) ->
    self = this
    $.ajax
      url: url
      data: options['data'] || {}
      type: options['type'] || 'GET'
      dataType: 'json'
      success: (response) ->
        if response
          responseParams = response['responseParams'] || {}
          self.response.apply responseParams if self.response
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