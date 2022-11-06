defmodule Cat.FeedsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cat.Feeds` context.
  """

  @doc """
  Generate a feed.
  """
  def feed_fixture(attrs \\ %{}) do
    {:ok, feed} =
      attrs
      |> Enum.into(%{
        description: "some description",
        fetched_at: ~U[2022-10-16 20:47:00Z],
        title: "some title",
        url: "some url"
      })
      |> Cat.Feeds.create_feed()

    feed
  end
end
