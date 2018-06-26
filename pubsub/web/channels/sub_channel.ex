defmodule Pubsub.SubChannel do
  use Pubsub.Web, :channel
  intercept ["new_event"]

  alias Pubsub.Event
  alias Pubsub.Repo

  def join("subscription:" <> channel_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("subscription", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # def handle_in("watch", %{"channel_id" => id}, socket) do
  #   payload = %{title: title, description: descreption}
  #   push_new_events(socket, ["channel:#{id}"])
  #   Event.changeset(%Event{}, payload) |> Repo.insert
  #   broadcast! socket, "new_event:" <> channel_id, payload

  #   {:reply, {:ok, payload}, socket}
  # end

  def handle_in("new_event", %{"title" => title, "description" => descreption}, socket) do
    # import IEx
    # IEx.pry

    payload = %{title: title, description: descreption}
    broadcast! socket, "new_event", payload

    {:reply, {:ok, payload}, socket}
  end

  def handle_out("new_event", %{"title" => title, "description" => descreption}, socket) do
    payload = %{title: title, description: descreption}
    push(socket, "new_event", payload)

    {:noreply, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (sub:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
