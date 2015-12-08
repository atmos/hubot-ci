Path      = require "path"
Octonode  = require "octonode"
ApiConfig = require("hubot-deploy/src/models/api_config").ApiConfig
###########################################################################
class Commit
  constructor: (token, @repo, @sha) ->
    @token = token?.trim()

    @config = new ApiConfig(@token, null)
    @api   = Octonode.client(@config.token, {hostname: @config.hostname})

  status: (callback) ->
    @api.get "/repos/#{@repo}/commits/#{@sha}/statuses", (err, status, data, headers) ->
      callback(err, data)

module.exports.Commit = Commit
