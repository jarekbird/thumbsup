defmodule Thumbsup.Repo.Migrations.CreatePrequestions do
  use Ecto.Migration

  def change do
    create table(:prequestions) do
      add :text, :text
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:prequestions, [:question_id])
  end
end
