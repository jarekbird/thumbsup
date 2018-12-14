defmodule Thumbsup.Surveys.SetConversationState do
  alias Thumbsup.Surveys.Conversation
  alias Thumbsup.Surveys

  def created(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :created})
    |> Surveys.repo_update_conversation()
  end

  def prequestion(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :prequestion})
    |> Surveys.repo_update_conversation()
  end

  def question(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :question})
    |> Surveys.repo_update_conversation()
  end

  def question_answered(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :question_answered})
    |> Surveys.repo_update_conversation()
  end

  def gif_response(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :gif_response})
    |> Surveys.repo_update_conversation()
  end

  def further_feedback(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :gif_response})
    |> Surveys.repo_update_conversation()
  end

  def further_feedback_received(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :further_feedback_received})
    |> Surveys.repo_update_conversation()
  end

  def completed(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Conversation.unvalidated_changeset(%{state: :completed})
    |> Surveys.repo_update_conversation()
  end
end