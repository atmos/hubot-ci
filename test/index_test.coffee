Path          = require("path")
Robot         = require "hubot/src/robot"
TextMessage   = require("hubot/src/message").TextMessage

pkg = require Path.join __dirname, "..", 'package.json'
pkgVersion = pkg.version

describe "The hubot-ci Script", () ->
  user  = null
  robot = null
  adapter = null

  beforeEach (done) ->
    robot = new Robot(null, "mock-adapter", true, "Hubot")

    robot.adapter.on "connected", () ->
      require("../index")(robot)

      userInfo =
        name: "atmos",
        room: "#my-room"

      user    = robot.brain.userForId "1", userInfo
      adapter = robot.adapter

      done()

    robot.run()

  afterEach () ->
    robot.server.close()
    robot.shutdown()

  it "tells you when your provided GitHub token is invalid", (done) ->
    adapter.on "send", (envelope, strings) ->
      expected = "hubot-ci v#{pkgVersion}/hubot v#{robot.version}/node #{process.version}"
      assert.equal strings[0], expected
      done()

    adapter.receive(new TextMessage(user, "hubot ci:version"))
