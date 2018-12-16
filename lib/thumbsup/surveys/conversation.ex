defmodule Thumbsup.Surveys.Conversation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thumbsup.Surveys.Question
  alias Thumbsup.Surveys.Prequestion
  alias Thumbsup.Accounts.User
  alias Thumbsup.Surveys.GifResponse

  schema "conversations" do
    field :state, ConversationStateEnum, default: :created
    field :positive_sentiment, :boolean
    field :additional_feedback, :string
    belongs_to :question, Question
    belongs_to :prequestion, Prequestion
    belongs_to :user, User
    belongs_to :gif_response, GifResponse

    timestamps()
  end

  @doc false
  def unvalidated_changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:state, :question_id, :user_id, :prequestion_id, :gif_response_id, :positive_sentiment, :additional_feedback])
  end

  def validate_changeset(changeset) do
    changeset
    |> validate_required([:state, :user_id])
  end

  def appended_additional_feedback(%Thumbsup.Surveys.Conversation{} = conversation, string = new_feedback) do
    if conversation.additional_feedback do
      conversation.additional_feedback <> " " <> new_feedback
    else
      new_feedback
    end
  end
end
