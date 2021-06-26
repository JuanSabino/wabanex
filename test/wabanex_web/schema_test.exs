defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "user queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do

      params = %{name: "Juan", email: "juan@teste.com", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            id,
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "data" => %{
            "getUser" => %{
              "email" => "juan@teste.com",
              "id" => user_id,
              "name" => "Juan"
            }
          }
        }

        assert response == expected_response

    end

    test "when a invalid UUID4 id, returns an error", %{conn: conn} do


      query = """
        {
          getUser(id: "123456"){
            id,
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "errors" => [%{"locations" => [%{"column" => 13, "line" => 2}],
          "message" => "Argument \"id\" has invalid value \"123456\"."}]
      }

        assert response == expected_response

    end

    test "when a invalid user id, returns an error", %{conn: conn} do


      query = """
        {
          getUser(id: "b458cbf0-e594-4dc2-ba1f-1542849e69da"){
            id,
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "errors" => [%{"locations" => [%{"column" => 5, "line" => 2}],
          "message" => "User not found", "path" => ["getUser"]}],
          "data" => %{"getUser" => nil}
        }

        assert response == expected_response

    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do

      mutation = """
        mutation{
          createUser(input: {
            email:"teste@123.com",
            name:"teste",
            password:"123456"
          }){
            id,
            name,
            email
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)



        assert  %{
          "data" => %{
            "createUser" => %{
              "email" => "teste@123.com", "id" => _id, "name" => "teste"
            }
          }
        } = response
    end

    test "when the email already exists, returns an error", %{conn: conn} do

      mutation = """
        mutation{
          createUser(input: {
            email:"teste@123.com",
            name:"teste",
            password:"123456"
          }){
            id,
            name,
            email
          }
        }
      """
      _res =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)



        assert  %{
          "data" => %{"createUser" => nil}, "errors" => [%{"locations" => [%{"column" => 5, "line" => 2}],
          "message" => "email has already been taken", "path" => ["createUser"]}]
        } = response
    end

    test "when all params are invalid, returns an error", %{conn: conn} do

      mutation = """
        mutation{
          createUser(input: {
            email:"teste123.com",
            name:"t",
            password:"1"
          }){
            id,
            name,
            email
          }
        }
      """
      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)



        assert  %{
          "data" => %{"createUser" => nil},
          "errors" => [
            %{
              "locations" => [%{"column" => 5, "line" => 2}],
              "message" => "email has invalid format",
              "path" => ["createUser"]
            },
            %{
              "locations" => [%{"column" => 5, "line" => 2}],
              "message" => "name should be at least 2 character(s)",
              "path" => ["createUser"]
            },
            %{
              "locations" => [%{"column" => 5, "line" => 2}],
              "message" => "password should be at least 6 character(s)",
              "path" => ["createUser"]
            }
          ]
        } = response
    end


  end
end
