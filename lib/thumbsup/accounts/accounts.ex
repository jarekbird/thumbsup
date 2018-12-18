defmodule Thumbsup.Accounts do

  import Ecto.Query, warn: false
  alias Thumbsup.Repo

  alias Thumbsup.Accounts.User
  alias Thumbsup.Accounts.Company

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_phone_number(phone_number), do: Repo.one(from u in User, where: u.phone_number == ^phone_number)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def list_companies do
    Repo.all(Company)
  end

  def get_company!(id), do: Repo.get!(Company, id)

  def create_company(attrs \\ %{}) do
    %Company{}
    |> Company.changeset(attrs)
    |> Repo.insert()
  end

  def update_company(%Company{} = company, attrs) do
    company
    |> Company.changeset(attrs)
    |> Repo.update()
  end

  def delete_company(%Company{} = company) do
    Repo.delete(company)
  end

  def change_company(%Company{} = company) do
    Company.changeset(company, %{})
  end

  alias Thumbsup.Accounts.UserCompany

  def list_user_companies do
    Repo.all(UserCompany)
  end

  def get_user_company!(id), do: Repo.get!(UserCompany, id)

  def create_user_company(attrs \\ %{}) do
    %UserCompany{}
    |> UserCompany.changeset(attrs)
    |> Repo.insert()
  end

  def update_user_company(%UserCompany{} = user_company, attrs) do
    user_company
    |> UserCompany.changeset(attrs)
    |> Repo.update()
  end

  def delete_user_company(%UserCompany{} = user_company) do
    Repo.delete(user_company)
  end

  def change_user_company(%UserCompany{} = user_company) do
    UserCompany.changeset(user_company, %{})
  end
end
