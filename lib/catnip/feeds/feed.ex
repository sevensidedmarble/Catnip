defmodule Cat.Feeds.Feed do
  use Ecto.Schema

  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime]

  schema "feeds" do
    field :url, :string
    field :link, :string
    field :title, :string
    field :description, :string
    field :image, :string
    field :pub_date, :utc_datetime
    field :last_build_date, :utc_datetime
    field :fetched_at, :utc_datetime

    has_many :posts, Cat.Posts.Post
    has_many :user_feeds, Cat.Users.UserFeed

    timestamps()
  end

  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end

  def fetch_changeset(feed, attrs) do
    feed
    |> cast(attrs, [:link, :title, :description, :image, :pub_date, :last_build_date])
    |> cast(%{fetched_at: DateTime.utc_now}, [:fetched_at])
  end
end
