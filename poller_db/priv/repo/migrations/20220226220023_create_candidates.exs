defmodule PollerDb.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:candidatse) do
      add(:name, :string)

      timestamps()
    end

  end
end
