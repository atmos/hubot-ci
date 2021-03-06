VCR    = require "ys-vcr"
Path   = require("path")
Commit = require("../../src/models/commit").Commit

describe "A GitHub commit", () ->
  beforeEach (done) ->
    VCR.playback()
    done()

  afterEach () ->
    VCR.stop()

  it "knows a success status", (done) ->
    VCR.play "/repos-atmos-hubot-deploy-status-mysha-success"
    commit = new Commit("mytoken", "atmos/hubot-deploy", "mysha")
    commit.status (err, data) ->
      throw err if err
      jenkins = data[0]
      assert.equal jenkins.state, "success"
      assert.equal jenkins.context, "continuous-integration/jenkins"
      assert.equal jenkins.target_url, "https://ci.example.com/1000/output"
      assert.equal jenkins.description, "Build has completed successfully"
      done()

  it "knows a failure status", (done) ->
    VCR.play "/repos-atmos-hubot-deploy-status-mysha-failure"
    commit = new Commit("mytoken", "atmos/hubot-deploy", "mysha")
    commit.status (err, data) ->
      throw err if err
      jenkins = data[0]
      assert.equal jenkins.state, "failure"
      assert.equal jenkins.context, "continuous-integration/jenkins"
      assert.equal jenkins.target_url, "https://ci.example.com/1000/output"
      assert.equal jenkins.description, "Build was not successful"
      done()

  it "knows a pending status", (done) ->
    VCR.play "/repos-atmos-hubot-deploy-status-mysha-pending"
    commit = new Commit("mytoken", "atmos/hubot-deploy", "mysha")
    commit.status (err, data) ->
      throw err if err
      jenkins = data[0]
      assert.equal jenkins.state, "pending"
      assert.equal jenkins.context, "continuous-integration/jenkins"
      assert.equal jenkins.target_url, "https://ci.example.com/1000/output"
      assert.equal jenkins.description, "Build pending"
      done()
