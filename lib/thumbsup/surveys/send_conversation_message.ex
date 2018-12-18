defmodule Thumbsup.Surveys.SendConversationMessage do
  alias Thumbsup.Surveys.Bandwidth
  alias Thumbsup.Repo
  alias Thumbsup.Surveys.Conversation

  @confused_gif "https://media.tenor.com/images/ff2826ad679ed76ee2ce48aac1894e10/tenor.gif"
  @confused_message "Sorry, I didn't get that! Respond with a 👍 or 👎"
  @positive_feedback_prompt "That's So Great! Tell us why!"
  @negative_feedback_prompt "I'm sorry to hear that. Tell us why not?"
  @feedback_received "Thanks for the feedback! Remember, we keep everything anonymous"

  def confused_response(%Conversation{} = conversation) do
    user = Repo.preload(conversation, :user).user
    Bandwidth.send_mms_message(@confused_message, user, @confused_gif)
    conversation
  end

  def gif_response(%Conversation{} = conversation) do
    user = Repo.preload(conversation, :user).user
    gif_response = Repo.preload(conversation, :gif_response).gif_response
    if conversation.positive_sentiment do
      Bandwidth.send_mms_message(@positive_feedback_prompt, user, gif_response.url)
    else
      Bandwidth.send_mms_message(@negative_feedback_prompt, user, gif_response.url)
    end
    conversation
  end

  def feedback_received(%Conversation{} = conversation) do
    user = Repo.preload(conversation, :user).user
    Bandwidth.send_sms_message(@feedback_received, user) 
    conversation
  end

  def question(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation
    |> Repo.preload(:company)
    |> question_message()
    |> Bandwidth.send_sms_message(conversation.user)
    conversation
  end

  def question_message(%Thumbsup.Surveys.Conversation{} = conversation) do
    inject_company_name_into_prequestion(conversation) <> " " <> inject_company_name_into_question(conversation)
  end

  def inject_company_name_into_prequestion(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.prequestion.text
    |> String.replace("***company_name***", conversation.company.name)
  end

  def inject_company_name_into_question(%Thumbsup.Surveys.Conversation{} = conversation) do
    conversation.question.text
    |> String.replace("***company_name***", conversation.company.name)
  end
end