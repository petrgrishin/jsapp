class Response
  constructor: (@params) ->
    @listener = new Listener()

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
