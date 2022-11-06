defmodule Cat.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @timestamps_opts [type: :utc_datetime]

  schema "users" do
    pow_user_fields()

    has_many :user_feeds, Cat.Users.UserFeed
    has_many :feeds, through: [:user_feeds, :feed]
    has_many :posts, through: [:feeds, :posts]

    timestamps()
  end
end
