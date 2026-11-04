defmodule PoseidonWeb.SessionController do
  use PoseidonWeb, :controller

  alias Poseidon.Accounts
  alias Poseidon.Auth.Token

  action_fallback PoseidonWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate(email, password),
         {:ok, jwt, _claims} <- Token.generate_and_sign(%{"sub" => user.id}) do
      json(conn, %{token: jwt})
    end
  end
end
