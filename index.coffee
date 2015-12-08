Path = require 'path'

module.exports = (robot, scripts) ->
  robot.loadFile("hubot-vault")
  robot.loadFile(Path.resolve(__dirname, "src", "scripts"), "ci.coffee")
