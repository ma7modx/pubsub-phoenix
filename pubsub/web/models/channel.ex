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

    channel = Repo.get!(__MODULE__, id) |> Repo.preload(:users)
    Enum.each(channel.users, fn user ->
      Pubsub.Endpoint.broadcast! "subscription:user:" <> Integer.to_string(user.id), "new_event", event
    end)
  end
end
