defmodule WeblogWeb.ArticleLive.Public do
  use WeblogWeb, :live_view

  require Ecto.Query

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    query = Ecto.Query.from(Weblog.Article, order_by: [desc: :inserted_at])

    socket
    |> assign(:page_title, "All articles")
    |> assign(:articles, Weblog.Repo.all(query))
  end

  defp apply_action(socket, :show, %{"slug" => slug}) do
    article = Weblog.Repo.get_by!(Weblog.Article, slug: slug)

    socket
    |> assign(:page_title, article.slug)
    |> assign(:article, article)
  end
end
