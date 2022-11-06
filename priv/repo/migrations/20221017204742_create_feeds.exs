defmodule Cat.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :url, :text
      add :link, :text
      add :title, :text
      add :description, :text
      add :image, :text
      add :pub_date, :utc_datetime
      add :last_build_date, :utc_datetime
      add :fetched_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:feeds, [:url])
    create index(:feeds, [:link])
    create index(:feeds, [:title])
    create index(:feeds, [:description])
    create index(:feeds, [:pub_date])
    create index(:feeds, [:last_build_date])
    create index(:feeds, [:fetched_at])
  end
end
