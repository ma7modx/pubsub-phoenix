defmodule Pubsub.EventTest do
  use Pubsub.ModelCase

  alias Pubsub.Event

  @valid_attrs %{channel_id: 42, description: "some description", title: "some title"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
