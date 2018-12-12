defmodule Thumbsup.Repo.Migrations.AddPrequestionsToConversation do
  use Ecto.Migration

  def change do
    alter table(:conversations) do
      add :prequestion_id, references(:prequestions)
    end
  end
end
