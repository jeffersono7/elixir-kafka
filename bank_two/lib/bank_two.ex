defmodule BankTwo do
  @moduledoc """
  BankTwo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate credit_account(id, amount), to: BankTwo.Accounts.Credit, as: :call

  defdelegate transfer_all(id, payee_account_id, amount_per_transfer), to: BankTwo.Accounts.TransferAll, as: :call

  defdelegate receive_transfer(transfer), to: BankTwo.Transfers.ReceiveTransfer, as: :call
end
