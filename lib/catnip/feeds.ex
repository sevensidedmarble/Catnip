defmodule Cat.Feeds do
  @moduledoc """
  The Feeds context.
  """

  import Ecto.Query, warn: false
  alias Cat.Repo

  alias Cat.Feeds.Feed

  def list_feeds, do: Repo.all(Feed)
  def get_feed!(id), do: Repo.get!(Feed, id)

  def create(uri) when is_binary(uri) do
    Cat.URL.parse(uri)
    |> create()
  end

  def create(%URI{} = uri) do
    %{url: uri |> URI.to_string()}
    |> create()
  end

  def create(attrs) when is_map(attrs) do
    %Feed{}
    |> Feed.changeset(attrs)
    |> Repo.insert()
  end

  def update_feed(%Feed{} = feed, attrs) do
    feed
    |> Feed.changeset(attrs)
    |> Repo.update()
  end

  def delete_feed(%Feed{} = feed) do
    Repo.delete(feed)
  end

  def change_feed(%Feed{} = feed, attrs \\ %{}) do
    Feed.changeset(feed, attrs)
  end

  # Returns the feeds ready to fetch again.
  def scheduled do
    Repo.all from f in Feed,
      where: is_nil(f.fetched_at) or f.fetched_at < fragment("now() - interval '5 minutes'"),
      order_by: [asc: f.fetched_at]
  end
end
