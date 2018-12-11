defmodule Thumbsup.Surveys.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thumbsup.Surveys.Question


  schema "conversations" do
    field :state, :integer
    belongs_to :question, Question

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:state])
    |> validate_required([:state])
  end
end
