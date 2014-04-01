App = require "../../../build/app"
Underscore = require "underscore"

module.exports.WidgetTest =
  "test listener gear": (test) ->
    isTestPassed = false
    appInstance = new App(null, null, Underscore)
    responseInstance = appInstance.scope.createResponse()
    responseInstance.bindApply () -> isTestPassed = true
    area = appInstance.scope.createAreaWidget()
    area.onApply responseInstance
    test.ok not isTestPassed
    area.load()
    test.ok isTestPassed
    test.done()
