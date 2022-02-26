defmodule Poller.Question do
  alias __MODULE__
  defstruct id: nil, title: nil, candidates: []

  def new(id, title) do
    %Question{id: id, title: title}
  end

  def add_candidate(question, candidate) do
    candidates = [candidate | question.candidates]
    Map.put(question, :candidates, candidates)
  end
end
