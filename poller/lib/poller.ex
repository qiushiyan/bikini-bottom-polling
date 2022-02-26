defmodule Poller do
  use Application
  alias Poller.PollSupervisor

  def start(_, _) do
    Supervisor.start_link([PollSupervisor], strategy: :one_for_one)
  end
end
