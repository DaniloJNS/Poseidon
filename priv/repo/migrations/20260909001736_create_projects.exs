defmodule Poseidon.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false

      # ON DELETE is dangerous when an large row sets are deleted in an single action
      add :user_id, references(:user, on_delete: :nothing, type: :binary_id),
        null: false

      timestamps()
    end
  end
end
