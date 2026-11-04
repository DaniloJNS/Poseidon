defmodule PoseidonWeb.SessionControllerTest do
  use PoseidonWeb.ConnCase

  import Poseidon.AccountsFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user_fixture()}
  end

  describe "POST /api/login" do
    test "devolve um JWT que acessa rotas protegidas", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/login", email: user.email, password: valid_user_password())
      assert %{"token" => token} = json_response(conn, 200)

      conn =
        build_conn()
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization", "Bearer " <> token)
        |> get(~p"/api/projects")

      assert json_response(conn, 200)["data"] == []
    end

    test "retorna 401 com senha errada", %{conn: conn, user: user} do
      conn = post(conn, ~p"/api/login", email: user.email, password: "senha-errada")
      assert json_response(conn, 401)["errors"]["detail"] == "Unauthorized"
    end
  end
end
