defmodule WeblogWeb.ArticleLive.Show do
  use WeblogWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    updated_socket =
      socket
      |> assign(:page_title, page_title(socket.assigns.live_action))
      |> assign(:article, Weblog.Repo.get!(Weblog.Article, id))

    {:noreply, updated_socket}
  end

  defp page_title(:show), do: "Show Article"
  defp page_title(:edit), do: "Edit Article"
end
