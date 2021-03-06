defmodule BankOne.Accounts.List do

  import Ecto.Query, only: [from: 2]

  alias BankOne.{Account, Repo}

  def call(page, size) do
    query = from a in Account, offset: ^((page - 1) * size), limit: ^size

    Repo.all(query)
  end
end
