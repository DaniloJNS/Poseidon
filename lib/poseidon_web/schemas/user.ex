defmodule PoseidonWeb.Schemas.User do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "User",
    type: :object,
    properties: %{
      id: %Schema{type: :string, format: :uuid},
      name: %Schema{type: :string},
      email: %Schema{type: :string, format: :email},
      birthdate: %Schema{type: :string, format: :date, nullable: true},
      language: %Schema{type: :string},
      timezone: %Schema{type: :string}
    },
    required: [:id, :name, :email],
    example: %{
      "id" => "0b6f4a8e-2c1d-4f4e-9a3b-5d7c8e9f0a1b",
      "name" => "Danilo",
      "email" => "danilo@example.com",
      "birthdate" => nil,
      "language" => "pt-BR",
      "timezone" => "America/Sao_Paulo"
    }
  })
end
