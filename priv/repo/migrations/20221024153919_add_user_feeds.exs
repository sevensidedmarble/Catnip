defmodule Cat.Repo.Migrations.AddUserFeeds do
  use Ecto.Migration

  def change do
    create table(:user_feeds) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :feed_id, references(:feeds, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
