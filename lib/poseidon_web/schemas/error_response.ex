defmodule PoseidonWeb.Schemas.ErrorResponse do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "ErrorResponse",
    type: :object,
    properties: %{
      errors: %Schema{
        type: :object,
        properties: %{detail: %Schema{type: :string}},
        required: [:detail]
      }
    },
    required: [:errors],
    example: %{"errors" => %{"detail" => "Unauthorized"}}
  })
end
