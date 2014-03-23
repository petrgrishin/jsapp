App = require "../../src/app"

module.exports.AppTest =
  setUp: (callback) ->
    @appInstance = new App
    callback()

  "test simple": (test) ->
    result = @appInstance.f "testName", ->
    test.equal result, true
    test.done
