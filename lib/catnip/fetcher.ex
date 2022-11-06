defmodule Cat.Fetcher do
  @moduledoc """
  This module is responsible for fetching the data from the API.
  """

  alias Cat.Feeds
  alias Cat.Posts
  alias Cat.RSS
  alias Cat.Users

  @max_redirects 5
  @http_opts [recv_timeout: 1_000, timeout: 1_500]

  import Logger

  def fetch(%Users.User{} = user) do
    Users.get_feeds(user)
    |> fetch()
  end

  def fetch(%Feeds.Feed{} = feed) do
    with {:ok, body, feed} <- request(feed),
         {:ok, rss_map} <- FastRSS.parse(body) do
        # Parse out the fields for the feed
        fields = rss_map
          |> RSS.update_date("last_build_date")
          |> Enum.filter(fn {_key, value} -> !is_nil(value) end)
          |> Map.new()
          |> Map.put("fetched_at", DateTime.utc_now())

        info "🔥"
        info "🔥"
        info "🔥"
        dbg(fields["image"])

        # Update the feed
        feed
          |> Feeds.Feed.fetch_changeset(fields)
          |> Cat.Repo.update()
          |> case do
            {:ok, %Feeds.Feed{} = feed} ->
              info("Fetched successfully: #{inspect feed}")
              :ok
            {:error, changeset} ->
              info("Failed to fetch: #{inspect changeset}")
              :error
          end

        items = rss_map["items"]
        for {item, index} <- Enum.with_index(items) do
          info("Updating item #{index + 1} of #{length(items)} (#{item["link"]})")

          item
          |> Enum.filter(fn {_key, value} -> !is_nil(value) end)
          |> Enum.map(fn
            {k, v} when is_binary(v) -> {k, String.slice(v, 0..254)}
            x -> x
          end)
          |> Map.new()
          |> Map.put("fetched_at", DateTime.utc_now())
          |> RSS.update_date("pub_date")
          |> Posts.upsert()
        end
      else
        {:error, reason} ->
          info("Failed to fetch: #{inspect reason}")
          :ok
        error ->
          IO.inspect(error)
          info("Failed to fetch: #{inspect error}")
          :ok
      end
  end

  def fetch(feeds) when is_list(feeds) do
    info("Fetching #{length(feeds)} feeds.")

    feeds
      |> Enum.with_index()
      |> Task.async_stream(Cat.Fetcher, :fetch_and_count, [length(feeds)], max_concurrency: 20, on_timeout: :kill_task)
      |> Enum.to_list()
  end

  def fetch_and_count({feed, index}, length) do
    info("Fetching feed #{index + 1} of #{length} (#{feed.url})")
    fetch(feed)
  end

  @spec request(Feeds.Feed.t()) :: {:ok, binary(), Feeds.Feed.t()} | {:error, any()}
  def request(%Feeds.Feed{} = feed, redirects \\ 0) do
    case HTTPoison.get(feed.url, [], @http_opts) do
      # Happy path: 200 response
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case body do
          "" -> {:error, "empty body"}
          _ -> {:ok, body, feed}
        end

      # Bad path: redirect
      {:ok, %HTTPoison.Response{status_code: status, headers: headers}} when status in [301, 302, 307] ->
        maybe_update_url(feed, headers, redirects)

      # Bad path: Some other bad response, like a 404
      {:ok, %HTTPoison.Response{} = response} ->
        {:error, "bad response: #{response.status_code}"}

      # Any other error
      {:error, reason} -> {:error, reason}
      _ -> {:error, "unknown error"}
    end
  rescue
    e ->
      error("Error during HTTPoison get #{feed.url}: #{inspect e}")
      {:error, e}
  end

  defp update_url(feed, url) do
    info("Updating Feed #{feed.id} (#{feed.url}) to #{url}")
    {:ok, feed} = Feeds.update_feed(feed, %{url: url})
    feed
  end

  # Get location header independent of it's casing
  def get_location(headers) do
    case Enum.find(headers, fn {k, _v} -> String.downcase(k) == "location" end) do
      {_, location} -> location
      _ -> nil
    end
  end

  def maybe_update_url(feed, headers, redirects) do
    case get_location(headers) do
      nil -> {:error, "no location"}
      location ->
        feed = update_url(feed, location)

        if redirects < @max_redirects - 1 do
          request(feed, redirects + 1)
        else
          {:error, "too many redirects"}
        end
    end
  end

  # defp extract_title(document) do
  #   document |> Floki.find("title") |> Floki.text()
  # end

  # def start_link(opts \\ []) do
  #   GenServer.start_link(__MODULE__, :ok, opts)
  # end
  #
  # def init(:ok) do
  #   {:ok, %{}}
  # end
  #
  # def fetch(pid, %Feed{} = feed) do
  #
  #   GenServer.call(pid, {:fetch_feed, feed})
  # end
  #
  # def handle_call({:fetch_feed, %Feed{} = feed}, _from, state) do
  #   {:ok, document} = HTTPoison.get(feed.url)
  #   {:reply, extract_title(document), state}
  # end
end
