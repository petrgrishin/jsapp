App = require "../../src/app"

module.exports.AppTest =
  "test listener gear": (test) ->
    appInstance = new App()
    listener = appInstance.scope.createListener()
    isTestPassed = true
    listener.subscribe "test", (param) -> isTestPassed = param
    listener.trigger "test", true
    test.ok(isTestPassed)
    test.done()
