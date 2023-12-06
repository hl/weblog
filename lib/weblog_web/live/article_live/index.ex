defmodule WeblogWeb.ArticleLive.Index do
  use WeblogWeb, :live_view

  require Ecto.Query

  @impl true
  def mount(_params, _session, socket) do
    query = Ecto.Query.from(Weblog.Article, order_by: [desc: :inserted_at])

    {:ok, stream(socket, :articles, Weblog.Repo.all(query))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article")
    |> assign(:article, Weblog.Repo.get!(Article, id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article")
    |> assign(:article, %Weblog.Article{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Articles")
    |> assign(:article, nil)
  end

  @impl true
  def handle_info({WeblogWeb.ArticleLive.FormComponent, {:saved, article}}, socket) do
    {:noreply, stream_insert(socket, :articles, article)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article = Weblog.Repo.get!(Article, id)
    {:ok, _} = Weblog.Repo.delete(article)

    {:noreply, stream_delete(socket, :articles, article)}
  end
end
