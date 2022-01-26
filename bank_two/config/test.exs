import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bank_two, BankTwo.Repo,
  username: "bank_two",
  password: "bank_two",
  hostname: "localhost",
  port: 5433,
  database: "bank_two_db#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_two, BankTwoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4003],
  secret_key_base: "WVgz4UwXBqlLsNruoTQtqQhSJwQpBzIRdEzYkbEHkhHSi4hnN0DVG/IGVg0CJEsr",
  server: false

# In test we don't send emails.
config :bank_two, BankTwo.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
