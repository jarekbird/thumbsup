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
  alias Thumbsup.Surveys.ConversationEngine
  alias Thumbsup.Surveys.GifResponse
  alias Thumbsup.Surveys.GifResponse
  alias Thumbsup.Surveys.IncomingText

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
    conversation = %Conversation{}
    |> Conversation.unvalidated_changeset(attrs)
    |> preset_question()
    |> repo_insert_conversation()
    |> elem(1)
    |> complete_other_conversations()
    |> ConversationEngine.progress_conversation()
  end

  def preset_question(%Ecto.Changeset{} = changeset) do
    unless Map.has_key?(changeset.changes, :question_id) do
      put_change(changeset, :question_id, determine_random_question().id)
    else
      changeset
    end
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

  def list_incoming_texts do
    Repo.all(IncomingText)
  end

  def get_incoming_text!(id), do: Repo.get!(IncomingText, id)

  def create_incoming_text(attrs \\ %{}) do
    %IncomingText{}
    |> IncomingText.changeset(attrs)
    |> Repo.insert()
    |> elem(1)
    |> ConversationEngine.link_incoming_text_to_conversation()
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

  def list_gif_responses do
    Repo.all(GifResponse)
  end

  def get_gif_response!(id), do: Repo.get!(GifResponse, id)

  def create_gif_response(attrs \\ %{}) do
    %GifResponse{}
    |> GifResponse.changeset(attrs)
    |> Repo.insert()
  end

  def update_gif_response(%GifResponse{} = gif_response, attrs) do
    gif_response
    |> GifResponse.changeset(attrs)
    |> Repo.update()
  end

  def delete_gif_response(%GifResponse{} = gif_response) do
    Repo.delete(gif_response)
  end

  def change_gif_response(%GifResponse{} = gif_response) do
    GifResponse.changeset(gif_response, %{})
  end

  def determine_incoming_text_conversation(%IncomingText{} = incoming_text) do
    user = Repo.preload(incoming_text, :user).user
    Repo.one(from c in Conversation, where: c.state in ["question", "gif_response", "further_feedback"], where: c.user_id == ^user.id)
  end

  def complete_other_conversations(%Thumbsup.Surveys.Conversation{} = conversation) do
    user = Repo.preload(conversation, :user).user
    (from c in Conversation, where: c.user_id == ^user.id, where: c.id != ^conversation.id)
    |> Repo.update_all(set: [state: "completed"])
    conversation
  end

  def question_gif_responses(%Question{} = question, boolean = positive_sentiment) do
    IO.puts question.id
    IO.puts positive_sentiment
    (from g in GifResponse, where: g.question_id == ^question.id, where: g.positive_sentiment == ^positive_sentiment)
    |> Repo.all()
  end
end
