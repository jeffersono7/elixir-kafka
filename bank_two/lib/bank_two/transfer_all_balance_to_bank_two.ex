defmodule BankTwo.TransferAllBalanceToBankTwo do
  alias BankTwo.{Account, Accounts}
  alias Accounts.{TransferAll, List}

  def call(amount_per_transfer, page \\ 1, size \\ 1_000, continue \\ true) do
    case continue do
      false ->
        :ok

      true ->
        accounts = List.call(page, size)
        transfer_by_chunk(accounts, amount_per_transfer)

        call(amount_per_transfer, page + 1, size, not Enum.empty?(accounts))
    end

    :ok
  end

  defp transfer_by_chunk(accounts, amount_per_transfer) do
    accounts
    |> Enum.map(fn account ->
      Task.async(fn -> transfer_all_balance(account, amount_per_transfer) end)
    end)
    |> Enum.map(&Task.await/1)
  end

  defp transfer_all_balance(%Account{} = account, amount_per_transfer) do
    TransferAll.call(account.id, account.id, String.to_integer(amount_per_transfer))
  end
end
