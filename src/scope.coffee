# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

  createAreaWidget: (response) ->
    new Area(response)

  createLoader: (response) ->
    new Loader(response)