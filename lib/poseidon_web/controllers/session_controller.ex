defmodule PoseidonWeb.SessionController do
  use PoseidonWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Poseidon.Accounts
  alias Poseidon.Auth.Token
  alias PoseidonWeb.Schemas

  action_fallback PoseidonWeb.FallbackController

  tags(["Autenticação"])

  operation(:create,
    summary: "Login: troca email e senha por um JWT",
    request_body: {"Credenciais", "application/json", Schemas.LoginRequest, required: true},
    responses: [
      ok: {"Token de acesso", "application/json", Schemas.TokenResponse},
      unauthorized: {"Credenciais inválidas", "application/json", Schemas.ErrorResponse}
    ]
  )

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate(email, password),
         {:ok, jwt, _claims} <- Token.generate_and_sign(%{"sub" => user.id}) do
      json(conn, %{token: jwt})
    end
  end
end
