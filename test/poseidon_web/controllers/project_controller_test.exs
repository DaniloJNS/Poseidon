defmodule PoseidonWeb.ProjectControllerTest do
  use PoseidonWeb.ConnCase

  import Poseidon.ProjectsFixtures
  alias Poseidon.Projects.Project

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  describe "sem token" do
    test "retorna 401", %{conn: conn} do
      conn =
        conn
        |> put_req_header("accept", "application/json")
        |> get(~p"/api/projects")

      assert json_response(conn, 401)["errors"]["detail"] == "Unauthorized"
    end

    test "token inválido retorna 401", %{conn: conn} do
      conn =
        conn
        |> put_req_header("accept", "application/json")
        |> put_req_header("authorization", "Bearer token-falso")
        |> get(~p"/api/projects")

      assert json_response(conn, 401)
    end
  end

  describe "index" do
    setup :register_and_log_in_user

    test "lists only the user's projects", %{conn: conn, user: user} do
      %Project{id: id} = project_fixture(user: user)
      _de_outro_usuario = project_fixture()

      conn = get(conn, ~p"/api/projects")
      assert [%{"id" => ^id}] = json_response(conn, 200)["data"]
    end
  end

  describe "create project" do
    setup :register_and_log_in_user

    test "renders project when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/projects", project: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/projects/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/projects", project: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update project" do
    setup [:register_and_log_in_user, :create_project]

    test "renders project when data is valid", %{conn: conn, project: %Project{id: id} = project} do
      conn = put(conn, ~p"/api/projects/#{project}", project: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/projects/#{id}")

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      conn = put(conn, ~p"/api/projects/#{project}", project: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "returns 404 for another user's project", %{conn: conn} do
      de_outro_usuario = project_fixture()

      assert_error_sent 404, fn ->
        put(conn, ~p"/api/projects/#{de_outro_usuario}", project: @update_attrs)
      end
    end
  end

  describe "delete project" do
    setup [:register_and_log_in_user, :create_project]

    test "deletes chosen project", %{conn: conn, project: project} do
      conn = delete(conn, ~p"/api/projects/#{project}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/projects/#{project}")
      end
    end
  end

  defp create_project(%{user: user}) do
    %{project: project_fixture(user: user)}
  end
end
