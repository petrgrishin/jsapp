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
          params = response['params'] || []
          dependents = response['dependents'] || []

          if response['name']
            # TODO: run window.App
            context = window.App.run response['name'], params, dependents
            self.response.setContext context

          if response['content']
            self.response.setContent response['content']

          if response['responseParams']
            self.response.apply response['responseParams'] if self.response