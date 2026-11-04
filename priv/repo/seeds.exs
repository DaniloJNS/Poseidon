# Popula o banco com um usuário de demonstração e alguns projetos.
#
#     mix run priv/repo/seeds.exs
#
# Pode ser executado mais de uma vez: não duplica dados.

alias Poseidon.{Accounts, Projects, Repo}
alias Poseidon.Accounts.User

email = "demo@poseidon.dev"

user =
  case Repo.get_by(User, email: email) do
    nil ->
      {:ok, user} =
        Accounts.create_user(%{name: "Usuário Demo", email: email, password: "poseidon123"})

      user

    user ->
      user
  end

if Projects.list_projects(user) == [] do
  for name <- ["Faculdade", "Pessoal"] do
    {:ok, _project} = Projects.create_project(user, %{name: name})
  end
end

IO.puts("Seed ok: #{email} / poseidon123")
