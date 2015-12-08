global.assert = require("chai").assert
require("chai").Assertion.includeStack = true
process.env.NODE_ENV = 'test'
process.env.HUBOT_FERNET_SECRETS = "cw_0x689RpI-jtRR7oE8h_eQsKImvJapLeSbXpwF4e4="
process.env.HUBOT_DEPLOY_APPS_JSON = require("path").join(__dirname, "test_apps.json")
