# Description
#   Custom Handlers for commit statuses from hubot-ci.
#

###########################################################################
module.exports = (robot) ->
  #########################################################################
  robot.on "hubot_ci_commit_status", (err, msg, deployment, status) ->
    if err
      robot.logger.info err
    if status? and status.statuses?
      for commitStatus in status.statuses
        msg.send "Build status for #{deployment.name}@#{deployment.ref}(#{status.sha[0..7]}) - #{commitStatus.context} - #{commitStatus.state} - #{commitStatus.target_url}."
