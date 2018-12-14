defmodule Thumbsup.Surveys.ConversationEngine do
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys
  alias Thumbsup.Surveys.SetConversationState
  alias Thumbsup.Surveys.ConversationState
  alias Thumbsup.Surveys.Bandwidth
  alias Thumbsup.Surveys.IncomingText
  import Ecto.Query, warn: false
  alias Thumbsup.Repo

  @awaiting_response_states ["question", "further_feedback"]

  def progress_conversation(%Conversation{} = conversation) do
    apply(__MODULE__, String.to_atom("progress_at_" <> to_string(conversation.state)), [conversation])
  end

  def progress_conversation(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
    apply(__MODULE__, String.to_atom("progress_at_" <> to_string(conversation.state)), [conversation, incoming_text])
  end

  # def awaiting_response?(%Conversation{} = conversation) do
  #   if ConversationState.question?(conversation) || ConversationState.further_feedback?(conversation) do
  #     true
  #   else
  #     false
  #   end
  # end

  def progress_at_created(%Conversation{} = conversation) do
    progress_to_prequestion(conversation)
  end

  def progress_to_prequestion(%Conversation{} = conversation) do
    conversation
    |> set_prequestion()
    |> elem(1)
    |> SetConversationState.prequestion()
    |> elem(1)
    |> progress_conversation
  end

  def progress_at_prequestion(%Conversation{} = conversation) do
    progress_to_question(conversation)
  end

  def progress_to_question(%Conversation{} = conversation) do
    conversation
    |> Repo.preload(:question)
    |> Repo.preload(:user)
    |> Repo.preload(:prequestion)
    |> send_conversation_question()
    |> SetConversationState.question()
  end

  # def progress_at_question(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
  #   progress_to_question_answered(conversation, incoming_text)
  # end

  # def progress_to_question_answered(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
  # end

  # def progress_at_question_answered(%Conversation{} = conversation) do
  # end

  # def progress_at_gif_response(%Conversation{} = conversation) do
  # end

  # def progress_at_further_feedback(%Conversation{} = conversation) do
  # end

  def set_prequestion(%Conversation{} = conversation) do
    prequestion = determine_random_prequestion(conversation)
    Surveys.update_conversation(conversation, %{prequestion_id: prequestion.id})
  end

  def determine_random_prequestion(%Thumbsup.Surveys.Conversation{} = conversation) do
    (conversation.question_id
    |> Surveys.get_question!()
    |> Repo.preload(:prequestions)).prequestions
    |> Enum.random()
  end

  def send_conversation_question(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> question_message
    |> Bandwidth.send_message(conversation.user)
    conversation
  end

  def question_message(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.prequestion.text <> " " <> conversation.question.text
  end

  def determine_incoming_text_conversation(%IncomingText{} = incoming_text) do
    user_id = Repo.preload(incoming_text, :users).user.id
    conversation = Repo.one(from c in Conversation, where: c.state in @awaiting_response_states, where: c.user_id == ^user_id)
    if conversation do
      updated_incoming_text = Surveys.update_incoming_text!(incoming_text, %{conversation_id: conversation.id}) |> elem(1)
      progress_conversation(conversation, updated_incoming_text)
    end
  end
 end