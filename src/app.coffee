class App
  constructor: () ->
    @viewFunctions = {}
    @scope ?= new Scope()

  register: (name, func) ->
    @viewFunctions[name] = func

  run: (name, params, dependents) ->
    params = params || {}
    dependents = dependents || []
    dependentsResult = []
    _.each dependents, ({name, params, dependents}, dependentName) ->
      dependentsResult[dependentName] = this.run(name, params, dependents)

    callback = @viewFunctions[name]
    return callback params, @scope, dependentsResult