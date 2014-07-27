class Response
  constructor: (@params) ->
    @listener = new Listener()

  bindLoad: (callback) ->
    @listener.subscribe "load", callback

  load: () ->
    @listener.trigger "load"

  bindApply: (callback) ->
    @listener.subscribe "apply", callback

  apply: (params) ->
    @listener.trigger "apply", params

  setContent: (@content) ->

  getContent: () ->
    return @content

  setContext: (@context) ->

  getContext: () ->
    return @context
