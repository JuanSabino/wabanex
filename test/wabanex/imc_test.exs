defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the filename is valid" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)
      expected_response = {:ok, %{"juan" => 28.305995064595734, "tste" => 22.22222222222222}}

      assert response == expected_response
    end

    test "when the wrong filename is given" do
      params = %{"filename" => "students2.csv"}

      response = IMC.calculate(params)
      expected_response = {:error, "Error while opening the file"}

      assert response == expected_response
    end

  end

end
