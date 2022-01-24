defmodule BankOne.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :owner, :string
      add :balance, :decimal

      timestamps()
    end
  end
end
