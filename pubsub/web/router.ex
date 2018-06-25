defmodule Pubsub.Router do
  use Pubsub.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Pubsub do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/channels", ChannelController do
      post "/broadcast", ChannelController, :broadcast, as: :broadcast
    end
    resources "/users", UserController
    resources "/user_channels", UserChannelController
    resources "/events", EventController
  end

  # Other scopes may use custom stacks.
  scope "/api", Pubsub do
    pipe_through :api
    resources "/users", UserController
  end
end
