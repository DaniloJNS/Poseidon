defmodule Poseidon.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :email, :string, null: false
      add :hashed_password, :string, null: false
      add :birthdate, :date
      add :language, :string, default: "pt-BR"
      add :timezone, :string, default: "America/Sao_Paulo"

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
