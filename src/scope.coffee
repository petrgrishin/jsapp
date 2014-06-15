# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

  createAreaWidget: (params) ->
    new Area(params)

  createLoader: (response) ->
    new Loader(response)