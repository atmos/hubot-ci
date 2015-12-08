module.exports.cassettes =
  "/repos-atmos-hubot-deploy-status-mysha-success":
    host: "https://api.github.com:443"
    path: "/repos/atmos/hubot-deploy/commits/mysha/statuses"
    method: "get"
    code: 200
    body: [
      {
        id: 1
        url: "https://api.github.com/repos/atmos/hubot-deploy/commits/mysha/statuses"
        state: "success"
        target_url: "https://ci.example.com/1000/output",
        description: "Build has completed successfully",
        context: "continuous-integration/jenkins",
        creator:
          id: 1
          login: "octocat"
          avatar_url: "https://github.com/images/error/octocat_happy.gif"
      }
    ]

  "/repos-atmos-hubot-deploy-status-mysha-failure":
    host: "https://api.github.com:443"
    path: "/repos/atmos/hubot-deploy/commits/mysha/statuses"
    method: "get"
    code: 200
    body: [
      {
        id: 1
        url: "https://api.github.com/repos/atmos/hubot-deploy/commits/mysha/statuses"
        state: "failure"
        target_url: "https://ci.example.com/1000/output",
        description: "Build was not successful",
        context: "continuous-integration/jenkins",
        creator:
          id: 1
          login: "octocat"
          avatar_url: "https://github.com/images/error/octocat_happy.gif"
      }
    ]

  "/repos-atmos-hubot-deploy-status-mysha-pending":
    host: "https://api.github.com:443"
    path: "/repos/atmos/hubot-deploy/commits/mysha/statuses"
    method: "get"
    code: 200
    body: [
      {
        id: 1
        url: "https://api.github.com/repos/atmos/hubot-deploy/commits/mysha/statuses"
        state: "pending"
        target_url: "https://ci.example.com/1000/output",
        description: "Build pending",
        context: "continuous-integration/jenkins",
        creator:
          id: 1
          login: "octocat"
          avatar_url: "https://github.com/images/error/octocat_happy.gif"
      }
    ]
