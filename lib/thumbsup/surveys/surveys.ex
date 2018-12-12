defmodule Thumbsup.Surveys do
  @moduledoc """
  The Surveys context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Thumbsup.Repo
  alias Thumbsup.Surveys.Prequestion
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys.Question
  alias Thumbsup.Surveys.Bandwidth

  def list_questions do
    Repo.all(Question)
  end

  def get_question!(id) do 
    Question
    |> Repo.get!(id)
    |> Repo.preload(:prequestions)
  end

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

  def get_conversation!(id) do 
    Repo.get!(Conversation, id)
  end

  def create_conversation(attrs \\ %{}) do
    %Conversation{}
    |> Conversation.changeset(attrs)
    |> set_random_conversation_values()
    |> Repo.insert()
    |> elem(1)
    |> Repo.preload(:question)
    |> Repo.preload(:user)
    |> send_first_conversation_message()
    |> increment_conversation_state()
  end

  def send_first_conversation_message(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> conversation_first_message
    |> Bandwidth.send_message(conversation.user)
    conversation
  end

  def increment_conversation_state(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.changeset(%{state: conversation.state + 1})
    |> Repo.update()
  end

  def conversation_first_message(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.prequestion.text <> " " <> conversation.question.text
  end

  def determine_random_prequestion(%Ecto.Changeset{} = changeset) do
    get_question!(changeset.changes.question_id).prequestions
    |> Enum.random()
  end

  def determine_random_prequestion(%Thumbsup.Surveys.Conversation{} = conversation) do
    get_question!(conversation.question.id).prequestions
    |> Enum.random()
  end

  def set_random_conversation_values(%Ecto.Changeset{} = changeset) do
    changeset
    |> put_change(:prequestion, determine_random_prequestion(changeset))
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
