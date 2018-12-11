defmodule Thumbsup.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  alias Thumbsup.Repo
  alias Thumbsup.Surveys.Prequestion
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys.Question

  def list_questions do
    Repo.all(Question)
  end

  def get_question!(id), do: Repo.get!(Question, id)

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  def change_question(%Question{} = question) do
    Question.changeset(question, %{})
  end

  def list_conversations do
    Repo.all(Conversation)
  end

  def get_conversation!(id), do: Repo.get!(Conversation, id)

  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> Repo.insert()
    |> begin_conversation()
  end

  def begin_conversation(%Conversation{} = conversation) do
  end

  def set_random_conversation_values(%Conversation{} = conversation) do
    conversation
  end

  def update_conversation(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.changeset(attrs)
    |> Repo.update()
  end

  def delete_conversation(%Conversation{} = conversation) do
    Repo.delete(conversation)
  end

  def change_conversation(%Conversation{} = conversation) do
    Conversation.changeset(conversation, %{})
  end

  def list_prequestions do
    Repo.all(Prequestion)
  end

  def get_prequestion!(id), do: Repo.get!(Prequestion, id)

  def create_prequestion(attrs \\ %{}) do
    %Prequestion{}
    |> Prequestion.changeset(attrs)
    |> Repo.insert()
  end

  def update_prequestion(%Prequestion{} = prequestion, attrs) do
    prequestion
    |> Prequestion.changeset(attrs)
    |> Repo.update()
  end

  def delete_prequestion(%Prequestion{} = prequestion) do
    Repo.delete(prequestion)
  end

  def change_prequestion(%Prequestion{} = prequestion) do
    Prequestion.changeset(prequestion, %{})
  end
end
