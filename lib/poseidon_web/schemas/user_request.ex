defmodule PoseidonWeb.Schemas.UserRequest do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "UserRequest",
    type: :object,
    properties: %{
      user: %Schema{
        type: :object,
        properties: %{
          name: %Schema{type: :string},
          email: %Schema{type: :string, format: :email},
          password: %Schema{type: :string, format: :password, minLength: 8, maxLength: 72},
          birthdate: %Schema{type: :string, format: :date},
          language: %Schema{type: :string, default: "pt-BR"},
          timezone: %Schema{type: :string, default: "America/Sao_Paulo"}
        },
        required: [:name, :email, :password]
      }
    },
    required: [:user],
    example: %{
      "user" => %{"name" => "Danilo", "email" => "danilo@example.com", "password" => "poseidon123"}
    }
  })
end
