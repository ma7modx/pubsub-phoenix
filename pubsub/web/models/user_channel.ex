defmodule Pubsub.UserChannel do
  use Pubsub.Web, :model

  schema "user_channels" do
    field :user_id, :integer
    field :channel_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :channel_id])
    |> validate_required([:user_id, :channel_id])
  end
end
