defmodule Thumbsup.Repo.Migrations.AddCompanyReferenceToConversation do
  use Ecto.Migration

  def change do
    alter table(:conversations) do
      add :company_id, references(:companies)
    end
  end
end
