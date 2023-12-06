defmodule Weblog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string, null: false
      add :content, :string
      add :content_html, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:articles, [:slug])
  end
end
