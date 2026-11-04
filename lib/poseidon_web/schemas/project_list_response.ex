defmodule PoseidonWeb.Schemas.ProjectListResponse do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "ProjectListResponse",
    type: :object,
    properties: %{data: %Schema{type: :array, items: PoseidonWeb.Schemas.Project}},
    required: [:data]
  })
end
