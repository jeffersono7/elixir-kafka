defmodule BankTwo.Transfers.ReceiveTransfer do

  alias BankTwo.Accounts.Credit

  def call(%{"payee_account" => payee_account, "amount" => amount}) do
    with {:ok, _} <- Credit.call(payee_account, amount) do
      :ok
    end
  end
end
