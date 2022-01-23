defmodule BankOne.Repo do
  use Ecto.Repo,
    otp_app: :bank_one,
    adapter: Ecto.Adapters.Postgres
end
