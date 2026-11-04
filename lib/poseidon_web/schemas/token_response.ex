defmodule PoseidonWeb.Schemas.TokenResponse do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "TokenResponse",
    description: "JWT (HS256) válido por 24h. Envie em `Authorization: Bearer <token>`.",
    type: :object,
    properties: %{token: %Schema{type: :string}},
    required: [:token],
    example: %{"token" => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."}
  })
end
