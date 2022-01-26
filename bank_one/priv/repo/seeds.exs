alias BankOne.Accounts.Create, as: CreateAccount
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BankOne.Repo.insert!(%BankOne.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

BankOne.Repo.delete_all(BankOne.Transfer)
BankOne.Repo.delete_all(BankOne.Account)

create_account_async = fn i ->
  Task.async(fn ->
    {:ok, account} = CreateAccount.call("jefferson-#{i}", 1_000_000)
  end)
end

Enum.chunk_every(1..20_000, 2_000)
|> Enum.map(fn chunk ->
  Enum.map(chunk, create_account_async)
  |> Enum.map(&Task.await/1)
end)
