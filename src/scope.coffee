# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()

  createLoader: (response) ->
    new Loader(response)

  $id: (id) ->
    $(window.document.getElementById(id))
