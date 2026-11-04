defmodule PoseidonWeb.ApiSpecTest do
  use PoseidonWeb.ConnCase, async: true

  test "GET /api/openapi documenta login, cadastro e CRUD de projects", %{conn: conn} do
    paths = conn |> get(~p"/api/openapi") |> json_response(200) |> Map.fetch!("paths")

    assert Map.has_key?(paths, "/api/login")
    assert Map.has_key?(paths, "/api/users")
    assert Map.keys(paths["/api/projects"]) |> Enum.sort() == ["get", "post"]

    assert Map.keys(paths["/api/projects/{id}"]) |> Enum.sort() == [
             "delete",
             "get",
             "patch",
             "put"
           ]
  end

  test "GET /swaggerui renderiza o Swagger UI", %{conn: conn} do
    assert conn |> get(~p"/swaggerui") |> html_response(200) =~ "swagger-ui"
  end
end
