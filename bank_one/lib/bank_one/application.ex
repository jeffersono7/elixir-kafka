defmodule BankOne.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BankOne.Repo,
      # Start the Telemetry supervisor
      BankOneWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BankOne.PubSub},
      # Start the Endpoint (http/https)
      BankOneWeb.Endpoint,
      # Start a worker by calling: BankOne.Worker.start_link(arg)
      # {BankOne.Worker, arg}
      {BankOne.Broadway, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BankOne.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BankOneWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
