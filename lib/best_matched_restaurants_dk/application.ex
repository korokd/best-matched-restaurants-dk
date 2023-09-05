defmodule BestMatchedRestaurantsDk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BestMatchedRestaurantsDkWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BestMatchedRestaurantsDk.PubSub},
      # Start the Endpoint (http/https)
      BestMatchedRestaurantsDkWeb.Endpoint
      # Start a worker by calling: BestMatchedRestaurantsDk.Worker.start_link(arg)
      # {BestMatchedRestaurantsDk.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BestMatchedRestaurantsDk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BestMatchedRestaurantsDkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
