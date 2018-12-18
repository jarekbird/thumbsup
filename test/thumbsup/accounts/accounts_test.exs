defmodule Thumbsup.AccountsTest do
  use Thumbsup.DataCase

  alias Thumbsup.Accounts

  describe "users" do
    alias Thumbsup.Accounts.User

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number"}
    @invalid_attrs %{first_name: nil, last_name: nil, phone_number: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.phone_number == "some phone_number"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.phone_number == "some updated phone_number"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "companies" do
    alias Thumbsup.Accounts.Company

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Accounts.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Accounts.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Accounts.create_company(@valid_attrs)
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = Accounts.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_company(company, @invalid_attrs)
      assert company == Accounts.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Accounts.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Accounts.change_company(company)
    end
  end

  describe "user_companies" do
    alias Thumbsup.Accounts.UserCompany

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def user_company_fixture(attrs \\ %{}) do
      {:ok, user_company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_company()

      user_company
    end

    test "list_user_companies/0 returns all user_companies" do
      user_company = user_company_fixture()
      assert Accounts.list_user_companies() == [user_company]
    end

    test "get_user_company!/1 returns the user_company with given id" do
      user_company = user_company_fixture()
      assert Accounts.get_user_company!(user_company.id) == user_company
    end

    test "create_user_company/1 with valid data creates a user_company" do
      assert {:ok, %UserCompany{} = user_company} = Accounts.create_user_company(@valid_attrs)
      assert user_company.name == "some name"
    end

    test "create_user_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_company(@invalid_attrs)
    end

    test "update_user_company/2 with valid data updates the user_company" do
      user_company = user_company_fixture()
      assert {:ok, user_company} = Accounts.update_user_company(user_company, @update_attrs)
      assert %UserCompany{} = user_company
      assert user_company.name == "some updated name"
    end

    test "update_user_company/2 with invalid data returns error changeset" do
      user_company = user_company_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_company(user_company, @invalid_attrs)
      assert user_company == Accounts.get_user_company!(user_company.id)
    end

    test "delete_user_company/1 deletes the user_company" do
      user_company = user_company_fixture()
      assert {:ok, %UserCompany{}} = Accounts.delete_user_company(user_company)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_company!(user_company.id) end
    end

    test "change_user_company/1 returns a user_company changeset" do
      user_company = user_company_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_company(user_company)
    end
  end
end
