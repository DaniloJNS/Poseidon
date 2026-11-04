defmodule PoseidonWeb.Plugs.Auth do
  import Plug.Conn

  alias Poseidon.Accounts
  alias Poseidon.Auth.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{"sub" => id}} <- Token.verify_and_validate(token),
         {:ok, user} <- Accounts.get_user(id) do
      assign(conn, :current_user, user)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Phoenix.Controller.json(%{errors: %{detail: "Unauthorized"}})
        |> halt()
    end
  end
end
