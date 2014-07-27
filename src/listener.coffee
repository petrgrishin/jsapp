class Listener
  constructor: () ->
    @subscribers = {}

  trigger: (name, params = {}, context = {}) ->
    if @subscribers[name] then _.each @subscribers[name], (callback) ->
      callback.call(context, params)
    this

  subscribe: (name, callback) ->
    @subscribers[name] ?= []
    @subscribers[name].push callback
    this