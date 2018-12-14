defmodule Thumbsup.Surveys.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thumbsup.Surveys.Question
  alias Thumbsup.Surveys.Prequestion
  alias Thumbsup.Accounts.User

  schema "conversations" do
    field :state, ConversationStateEnum, default: :created
    belongs_to :question, Question
    belongs_to :prequestion, Prequestion
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def unvalidated_changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:state, :question_id, :user_id, :prequestion_id])
  end

  def validate_changeset(changeset) do
    changeset
    |> validate_required([:state, :user_id])
  end
end
