defmodule Cat.PostsTest do
  use Cat.DataCase

  alias Cat.Posts

  describe "posts" do
    alias Cat.Posts.Post

    import Cat.PostsFixtures

    @invalid_attrs %{author: nil, description: nil, fetched_at: nil, link: nil, pub_date: nil, title: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{author: "some author", description: "some description", fetched_at: ~U[2022-10-18 22:22:00Z], link: "some link", pub_date: ~U[2022-10-18 22:22:00Z], title: "some title"}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.author == "some author"
      assert post.description == "some description"
      assert post.fetched_at == ~U[2022-10-18 22:22:00Z]
      assert post.link == "some link"
      assert post.pub_date == ~U[2022-10-18 22:22:00Z]
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{author: "some updated author", description: "some updated description", fetched_at: ~U[2022-10-19 22:22:00Z], link: "some updated link", pub_date: ~U[2022-10-19 22:22:00Z], title: "some updated title"}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.author == "some updated author"
      assert post.description == "some updated description"
      assert post.fetched_at == ~U[2022-10-19 22:22:00Z]
      assert post.link == "some updated link"
      assert post.pub_date == ~U[2022-10-19 22:22:00Z]
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
