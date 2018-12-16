defmodule Thumbsup.Repo.Migrations.CreateGifResponses do
  use Ecto.Migration

  def change do
    create table(:gif_responses) do
      add :url, :string
      add :positive_sentiment, :boolean, default: false, null: false
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:gif_responses, [:question_id])
  end
end
