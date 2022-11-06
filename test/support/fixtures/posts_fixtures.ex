defmodule Cat.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cat.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        author: "some author",
        description: "some description",
        fetched_at: ~U[2022-10-18 22:22:00Z],
        link: "some link",
        pub_date: ~U[2022-10-18 22:22:00Z],
        title: "some title"
      })
      |> Cat.Posts.create_post()

    post
  end
end
