defmodule Thumbsup.Repo.Migrations.CreateIncomingTexts do
  use Ecto.Migration

  def change do
    create table(:incoming_texts) do
      add :body, :string
      add :conversation_id, references(:conversations)
      add :user_id, references(:users)
      timestamps()
    end

  end
end
