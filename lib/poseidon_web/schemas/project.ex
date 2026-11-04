defmodule PoseidonWeb.Schemas.Project do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "Project",
    type: :object,
    properties: %{
      id: %Schema{type: :string, format: :uuid},
      name: %Schema{type: :string}
    },
    required: [:id, :name],
    example: %{"id" => "7c1e2d3f-4a5b-6c7d-8e9f-0a1b2c3d4e5f", "name" => "Faculdade"}
  })
end
