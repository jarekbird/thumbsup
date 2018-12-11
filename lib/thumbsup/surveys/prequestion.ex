defmodule Thumbsup.Surveys.Prequestion do
  use Ecto.Schema
  import Ecto.Changeset
  alias Thumbsup.Surveys.Question


  schema "prequestions" do
    field :text, :string
    belongs_to :question, Question

    timestamps()
  end

  @doc false
  def changeset(prequestion, attrs) do
    prequestion
    |> cast(attrs, [:text, :question_id])
    |> validate_required([:text, :question_id])
  end
end
