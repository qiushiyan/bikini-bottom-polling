defmodule PollerDb.Candidates do
  import Ecto.Query
  alias PollerDb.Repo
  alias PollerDb.Candidates.Candidate

  def list_candidates_by_question_id(question_id) do
    from(
      c in Candidate,
      where: c.question_id == ^question_id
    )
    |> Repo.all()
  end

  def cretae_candidate(attrs) do
    %Candidate{}
    |> Candidate.changeset(attrs)
    |> Repo.insert()
  end

  def update_candidate(%Candidate{} = candidate, attrs) do
    candidate
    |> Candidate.changeset(attrs)
    |> Repo.update()
  end

  def delete_candidate(%Candidate{} = candidate) do
    candidate |> Repo.delete()
  end

  def list_candidates do
    Repo.all(Candidate)
  end

  def get_question!(id) do
    Repo.get!(Candidate, id)
  end
end
