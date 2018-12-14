defmodule ThumbsupWeb.Router do
  use ThumbsupWeb, :router

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

  scope "/", ThumbsupWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/questions", QuestionController
    post "/bandwidth_creation", IncomingTextController, :bandwidth_create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ThumbsupWeb do
  #   pipe_through :api
  # end
end
