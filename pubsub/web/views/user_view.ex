defmodule Pubsub.UserView do
  use Pubsub.Web, :view

  def render("show.json", %{user: user}) do
    %{
      name: user.name,
      channel_ids: Enum.map(user.channels, fn x -> x.id end)
    }
  end
end
