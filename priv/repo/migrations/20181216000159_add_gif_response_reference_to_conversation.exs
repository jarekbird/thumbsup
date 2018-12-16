defmodule Thumbsup.Repo.Migrations.AddGifResponseReferenceToConversation do
  use Ecto.Migration

  def change do
    alter table(:conversations) do
      add :gif_response_id, references(:gif_responses)
      add :additional_feedback, :text
    end
  end
end
