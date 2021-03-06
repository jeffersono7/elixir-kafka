defmodule BankTwo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BankTwo.Repo,
      # Start the Telemetry supervisor
      BankTwoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BankTwo.PubSub},
      # Start the Endpoint (http/https)
      BankTwoWeb.Endpoint,
      # Start a worker by calling: BankTwo.Worker.start_link(arg)
      # {BankTwo.Worker, arg}
      {BankTwo.Broadway, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankTwo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BankTwoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
