defmodule Weblog.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Weblog.Blog` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content: "some content",
        path: "some path"
      })
      |> Weblog.Blog.create_article()

    article
  end
end
