defmodule BankTwo.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :balance, :decimal
    field :owner, :string

    timestamps()
  end

  @doc false
  def changeset(account \\ %__MODULE__{}, attrs) do
    account
    |> cast(attrs, [:owner, :balance])
    |> validate_required([:owner, :balance])
  end
end
