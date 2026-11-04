defmodule PoseidonWeb.Schemas.ProjectRequest do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "ProjectRequest",
    type: :object,
    properties: %{
      project: %Schema{
        type: :object,
        properties: %{name: %Schema{type: :string}},
        required: [:name]
      }
    },
    required: [:project],
    example: %{"project" => %{"name" => "Faculdade"}}
  })
end
