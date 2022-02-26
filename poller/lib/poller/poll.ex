defmodule Poller.Poll do
  alias __MODULE__

  defstruct id: nil,
            questions: [],
            votes: %{}

  def new(id) do
    %Poll{id: id}
  end

  def add_question(poll, question) do
    votes = init_votes(poll.votes, question)

    questions = [question | poll.questions]
    %Poll{poll | questions: questions, votes: votes}
  end

  defp init_votes(votes, question) do
    question.candidates
    |> Enum.map(fn c -> {c.id, 0} end)
    |> Enum.into(votes)
  end

  def vote(poll, candidate_id) do
    do_vote(poll, candidate_id, Map.has_key?(poll.votes, candidate_id))
  end

  defp do_vote(poll, candidate_id, _has_candidate = true) do
    votes = Map.update!(poll.votes, candidate_id, &(&1 + 1))
    %Poll{poll | votes: votes}
  end

  defp do_vote(poll, _candidate_id, _has_candidate = false), do: poll
end
