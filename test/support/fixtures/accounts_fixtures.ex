defmodule Poseidon.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Poseidon.Accounts` context.
  """

  @doc """
  Generate a unique user email.
  """
  def unique_user_email, do: "user#{System.unique_integer([:positive])}@example.com"

  def valid_user_password, do: "poseidon123"

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2026-11-03],
        email: unique_user_email(),
        password: valid_user_password(),
        language: "some language",
        name: "some name",
        timezone: "some timezone"
      })
      |> Poseidon.Accounts.create_user()

    user
  end
end
