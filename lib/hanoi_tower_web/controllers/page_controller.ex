defmodule HanoiTowerWeb.PageController do
  use HanoiTowerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
