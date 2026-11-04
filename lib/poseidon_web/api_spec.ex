defmodule PoseidonWeb.ApiSpec do
  @moduledoc """
  Spec OpenAPI 3 da API. Servido em `/api/openapi` e exibido no Swagger UI em `/swaggerui`.
  """
  alias OpenApiSpex.{Components, Info, OpenApi, Paths, SecurityScheme, Server}
  alias PoseidonWeb.{Endpoint, Router}

  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [Server.from_endpoint(Endpoint)],
      info: %Info{
        title: "Poseidon API",
        version: "1.0.0",
        description: """
        API do Poseidon, gestão de tarefas no estilo GTD.

        Para testar as rotas protegidas: cadastre-se em `POST /api/users` (ou use o usuário da seed),
        faça login em `POST /api/login`, copie o `token` e clique em **Authorize**.
        """
      },
      paths: Paths.from_router(Router),
      components: %Components{
        securitySchemes: %{
          "bearerAuth" => %SecurityScheme{type: "http", scheme: "bearer", bearerFormat: "JWT"}
        }
      }
    }
    |> OpenApiSpex.resolve_schema_modules()
  end
end
