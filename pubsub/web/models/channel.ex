defmodule Pubsub.Channel do
  use Pubsub.Web, :model
  alias Pubsub.Repo
  alias Pubsub.Event

  schema "channels" do
    field :name, :string
    many_to_many :users, Pubsub.User, join_through: "user_channels"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def broadcast(id, event \\ %{}) do
    Event.changeset(%Event{channel_id: String.to_integer(id)}, event) |> Repo.insert
    Pubsub.Endpoint.broadcast! "subscription:" <> id, "new_event", event
  end
end
