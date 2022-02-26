defmodule PollerTest do
  use ExUnit.Case
  alias Poller.{Candidate, Question, Poll}

  setup_all do
    poll = Poll.new(1)

    first_candidate = Candidate.new(1, "Sponge Bob", nil)
    second_candidate = Candidate.new(2, "Patrick Star", nil)

    question =
      Question.new(
        1,
        "Who is your favorite character?"
      )

    {:ok,
     poll: poll,
     question: question,
     first_candidate: first_candidate,
     second_candidate: second_candidate}
  end

  test "add candidate to question", state do
    question =
      state[:question]
      |> Question.add_candidate(state[:first_candidate])
      |> Question.add_candidate(state[:second_candidate])

    assert Map.get(question, :candidates, nil) == [
             state[:second_candidate],
             state[:first_candidate]
           ]
  end

  test "add question to poll", state do
    question = state[:question] |> Question.add_candidate(state[:first_candidate])
    poll = state[:poll] |> Poll.add_question(question)

    assert poll == %Poll{
             state[:poll]
             | questions: [
                 %Question{
                   id: 1,
                   title: "Who is your favorite character?",
                   candidates: [state[:first_candidate]]
                 }
               ],
               votes: %{1 => 0}
           }
  end

  test "vote for candidate", state do
    question =
      Question.add_candidate(state[:question], state[:first_candidate])
      |> Question.add_candidate(state[:second_candidate])

    poll =
      state[:poll] |> Poll.add_question(question) |> Poll.vote(1) |> Poll.vote(1) |> Poll.vote(2)

    assert poll == %Poll{
             state[:poll]
             | questions: [
                 %Question{
                   id: 1,
                   title: "Who is your favorite character?",
                   candidates: [state[:second_candidate], state[:first_candidate]]
                 }
               ],
               votes: %{1 => 2, 2 => 1}
           }
  end
end
