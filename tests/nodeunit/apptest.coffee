App = require "../../../build/app"
global._ = require "underscore"
global.$ = require "jquery"

module.exports.AppTest =
  "test listener gear": (test) ->
    appInstance = new App()
    result = 0
    firstListener = appInstance.scope.createListener()
    secondListener = appInstance.scope.createListener()
    isTestPassed = false
    firstListener.subscribe "test", (param) ->
      isTestPassed = param
      result += 1
    test.ok not isTestPassed
    firstListener.trigger "test", true
    secondListener.trigger "test", true
    test.ok isTestPassed
    test.equals 1, result
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

  "test dependence scripts": (test) ->
    appInstance = new App()
    queueCall = []
    appInstance.register "first.script", -> queueCall.push "first.script"
    appInstance.register "second.script", -> queueCall.push "second.script"
#    TODO:
#    appInstance.run "first.script"
#    appInstance.run "second.script"
#    test.deepEqual queueCall, ["first.script", "second.script"]
    test.done()
