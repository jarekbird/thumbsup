defmodule Thumbsup.Surveys.ConversationState do
  alias Thumbsup.Surveys.Conversation

  def created?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :conversation
  end

  def prequestion?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :prequestion
  end

  def question?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :question
  end

  def question_answered?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :question_answered?
  end

  def gif_response?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :gif_response
  end

  def further_feedback?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :further_feedback
  end

  def further_feedback_received?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :further_feedback_received
  end

  def completed?(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.state == :completed
  end
end