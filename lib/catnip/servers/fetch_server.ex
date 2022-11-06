defmodule Cat.Servers.FetchServer do
  @moduledoc """
  A GenServer for handling fetching feeds.
  This handles timing out fetches on a regular interval.
  """

  use GenServer

  import Logger
  alias Timex.Duration

  @time 1 |> Duration.from_minutes |> Duration.to_milliseconds(truncate: true)

  @enforce_keys [:timer_pid]
  defstruct [:timer_pid]

  def start_link(_) do
    info("Starting fetch server.")
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  # def handle_info(:fetch, state) do
  #   info("got handle_info :fetch")
  #   {:noreply, state}
  # end

  def init(:ok) do
    timer_pid = Process.send_after(self(), :tick, @time)
    {:ok, %__MODULE__{timer_pid: timer_pid}}
  end

  # def fetch do
  #   GenServer.call(__MODULE__, :fetch)
  # end

  def handle_info(:tick, state) do
    Cat.benchmark "Fetch feeds", (fn ->
      Cat.Feeds.scheduled()
        |> Cat.Fetcher.fetch()
    end)

    timer_pid = Process.send_after(self(), :tick, @time)
    {:noreply, struct!(state, timer_pid: timer_pid)}
  end
end
