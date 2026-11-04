defmodule PoseidonWeb.UserControllerTest do
  use PoseidonWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "POST /api/users" do
    test "cadastra o usuário sem expor a senha", %{conn: conn} do
      conn =
        post(conn, ~p"/api/users",
          user: %{name: "Danilo", email: "danilo@example.com", password: "poseidon123"}
        )

      data = json_response(conn, 201)["data"]
      assert %{"id" => _, "email" => "danilo@example.com", "language" => "pt-BR"} = data
      refute Map.has_key?(data, "hashed_password")
      refute Map.has_key?(data, "password")
    end

    test "retorna 422 com dados inválidos", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: %{name: "", email: "x", password: "123"})
      errors = json_response(conn, 422)["errors"]
      assert errors["email"]
      assert errors["password"]
    end
  end
end
