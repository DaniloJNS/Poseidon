defmodule Poseidon.AccountsTest do
  use Poseidon.DataCase

  alias Poseidon.Accounts

  describe "users" do
    alias Poseidon.Accounts.User

    import Poseidon.AccountsFixtures

    @invalid_attrs %{name: nil, language: nil, birthdate: nil, timezone: nil, email: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", language: "some language", birthdate: ~D[2026-11-03], timezone: "some timezone", email: "user@example.com", password: "poseidon123"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.language == "some language"
      assert user.birthdate == ~D[2026-11-03]
      assert user.timezone == "some timezone"
      assert user.email == "user@example.com"
      assert Pbkdf2.verify_pass("poseidon123", user.hashed_password)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", language: "some updated language", birthdate: ~D[2026-11-04], timezone: "some updated timezone", email: "updated@example.com"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.language == "some updated language"
      assert user.birthdate == ~D[2026-11-04]
      assert user.timezone == "some updated timezone"
      assert user.email == "updated@example.com"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "authenticate/2 com credenciais válidas retorna o usuário" do
      user = user_fixture()
      assert {:ok, %User{id: id}} = Accounts.authenticate(user.email, valid_user_password())
      assert id == user.id
    end

    test "authenticate/2 com senha errada retorna :unauthorized" do
      user = user_fixture()
      assert {:error, :unauthorized} = Accounts.authenticate(user.email, "senha-errada")
    end

    test "authenticate/2 com email inexistente retorna :unauthorized" do
      assert {:error, :unauthorized} = Accounts.authenticate("ninguem@example.com", "poseidon123")
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
