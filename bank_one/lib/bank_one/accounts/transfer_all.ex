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
          %{
            amount: amount_per_transfer,
            account_id: account.id,
            payee_account: payee_account,
            inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
            updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
          }
        end)

      amount_transfered = Decimal.new(amount_per_transfer) |> Decimal.mult(transfers_count)
      balance_of_payer = account.balance |> Decimal.sub(amount_transfered)

      Multi.new()
      |> Multi.update(:account, Account.changeset(account, %{balance: balance_of_payer}))
      |> insert_all_transfers(transfers)
      |> Repo.transaction()

      BankOne.Transfers.Recipient.send_transfers_to_kafka(transfers)
    end
  end

  defp insert_all_transfers(multi, transfers) do
    Enum.chunk_every(transfers, 1000)
    |> Enum.reduce(multi, fn chunk, acc ->
      IO.inspect(chunk)

      Multi.insert_all(
        acc,
        "transfer-#{Enum.random(1..1_000_000_000)}" |> String.to_atom(),
        Transfer,
        chunk
      )
    end)

  end
end
