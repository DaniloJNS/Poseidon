defmodule PoseidonWeb.ProjectController do
  use PoseidonWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias Poseidon.Projects
  alias Poseidon.Projects.Project
  alias PoseidonWeb.Schemas

  action_fallback PoseidonWeb.FallbackController

  # current_user é atribuído pelo PoseidonWeb.Plugs.Auth (pipeline :auth no router)

  tags(["Projetos"])
  security([%{"bearerAuth" => []}])

  @id_param [id: [in: :path, type: :string, required: true, description: "ID do projeto (UUID)"]]
  @unauthorized {"Token ausente ou inválido", "application/json", Schemas.ErrorResponse}
  @not_found {"Projeto não encontrado ou de outro usuário", "application/json",
              Schemas.ErrorResponse}
  @invalid {"Dados inválidos", "application/json", Schemas.ChangesetErrors}

  operation(:index,
    summary: "Lista os projetos do usuário logado",
    responses: [
      ok: {"Projetos", "application/json", Schemas.ProjectListResponse},
      unauthorized: @unauthorized
    ]
  )

  operation(:create,
    summary: "Cria um projeto para o usuário logado",
    request_body: {"Projeto", "application/json", Schemas.ProjectRequest, required: true},
    responses: [
      created: {"Projeto criado", "application/json", Schemas.ProjectResponse},
      unprocessable_entity: @invalid,
      unauthorized: @unauthorized
    ]
  )

  operation(:show,
    summary: "Detalha um projeto",
    parameters: @id_param,
    responses: [
      ok: {"Projeto", "application/json", Schemas.ProjectResponse},
      not_found: @not_found,
      unauthorized: @unauthorized
    ]
  )

  operation(:update,
    summary: "Atualiza um projeto",
    parameters: @id_param,
    request_body: {"Projeto", "application/json", Schemas.ProjectRequest, required: true},
    responses: [
      ok: {"Projeto atualizado", "application/json", Schemas.ProjectResponse},
      unprocessable_entity: @invalid,
      not_found: @not_found,
      unauthorized: @unauthorized
    ]
  )

  operation(:delete,
    summary: "Remove um projeto",
    parameters: @id_param,
    responses: [
      no_content: "Projeto removido",
      not_found: @not_found,
      unauthorized: @unauthorized
    ]
  )

  def index(conn, _params) do
    projects = Projects.list_projects(conn.assigns.current_user)
    render(conn, :index, projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    with {:ok, %Project{} = project} <-
           Projects.create_project(conn.assigns.current_user, project_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/projects/#{project}")
      |> render(:show, project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Projects.get_project!(conn.assigns.current_user, id)
    render(conn, :show, project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Projects.get_project!(conn.assigns.current_user, id)

    with {:ok, %Project{} = project} <- Projects.update_project(project, project_params) do
      render(conn, :show, project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(conn.assigns.current_user, id)

    with {:ok, %Project{}} <- Projects.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
