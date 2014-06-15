App = require "../../../build/app"
global._ = require "underscore"
global.$ = require "jquery"

global.$.ajax = () ->

module.exports.WidgetTest =
  "test listener gear": (test) ->
    isTestPassed = false
    appInstance = new App()
    responseInstance = appInstance.scope.createResponse()
    responseInstance.bindApply () -> isTestPassed = true
    area = appInstance.scope.createAreaWidget()
    area.onApply responseInstance
    test.ok not isTestPassed
    area.load()
    test.ok isTestPassed
    test.done()
