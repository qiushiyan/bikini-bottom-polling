defmodule PollerDb.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add(:name, :string)
      add(:party, :integer)
      add(:votes, :integer)
      add(:slogan, :string)
      add(:question_id, references(:questions, on_delete: :delete_all))


      timestamps()
    end

    create(index(:candidates, [:question_id]))

  end
end
