defmodule BankOne.Accounts.TransferAll do
  alias Ecto.Multi
  alias BankOne.{Repo, Account, Transfer}

  def call(id, payee_account, amount_per_transfer) do
    with %Account{} = account <- Repo.get(Account, id) do
      transfers_count =
        Decimal.div_int(account.balance, amount_per_transfer)
        |> Decimal.to_integer()

      transfers =
        Enum.map(1..transfers_count, fn _ ->
          Transfer.changeset(%{
            amount: amount_per_transfer,
            account_id: account.id,
            payee_account: payee_account
          })
        end)

      amount_transfered = Decimal.new(amount_per_transfer) |> Decimal.mult(transfers_count)
      balance_of_payer = account.balance |> Decimal.sub(amount_transfered)

      Multi.new()
      |> Multi.update(:account, Account.changeset(account, %{balance: balance_of_payer}))
      |> Multi.insert_all(:transfers, Transfer, transfers)
      |> Repo.transaction()
    end
  end
end
