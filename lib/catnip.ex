defmodule Cat do
  @moduledoc """
  Cat keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Logger

  def benchmark(msg, function) do
    info("Benchmarking #{msg}.")
    :timer.tc(function, [])
    |> then(fn {time, result} ->
      info("Completed #{msg}. Benchmark time: #{time / 1_000_000}s.")
      result
    end)
  end
end
