defmodule Pubsub.Event do
  use Pubsub.Web, :model

  schema "events" do
    field :channel_id, :integer
    field :title, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:channel_id, :title, :description])
    |> validate_required([:channel_id, :title, :description])
  end
end
