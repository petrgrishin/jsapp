class Area extends Widget
  constructor: (@response) ->

  load: () ->
    load = new Loader(@response)
    load.pull "/", {data: ""}

  reload: () ->
