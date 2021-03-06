defmodule Thumbsup.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :phone_number, :string
      add :welcome_message, :boolean

      timestamps()
    end

  end
end
