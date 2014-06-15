class Area extends Widget
  constructor: (@params) ->

  load: () ->
    load = new Loader(@response)
    load.pull "/", {data: ""}


  reload: () ->
