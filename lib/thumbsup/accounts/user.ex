defmodule Thumbsup.Accounts.User do
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
end