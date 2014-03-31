class Load
  constructor: (@response) ->

  push: (@url) ->
    @params = {}
    @response.apply @params if @response