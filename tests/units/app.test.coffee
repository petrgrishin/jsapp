test("test simple", ->
  appInstance = new App
  result = appInstance.f("testName", ->)
  ok(true)
)