defmodule PoseidonWeb.Schemas.ChangesetErrors do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "ChangesetErrors",
    description: "Erros de validação por campo.",
    type: :object,
    properties: %{
      errors: %Schema{
        type: :object,
        additionalProperties: %Schema{type: :array, items: %Schema{type: :string}}
      }
    },
    required: [:errors],
    example: %{
      "errors" => %{
        "email" => ["formato inválido"],
        "password" => ["should be at least 8 character(s)"]
      }
    }
  })
end
