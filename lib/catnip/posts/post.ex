defmodule Cat.Posts.Post do
  use Ecto.Schema

  @derive {
    Flop.Schema,
    filterable: [:link],
    sortable: [:pub_date, :fetched_at],
    max_limit: 100,
    default_limit: 5
  }

  import Ecto.Changeset

  schema "posts" do
    field :author, :string
    field :description, :string
    field :fetched_at, :utc_datetime
    field :link, :string
    field :pub_date, :utc_datetime
    field :title, :string

    belongs_to :feed, Cat.Feeds.Feed

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:link, :title, :description, :author, :pub_date, :fetched_at])
    |> validate_required([:link])
  end
end
