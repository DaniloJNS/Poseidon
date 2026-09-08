defmodule PoseidonWeb.PageController do
  use PoseidonWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
