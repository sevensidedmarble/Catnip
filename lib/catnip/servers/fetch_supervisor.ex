defmodule Cat.Servers.FetchSupervisor do
  @moduledoc """
  A supervisor for the fetch server.
  """
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      Cat.Servers.FetchServer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
