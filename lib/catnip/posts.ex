defmodule Cat.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Cat.Repo

  alias Cat.Posts.Post

  # List many posts with pagination.
  def list(params) do
    Flop.validate_and_run(Post, params, for: Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post), do: Repo.delete(post)

  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  def upsert(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert(conflict_target: :link, on_conflict: {:replace, [:title, :description, :pub_date, :fetched_at]})
  end

  def upsert_posts(posts \\ []) do
    Repo.insert_all(
      Post,
      posts,
      conflict_target: [:link],
      on_conflict: {:replace, [:title, :description, :pub_date, :fetched_at]}
    )
  end
end
