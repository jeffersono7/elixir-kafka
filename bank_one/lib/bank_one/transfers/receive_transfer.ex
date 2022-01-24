defmodule BankOne.Transfers.ReceiveTransfer do

  alias BankOne.Accounts.Credit

  def call(%{"payee_account" => payee_account, "amount" => amount}) do
    with {:ok, _} <- Credit.call(payee_account, amount) do
      :ok
    end
  end
end
