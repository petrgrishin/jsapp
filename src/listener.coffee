class Listener
  constructor: ->
    @subscribers = {}

  trigger: (name, params) ->
    if @subscribers[name] then @subscribers[name].forEach (callback) ->
      callback(params)
    this

  subscribe: (name, callback) ->
    @subscribers[name] ?= []
    @subscribers[name].push callback
    this