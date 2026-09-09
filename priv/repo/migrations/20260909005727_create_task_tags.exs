defmodule Poseidon.Repo.Migrations.CreateTaskTags do
  use Ecto.Migration

  def change do
    create table(:task_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :task_id, references(:tasks, on_delete: :nothing, type: :binary_id),
        null: false
      add :tag_id, references(:tags, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end

    create unique_index(:task_tags, [:task_id, :tag_id])
  end
end
