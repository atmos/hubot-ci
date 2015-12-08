Path          = require("path")
Robot         = require "hubot/src/robot"
TextMessage   = require("hubot/src/message").TextMessage

Verifiers = require "hubot-deploy/src/models/verifiers"
TokenForBrain    = Verifiers.VaultKey

pkg = require Path.join __dirname, "..", "..", "package.json"
pkgVersion = pkg.version

describe "The hubot-ci Script", () ->
  user  = null
  robot = null
  adapter = null

  beforeEach (done) ->
    robot = new Robot(null, "mock-adapter", true, "Hubot")

    robot.adapter.on "connected", () ->
      require("hubot-deploy")(robot)
      require("hubot-vault")(robot)
      require("../../index")(robot)

      userInfo =
        name: "atmos",
        room: "#my-room"

      user    = robot.brain.userForId "1", userInfo
      adapter = robot.adapter

      robot.vault.forUser(user).set(TokenForBrain, "my-github-token")
      done()

    robot.run()

  afterEach () ->
    robot.server.close()
    robot.shutdown()

  it "tells you the version of hubot-ci", (done) ->
    adapter.on "send", (envelope, strings) ->
      expected = "hubot-ci v#{pkgVersion}/hubot v#{robot.version}/node #{process.version}"
      assert.equal strings[0], expected
      done()

    adapter.receive(new TextMessage(user, "hubot ci:version"))

  it "tells you if master is green", (done) ->
    adapter.on "send", (envelope, strings) ->
      expected = "Building atmos/hubot-deploy/master"
      assert.equal strings[0], expected
      done()

    adapter.receive(new TextMessage(user, "hubot ci status hubot-deploy"))
