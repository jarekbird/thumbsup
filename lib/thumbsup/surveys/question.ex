defmodule Thumbsup.Surveys.Question do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys.Prequestion

  schema "questions" do
    field :text, :string
    has_many :conversations, Conversation
    has_many :prequestions, Prequestion

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
