defmodule Pubsub.UserChannelController do
  use Pubsub.Web, :controller

  alias Pubsub.UserChannel

  def index(conn, _params) do
    user_channels = Repo.all(UserChannel)
    render(conn, "index.html", user_channels: user_channels)
  end

  def new(conn, _params) do
    changeset = UserChannel.changeset(%UserChannel{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_channel" => user_channel_params}) do
    changeset = UserChannel.changeset(%UserChannel{}, user_channel_params)

    case Repo.insert(changeset) do
      {:ok, user_channel} ->
        conn
        |> put_flash(:info, "User channel created successfully.")
        |> redirect(to: user_channel_path(conn, :show, user_channel))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_channel = Repo.get!(UserChannel, id)
    render(conn, "show.html", user_channel: user_channel)
  end

  def edit(conn, %{"id" => id}) do
    user_channel = Repo.get!(UserChannel, id)
    changeset = UserChannel.changeset(user_channel)
    render(conn, "edit.html", user_channel: user_channel, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user_channel" => user_channel_params}) do
    user_channel = Repo.get!(UserChannel, id)
    changeset = UserChannel.changeset(user_channel, user_channel_params)

    case Repo.update(changeset) do
      {:ok, user_channel} ->
        conn
        |> put_flash(:info, "User channel updated successfully.")
        |> redirect(to: user_channel_path(conn, :show, user_channel))
      {:error, changeset} ->
        render(conn, "edit.html", user_channel: user_channel, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_channel = Repo.get!(UserChannel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_channel)

    conn
    |> put_flash(:info, "User channel deleted successfully.")
    |> redirect(to: user_channel_path(conn, :index))
  end
end
