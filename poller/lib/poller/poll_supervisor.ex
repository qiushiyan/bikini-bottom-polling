defmodule Poller.PollSupervisor do
  use DynamicSupervisor
  alias Poller.PollServer

  @name :poll_server_supervisor
  def start_link(_args) do
    IO.puts("starting supervisor for poll server")
    DynamicSupervisor.start_link(__MODULE__, :ok, name: @name)
  end

  @spec start_poll(any) :: :ignore | {:error, any} | {:ok, pid} | {:ok, pid, any}
  def start_poll(district_id) do
    child_spec = {PollServer, district_id}
    IO.puts("starting poll server for district #{district_id}")
    DynamicSupervisor.start_child(@name, child_spec)
  end

  def init(_args), do: DynamicSupervisor.init(strategy: :one_for_one)
end
