defmodule PoseidonWeb.Schemas.UserResponse do
  require OpenApiSpex

  OpenApiSpex.schema(%{
    title: "UserResponse",
    type: :object,
    properties: %{data: PoseidonWeb.Schemas.User},
    required: [:data]
  })
end
