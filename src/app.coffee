class App
  constructor: (window, jQuery, underscore) ->
    @window = window
    @$ = jQuery
    @_ = underscore
    @viewFunctions = {}

  f: (name, func) ->
    @viewFunctions[name] = func
    @pullTurnScripts()

  pullTurnScripts: ->
    true

  load: (params, loader) ->
    true

# for qUnit
global.App = App if global?