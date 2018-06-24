defmodule Pubsub.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :channel_id, :integer
      add :title, :string
      add :description, :text

      timestamps()
    end
  end
end
