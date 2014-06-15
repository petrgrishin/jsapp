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
          responseParams = response['responseParams'] || {}
          self.response.apply responseParams if self.response