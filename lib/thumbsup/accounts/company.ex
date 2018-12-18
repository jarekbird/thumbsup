defmodule Thumbsup.Accounts.Company do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias Thumbsup.Accounts.User

  schema "companies" do
    field :name, :string
    many_to_many :users, User, join_through: "user_companies"

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
