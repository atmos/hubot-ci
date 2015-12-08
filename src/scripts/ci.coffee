# Description
#   Cut GitHub deployments from chat that deploy via hooks - https://github.com/atmos/hubot-deploy
#
# Commands:
#   hubot ci status hubot-ci - see what environments you can deploy app
#   hubot ci status hubot-ci/mybranch - see what environments you can deploy app
#   hubot ci:version - show the script version and node/environment info
#
supported_tasks = [ "ci status" ]

Path          = require("path")
Version       = require(Path.join(__dirname, "..", "version")).Version

###########################################################################
module.exports = (robot) ->
  ###########################################################################
  # ci status <app>/<branch|sha|tag>
  #
  # Displays the required statuses of the application
  robot.respond ///ci status( (\*\/[-_\+\.a-zA-z0-9\/]+))?$///i, (msg) ->
    robot.logger.info "Requesting status"

  ###########################################################################
  # ci:version
  #
  # Useful for debugging
  robot.respond /ci\:version$/i, (msg) ->
    msg.send "hubot-ci v#{Version}/hubot v#{robot.version}/node #{process.version}"
