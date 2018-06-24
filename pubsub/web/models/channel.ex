defmodule Pubsub.Channel do
  use Pubsub.Web, :model

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

  def broadcast(id) do
    channel = Channel
      |> Repo.get(id)
      |> Repo.preload(:users)
    
    users = channel.users

  end
end
