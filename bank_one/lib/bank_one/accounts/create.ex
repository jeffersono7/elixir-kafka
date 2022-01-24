defmodule BankOne.Accounts.Create do
  alias BankOne.{Account, Repo}
  alias Ecto.Changeset

  @spec call(String.t()) :: {:ok, %Account{}} | {:error, Changeset.t()}
  def call(owner) do
    Account.changeset(%{owner: owner, balance: Decimal.new("0.00")})
    |> Repo.insert()
  end
end
