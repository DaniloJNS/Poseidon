defmodule Poseidon.Auth.Token do
  @moduledoc """
  JWT de acesso temporario, eh valido por 24 horas

      {:ok, jwt, _claims} = Token.generate_and_sign(%{"sub" => user.id})
      {:ok, %{"sub" => user_id}} = Token.verify_and_validate(jwt)
  """
  use Joken.Config

  @impl true
  def token_config do
    default_claims(default_exp: 24 * 60 * 60, iss: "poseidon", aud: "poseidon")
  end
end
