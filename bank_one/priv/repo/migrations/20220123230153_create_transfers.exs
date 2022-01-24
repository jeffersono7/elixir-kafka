defmodule BankOne.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers) do
      add :amount, :decimal
      add :payee_account, :integer
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:transfers, [:account_id])
  end
end
