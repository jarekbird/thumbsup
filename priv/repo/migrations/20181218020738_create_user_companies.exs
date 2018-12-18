defmodule Thumbsup.Repo.Migrations.CreateUserCompanies do
  use Ecto.Migration

  def change do
    create table(:user_companies) do
      add :user_id, references(:users)
      add :company_id, references(:companies)

      timestamps()
    end

  end
end
