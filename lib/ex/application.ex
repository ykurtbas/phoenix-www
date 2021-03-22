defmodule Ex.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ex.Repo,
      # Start the Telemetry supervisor
      ExWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ex.PubSub},
      # Start the Endpoint (http/https)
      ExWeb.Endpoint
      # Start a worker by calling: Ex.Worker.start_link(arg)
      # {Ex.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
