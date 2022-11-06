defmodule Cat.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Cat.Repo
  alias Cat.Users.User
  alias Cat.Feeds.Feed

  def get_user!(id), do: Repo.get!(User, id)

  def get_feeds(user) do
    Repo.all(from f in Feed, join: uf in assoc(f, :user_feeds), where: uf.user_id == ^user.id)
  end
end
