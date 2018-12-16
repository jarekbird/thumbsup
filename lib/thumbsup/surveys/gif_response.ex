defmodule Thumbsup.Surveys.GifResponse do
  use Ecto.Schema
  import Ecto.Changeset


  schema "gif_responses" do
    field :positive_sentiment, :boolean, default: false
    field :url, :string
    field :question_id, :id

    timestamps()
  end

  @doc false
  def changeset(gif_response, attrs) do
    gif_response
    |> cast(attrs, [:url, :positive_sentiment])
    |> validate_required([:url, :positive_sentiment])
  end
end
