defmodule PoseidonWeb.UserController do
  use PoseidonWeb, :controller

  alias Poseidon.Accounts

  action_fallback PoseidonWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end
end
