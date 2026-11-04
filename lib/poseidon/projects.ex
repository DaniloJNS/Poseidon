defmodule Poseidon.Projects do
  @moduledoc """
  The Projects context.

  Toda leitura recebe o usuário dono: um usuário nunca enxerga projetos de outro.
  """

  import Ecto.Query, warn: false
  alias Poseidon.Repo

  alias Poseidon.Accounts.User
  alias Poseidon.Projects.Project

  @doc """
  Returns the list of projects owned by the user.

  ## Examples

      iex> list_projects(user)
      [%Project{}, ...]

  """
  def list_projects(%User{id: user_id}) do
    Project
    |> where(user_id: ^user_id)
    |> order_by(asc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single project owned by the user.

  Raises `Ecto.NoResultsError` if the Project does not exist or belongs to another user.

  ## Examples

      iex> get_project!(user, id)
      %Project{}

      iex> get_project!(user, id_de_outro_usuario)
      ** (Ecto.NoResultsError)

  """
  def get_project!(%User{id: user_id}, id), do: Repo.get_by!(Project, id: id, user_id: user_id)

  @doc """
  Creates a project owned by the user.

  ## Examples

      iex> create_project(user, %{name: "Faculdade"})
      {:ok, %Project{}}

      iex> create_project(user, %{name: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(%User{id: user_id}, attrs) do
    %Project{user_id: user_id}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end
end
