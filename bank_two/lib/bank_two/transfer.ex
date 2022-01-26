defmodule BankTwo.Transfer do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :amount, :payee_account, :account_id]}

  schema "transfers" do
    field :amount, :decimal
    field :payee_account, :integer
    field :account_id, :id

    timestamps()
  end

  @doc false
  def changeset(transfer \\ %__MODULE__{}, attrs) do
    transfer
    |> cast(attrs, [:amount, :account_id, :payee_account])
    |> validate_required([:amount, :account_id, :payee_account])
  end
end
