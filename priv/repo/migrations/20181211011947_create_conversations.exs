defmodule Thumbsup.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :state, :integer
      add :question_id, references(:questions)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
