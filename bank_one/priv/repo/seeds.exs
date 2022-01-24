alias BankOne.Accounts.Create, as: CreateAccount
alias BankOne.Accounts.Credit, as: CreditAccount
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

{:ok, first_account} = CreateAccount.call("jefferson")
{:ok, second_account} = CreateAccount.call("fulana")

# Setup my accounts with balance
CreditAccount.call(first_account.id, 10_000_000)
CreditAccount.call(second_account.id, 10_000_000)
