import Config

config :poller_db, PollerDb.Repo,
  database: "poller",
  username: "qiushi",
  password: "qiushi",
  hostname: "localhost"

config :poller_db,
  ecto_repos: [PollerDb.Repo]
