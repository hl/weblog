defmodule Weblog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :slug, :string
    field :content, :string
    field :content_html, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:slug, :content])
    |> update_change(:slug, &Slug.slugify/1)
    |> prepare_changes(fn changeset ->
      case get_change(changeset, :content) do
        nil -> changeset
        content -> put_change(changeset, :content_html, Earmark.as_html!(content))
      end
    end)
    |> validate_required([:slug, :content])
  end
end
