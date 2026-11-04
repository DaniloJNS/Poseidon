defmodule PoseidonWeb.Schemas.LoginRequest do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "LoginRequest",
    type: :object,
    properties: %{
      email: %Schema{type: :string, format: :email},
      password: %Schema{type: :string, format: :password}
    },
    required: [:email, :password],
    example: %{"email" => "demo@poseidon.dev", "password" => "poseidon123"}
  })
end
