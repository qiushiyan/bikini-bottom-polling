defmodule PollerDb.Candidates.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  @parties [
    {"Communist", 1},
    {"Republican", 2},
    {"Democrat", 3}
  ]

  @party_ids Enum.map(@parties, &elem(&1, 1))

  schema "candidates" do
    field(:name, :string)
    field(:party, :integer)
    field(:votes, :integer, default: 0)
    field(:slogan, :string, default: "")
    belongs_to(:question, PollerDb.Questions.Question)

    timestamps()
  end

  def changeset(candidate, attrs \\ %{}) do
    candidate
    |> cast(attrs, [:name, :party, :votes, :slogan, :question_id])
    |> validate_required([:name, :party, :question_id])
    |> validate_length(:name, min: 2, max: 20)
    |> validate_length(:slogan, min: 5, max: 30)
    |> validate_number(:votes, min: 0)
    |> validate_inclusion(:party, @party_ids)
    |> assoc_constraint(:question)
  end

  def party_name(id) do
    case Enum.find(@parties, fn {_, party_id} -> party_id == id end) do
      nil -> ""
      {name, _} -> name
    end
  end
end
