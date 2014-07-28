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