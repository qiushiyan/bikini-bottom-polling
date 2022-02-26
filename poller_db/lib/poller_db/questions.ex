defmodule PollerDb.Questions do
  import Ecto.Query
  alias PollerDb.Repo
  alias PollerDb.Questions.Question

  def list_questions_by_district_id(question_id) do
    from(
      q in Question,
      where: q.question_id == ^question_id
    )
    |> Repo.all()
  end

  def cretae_question(attrs) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def delete_question(%Question{} = question) do
    question |> Repo.delete()
  end

  def list_questions do
    Repo.all(Question)
  end

  def get_question!(id) do
    Repo.get!(Question, id)
  end
end
