defmodule Wabanex.UserTest do

  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        name: "Juan",
        email: "juan@teste.com",
        password: "123456",
        birthday_date: "1990-01-01",
        height: 1.65
      }

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{
          birthday_date: ~D[1990-01-01],
          email: "juan@teste.com",
          height: 1.65,
          name: "Juan",
          password: "123456"
        },
        errors: []
      } = response
    end

    test "when there are invalid params, returns a invalid changeset" do
      params = %{name: "J", email: "juanteste.com", password: "1"}

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"],
        password: ["should be at least 6 character(s)"],
        birthday_date: ["can't be blank"],
        height: ["can't be blank"]
      }
      assert expected_response == errors_on(response)
    end

  end

end
