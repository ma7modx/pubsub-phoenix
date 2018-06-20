defmodule Pubsub.PageController do
  use Pubsub.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
