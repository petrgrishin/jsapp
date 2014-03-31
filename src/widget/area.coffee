class Area extends Widget
  constructor: (@params) ->

  load: () ->
    load = new Load(@response)
    load.push "/"

  reload: () ->
