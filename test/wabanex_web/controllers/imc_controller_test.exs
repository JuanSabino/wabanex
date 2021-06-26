defmodule WabanexWeb.IMCControllerTest  do

  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns the imc info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |>json_response(:ok)

        expected_response = %{"result" => %{"juan" => 28.305995064595734, "tste" => 22.22222222222222}}
        assert response == expected_response

    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{"filename" => "students2.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |>json_response(:bad_request)

        expected_response = %{"result" => "Error while opening the file"}
        assert response == expected_response

    end
  end

end
