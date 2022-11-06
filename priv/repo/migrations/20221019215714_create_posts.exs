defmodule Cat.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :link, :text
      add :title, :text
      add :description, :text
      add :author, :text
      add :pub_date, :utc_datetime
      add :fetched_at, :utc_datetime

      add :feed_id, references(:feeds, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:posts, [:link])
    create index(:posts, [:title])
    create index(:posts, [:description])
    create index(:posts, [:author])
    create index(:posts, [:pub_date])
    create index(:posts, [:fetched_at])
  end
end
