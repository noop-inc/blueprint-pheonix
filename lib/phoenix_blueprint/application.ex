defmodule PhoenixBlueprint.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixBlueprintWeb.Telemetry,
      PhoenixBlueprint.Repo,
      {DNSCluster, query: Application.get_env(:phoenix_blueprint, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixBlueprint.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixBlueprint.Finch},
      # Start a worker by calling: PhoenixBlueprint.Worker.start_link(arg)
      # {PhoenixBlueprint.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixBlueprintWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixBlueprint.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixBlueprintWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
