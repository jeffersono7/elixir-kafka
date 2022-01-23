defmodule BankTwo.Repo do
  use Ecto.Repo,
    otp_app: :bank_two,
    adapter: Ecto.Adapters.Postgres
end
