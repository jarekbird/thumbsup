defmodule Thumbsup.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone_number])
    |> validate_required([:first_name, :last_name, :phone_number])
  end

  def message_user(user) do
    body = Jason.encode!(%{from: "13852037751", to: "+1" <> user.phone_number, text: "Hello from Bandwidth! We are Watching You. Say Goodbye to thumbsupsurveys.com"})
    headers = [
      "Authorization": "Basic dC1heG5rdGJ4Mm1iNGFjY29nd2Q0cnNkaTpvb2F4bHhrbXE3eXJmM3RocWVnaWEzdnFiY2hmZTZjaDJwbXNveGE=",
      "Content-Type": "application/json"
    ]
    bandwidth_url = "https://api.catapult.inetwork.com/v1/users/u-pffxsmatqcxm4grkewgl6dq/messages"
    HTTPotion.post bandwidth_url, [body: body, headers: headers]
  end
end
