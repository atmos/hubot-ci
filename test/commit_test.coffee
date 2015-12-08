Path          = require("path")
Commit        = require("../src/models/commit").Commit

describe "A GitHub commit", () ->
  it "knows a status", (done) ->
    commit = new Commit("mytoken", "hubot-deploy", "mysha")
    commit.status (err, data) ->
      throw err if err
      assert.equal data, {}
      done()
