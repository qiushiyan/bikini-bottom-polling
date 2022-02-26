defmodule Poller.PollServer do
  use GenServer
  alias Poller.Poll

  def start_link(district_id) do
    name = district_name(district_id)
    GenServer.start_link(__MODULE__, district_id, name: name)
  end

  @impl true
  def init(district_id) do
    poll = Poll.new(district_id)
    {:ok, poll}
  end

  def get_poll(district_id) do
    name = district_name(district_id)
    GenServer.call(name, {:get_poll})
  end

  def add_question(district_id, question) do
    name = district_name(district_id)
    GenServer.call(name, {:add_question, question})
  end

  def vote(district_id, candidate_id) do
    name = district_name(district_id)
    GenServer.call(name, {:vote, candidate_id})
  end

  @impl true
  def handle_call({:add_question, question}, _from, poll) do
    new_poll = Poll.add_question(poll, question)
    {:reply, new_poll, new_poll}
  end

  @impl true
  def handle_call({:vote, candidate_id}, _from, poll) do
    new_poll = Poll.vote(poll, candidate_id)
    {:reply, new_poll, new_poll}
  end

  @impl true
  def handle_call({:get_poll}, _from, poll) do
    {:reply, poll, poll}
  end

  defp district_name(district_id), do: String.to_atom("district_#{district_id}")
end
