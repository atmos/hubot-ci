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
Version       = require(Path.join(__dirname, "..", "version")).Version
Deployment    = require("hubot-deploy/src/models/deployment").Deployment

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

    msg.send "Building #{deployment.repository}/#{ref}"

  ###########################################################################
  # ci:version
  #
  # Useful for debugging
  robot.respond /ci\:version$/i, (msg) ->
    msg.send "hubot-ci v#{Version}/hubot v#{robot.version}/node #{process.version}"
