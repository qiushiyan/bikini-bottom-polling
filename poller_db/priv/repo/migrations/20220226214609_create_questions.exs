defmodule PollerDb.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add(:title, :string)
      add(:district_id, references(:districts, on_delete: :delete_all))

      timestamps()
    end

    create(index(:questions, :district_id))

  end
end
