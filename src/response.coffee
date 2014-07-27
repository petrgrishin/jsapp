class Response
  constructor: (@params) ->
    @listener = new Listener()

  getParams: () ->
    @params

  bindLoad: (callback) ->
    @listener.subscribe "load", callback

  load: () ->
    @listener.trigger "load", {}, this

  bindApply: (callback) ->
    @listener.subscribe "apply", callback

  apply: () ->
    @listener.trigger "apply", {}, this

  setContent: (@content) ->

  getContent: () ->
    @content

  setContext: (@context) ->

  getContext: () ->
    @context
