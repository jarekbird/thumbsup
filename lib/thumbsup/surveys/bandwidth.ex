defmodule Thumbsup.Surveys.Bandwidth do
  alias Thumbsup.Accounts.User

  def send_message(string = message, %User{} = user) do
    body = Jason.encode!(%{from: "13852037751", to: user.phone_number, text: message})
    headers = [
      "Authorization": "Basic dC1heG5rdGJ4Mm1iNGFjY29nd2Q0cnNkaTpvb2F4bHhrbXE3eXJmM3RocWVnaWEzdnFiY2hmZTZjaDJwbXNveGE=",
      "Content-Type": "application/json"
    ]
    bandwidth_url = "https://api.catapult.inetwork.com/v1/users/u-pffxsmatqcxm4grkewgl6dq/messages"
    # HTTPotion.post bandwidth_url, [body: body, headers: headers]
    IO.puts message
    true
  end
end