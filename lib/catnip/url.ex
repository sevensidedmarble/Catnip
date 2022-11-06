defmodule Cat.URL do
  @moduledoc """
  Parsing URLs.
  """

  def parse(url) do
    case URI.parse(url) do
      %URI{scheme: nil} ->
        parse("https://#{url}")
      %URI{path: nil} ->
        parse("#{url}/")
      parsed ->
        parsed
    end
  end
end
