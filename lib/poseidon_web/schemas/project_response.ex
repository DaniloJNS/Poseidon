defmodule PoseidonWeb.Schemas.ProjectResponse do
  require OpenApiSpex

  OpenApiSpex.schema(%{
    title: "ProjectResponse",
    type: :object,
    properties: %{data: PoseidonWeb.Schemas.Project},
    required: [:data]
  })
end
