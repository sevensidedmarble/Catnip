defmodule Cat.Users.UserFeed do
  use Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  schema "user_feeds" do
    belongs_to :user, Cat.Users.User
    belongs_to :feed, Cat.Feeds.Feed

    timestamps()
  end
end
