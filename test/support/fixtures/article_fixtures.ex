defmodule Weblog.ArticleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        content: "some content",
        slug: "some slug"
      })

    changeset = Weblog.Article.changeset(%Weblog.Article{}, attrs)
    Weblog.Repo.insert!(changeset)
  end
end
