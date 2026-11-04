defmodule PoseidonWeb.UserController do
  use PoseidonWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Poseidon.Accounts
  alias PoseidonWeb.Schemas

  action_fallback PoseidonWeb.FallbackController

  tags ["Usuários"]

  operation :create,
    summary: "Cadastra um usuário",
    request_body: {"Dados do usuário", "application/json", Schemas.UserRequest, required: true},
    responses: [
      created: {"Usuário criado", "application/json", Schemas.UserResponse},
      unprocessable_entity: {"Dados inválidos", "application/json", Schemas.ChangesetErrors}
    ]

  def create(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end
end
