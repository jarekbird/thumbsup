defmodule Thumbsup.Surveys.Bandwidth do
  alias Thumbsup.Accounts.User
  alias Thumbsup.Accounts

  @first_message "Hello from Thumbsup! Your company has committed to providing you a better experience at work and has partnered with Thumbsup to get feedback from you! Respond to each question with a 👍 or 👎 and be sure to include extra feedback!"
  @thumbsup_phone_number "13852037751"
  @thumbsup_bandwidth_authorization "Basic dC1heG5rdGJ4Mm1iNGFjY29nd2Q0cnNkaTpvb2F4bHhrbXE3eXJmM3RocWVnaWEzdnFiY2hmZTZjaDJwbXNveGE="
  @bandwidth_url "https://api.catapult.inetwork.com/v1/users/u-pffxsmatqcxm4grkewgl6dq/messages"

  def send_sms_message(string = message, %User{} = user) do
    unless user.welcome_message do
      send_first_message(user)
    end
    IO.puts message
    Jason.encode!(%{from: @thumbsup_phone_number, to: user.phone_number, text: message})
    |> connect_to_bandwidth()
  end

  def send_mms_message(string = message, %User{} = user, media_url) do
    unless user.welcome_message do
      send_first_message(user)
    end
    IO.puts message
    IO.puts media_url
    Jason.encode!(%{from: @thumbsup_phone_number, to: user.phone_number, text: message, media: media_url})
    |> connect_to_bandwidth()
  end

  def connect_to_bandwidth(body) do
    headers = [
      "Authorization": @thumbsup_bandwidth_authorization,
      "Content-Type": "application/json"
    ]
    connection = HTTPotion.post @bandwidth_url, [body: body, headers: headers]
    IO.puts(inspect(connection))
    true
  end

  def send_first_message(%User{} = user) do
    IO.puts @first_message
    Jason.encode!(%{from: @thumbsup_phone_number, to: user.phone_number, text: @first_message})
    |> connect_to_bandwidth()
    Accounts.update_user(user, %{welcome_message: true})
  end
end