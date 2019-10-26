defmodule HanoiTowerWeb.Router do
  use HanoiTowerWeb, :router

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

  scope "/", HanoiTowerWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/towers", HanoiController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HanoiTowerWeb do
  #   pipe_through :api
  # end
end
