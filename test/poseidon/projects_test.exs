defmodule Poseidon.ProjectsTest do
  use Poseidon.DataCase

  alias Poseidon.Projects

  describe "projects" do
    alias Poseidon.Projects.Project

    import Poseidon.AccountsFixtures
    import Poseidon.ProjectsFixtures

    @invalid_attrs %{name: nil}

    setup do
      %{user: user_fixture()}
    end

    test "list_projects/1 returns only the user's projects", %{user: user} do
      project = project_fixture(user: user)
      _de_outro_usuario = project_fixture()

      assert Projects.list_projects(user) == [project]
    end

    test "get_project!/2 returns the project with given id", %{user: user} do
      project = project_fixture(user: user)
      assert Projects.get_project!(user, project.id) == project
    end

    test "get_project!/2 raises for another user's project", %{user: user} do
      project = project_fixture()
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(user, project.id) end
    end

    test "create_project/2 with valid data creates a project", %{user: user} do
      assert {:ok, %Project{} = project} = Projects.create_project(user, %{name: "some name"})
      assert project.name == "some name"
      assert project.user_id == user.id
    end

    test "create_project/2 ignores user_id sent in attrs", %{user: user} do
      outro = user_fixture()

      assert {:ok, project} =
               Projects.create_project(user, %{"name" => "x", "user_id" => outro.id})

      assert project.user_id == user.id
    end

    test "create_project/2 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(user, @invalid_attrs)
    end

    test "update_project/2 with valid data updates the project", %{user: user} do
      project = project_fixture(user: user)
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Project{} = project} = Projects.update_project(project, update_attrs)
      assert project.name == "some updated name"
    end

    test "update_project/2 with invalid data returns error changeset", %{user: user} do
      project = project_fixture(user: user)
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(user, project.id)
    end

    test "delete_project/1 deletes the project", %{user: user} do
      project = project_fixture(user: user)
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(user, project.id) end
    end

    test "change_project/1 returns a project changeset", %{user: user} do
      project = project_fixture(user: user)
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
