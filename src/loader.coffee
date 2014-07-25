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

          params = response['params'] || []
          dependents = response['dependents'] || []
          # TODO: window.App
          window.App.run response['name'], params, dependents if response['name']

          self.response.apply responseParams if self.response