defmodule Cat.FeedsTest do
  use Cat.DataCase

  alias Cat.Feeds

  describe "feeds" do
    alias Cat.Feeds.Feed

    import Cat.FeedsFixtures

    @invalid_attrs %{description: nil, fetched_at: nil, title: nil, url: nil}

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Feeds.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      valid_attrs = %{description: "some description", fetched_at: ~U[2022-10-16 20:47:00Z], title: "some title", url: "some url"}

      assert {:ok, %Feed{} = feed} = Feeds.create_feed(valid_attrs)
      assert feed.description == "some description"
      assert feed.fetched_at == ~U[2022-10-16 20:47:00Z]
      assert feed.title == "some title"
      assert feed.url == "some url"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      update_attrs = %{description: "some updated description", fetched_at: ~U[2022-10-17 20:47:00Z], title: "some updated title", url: "some updated url"}

      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, update_attrs)
      assert feed.description == "some updated description"
      assert feed.fetched_at == ~U[2022-10-17 20:47:00Z]
      assert feed.title == "some updated title"
      assert feed.url == "some updated url"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end
end
