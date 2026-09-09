defmodule Poseidon.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :string

      add :project_id, references(:projects, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end
  end
end
