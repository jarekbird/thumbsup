defmodule Thumbsup.Surveys.IncomingText do
  use Ecto.Schema
  import Ecto.Changeset

  alias Surveys.Conversation
  alias Accounts.User


  schema "incoming_texts" do
    field :body, :string
    belongs_to :conversation, Conversation
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(incoming_text, attrs) do
    incoming_text
    |> cast(attrs, [:body, :conversation_id, :user_id])
    |> validate_required([:body, :user_id])
  end
end
