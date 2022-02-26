defmodule PollerDb do
  use Application

  def start(_, _) do
    children = [{PollerDb.Repo, []}]

    opts = [strategy: :one_for_one, name: :poller_db_supervisor]
    Supervisor.start_link(children, opts)
  end
end
