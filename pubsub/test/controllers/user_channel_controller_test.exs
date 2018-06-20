defmodule Pubsub.UserChannelControllerTest do
  use Pubsub.ConnCase

  alias Pubsub.UserChannel
  @valid_attrs %{channel_id: 42, user_id: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_channel_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing user channels"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_channel_path(conn, :new)
    assert html_response(conn, 200) =~ "New user channel"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_channel_path(conn, :create), user_channel: @valid_attrs
    user_channel = Repo.get_by!(UserChannel, @valid_attrs)
    assert redirected_to(conn) == user_channel_path(conn, :show, user_channel.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_channel_path(conn, :create), user_channel: @invalid_attrs
    assert html_response(conn, 200) =~ "New user channel"
  end

  test "shows chosen resource", %{conn: conn} do
    user_channel = Repo.insert! %UserChannel{}
    conn = get conn, user_channel_path(conn, :show, user_channel)
    assert html_response(conn, 200) =~ "Show user channel"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_channel_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    user_channel = Repo.insert! %UserChannel{}
    conn = get conn, user_channel_path(conn, :edit, user_channel)
    assert html_response(conn, 200) =~ "Edit user channel"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user_channel = Repo.insert! %UserChannel{}
    conn = put conn, user_channel_path(conn, :update, user_channel), user_channel: @valid_attrs
    assert redirected_to(conn) == user_channel_path(conn, :show, user_channel)
    assert Repo.get_by(UserChannel, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_channel = Repo.insert! %UserChannel{}
    conn = put conn, user_channel_path(conn, :update, user_channel), user_channel: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit user channel"
  end

  test "deletes chosen resource", %{conn: conn} do
    user_channel = Repo.insert! %UserChannel{}
    conn = delete conn, user_channel_path(conn, :delete, user_channel)
    assert redirected_to(conn) == user_channel_path(conn, :index)
    refute Repo.get(UserChannel, user_channel.id)
  end
end
