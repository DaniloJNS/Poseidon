defmodule Poseidon.Repo do
  use Ecto.Repo,
    otp_app: :poseidon,
    adapter: Ecto.Adapters.Postgres
end
