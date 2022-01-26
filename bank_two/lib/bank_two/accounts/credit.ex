defmodule BankTwo.Accounts.Credit do
  alias BankTwo.Account
  alias BankTwo.Repo

  def call(id, amount) when amount > 0 do
    with %Account{} = account <- Repo.get(Account, id) do
      balance = account.balance |> Decimal.add(amount)

      Account.changeset(account, %{balance: balance})
      |> Repo.update()
    end
  end

  def call(_, _), do: {:error, :invalid_amount}
end
