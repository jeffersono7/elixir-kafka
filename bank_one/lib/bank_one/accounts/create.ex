defmodule BankOne.Accounts.Create do
  alias BankOne.{Account, Repo}
  alias Ecto.Changeset

  @spec call(String.t()) :: {:ok, %Account{}} | {:error, Changeset.t()}
  def call(owner, balance \\ Decimal.new("0.00")) do
    Account.changeset(%{owner: owner, balance: balance})
    |> Repo.insert()
  end
end
