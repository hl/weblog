defmodule Weblog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :path, :string
      add :content, :string

      timestamps(type: :utc_datetime)
    end
  end
end
