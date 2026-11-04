defmodule PoseidonWeb.UserJSON do
  alias Poseidon.Accounts.User

  @doc """
  Renders a single user. Nunca expõe `hashed_password`.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      birthdate: user.birthdate,
      language: user.language,
      timezone: user.timezone
    }
  end
end
