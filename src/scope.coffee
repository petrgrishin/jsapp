# Singleton class
class Scope
  createListener: ->
    new Listener()

  createResponse: ->
    new Response()