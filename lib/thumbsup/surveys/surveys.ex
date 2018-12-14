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
  alias Thumbsup.Surveys.SetConversationState
  alias Thumbsup.Surveys.ConversationEngine

  def list_questions do
    Repo.all(Question)
  end

  def get_question!(id) do 
    Question
    |> Repo.get!(id)
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
    |> Conversation.unvalidated_changeset(attrs)
    |> put_change(:question_id, determine_random_question().id)
    |> repo_insert_conversation()
    |> elem(1)
    |> ConversationEngine.progress_conversation()
  end

  def repo_insert_conversation(%Ecto.Changeset{} = changeset) do
    changeset
    |> Conversation.validate_changeset()
    |> Repo.insert()
  end

  def determine_random_prequestion(%Ecto.Changeset{} = changeset) do
    changeset.changes.question_id
    |> get_question!()
    |> Repo.preload(:prequestions).prequestions
    |> Enum.random()
  end

  def determine_random_question() do
    list_questions()
    |> Enum.random()
  end

  def set_random_prequestion(%Ecto.Changeset{} = changeset) do
    put_change(changeset, :prequestion_id, determine_random_prequestion(changeset).id)
  end

  def progress_conversation(%Conversation{} = conversation) do
    
  end

  def update_conversation(%Conversation{} = conversation, attrs) do
    conversation
    |> Conversation.unvalidated_changeset(attrs)
    |> repo_update_conversation()
  end

  def repo_update_conversation(%Ecto.Changeset{} = changeset) do
    changeset
    |> Conversation.validate_changeset()
    |> Repo.update()
  end

  def delete_conversation(%Conversation{} = conversation) do
    Repo.delete(conversation)
  end

  def change_conversation(%Conversation{} = conversation) do
    Conversation.unvalidated_changeset(conversation, %{})
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

  alias Thumbsup.Surveys.IncomingText

  def list_incoming_texts do
    Repo.all(IncomingText)
  end

  def get_incoming_text!(id), do: Repo.get!(IncomingText, id)

  def create_incoming_text(attrs \\ %{}) do
    %IncomingText{}
    |> IncomingText.changeset(attrs)
    |> Repo.insert()
    |> elem(1)
    |> ConversationEngine.determine_incoming_text_conversation()
    # |> preload(:conversation).conversation
    # |> progress_conversation()
  end

  def update_incoming_text(%IncomingText{} = incoming_text, attrs) do
    incoming_text
    |> IncomingText.changeset(attrs)
    |> Repo.update()
  end

  def update_incoming_text!(%IncomingText{} = incoming_text, attrs) do
    incoming_text
    |> IncomingText.changeset(attrs)
    |> Repo.update!()
  end

  def delete_incoming_text(%IncomingText{} = incoming_text) do
    Repo.delete(incoming_text)
  end

  def change_incoming_text(%IncomingText{} = incoming_text) do
    IncomingText.changeset(incoming_text, %{})
  end
end
