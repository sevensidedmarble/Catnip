defmodule Cat.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Cat.Repo,
      CatWeb.Telemetry,
      {Phoenix.PubSub, name: Cat.PubSub},
      CatWeb.Endpoint,
    ] |> unless_iex([
        Cat.Servers.FetchSupervisor
      ])

    opts = [strategy: :one_for_one, name: Cat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CatWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp unless_iex(children, other_children) do
    if IEx.started?() do
      children
    else
      children ++ other_children
    end
  end
end
