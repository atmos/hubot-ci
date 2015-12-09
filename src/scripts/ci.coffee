# Description
#   See the status of CI from chat https://github.com/atmos/hubot-ci
#
# Commands:
#   hubot ci status myapp - see the status of the default branch for app
#   hubot ci status myapp/mybranch - see the status of a branch of app
#   hubot ci:version - show the script version and node/environment info
#
supported_tasks = [ "ci status" ]

Path          = require("path")
Commit        = require(Path.join(__dirname, "..", "models", "commit")).Commit
Version       = require(Path.join(__dirname, "..", "version")).Version
Deployment    = require("hubot-deploy/src/github/api").Deployment

Verifiers        = require "hubot-deploy/src/models/verifiers"
TokenForBrain    = Verifiers.VaultKey
ApiTokenVerifier = Verifiers.ApiTokenVerifier


###########################################################################
module.exports = (robot) ->
  ###########################################################################
  # ci status <app>/<branch|sha|tag>
  #
  # Displays the required statuses of the application
  robot.respond /ci status ([-_\.0-9a-z]+)(?:\/([^\s]+))?/i, (msg) ->
    name  = msg.match[1]
    ref   = (msg.match[2]||'master')

    deployment = new Deployment(name, ref)

    user = robot.brain.userForId msg.envelope.user.id
    token = robot.vault.forUser(user).get(TokenForBrain)
    if token?
      deployment.setUserToken(token)

    commit = new Commit(deployment.userToken, deployment.repository, ref)
    commit.status (err, data) ->
      robot.emit "hubot_ci_commit_status", err, msg, deployment, data

  ###########################################################################
  # ci:verify
  #
  # Useful for debugging
  robot.respond /ci\:verify$/i, (msg) ->
    user = robot.brain.userForId msg.envelope.user.id
    token = robot.vault.forUser(user).get(TokenForBrain)
    verifier = new ApiTokenVerifier(token)
    verifier.valid (result) ->
      if result
        msg.send "Your GitHub token is valid on #{verifier.config.hostname}."
      else
        msg.send "Your GitHub token is invalid, verify that it has 'repo' scope."

  ###########################################################################
  # ci:version
  #
  # Useful for debugging
  robot.respond /ci\:version$/i, (msg) ->
    msg.send "hubot-ci v#{Version}/hubot v#{robot.version}/node #{process.version}"
