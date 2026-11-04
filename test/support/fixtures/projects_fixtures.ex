defmodule Poseidon.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Poseidon.Projects` context.
  """

  @doc """
  Generate a project. Passe `user: user` para definir o dono; sem isso, cria um usuário novo.
  """
  def project_fixture(attrs \\ %{}) do
    {user, attrs} =
      attrs
      |> Enum.into(%{})
      |> Map.pop_lazy(:user, &Poseidon.AccountsFixtures.user_fixture/0)

    {:ok, project} =
      Poseidon.Projects.create_project(user, Enum.into(attrs, %{name: "some name"}))

    project
  end
end
