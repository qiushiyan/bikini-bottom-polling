defmodule PollerDb.Repo do
  use Ecto.Repo,
    otp_app: :poller_db,
    adapter: Ecto.Adapters.Postgres
end
