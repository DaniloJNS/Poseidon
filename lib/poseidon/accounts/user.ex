defmodule Poseidon.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :name, :string
    field :birthdate, :date
    field :language, :string, default: "pt-BR"
    field :timezone, :string, default: "America/Sao_Paulo"
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true

    timestamps(type: :utc_datetime)
  end

  @doc "Does not change sensitive fields, such as password"
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :birthdate, :language, :timezone, :email])
    |> validate_required([:name, :email])
    |> validate_email()
  end

  @doc "Only validates the password and store the result hash"
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :birthdate, :language, :timezone, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_email()
    |> validate_length(:password, min: 8, max: 72)
    |> put_password_hash()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^@\s]+@[^@\s]+$/, message: "Formato incorreto")
    |> unique_constraint(:email)
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: pw}} = changeset) do
    pw
    |> Pbkdf2.hash_pwd_salt(digest: :sha512)
    |> then(&put_change(changeset, :hashed_password, &1))
    |> delete_change(:password)
  end

  defp put_password_hash(changeset), do: changeset
end
