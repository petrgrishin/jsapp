App = require "../../src/app"

module.exports.AppTest =
  "test simple": (test) ->
    appInstance = new App()
    result = appInstance.f("testName", ->)
    test.equal(true, true)
    test.done()
