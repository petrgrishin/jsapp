class Loader
  constructor: (@response) ->

  pull: (url, options = {}) ->
    $.ajax
      url: url
      data: options['data'] || {}
      type: options['type'] || 'GET'
      dataType: 'json'
      success: (response) ->
        if response
          responseParams = response['responseParams'] || {}
          @response.apply responseParams if @response