defmodule Pubsub.SubChannel do
  use Pubsub.Web, :channel
  intercept ["new_event"]

  alias Pubsub.Event
  alias Pubsub.Repo

  def join("subscription:user:" <> user_id, payload, socket) do
    assign(socket, :user_id, user_id)

    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def channel_id(socket) do
    socket.assigns.channel_id
  end

  def handle_in("new_event", %{"title" => title, "description" => descreption}, socket) do
    payload = %{title: title, description: descreption}
    broadcast! socket, "new_event", payload

    {:reply, {:ok, payload}, socket}
  end

  def handle_out("new_event", %{"title" => title, "description" => descreption}, socket) do
    payload = %{title: title, description: descreption}
    push(socket, "new_event", payload)

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
