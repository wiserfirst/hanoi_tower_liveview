defmodule HanoiTowerWeb.HanoiController do
  use HanoiTowerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"id" => "initial"}) do
    conn
    |> assign(:first_rod, 7..1)
    |> assign(:second_rod, [])
    |> assign(:third_rod, [])
    |> render("show.html")
  end

  def show(conn, %{"id" => "next"}) do
    conn
    |> assign(:first_rod, 7..3)
    |> assign(:second_rod, [1])
    |> assign(:third_rod, [2])
    |> render("show.html")
  end
end
