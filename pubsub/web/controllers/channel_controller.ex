defmodule Pubsub.ChannelController do
  use Pubsub.Web, :controller

  alias Pubsub.Channel
  alias Pubsub.Router

  def index(conn, _params) do
    channels = Repo.all(Channel)
    render(conn, "index.html", channels: channels)
  end

  def new(conn, _params) do
    changeset = Channel.changeset(%Channel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"channel" => channel_params}) do
    changeset = Channel.changeset(%Channel{}, channel_params)

    case Repo.insert(changeset) do
      {:ok, channel} ->
        conn
        |> put_flash(:info, "Channel created successfully.")
        |> redirect(to: channel_path(conn, :show, channel))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)
    render(conn, "show.html", channel: channel)
  end

  def edit(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)
    changeset = Channel.changeset(channel)
    render(conn, "edit.html", channel: channel, changeset: changeset)
  end

  def update(conn, %{"id" => id, "channel" => channel_params}) do
    channel = Repo.get!(Channel, id)
    changeset = Channel.changeset(channel, channel_params)

    case Repo.update(changeset) do
      {:ok, channel} ->
        conn
        |> put_flash(:info, "Channel updated successfully.")
        |> redirect(to: channel_path(conn, :show, channel))
      {:error, changeset} ->
        render(conn, "edit.html", channel: channel, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    channel = Repo.get!(Channel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(channel)

    conn
    |> put_flash(:info, "Channel deleted successfully.")
    |> redirect(to: channel_path(conn, :index))
  end

  def new_broadcast(conn, %{"channel_id" => id}) do
    channel = Repo.get!(Channel, id)

    render(conn, "new_broadcast.html", channel: channel, connection: conn,
      action: Router.Helpers.channel_broadcast_path(conn, :broadcast, id))
  end

  def broadcast(conn, %{"channel_id" => id, "event_params" => event_params}) do
    Task.async(fn -> Channel.broadcast(id, event_params) end)

    conn
    |> put_flash(:info, "Channel broadcasted successfully.")
    |> redirect(to: Router.Helpers.channel_broadcast_path(conn, :broadcast, id))
  end
end
