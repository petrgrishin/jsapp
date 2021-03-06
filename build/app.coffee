class App
  constructor: () ->
    @assertPath = '/assets/scripts/'
    @viewFunctions = {}
    @registerScripts = {}
    @registerStyles = {}
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

  registerStyleFile: (src) ->
    return if @registerStyles[src]?
    @registerStyles[src] = true
    $styleLink = $ '<link rel="stylesheet"/>'
    $styleLink.attr 'href', src
    @head ?= $ 'head:first'
    @head.append $styleLink

class Listener
  constructor: () ->
    @subscribers = {}

  trigger: (name, params = {}) ->
    if @subscribers[name] then _.each @subscribers[name], (callback) ->
      callback(params)
    this

  subscribe: (name, callback) ->
    @subscribers[name] ?= []
    @subscribers[name].push callback
    this

  clear: (name) ->
    @subscribers[name] = []
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

          if response['content']
            self.response.setContent response['content']

          if response['responseParams']
            self.response.triggerApply response['responseParams'] if self.response
          else
            self.response.triggerLoad()

          params = response['params'] || []
          dependents = response['dependents'] || []
          if response['name']
            # TODO: run window.App
            context = window.App.run response['name'], params, dependents
            self.response.setContext context
            self.response.triggerContext()

          styles = response['styles'] || []
          styleProcessor = (src) ->
            window.App.registerStyleFile src
          _.each styles, styleProcessor

class Queue

class Request

class Response
  constructor: (@params) ->
    @listener = new Listener()

  getParams: () ->
    @params

  bindLoad: (callback) ->
    @listener.subscribe "load", _.bind(callback, this)

  triggerLoad: () ->
    @listener.trigger "load"

  bindApply: (callback) ->
    @listener.subscribe "apply", _.bind(callback, this)

  triggerApply: () ->
    @listener.trigger "apply"

  bindContext: (callback) ->
    @listener.subscribe "context", _.bind(callback, this)

  triggerContext: () ->
    @listener.trigger "context"

  setContent: (@content) ->

  getContent: () ->
    @content

  setContext: (@context) ->

  getContext: () ->
    @context

  clearApply: () ->
    @listener.clear("apply")

  clearLoad: () ->
    @listener.clear("load")

  clearContext: () ->
    @listener.clear("context")
# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

  createLoader: (response) ->
    new Loader(response)

  $id: (id) ->
    $(window.document.getElementById(id))

class Widget
  apply: () ->
    @response.apply() if @response

  onApply: (response) ->
    throw "Not instance of Response" if not response instanceof Response
    @response = response
# for nodeunit
module.exports = App if module?
# for production
window.App = new App(window) if window?