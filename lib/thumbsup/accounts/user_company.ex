defmodule Thumbsup.Accounts.UserCompany do
  use Ecto.Schema
  import Ecto.Changeset

  alias Thumbsup.Accounts.User
  alias Thumbsup.Accounts.Company


  schema "user_companies" do
    belongs_to :user, User
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(user_company, attrs) do
    user_company
    |> cast(attrs, [:user_id, :company_id])
    |> validate_required([:user_id, :company_id])
  end
end
