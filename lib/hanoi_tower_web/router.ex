defmodule HanoiTowerWeb.Router do
  use HanoiTowerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_layout, {HanoiTowerWeb.LayoutView, :app}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HanoiTowerWeb do
    pipe_through :browser

    live "/", HanoiLive
  end
end
