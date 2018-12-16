defmodule Thumbsup.Surveys.ConversationEngine do
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys
  alias Thumbsup.Surveys.ConversationState
  alias Thumbsup.Surveys.IncomingText
  alias Thumbsup.Surveys.SendConversationMessage
  alias Thumbsup.Repo

  @positive_sentiment ["👍", "yes"]
  @negative_sentiment ["👎", "no"]

  def progress_conversation(%Conversation{} = conversation) do
    apply(__MODULE__, String.to_atom("progress_at_" <> to_string(conversation.state)), [conversation])
  end

  def progress_conversation(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
    apply(__MODULE__, String.to_atom("progress_at_" <> to_string(conversation.state)), [conversation, incoming_text])
  end

  def progress_at_created(%Conversation{} = conversation) do
    progress_to_prequestion(conversation)
  end

  def progress_to_prequestion(%Conversation{} = conversation) do
    conversation
    |> set_prequestion()
    |> elem(1)
    |> Surveys.update_conversation(%{state: :prequestion})
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
    |> SendConversationMessage.question()
    |> Surveys.update_conversation(%{state: :question})
  end

  def parse_conversation_sentiment(%IncomingText{} = incoming_text) do
    cond do
      String.contains?(incoming_text.body, @positive_sentiment) ->
        true
      String.contains?(incoming_text.body, @negative_sentiment) ->
        false
      true ->
        nil
    end
  end

  def progress_at_question(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
    conversation_sentiment = Surveys.update_incoming_text!(incoming_text, %{conversation_id: conversation.id})
    |> parse_conversation_sentiment()
    updated_conversation = Surveys.update_conversation(conversation, %{positive_sentiment: conversation_sentiment}) |> elem(1)
    if conversation_sentiment === true || conversation_sentiment === false do
      progress_to_question_answered(updated_conversation)
    else
      SendConversationMessage.confused_response(updated_conversation)
    end
  end

  def progress_to_question_answered(%Conversation{} = conversation) do
    conversation
    |> Surveys.update_conversation(%{state: :question_answered})
    |> elem(1)
    |> progress_conversation()
  end

  def progress_at_question_answered(%Conversation{} = conversation) do
    progress_to_gif_response(conversation)
  end

  def progress_to_gif_response(%Conversation{} = conversation) do
    gif_response = determine_gif_response(conversation)
    Surveys.update_conversation(conversation, %{gif_response_id: gif_response.id})
    |> elem(1)
    |> SendConversationMessage.gif_response()
    |> Surveys.update_conversation(%{state: :gif_response})
  end

  def progress_at_gif_response(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
    progress_at_further_feedback(conversation, incoming_text)
  end

  def progress_at_further_feedback(%Conversation{} = conversation, %IncomingText{} = incoming_text) do
    additional_feedback = Conversation.appended_additional_feedback(conversation, incoming_text.body)
    conversation
    |> Surveys.update_conversation(%{additional_feedback: additional_feedback, state: :further_feedback})
    |> elem(1)
    |> SendConversationMessage.feedback_received()
  end

  def set_prequestion(%Conversation{} = conversation) do
    prequestion = determine_random_prequestion(conversation)
    Surveys.update_conversation(conversation, %{prequestion_id: prequestion.id})
  end

  def determine_random_prequestion(%Conversation{} = conversation) do
    (conversation.question_id
    |> Surveys.get_question!()
    |> Repo.preload(:prequestions)).prequestions
    |> Enum.random()
  end

  def link_incoming_text_to_conversation(%IncomingText{} = incoming_text) do
    conversation = Surveys.determine_incoming_text_conversation(incoming_text)
    if conversation do
      progress_conversation(conversation, incoming_text)
      {:ok, incoming_text}
    else
      {:noop, incoming_text}
    end
  end

  def determine_gif_response(%Conversation{} = conversation) do
    IO.puts inspect(conversation)
    (conversation
    |> Repo.preload(:question)).question
    |> Surveys.question_gif_responses(conversation.positive_sentiment)
    |> Enum.random()
  end
 end