App = require "../../src/app"

module.exports.AppTest =
  "test listener gear": (test) ->
    appInstance = new App()
    listener = appInstance.scope.createListener()
    isTestPassed = false
    listener.subscribe "test", (param) -> isTestPassed = param
    test.ok not isTestPassed
    listener.trigger "test", true
    test.ok isTestPassed
    test.done()

  "test response object": (test) ->
    appInstance = new App()
    responseInstance = appInstance.scope.createResponse()
    isTestPassed = false
    responseInstance.bindApply (param) -> isTestPassed = param
    test.ok not isTestPassed
    responseInstance.apply true
    test.ok isTestPassed
    test.done()