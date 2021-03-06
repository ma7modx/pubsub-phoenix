defmodule Pubsub.User do
  use Pubsub.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string
    many_to_many :channels, Pubsub.Channel, join_through: "user_channels"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end
end
