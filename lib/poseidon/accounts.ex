defmodule Poseidon.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Poseidon.Repo

  alias Poseidon.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  Returns {:error, :user_not_found} if the User does not exist.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user(456)
      {:error, :user_not_found}
  """
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :user_not_found}

      user -> {:ok, user}
    end
  end

  @doc """
  Creates a user.

  ## Examples

  iex> create_user(%{field: value})
  {:ok, %User{}}

  iex> create_user(%{field: bad_value})
  {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Authenticate an user.

  ## Examples

  iex> authenticate("jhon@doe.com", "12345678")
  {:ok, %User{}}

  iex> authenticate("jhonny@doe.com", "12345678")
  {:error, :unauthorized}

  """
  @spec authenticate(String.t(), String.t()) :: {:ok, %User{}} | {:error, :unauthorized}
  def authenticate(email, password) do
    case Repo.get_by(User, email: email) do
      %User{} = user ->
        if Pbkdf2.verify_pass(password, user.hashed_password),
          do: {:ok, user},
          else: {:error, :unauthorized}

      nil ->
        # Mesmo custo de um verify, para o tempo de resposta não revelar se o email existe
        Pbkdf2.no_user_verify()
        {:error, :unauthorized}
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
