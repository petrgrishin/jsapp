class App
  constructor: () ->
    @assertPath = '/assets/scripts/'
    @viewFunctions = {}
    @registerScripts = {}
    @scope ?= new Scope()

  register: (name, func) ->
    @viewFunctions[name] = func

  run: (name, params, dependents) ->
    this.registerScriptFile name
    params = params || {}
    dependents = dependents || []
    dependentsResult = []
    dependentProcessor = ({name, params, dependents}, dependentName) ->
      dependentsResult[dependentName] = this.run(name, params, dependents)
    _.each dependents, dependentProcessor, this
    callback = @viewFunctions[name]
    return callback params, @scope, dependentsResult

  registerScriptFile: (name) ->
    return if @registerScripts[name]?
    @registerScripts[name] = @assertPath + name + '.js'
    $script = $ '<script>'
    $script.attr 'src', @registerScripts[name]
    @body ?= $ 'body:first'
    @body.append $script
