class Response
  constructor: (@params) ->
    @listener = new Listener()

  getParams: () ->
    @params

  bindLoad: (callback) ->
    @listener.subscribe "load", _.bind(callback, this)

  load: () ->
    @listener.trigger "load"

  bindApply: (callback) ->
    @listener.subscribe "apply", _.bind(callback, this)

  apply: () ->
    @listener.trigger "apply"

  setContent: (@content) ->

  getContent: () ->
    @content

  setContext: (@context) ->

  getContext: () ->
    @context
