defmodule Cat.RSS do
  @moduledoc """
  Helper stuff for cleaning up RSS output.
  """

  def update_date(map, key) do
    Map.update(map, key, nil, &parse_date/1)
  end

  def parse_date(date) do
    case Timex.parse(date, "{RFC822}") do
      {:ok, dt} -> dt
      _ -> nil
    end
  end
end
