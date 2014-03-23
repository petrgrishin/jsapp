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

# for nodeunit
module.exports = App if module and module.exports