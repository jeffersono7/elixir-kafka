defmodule BankTwoWeb.TransferToBankTwoController do
  use BankTwoWeb, :controller

  def create(conn, %{"amountPerTransfer" => amount_per_transfer}) do
    Task.async(fn -> BankTwo.TransferAllBalanceToBankTwo.call(amount_per_transfer) end)

    conn
    |> put_status(:created)
    |> json(%{"message" => "All balance will send to bank two!"})
  end
end
