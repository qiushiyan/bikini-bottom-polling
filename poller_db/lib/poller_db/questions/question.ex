defmodule PollerDb.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field(:title, :string)
    belongs_to(:district, PollerDb.Districts.District)
    timestamps()
  end

  def changeset(question, attrs \\ %{}) do
    question
    |> cast(attrs, [:title, :district_id])
    |> validate_required([:title, :district_id])
    |> validate_length(:title, min: 2, max: 50)
    |> assoc_constraint(:district)
  end
end
